#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/mman.h>

// in bytes
#define RECORD_SIZE 100
#define KEY_SIZE 4
#define VAL_SIZE 96

struct record{
  int key;
  char val[96];
};

struct thread_pool{
  pthread_mutex_t lock;    // lock for pool synchronization
  pthread_cond_t notify;   // condition variable to notify workers
  pthread_t *threads;      // array of worker threads
  struct task *queue;      // queue of tasks to be given to workers
  int num_threads;        // number of worker threads
  int workers_free;       // how many threads are currently active. Cant be > num_threads
  int queue_size;          
  int head, tail;          // queue head tail
  int count;               // num tasks in queue
  int shutdown;            // assert and broadcast to kill pool werkers
};

struct task{
  void (*func)(void*);     // Pointer to the function that represents a task
  void *func_args;         // Argument to pass to the function. actually a (struct merge_args *)
};

struct merge_args{
  struct record *records;     // a pointer to an array of records
  struct thread_pool *pool;   // global thread pool
  int left;                   // left index in 
  int right;
  pthread_mutex_t *done_lock;
  pthread_cond_t *done_signal;
};

// task and merge args are related in that a task will always be a call to merge_sort(), and merge_args are the args to that call
// so func_args is actually a merge_args *. 
// bc parent thread needs to sleep while 



 /*************************
   * Thread Pool Functions
  *************************/


// add a 'task' to the q -> thread workers constantly loop and 
int pool_enq(struct thread_pool *pool, void (*func)(void*), void *func_args) {
  pthread_mutex_lock(&(pool->lock));

  fprintf(stderr, "POOL_ENQ() num threads: %d, free workers: %d\n", pool->num_threads, pool->workers_free);
  if (pool->workers_free == 0 || pool->count == pool->queue_size) {
    fprintf(stderr, "POOL_ENQ() failed\n");
    pthread_mutex_unlock(&(pool->lock));
    return -1; // q is full
  }

  struct task t = {func, func_args};
  pool->queue[pool->tail] = t;
  pool->tail = (pool->tail + 1) % pool->queue_size;
  pool->count++;

  pthread_cond_signal(&(pool->notify));
  pthread_mutex_unlock(&(pool->lock));

  fprintf(stderr, "POOL_ENQ() SUCCESS\n");
  return 0;
}

// basically every thread will be here chilling waiting for a task to enq into the pool
// when a task arrives, it updates the pool structures and then merges the boots down
void *thread_pool_worker(void *arg) {
  struct thread_pool *pool = (struct thread_pool *)arg;

  while (1) {
    pthread_mutex_lock(&(pool->lock));
    while (pool->count == 0 && !pool->shutdown) { // wait for a task to get enqed
      pool->workers_free++;
      pthread_cond_wait(&(pool->notify), &(pool->lock));
      pool->workers_free--;
    }
    if (pool->shutdown) { // when destroying pool, shutdown==1, broadcast wakes every worker up and makes them die
      pthread_mutex_unlock(&(pool->lock));
      pthread_exit(NULL);
    }
    // update queue
    struct task t = pool->queue[pool->head];
    pool->head = (pool->head + 1) % pool->queue_size;
    pool->count--;
    pthread_mutex_unlock(&(pool->lock));

    // slay the boots down mama hunty
    // literally function pointers can die
    (*(t.func))(t.func_args);
  }
  return (void *) 1;
}


  // make our lil worker pool
struct thread_pool *thread_pool_create(int num_threads, int queue_size) {
  struct thread_pool *pool = (struct thread_pool *)malloc(sizeof(struct thread_pool));
  pool->num_threads = num_threads;
  pool->queue_size = queue_size;
  pool->head = 0;
  pool->tail = 0;
  pool->count = 0;
  pool->workers_free = 0;
  pool->shutdown = 0;

  // init our mutex and conditional var
  pthread_mutex_init(&(pool->lock), NULL);
  pthread_cond_init(&(pool->notify), NULL);

  pool->threads = (pthread_t *)malloc(num_threads * sizeof(pthread_t));
  pool->queue = (struct task *)malloc(queue_size * sizeof(struct task));

  // create pool workers
  for (int i = 0; i < num_threads; ++i) {
    pthread_create(&(pool->threads[i]), NULL, thread_pool_worker, (void *)pool); // launch thread: thread_pool_worker(thread_pool *pool)
  }

  return pool;
}


// drain the swamp!!!11!1!!
void thread_pool_destroy(struct thread_pool *pool) {
  pool->shutdown = 1;
  pthread_cond_broadcast(&(pool->notify)); // wakes EVERYONE up not just the next in cond signal queue
  for (int i = 0; i < pool->num_threads; ++i) {
    pthread_join(pool->threads[i], NULL);
  }

  // clean up
  free(pool->threads);
  free(pool->queue);
  pthread_mutex_destroy(&(pool->lock));
  pthread_cond_destroy(&(pool->notify));
  free(pool);
}


  /*************************
   * Sorting functions
  *************************/
void merge(struct record* records, int left, int middle, int right) {
  int n1 = middle - left + 1;
  int n2 = right - middle;

  struct record* left_array = (struct record*)malloc(n1 * sizeof(struct record));
  struct record* right_array = (struct record*)malloc(n2 * sizeof(struct record));

  //memcpy(left_array, records + (left * sizeof(struct record)), n1*sizeof(struct record));
  //memcpy(right_array, records + ((middle + 1) * sizeof(struct record)), n2*sizeof(struct record));
  for (int i = 0; i < n1; i++)
    left_array[i] = records[left + i];
  for (int j = 0; j < n2; j++)
    right_array[j] = records[middle + 1 + j];
  

  int i = 0;
  int j = 0;
  int k = left;
  while (i < n1 && j < n2) {
    if (left_array[i].key <= right_array[j].key)
      records[k++] = left_array[i++];
    else
      records[k++] = right_array[j++];
  }

  while (i < n1)
    records[k++] = left_array[i++];
  while (j < n2)
    records[k++] = right_array[j++];

  free(left_array);
  free(right_array);
}

void merge_sort(void* ma) {
  // get args
  struct record* records = ((struct merge_args *)ma)->records;
  struct thread_pool *pool = ((struct merge_args *)ma)->pool;
  int left = ((struct merge_args *)ma)->left;
  int right = ((struct merge_args *)ma)->right;
  int middle = left + (right - left) / 2;
  int left_failed = 0; // not like failed to sort, failed to get enqueued
  int right_failed = 0;
  
  if(left < right){
    // initialize left mutex stuff
    pthread_mutex_t *done_lock_left = (pthread_mutex_t *)malloc(sizeof(pthread_mutex_t));
    pthread_cond_t *done_signal_left = (pthread_cond_t *)malloc(sizeof(pthread_cond_t));
    pthread_mutex_init(done_lock_left, NULL);
    pthread_cond_init(done_signal_left, NULL);
  
    // initialize right mitex stuff
    pthread_mutex_t *done_lock_right = (pthread_mutex_t *)malloc(sizeof(pthread_mutex_t));
    pthread_cond_t *done_signal_right = (pthread_cond_t *)malloc(sizeof(pthread_cond_t));
    pthread_mutex_init(done_lock_right, NULL);
    pthread_cond_init(done_signal_right, NULL);
  
    // initialize left args
    struct merge_args *left_args = (struct merge_args *)malloc(sizeof(struct merge_args));
    left_args->records = records;
    left_args->pool = pool;
    left_args->left = left;
    left_args->right = middle;
    left_args->done_lock = done_lock_left;
    left_args->done_signal = done_signal_left;
  
    // initialize right args
    struct merge_args *right_args = (struct merge_args *)malloc(sizeof(struct merge_args));
    right_args->records = records;
    right_args->pool = pool;
    right_args->left = middle + 1;
    right_args->right = right;
    right_args->done_lock = done_lock_right;
    right_args->done_signal = done_signal_right;

    if(pool_enq(pool, merge_sort, (void *)left_args) == -1){
      // if == -1, failed to enq left
      left_failed = 1;
      left_args->done_lock = NULL; // bc this same thread is gonna do it, not a different thread
      left_args->done_signal = NULL;
      merge_sort(left_args);
    }

    if(pool_enq(pool, merge_sort, (void *)right_args) == -1){
      // if == -1, failed to enq right
      right_failed = 1;
      right_args->done_lock = NULL;
      right_args->done_signal = NULL;
      merge_sort(right_args);
    }

    // wait for children to be done, if they got enq
    if(left_failed){
      pthread_mutex_lock(done_lock_left);
      pthread_cond_wait(done_signal_left, done_lock_left);
      pthread_mutex_unlock(done_lock_left);
    }
    if(right_failed){
      pthread_mutex_lock(done_lock_right);
      pthread_cond_wait(done_signal_right, done_lock_right);
      pthread_mutex_unlock(done_lock_right);
    }

    // finally, merge results
    merge(records, left, middle, right);

    // clean
    free(left_args);
    free(done_lock_left);
    free(done_signal_left);
    free(right_args);
    free(done_lock_right);
    free(done_signal_right);
  }

  // if our signal is not null, we are gonna signal it and wake our parent thread to tell them we're done
  if(((struct merge_args *)ma)->done_lock != NULL){
    pthread_mutex_lock(((struct merge_args *)ma)->done_lock);
    pthread_cond_signal(((struct merge_args *)ma)->done_signal);
    pthread_mutex_unlock(((struct merge_args *)ma)->done_lock);
  }
}

void parallel_sort(struct record* records, int len, int num_threads) {
  struct thread_pool *pool = thread_pool_create(num_threads - 1, 2);  // literally dont know what size the queue should be now? num_threads - 1 bc main thread is gonna werk it
  struct merge_args ma = {records, pool, 0, len - 1, NULL, NULL};
  merge_sort(&ma);
  fprintf(stderr, "we're done?\n");
  thread_pool_destroy(pool);
  fprintf(stderr, "pool destroyed :D\n");
  return;
}


  /*************************
   * Main/control functions
  *************************/

int thread_sort(char *fin_name, char *fout_name, int num_threads){
  struct stat file_stats;
  FILE *f_in, *f_out;
  struct record *records;


  // initialize file / mmap
  f_in = fopen(fin_name, "r");
  if (f_in == NULL) {
    fprintf(stderr, "Failed to open the input file: %s\n", fin_name);
    return 1;
  }
  if (stat(fin_name, &file_stats) == -1) {
    fprintf(stderr, "Failed to get file information for input file\n");
    return 1;
  }
  records = (struct record *)mmap(NULL, file_stats.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fileno(f_in), 0); 
  if (records == MAP_FAILED){
    fprintf(stderr, "mmap failed lol\n");
    return 1;
  }
  fclose(f_in); // dont need to keep this open after mmap() i think

  // YEAHHHHH 
  parallel_sort(records, file_stats.st_size/sizeof(struct record), num_threads);

  // writeout
  f_out = fopen(fout_name, "w");
  if (f_out == NULL) {
    fprintf(stderr, "Failed to open the output file: %s\n", fout_name);
    return 1;
  }
  fwrite(records, sizeof(struct record), file_stats.st_size/sizeof(struct record), f_out);
  fclose(f_out);

  // cleanup
  munmap((void *)records, file_stats.st_size);
  return 0;
}



int main(int argc, char *argv[]){
  if (argc != 4) {
    printf("Usage: %s input output N\n", argv[0]);
    return 1;
  }
  fprintf(stderr, "\nstarting this shit\n");
  char *fin_name = argv[1];
  char *fout_name = argv[2];
  int num_threads = atoi(argv[3]);
  if(num_threads < 1) {
    printf("Number of threads is < 1\n");
    return 1;
  }

  struct timeval t0, t1, dt;
  gettimeofday(&t0, NULL);
  thread_sort(fin_name, fout_name, num_threads);
  gettimeofday(&t1, NULL);
  timersub(&t1, &t0, &dt);
  fprintf(stderr, "%lu.%06lu s\n", dt.tv_sec, dt.tv_usec);
  return 0;
}

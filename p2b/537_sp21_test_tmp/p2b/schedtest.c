#include "types.h"
#include "stat.h"
#include "user.h"
#include "pstat.h"

int main(int argc, char* argv[]) {

  if(argc != 6) {
    exit();
  }

  char* loop1[] = { "loop", argv[2] };
  char* loop2[] = { "loop", argv[4] };
  int slice1 = atoi(argv[1]);
  int slice2 = atoi(argv[3]);

  int child1 = -2, child2 = -2;

  struct pstat stat;
  struct pstat *addr = &stat;
  
  if(!(child1 = fork2(slice1))) {  // child process
    exec(loop1[0], loop1);
  } else {  // parent process
    if(!(child2 = fork2(slice2))) {
      exec(loop2[0], loop2);  // second child process
    } else {  //parent process
      sleep(atoi(argv[5]));

      if(getpinfo(addr)) {
        exit();  // getpinfo returned non nero value
      }
      printf(1, "%d %d\n", addr->compticks[child1], addr->compticks[child2]);
//      wait();
//      wait();
    }
    wait();
    wait();
  }
  exit();
}

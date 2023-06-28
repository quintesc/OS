#include <assert.h>
#include <bloom.h>
#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <zstd.h>

/*
 *  WizBloomZip.c
 *  -f <file> -o [output] -b [bloom_filter] -k [key]
 */

#define MAX_FILE_LINE_LEN 256

// Global variables
char *g_file_name = NULL;
char *g_output = NULL;
char *g_bloom_file = NULL;
char *g_key = NULL;

// Bloom filter parameters
int g_bloom_entries = 1000000;
float g_bloom_error = 0.01;

void print_usage() {
  printf(
      "Usage: WizBloomZip -f <file> -o [output] -b [bloom_filter] -k [key]\n");
  printf("  -f <file>          Input file\n");
  printf("  -o [output]        Output file\n");
  printf("  -b [bloom_filter]  Bloom filter file\n");
  printf("  -k [key]           Key\n");
}

// gets file size
size_t get_file_size(const char *fname) {
  struct stat fileStat;
  if (stat(fname, &fileStat) == 0) {
        printf("File size: %ld bytes\n", fileStat.st_size);
        return (size_t)fileStat.st_size;
    } else {
        printf("Failed to retrieve file information.\n");
        exit(1);
    }
}  

char *file_to_buffer(FILE *file){
    fseek(file, 0, SEEK_SET); // reset file cursor to beginnign
    fseek(file, 0, SEEK_END);
    size_t file_size = (size_t)ftell(file);
    rewind(file);
    char *buffer = malloc(file_size + 1); // for null terminator
    fread(buffer, 1, file_size, file);
    buffer[file_size] = '\0';
    return buffer;
}

void buffer_to_file(char *buffer, FILE *file, size_t buff_size){
    fwrite(buffer, sizeof(char), buff_size, file);
}



// creates a bloom filter where each entry is a line from the given file
void make_bloom(FILE *input_file){
  //printf("making a new bloom filter\n");
  struct bloom *bloom = malloc(sizeof(struct bloom));
  bloom_init2(bloom, g_bloom_entries, g_bloom_error);

  // get line, get size of line, add it to bloom filter
  char line[200];
  int str_size;
  fseek(input_file, 0, SEEK_SET); // reset file cursor to beginnign
  while (fgets(line, sizeof(line), input_file)) {
      str_size = strlen(line);
      str_size--;
      line[str_size] = '\0'; // to get rid of newline
      //printf("line has %d length\n", str_size);
      bloom_add(bloom, (void *)line, str_size);
   }
   bloom_save(bloom, g_bloom_file);
   bloom_free(bloom);
   free(bloom);
   //printf("bloom filter done\n");
}


void compress_one_file(const char *file_name) {
  //printf("Compressing: input file: %s, output file: %s\n", file_name, g_output);

  // open files
  FILE *input_file = fopen(file_name, "r");
  FILE *output_file = fopen(g_output, "w");
  if(input_file == NULL || output_file == NULL){
    printf("Error: file %s not found", file_name);
    exit(1);
  }
  //printf("Files opened uwu\n");

  // get size for compression
  size_t input_size = get_file_size(file_name);
  size_t output_size = ZSTD_compressBound(input_size) + 1;
  //printf("compression input %ld output %ld ish\n", input_size, output_size);

  // create buffer from input file 
  char *input_buff = file_to_buffer(input_file); // have to free
  char *output_buff = malloc(output_size); // have to free

  size_t actual_output_size = ZSTD_compress((void *) output_buff, output_size, (void *) input_buff, input_size, 10);
  free(input_buff);

  //printf("compressed file size: %ld\n", actual_output_size);
  printf("%ld\n%ld", input_size, actual_output_size); // for grading tests
  if(ZSTD_isError(actual_output_size)){
    printf("Error compressing idk what to do now");
  } 

  // move output buffer to output file
  buffer_to_file(output_buff, output_file, actual_output_size);
  free(output_buff);
  fclose(output_file);

  if(g_bloom_file){
    make_bloom(input_file);
  }
  fclose(input_file);
  
  //printf("compressing done\n");
}



void print_key_position(FILE *stream, const char *key, int64_t pos) {
  if (pos < 0) {
    fprintf(stdout, "Key %s not found\n", key);
    return;
  }
  fprintf(stdout, "Key %s found at line %ld\n", key, pos);
}


void find_position(const char *key, char *buffer){
    // Tokenize the string using newline as the delimiter
    char *curr_word = strtok(buffer, "\n");

    // Iterate through each word and compare with the key
    int64_t count = 0;
    while (curr_word != NULL) {
        if (strcmp(curr_word, key) == 0) {
            print_key_position(stdout, key, count);
            break;
        }
        count++;
        curr_word = strtok(NULL, "\n");
    }
}



// decompresses a file and returns it as a big string
char *decompress_file(const char *fname){
    //printf("decompresssing yass\n");
    FILE *compressed_file = fopen(fname,"r");
    if(compressed_file == NULL){
      printf("Error: file %s not found", fname);
      exit(1);
    }
    size_t comp_size = get_file_size(fname);
    char *compressed_file_buffer = file_to_buffer(compressed_file); // have to free
    fclose(compressed_file);
    size_t uncomp_size = ZSTD_getFrameContentSize((void *)compressed_file_buffer, comp_size);
    //printf("uncomp size: %ld", uncomp_size);
    char *decompressed_file_buffer = malloc(sizeof(char) * uncomp_size);
    size_t decomp_size_actual = (size_t) ZSTD_decompress(decompressed_file_buffer, uncomp_size, compressed_file_buffer, comp_size);
    if(ZSTD_isError(decomp_size_actual)){
      printf("Error decompressing idk what to do now");
    } 
    //printf("sizes: compressed %ld uncompressed %ld\n actual uncompressed %ld", comp_size, uncomp_size, decomp_size_actual)
    free(compressed_file_buffer);
    return decompressed_file_buffer; 
}



void query_bloom(const char *fname, const char *key) {
  //printf("looking in bloom for key %s with length %ld\n", key, strlen(key));
  struct bloom *bloom = malloc(sizeof(struct bloom));
  bloom_load(bloom, g_bloom_file);
  if(bloom_check(bloom, key, strlen(key))){ // key may be in set
    char *decomp_buff = decompress_file(fname);
    find_position(key, decomp_buff);
    free(decomp_buff);
  } else { // definitely not in set
    print_key_position(stdout, key, -1);
  }
  bloom_free(bloom);
  free(bloom);
}



void query_one_key(const char *fname, const char *key) {
  if(g_bloom_file){ // querying with bloom
    query_bloom(fname, key);
  } else {
    char *decomp_buff = decompress_file(fname);
    find_position(key, decomp_buff);
    free(decomp_buff);
  }
}



int main(int argc, char *argv[]) {
  int opt;
  // parse command line arguments
  while ((opt = getopt(argc, argv, "f:o:b:k:")) != -1) {
    switch (opt) {
      case 'f':
        // input file
        g_file_name = optarg;
        break;
      case 'o':
        // output file
        g_output = optarg;
        break;
      case 'b':
        // bloom filter file
        g_bloom_file = optarg;
        break;
      case 'k':
        // key
        g_key = optarg;
        break;
      default:
        // print usage
        print_usage();
        exit(EXIT_FAILURE);
        break;
    }
  }
    
  // if input file
  if (g_file_name) {
    if (g_key) {
      // query instead of compressing
      query_one_key(g_file_name, g_key);
    } else {
      assert(g_output);
      compress_one_file(g_file_name);
    }
  } else {
    print_usage();
    exit(EXIT_FAILURE);
  }

  return 0;
}



 

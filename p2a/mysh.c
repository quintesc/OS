/******************************************************************************
 * @file: shell.c
 * @creator: Andres Quintanal Escandon
 *****************************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

// Some macros 
#define DEBUG               0 
#define dbgprintf(...)      if (DEBUG) { printf(__VA_ARGS__); }

#define printflush(fd, fmt, ...) \
    do { \
        fprintf(fd, fmt, ##__VA_ARGS__); \
        fflush(fd); \
    } while(0)

#define MAX_CMD_LEN 512
#define MAX_ARGS 50

void interactive_mode();
void batch_mode(char *filename);
void do_command(char *command);

/******************************************************************************
 * Helper functions
 *****************************************************************************/

/*
 * Checks if a character is a letter
 *
 * @param ch the character to check
 * @return ture if it's a letter, false otherwise
 */

//char *strtok(char *str, const char *delim);
void test(){
  char strong[] = "      Once there was your mom eating       pussy \n";
  char *dest;

  printflush(stdout, "WTF\n");
  dest = strtok(strong, " ");
  printflush(stdout,"DONE\n");
  printflush(stdout, "%s\n", dest);

  for(int i = 0; i < 7; i++){
    dest = strtok(NULL, " ");
    printflush(stdout, "%s\n", dest);
  }
  return;

  // conclusion: it does ignore a lot of spaces together, pero tipo si hay un espacio un tab y luego otro espacio trata el tab como su propia token
  // what about newlines? Y nuestro command tendra newlines o nel? porq creo que el del batch file will pero no el del interactive

  // ok entonces en interactive mode, va a ser el command y ya sin newline.
  // strtok si considera un newline como otro token, igual que tab.
}

int main(int argc, char *argv[]){

 test();


  if(argc == 1) {           
    interactive_mode();
  } else if (argc == 2) {   // running in batch mode, batch filename given in argv[1]
    batch_mode(argv[1]);
  } else {                  // error. only have 1 argument and that's the batch file name
    printflush(stderr, "Usage: mysh [batch-file]\n");
    exit(1);
  }
  return 0;
}


/*
 * Runs shell in interactive mode, ie what we're used to:
 * mysh> command_to_run -flags -args etc
 */
void interactive_mode(){
  char command[MAX_CMD_LEN + 1]; // will hold our command :3

    printflush(stdout,"mysh> ");
    scanf("%512s",command); // TODO what if user input doesnt fit in command?
    do_command(command);
}


/*
 * Runs shell in batch mode, which reads commands from a file
 * Each line in the file must be a single command, with a maximum command length of 512
 * 
 * @param filename the name of the bathc file to open
 */
void batch_mode(char *filename){
  char command[MAX_CMD_LEN + 1];

  FILE *batch = fopen(filename, "r");
  if(batch == NULL){
    printflush(stderr,"Error: Cannot open file %s.\n", filename);
    exit(1);
  }

  // go through all the commands in the file
  while(fgets(command, MAX_CMD_LEN + 1, batch) != NULL){ // TODO have to check each line isnt bigger than 512, but idk how?
    printflush(stdout, "%s", command); // have to print each command we're running
    do_command(command);
  }
  return;
}

/*
 * Takes a command to excecute and creates a new process that excecutes it
 * 
 * 
 * @param command
 */
void do_command(char *command){
  //char *args[50]; 

}


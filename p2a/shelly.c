/******************************************************************************
 * @file: shelly.c
 * @creator: Andres Quintanal Escandon
 * @desc: Implementation of basic UNIX-like shell
 *****************************************************************************/
#include "shelly.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <ctype.h>


// GLOBALS
struct node *alias_head = NULL; // alias linked list 



int main(int argc, char *argv[]){
  if(argc == 1) {           
    interactive_mode();
  } else if (argc == 2) {   // running in batch mode, batch filename given in argv[1]
    batch_mode(argv[1]);
  } else {                  // error. only have 1 argument and that's the batch file name
    printflush(stderr, "Usage: mysh [batch-file]\n");
    exit(1);
  }
  free_alias();
  return 0;
}



void interactive_mode(){
  char command[MAX_CMD_LEN + 1]; // will hold our command :3
  int done;

  done = 0;
  while(!done){
    printflush(stdout,"shelly> ");
    if(fgets(command, MAX_CMD_LEN + 1, stdin) == NULL) return; // TODO size errs
    dbgprintf("command interactive mode: %s\n", command);
    done = do_command(command);
    dbgprintf("back\n");
  }
}



void batch_mode(char *filename){
  int done;
  char command[MAX_CMD_LEN + 1];
  FILE *batch;

  batch = fopen(filename, "r");
  if(batch == NULL){
    printflush(stderr,"Error: Cannot open file %s.\n", filename);
    exit(1);
  }

  // go through all the commands in the batch file
  done = 0;
  while((fgets(command, MAX_CMD_LEN + 1, batch) != NULL) && !done){ // get next command or NULL if EOF  TODO size errs
    printflush(stdout, "%s", command); // have to print each command we're running 
    done = do_command(command);
  }
  return;
}



int do_command(char *command){
  char *cmd_backup;
  char *args[MAX_ARGS + 1]; // each element is an arg
  int num_args;
  pid_t rc;
  int alias_found;
  int redir;
  FILE *r_file = NULL;
  char *r_fname = NULL;


  cmd_backup = strdup(command);
  cmd_backup[strlen(cmd_backup) - 1] = '\0'; // get rid of newline



  // check raw command for aliases:
  dbgprintf("command do_command b4 alias: %s\n", command);
  alias_found = find_alias(&command);
  dbgprintf("command do_command post alias: %s\n", command);
    
  //redirect
  redir = redirect(command, &r_fname);
  if(!redir) return 0; // wrongly formatted redirection
  

  // break command into pieces we can send to execv
  num_args = parse_args(args, command);
  if(num_args == 0) return 0;
  args[num_args] = NULL; // for execv, has to be null terminated

  // handle exit and alias cases -> built-in commands not executed by execv
  if(!strcmp(args[0],"alias")){
    dbgprintf("command: alias\n");
    alias(args, num_args);
    if(alias_found) free(command); // dont think this will ever happen but just in case?
    free(cmd_backup);
    return 0;
  }
  if(!strcmp(args[0],"unalias")){
    if(num_args != 2){
      printflush(stderr, "unalias: Incorrect number of arguments.\n");
      return 0;
    }
    unalias(args[1]);
    if(alias_found) free(command);
    free(cmd_backup);
    return 0;
  }
  if(!strcmp(args[0], "exit") && num_args == 1){
    dbgprintf("command: exit\n");
    if(alias_found) free(command);
    free(cmd_backup);
    return 1;
  }

  if(r_fname != NULL){
    r_file = fopen(r_fname, "w+"); 
    if(r_file != NULL) dbgprintf("opened file %s\n", r_fname);
    if(r_file == NULL){
      printflush(stdout, "Cannot write to file %s.\n", r_fname);
      return 0;
    }
  }

int test;
  rc = fork(); // big dick moves
  if(rc < 0){ // fork failed
    printflush(stderr, "%s: Command not found.\n", cmd_backup);
  } else if (rc == 0){ // child process
    if(r_file){
      test = dup2(fileno(r_file), STDOUT_FILENO);
      if(test == -1) dbgprintf("redirectation failed, dup2 returned -1\n");
    }
    dbgprintf("Hewwo im child pid=%d\n", (int)getpid());
    execv(args[0], args);
    printflush(stderr, "%s: Command not found.\n", cmd_backup);
    _exit(0);
  } else { // parent process
    waitpid(rc, NULL, 0); // wait for child to end? idk if this does that
  }
   
  if(alias_found) free(command);
  if(r_file) fclose(r_file);
  free(cmd_backup);
  return 0;

}



int parse_args(char *args[], char *command){
  int num_args = 0;
  char *curr_arg;

  dbgprintf("starting parsing\n");
  curr_arg = strtok(command," \t\r\n\v\f");
  if(curr_arg == NULL) return num_args;   // blank command

  while(curr_arg != NULL && num_args < MAX_ARGS){
    dbgprintf("curr_arg= %s\n", curr_arg);
    args[num_args] = curr_arg;
    curr_arg = strtok(NULL, " \t\r\n\v\f");
    num_args++; // TODO what if we exceed MAX ARGS? error
  }
  dbgprintf("finished parsing\n");
  return num_args;
}



void alias(char *args[], int num_args){
  struct node *curr = alias_head;
  char *key; 
  char *value;
  size_t value_size;

  // command is just "alias" -> print all aliases
  if(num_args == 1){
    while(curr != NULL){
      printflush(stdout, "%s %s\n", curr->key, curr->value);
      curr = curr->next;
    }
    return;
  }

  // alias x -> if x is an alias, print it and its replacement
  if(num_args == 2){
    while(curr != NULL){
      if(!strcmp(args[1], curr->key)){
        printflush(stdout, "%s %s\n", curr->key, curr->value);
        return;
      }
      curr = curr->next;
    }
    return;
  }

  // words arent allowed: alias, unalias, exit
  if(!strcmp("exit", args[1]) || !strcmp("alias", args[1]) || !strcmp("unalias", args[1])){
    printflush(stderr, "alias: Too dangerous to alias that.\n");
    return; // TODO error handling
  }

  key = malloc(sizeof(args[1]) + 1); 
  strcpy(key, args[1]);


  // get string size of alias value
  value_size = 0;
  for(int i = 2; i < num_args; i++){ // start i=2 bc we wanna skip "alias xxxx"
    value_size += sizeof(args[i]) + sizeof(' ');
  }


  value = malloc(value_size + 1);
  value[0] = '\0';
  for(int i = 2; i < num_args; i++){
    strcat(value, args[i]);
    strcat(value, " ");
  }
  value[strlen(value)-1] = '\0';
  dbgprintf("new alias: %s = %s\n", key, value);

  while(curr != NULL){
    if(!strcmp(key, curr->key)){ // if key already exists, replace value
      free(key); // because it already exists, so we dont need to add it again
      free(curr->value);
      curr->value = value;
      return;
    }
    curr = curr->next;
  }
  curr = malloc(sizeof(struct node));
  curr->key = key;
  curr->value = value;
  curr->next = alias_head;
  alias_head = curr;
}



int find_alias(char **command){
  // summary: find first arg. find alias. copy alias + everything from og command except first arg to a new string. 
  char *cmd_backup; // so we dont edit og command in case we return that
  char *cmd_parse; 
  int first_arg_len;
  //size_t first_arg_size;
  char *new_command;
  struct node *curr;

  cmd_backup = strdup(*command); // bc we're gonna strtok and we dont wanna mess with og string
  cmd_parse = strtok(cmd_backup, " \t\r\n\v\f"); // get first arg -> the only one that can be aliased
  if(cmd_parse == NULL) return 0; // command is blank space
  first_arg_len = strlen(cmd_parse); 
  //first_arg_size = sizeof(cmd_parse);
  curr = alias_head;

  dbgprintf("First arg: %s\n", cmd_parse);

  while(curr != NULL){
    dbgprintf("while Command: %s", *command); // ls -a
    if(!strcmp(cmd_parse, curr->key)){
      for(int i = 0; i < first_arg_len + 1; i++){ // move cmd_backup to the start of the rest of the command post alias. + 1 for null term from strtok
        cmd_parse++; 
        dbgprintf("cmd_parse++: %s\n", cmd_parse);
      }
      new_command = malloc(sizeof(char)*strlen(cmd_parse) + sizeof(char)*strlen(curr->value) + sizeof(" \0"));
      strcpy(new_command, curr->value);
      strcat(new_command, " ");
      strcat(new_command, cmd_parse);
      *command = new_command;
      dbgprintf("new command: %s\n", *command);
      free(cmd_backup);
      dbgprintf("new command: %s\n", *command);
      return 1;
    }
    curr = curr->next;
  }
  free(cmd_backup);
  return 0;
}



void unalias(char *arg){
  struct node *curr;
  struct node *prev;

  prev = NULL;
  curr = alias_head;

  while(curr != NULL){
    if(!strcmp(arg, curr->key)){
      dbgprintf("is this the issue?\n");
      free(curr->value);
      free(curr->key);
      dbgprintf("or is it here?\n");
      if(prev != NULL){
        prev->next = curr->next;
      } else {
        alias_head = curr->next;
      }
      dbgprintf("or heree?\n");
      free(curr);
      dbgprintf("nae nae\n");
      return;
    }
    prev = curr;
    curr = curr->next;
  }
}



void free_alias(){
  struct node *curr = alias_head;
  struct node *temp;
  while(curr != NULL){
    free(curr->key);
    free(curr->value);
    temp = curr;
    curr = curr->next;
    free(temp);
  }
  return;
}



int redirect(char *command, char **file_name){
  char *file_pos;
  char *redir_pos;

  dbgprintf("redir: command gotten: %s\n", command);

  redir_pos = strchr(command, '>');
  if(redir_pos == NULL){
    return -1;
  }
  dbgprintf("redir: before >= null: %s\n", command);
  *redir_pos = '\0'; // clean up command so when parsing later on, we dont parse the redirection
  dbgprintf("redir: after >= null: %s\n", command);
  redir_pos++;
  dbgprintf("redir: everything after > : %s\n", redir_pos);

  // check we have a command before the >
  char *cmd_backup = strdup(command);
  if(strtok(cmd_backup," \t\r\n\v\f") == NULL){
    free(cmd_backup);
    printflush(stderr, "Redirection misformatted.\n");
    return 0;
  }
  free(cmd_backup);

  // get file name
  file_pos = strtok(redir_pos, " \t\r\n\v\f");
  dbgprintf("redir: file_name: %s\n", file_pos);

  // no file name after >
  if(file_pos == NULL){
    printflush(stderr, "Redirection misformatted.\n");
    return 0;
  }
  *file_name = file_pos;

  // check if there is more than 1 arg after >
  file_pos = strtok(NULL, " \t\r\n\v\f");
  if(file_pos != NULL){
    printflush(stderr, "Redirection misformatted.\n");
    return 0;
  }
return 1;
}

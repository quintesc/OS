/******************************************************************************
 * @file: shelly.h
 * @creator: Andres Quintanal Escandon
 * @desc: Contains macros, structs, function declarations and documentation for shelly.c
 *****************************************************************************/
#ifndef SHELLY_H_
#define SHELLY_H_


// printf with on/off switch, set DEBUG to 0 when running automated tests
#define DEBUG               0
#define dbgprintf(...)      if (DEBUG) { printf(__VA_ARGS__); }


// for automated tests & running multiple processes at once, want printf to flush immediately instead of buffering
#define printflush(fd, fmt, ...) \
    do { \
        fprintf(fd, fmt, ##__VA_ARGS__); \
        fflush(fd); \
    } while(0)


// these are defined but we dont really do any error checking to make sure theyre being followed
#define MAX_CMD_LEN 512
#define MAX_ARGS 99


// simple linked list
struct node{
    struct node *next;
    char *key;
    char *value;
};


/********************************
*           FUNCTIONS
********************************/


/**
 * Runs shell in interactive mode, ie what we're used to:
 * mysh> command_to_run -flags -args 
 */
void interactive_mode();


/**
 * Runs shell in batch mode, which reads commands from a file
 * Each line in the file must be a single command, with a maximum command length of 512 chars
 * 
 * @param filename The name of the batch file to read from
 */
void batch_mode(char *filename);


/**
 * Takes a command to excecute and creates a new process that excecutes it
 * @param command The command to execute
 * @return 1 if command is exit, 0 otherwise
 */
int do_command(char *command);


/**
 * Parses a command and breaks it up into its components
 *
 * @param args Array of strings where each token of the command will be placed
 * @param command Command to parse
 * @return number of arguments (including the base command to run eg "ls -a" will return 2)
 */
int parse_args(char *args[], char *command);


/**
 * Adds an alias to the list of aliases
 * If an alias already exists, replaces the alias value
 *
 * @param args Array of strings, tokenized command
 * @param num_args the number of arguments in command
 */
void alias(char *args[], int num_args);


/**
 * Look for an alias. If alias exists, replace *command with a new (malloced) string with alias replaced
 *
 * @param command: pointer to command string to parse for aliases
 * @return 1 if alias found and have to free command, 0 if alias not found
 */
int find_alias(char **command);


/**
 * Removes an alias from the alias list
 * Nothing happens if alias not in list
 *
 * @param arg The alias to unalias
 */
void unalias(char *arg);


/**
 * Frees the alias list memory
 */
void free_alias();


/**
 * Checks if a command has redirection, designated by '>'
 * Truncates command string at '>' if found
 * 
 * @param command String to check for redirection
 * @param file_name Will set *file_name to the one specified by redirection
 * @return -1 if no redirection, 0 if redirection is misformatted, 1 if redirection exists and is succesful
 */
int redirect(char *command, char **file_name);

#endif // SHELLY_H

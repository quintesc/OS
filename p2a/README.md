# shelly.c
This is the third project in CS537, in which I had to implement a unix-like shell.  with fork() and exec() to start new processes, and

## Features:
### Aliasing
The user can add their own aliases to the shell by typing 'alias <key> <value>'. By doing this, the user can call <value> by simply typing <key>. For example, 'alias ls /usr/bin/ls' will add ls to the list of aliases, and the user will be able to call /usr/bin/ls by simply typing ls

You can also remove an alias by typing 'unalias <alias-key>'

If you want to see what aliases you have registered, simply type 'alias'

If you want to see the value of an alias, type 'alias <key>'

### Output redirection
Like with the normal shell, the user can redirect a command's outputs to a file by using the '>' character. Redirection has to follow this pattern: '<command> > <output_file>'. If there is more than one output file, no command, multiple '>' symbols, or any other misformatted redirections, the command will not run and the shell will rint out a message.

### Batch file processing
The user can write batch files to run several commands without having to type them all out. The file must have one command per line, and it **doesnt** need to end with the 'exit' command. To use batch mode, run 'shelly [batch-file-name]'

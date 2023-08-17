# Build by running 'make shelly' or simply 'make'
# Clean by running 'make clean'

# A couple standard variables:
# C Compiler
CC=gcc
# C Flags
CFLAGS=-Wall -Werror -pthread -O

# Main build command
psort: psort.c
	$(CC) $(CFLAGS) -o psort psort.c -I.


# .PHONY means this command does not actually produce an output file
.PHONY: clean
clean:
	rm -rf mysh

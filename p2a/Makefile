# Build by running 'make shelly' or simply 'make'
# Clean by running 'make clean'

# A couple standard variables:
# C Compiler
CC=gcc
# C Flags
CFLAGS=-Wall -Werror -g

# Main build command
shelly: shelly.c
	$(CC) $(CFLAGS) -o shelly shelly.c -I.


# .PHONY means this command does not actually produce an output file
.PHONY: clean
clean:
	rm -rf mysh

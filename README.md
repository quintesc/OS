# OS
Projects from my Operating Systems course, CS537 at UW-Madison

##p1a- File compression. 
This project was intended to get us warmed up with C and get comfortable with it. The program uses zstd to compress files and decompress them, as well as libbloom to create bloom filters where each entry is a line of the file you're compressing. The program also has command line arguments to search for a key in a compressed file, and if a bloom filter is created when compressing it also checks the filter to see if the key is not in the compressed file

##p1b - System Calls. 
We used the xv6 OS simulator and the objective was to add another system call to the OS. In this case it we had to implement getfdcount(), which tells you how many file descriptors the current process has open. Although it was not a lot of coding on my part, it was a lot of reading through code, understanding how it works and how to expand upon an existing code base

##p2a - Shell
In this project I had to implement a shell capable of executing commands both from the shell command line and from a batch file. It also allows for output redirection and is able to use aliases.

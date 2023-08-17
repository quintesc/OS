# OS
Projects from my Operating Systems course, CS537 at UW-Madison

##p1a- File compression. 
This project was intended to get us warmed up with C and get comfortable with it. The program uses zstd to compress files and decompress them, as well as libbloom to create bloom filters where each entry is a line of the file you're compressing. The program also has command line arguments to search for a key in a compressed file, and if a bloom filter is created when compressing it also checks the filter to see if the key is not in the compressed file

##p1b - System Calls. 
We used the xv6 OS simulator and the objective was to add another system call to the OS. In this case it we had to implement getfdcount(), which tells you how many file descriptors the current process has open. Although it was not a lot of coding on my part, it was a lot of reading through code, understanding how it works and how to expand upon an existing code base

##p2a - Shell
In this project I had to implement a shell capable of executing commands both from the shell command line and from a batch file. It also allows for output redirection and is able to use aliases.

##p2b - Scheduler
Here I had to replace xv6's default round robin process scheduler with a new scheduler that would reward processes for sleeping/yielding by giving them longer times to use the CPU later on. It... doesn't really work and none of the grading tests passed. It was still interesting seeing how an actual scheduler is implemented, what you can do to change it, and what considerations you have to make

##p3a - Memory 'encryption'
So for this project I messed with the memory system and data structures of xv6 which was super fun. What we had to do was implement a system call that would 'encrypt' a page by flipping all the bits in the specified page ranges. If a user requested data from a page that was encrypted, we had to decrypt it first and then the user cold have it. This was accomplished by adding a bit to each page's PTE to tell if it was encrypted or not, and make the OS page fault when trying to access an encrypted page.

Probably my favorite project in the class. Having taken computer architecture last semester and learning about physical and virtual addresses, page tables and PTEs, it was extremely interesting to see how that is implemented in code. 

##p3b
This was an optional project where we had to implement a multithreaded sorting algorithm using pthreads. This was the first time I have used multiple threads, as well as locks and condition variables for an application and it was much harder than I expected. Like, I knew the basics of how locks and mutex works, but had never coded anything with them before and ran into a lot of issues on how to dispatch new threads, my program getting deadlocked, things not being sorted correctly, but in the end I worked it out.

I implemented merge sort by making a thread pool where we can send work requests to sort/merge to other threads.

When actually running and timing this with 1, 2, 3, and 4 threads there was a slight speedup but not really anything substantial, so I think that could defnitely improve, but I still learnt about how to make a thread pool, using multiple threads, and synchronising them. Really fun


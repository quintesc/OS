#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

#define MAX_FD 9
int fd_array[MAX_FD];
char *fd_name = "test.txt0";

void test_fd_open(int num_fd) {
  int i;
  for (i = 0; i < num_fd; i++) {
    fd_array[i] = -1;
    fd_name[8] = '0' + i;  // test.txt0, test.txt1, test.txt2, ...
    fd_array[i] = open(fd_name, O_CREATE | O_RDWR);
    if (fd_array[i] < 0) {
      printf(1, "open failed\n");
      return;
    }
  }
}

void test_fd_close(int num_fd) {
  int i;
  for (i = 0; i < num_fd; i++) {
    if (fd_array[i] >= 0) {
      int ret = close(fd_array[i]);
      if (ret == 0)
        printf(1, "close fd:%d success\n", fd_array[i]);
      else
        printf(1, "close fd:%d failed\n", fd_array[i]);
    }
  }
}

void test_print(int num_fd_open, int num_closed) {
  printf(1, "%d %d\n", num_fd_open, num_closed);
}

void test() {
  int open_nums = 5;
  int total_nums = 9;

  // let's test here
  int num_closed = 0;
  int num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);

  test_fd_open(open_nums);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);

  test_fd_close(open_nums);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);

  test_fd_open(open_nums);
  test_fd_close(open_nums + 2);
  test_print(num_fd_open, num_closed);

  test_fd_open(total_nums - num_fd_open);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);

  test_fd_close(total_nums - 1);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);

  test_fd_open(16);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);

  test_fd_close(MAX_FD);
  num_fd_open = getfdcount(&num_closed);
  test_print(num_fd_open, num_closed);
}

int main(int argc, char *argv[]) {
  test();
  exit();
}

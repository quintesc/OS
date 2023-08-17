#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char* argv[]) {
    
  int sleepT = atoi(argv[0]);
  sleep(sleepT);
  int i = 0, j = 0;
  while (i < 800000000) {
    j += i * j + 1;
    i++;
  }
  exit();
}

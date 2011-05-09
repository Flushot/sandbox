/**
 * FizzBuzz
 * by Chris Lyon
 */
#include <stdio.h>

extern int fizzy(int start, int end);

int usage(char *exename) {
  printf("usage: %s <start> <end>\n", exename);
  return -1;
}

int main(int argc, char **argv) {
  // get args
  if (argc < 3)
    return usage(argv[0]);
  int start = atoi(argv[1]);
  int end = atoi(argv[2]);
  if (start <= 0 || end <= 0)
    return usage(argv[0]);

  // fizzbuzz
  int fizz_c = fizzy(start, end);
  
  // display return value
  printf("fizzed %i time", fizz_c);
  if (fizz_c > 1)
    printf("s");
  printf("\n");
}

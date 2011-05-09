/**
 * FizzBuzz
 * by Chris Lyon
 */
#include <stdio.h>
#include <string.h>
#include <malloc.h>

// defined in fizz.asm
extern int fizzy(int start, int end);

int usage(char *exename) {
  printf("usage: %s <start> <end>\n", exename);
  return -1;
}

char *pluralize(int count, char *word) {
  int ilen = strlen(word);
  char *plural = (char *)malloc(sizeof(char) * ilen + 2);
  strcpy(plural, word);
  if (count != 1 && word[ilen - 1] != 's')
    strcat(plural, "s");
  return plural;
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
  char *times = pluralize(fizz_c, "time");
  printf("fizzed %i %s\n", fizz_c, times);
  free(times);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>

/* Executes external fizz.asm -> fizzy(), which displays output to stdout. */
extern int fizzy(      /* [ret] Number of "fizz" that occurred. */
	    int start, /* [in] Starting number (e.g. 0) */
            int end);  /* [in] Ending number (e.g. 100) */

/* Show CLI usage syntax and exit. */
void die_usage(char **argv) { /* [in] Arguments. */
  printf("usage: %s <start> <end>\n", argv[0]);
  exit(1);
}

/* Pluralize a single word. */
char *pluralize(    /* [ret] Pluralized word (caller must free()) or 0 if error. */
      int count,    /* [in] Counted instances of word (0 < singular < plural). */
      char *word) { /* [in] Word to pluralize (e.g. "fish"). */
  int ilen = strlen(word);
  
  /* Allocate pluralized buffer. */
  char *plural = (char *)malloc(sizeof(char) * ilen + 2);
  if (!plural) {
    fprintf(stderr, "Out of memory!");
    return 0;
  }
  
  strcpy(plural, word);
  if (count != 1 && word[ilen - 1] != 's')
    strcat(plural, "s"); /* Append 's' if count != 1. */

  return plural;
}

/* Program entry point. */
int main(int argc, char **argv) {
  /* Get and validate arguments. */
  if (argc != 3) die_usage(argv);
  int start = atoi(argv[1]), end = atoi(argv[2]);
  if (start <= 0 || end < start) die_usage(argv);

  /* Invoke external (asm) function. */
  int fizz_count = fizzy(start, end);
  
  /* Display number of fizzes. */
  char *times = pluralize(fizz_count, "time");
  if (times) {
    printf("fizzed %i %s\n", fizz_count, times);
    free(times);
  }

  return 0;
}

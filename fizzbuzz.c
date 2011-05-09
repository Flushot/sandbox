/**
 * FizzBuzz
 * Useless assembly test app
 *
 * @version 1.5
 * @author Chris Lyon
 */
#include <stdio.h>
#include <string.h>
#include <malloc.h>

/**
   Executes and displays fizzbuzz

   @param[in] start Starting number
   @param[out] end Ending number
   @return Number of fizzes that occurred
 */
extern int fizzy(int start, int end);

/**
   Displays command usage info

   @param[in] exename Executable name (argv[0])
   @return Error code to return to shell
 */
int usage(char *exename) {
  printf("usage: %s <start> <end>\n", exename);
  return -1;
}

/**
   Pluralizes a word

   @param[in] count Count used to determine pluralization
   @param[in] word Word to pluralize based on count
   @return Pluralized word (must be free'd by caller)
 */
char *pluralize(int count, char *word) {
  int ilen = strlen(word);
  char *plural = (char *)malloc(sizeof(char) * ilen + 2);
  strcpy(plural, word);
  if (count != 1 && word[ilen - 1] != 's')
    strcat(plural, "s");
  return plural;
}

/**
   Entry point
 */
int main(int argc, char **argv) {
  // Get arguments
  if (argc < 3)
    return usage(argv[0]);
  int start = atoi(argv[1]);
  int end = atoi(argv[2]);
  if (start <= 0 || end <= 0)
    return usage(argv[0]);

  // fizzbuzz
  int fizz_c = fizzy(start, end);
  
  // Display number of fizzes
  char *times = pluralize(fizz_c, "time");
  printf("fizzed %i %s\n", fizz_c, times);
  free(times);
}

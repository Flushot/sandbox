#ifndef __FIZZY_H__
#define __FIZZY_H__

/* Executes external fizz.asm -> fizzy(), which displays output to stdout. */
extern int fizzy(      /* [ret] Number of "fizz" that occurred. */
	    int start, /* [in] Starting number (e.g. 0) */
            int end);  /* [in] Ending number (e.g. 100) */

#endif

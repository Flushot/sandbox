#include <jni.h>
#include "JFizz.h"

/* Executes external fizz.asm -> fizzy(), which displays output to stdout. */
extern int fizzy(      /* [ret] Number of "fizz" that occurred. */
	    int start, /* [in] Starting number (e.g. 0) */
            int end);  /* [in] Ending number (e.g. 100) */

/*
 * Class:     JFizz
 * Method:    fizzy
 * Signature: (II)I
 */
JNIEXPORT jint JNICALL Java_JFizz_fizzy(JNIEnv *env, jclass obj, jint start, jint end) {
  /* Proxy to assembly EP. */
  return fizzy(start, end);
}

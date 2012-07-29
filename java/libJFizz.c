#include <jni.h>
#include "JFizz.h"
#include "../fizzy.h"

/* Wrapper function */
JNIEXPORT jint JNICALL Java_JFizz_fizzy(JNIEnv *env, jclass obj, jint start, jint end) {
  return fizzy(start, end);
}

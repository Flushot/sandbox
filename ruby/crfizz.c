#ifdef WIN32
#include "windows.h"
#endif

#include "ruby.h"

static VALUE _module;

/* Executes external fizz.asm -> fizzy(), which displays output to stdout. */
extern int fizzy(      /* [ret] Number of "fizz" that occurred. */
	    int start, /* [in] Starting number (e.g. 0) */
            int end);  /* [in] Ending number (e.g. 100) */

static VALUE fizzy_wrapper(VALUE self, VALUE start, VALUE end) {
  return INT2FIX(fizzy(NUM2INT(start), NUM2INT(end)));
}

/* Initialize and declare bindings */
#ifdef WIN32
_declspec(dllexport)
#endif
void Init_crfizz() {
  _module = rb_define_module("CRFizz");
  rb_define_module_function(_module, "fizzy", fizzy_wrapper, 2);
}

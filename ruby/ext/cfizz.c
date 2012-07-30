#ifdef WIN32
#include "windows.h"
#endif

#include "ruby.h"
#include "../../fizzy.h"

/* Wrapper function */
static VALUE cfizz_fizzy(VALUE self, VALUE start, VALUE end) {
  return INT2FIX(fizzy(NUM2INT(start), NUM2INT(end)));
}

/* Initialize and bind */
static VALUE _module;
#ifdef WIN32
_declspec(dllexport)
#endif
void Init_cfizz() {
  _module = rb_define_module("CFizz");
  rb_define_module_function(_module, "fizzy", cfizz_fizzy, 2);
}

#ifndef PHP_FIZZ_H
#define PHP_FIZZ_H 1

#define PHP_FIZZY_VERSION "1.0"
#define PHP_FIZZY_EXTNAME "fizzy"

PHP_FUNCTION(fizzy);

extern zend_module_entry fizzy_module_entry;
#define phpext_fizzy_ptr &fizzy_module_entry;

#endif

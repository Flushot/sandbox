#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "php_fizz.h"
#include "../fizzy.h"

static function_entry fizzy_functions[] = {
  PHP_FE(fizzy, NULL)
  { NULL, NULL, NULL }
};

zend_module_entry fizzy_module_entry = {
#if ZEND_MODULE_API_NO >= 20010901
  STANDARD_MODULE_HEADER,
#endif
  PHP_FIZZY_EXTNAME,
  fizzy_functions,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
#if ZEND_MODULE_API_NO >= 20010901
  PHP_FIZZY_VERSION,
#endif
  STANDARD_MODULE_PROPERTIES
};

#ifdef COMPILE_DL_FIZZY
ZEND_GET_MODULE(fizzy)
#endif

/* Module init */
PHP_MINIT_FUNCTION(fizzy) {
  ZEND_INIT_MODULE_GLOBALS(fizzy, php_fizzy_init_globals, NULL);
  REGISTER_INI_ENTRIES();
  return SUCCESS;
}

/* Request init */
PHP_RINIT_FUNCTION(fizzy) {
  return SUCCESS;
}

PHP_FUNCTION(fizzy) {
  int results = fizzy(1, 5);
  RETURN_LONG((long)results);
}

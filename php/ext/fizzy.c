#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "fizzy.h"
#include "../../fizzy.h"

static zend_function_entry fizzy_functions[] = {
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

PHP_FUNCTION(fizzy) {
    int results = fizzy(1, 5);
    RETURN_LONG((long)results);
}

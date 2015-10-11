PHP_ARG_ENABLE(fizzy, whether to enable FizzBuzz support,
[ --enable-fizzy      Enable FizzBuzz support])

if test "$PHP_FIZZY" = "yes"; then
   AC_DEFINE(HAVE_FIZZY, 1, [Whether you have FizzBuzz])
   PHP_ADD_LIBRARY_WITH_PATH(fizzy.o, ../../, FIZZY_SHARED_LIBADD)
   PHP_NEW_EXTENSION(fizzy, fizzy.c, $ext_shared)
fi

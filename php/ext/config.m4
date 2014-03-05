PHP_ARG_ENABLE(fizzy, whether to enable FizzBuzz support,
[ --enable-fizzy      Enable FizzBuzz support])

if test "$PHP_FIZZY" = "yes"; then
   AC_DEFINE(HAVE_FIZZY, 1, [Whether you have FizzBuzz])
   PHP_NEW_EXTENSION(fizzy, fizz.c, $ext_shared)
fi

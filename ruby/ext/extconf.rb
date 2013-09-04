require 'mkmf'
$CFLAGS << ' -Wextra -Wall -pedantic -m32 '
#$LDFLAGS << ' -m32 '
create_makefile('cfizz')

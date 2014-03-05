CC = gcc
CFLAGS = -Wall -O0 -g -ansi -m32

.PHONY: fizz test node_check

all: fizz

node_check:
	[ "`node -pe "process.arch"`" == "i386" ]

fizz: fizz.js libfizz.so
	npm install ffi --arch=ia32

libfizz.so: ../fizzy.o
	$(CC) $(CFLAGS) -shared -read_only_relocs suppress -o libfizz.so ../fizzy.o
	ln -s libfizz.so libfizz.dylib

test: all
	time ./fizz 1 5

clean:
	rm -f libfizz.so libfizz.dylib
	rm -rf node_modules

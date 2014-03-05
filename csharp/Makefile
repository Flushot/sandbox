CC = gcc
CFLAGS = -Wall -O0 -g -ansi -m32

.PHONY: fizz test

all: fizz

fizz: CSFizz.cs libcsfizz.so
	mcs -out:fizz.exe CSFizz.cs
	chmod 755 fizz.exe

libcsfizz.so: ../fizzy.o
	$(CC) $(CFLAGS) -shared -read_only_relocs suppress -o libcsfizz.so ../fizzy.o

test: all
	time ./fizz 1 5

clean:
	rm -f *.so fizz.exe


CC = gcc
CFLAGS = -Wall -O0 -g -ansi -m32

.PHONY: fizz test

all: fizz

fizz: ../fizzy.o fizz.c
	$(CC) $(CFLAGS) -o fizz fizz.c ../fizzy.o

test: all
	time ./fizz 1 5

clean:
	rm -f *.o fizz
	rm -rf fizz.dSYM

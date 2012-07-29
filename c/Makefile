CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: fizz

fizz: ../fizzy.o cfizz.c
	$(CC) $(CFLAGS) -o fizz cfizz.c ../fizzy.o

test: all
	time ./fizz 1 5

clean:
	rm -f *.o fizz

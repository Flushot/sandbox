CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: fizz

fizz: cfizz.o
cfizz.o: ../fizzy.o
	cd ext; ruby extconf.rb
	$(MAKE) -C ext all
	$(CC) $(CFLAGS) -shared -o ext/cfizz.so ext/cfizz.o ../fizzy.o

test: all
	time ./fizz 1 5

clean:
	$(MAKE) -C ext clean
	rm -f ext/Makefile

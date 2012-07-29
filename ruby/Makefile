CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: fizz

fizz: crfizz.o
crfizz.o: ../fizzy.o
	cd ext; ruby extconf.rb
	$(MAKE) -C ext all
	$(CC) $(CFLAGS) -shared -o ext/crfizz.so ext/crfizz.o ../fizzy.o

test: all
	time ./fizz 1 5

clean:
	$(MAKE) -C ext clean
	rm -f ext/Makefile

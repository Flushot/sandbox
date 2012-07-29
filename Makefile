CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: cfizz jfizz nfizz rfizz

# C version
cfizz: fizzy.o cfizz.c
	$(CC) $(CFLAGS) -o cfizz cfizz.c fizzy.o

# Java version
jfizz: JFizz.class libJFizz.so
libJFizz.so: libJFizz.c JFizz.h fizzy.o
	$(CC) $(CFLAGS) -I$(JAVA_HOME)/include -shared -o libJFizz.so libJFizz.c fizzy.o
JFizz.class: JFizz.java
	${JAVA_HOME}/bin/javac JFizz.java
JFizz.h: JFizz.class
	${JAVA_HOME}/bin/javah JFizz

# .Net version
nfizz: NFizz.cs libfizzy.so
	mcs -out:nfizz NFizz.cs
	chmod 755 nfizz
libfizzy.so: fizzy.o
	$(CC) $(CFLAGS) -shared -o libfizzy.so fizzy.o

# Ruby version
rfizz: crfizz.o
crfizz.o: fizzy.o
	cd ruby; ruby extconf.rb
	$(MAKE) -C ruby all
	$(CC) $(CFLAGS) -shared -o ruby/crfizz.so ruby/crfizz.o fizzy.o

# Assembly code
fizzy.o: fizzy.asm
	nasm -f elf -l fizzy.lst -w+orphan-labels -o fizzy.o fizzy.asm

test: all
	time ./cfizz 1 5
	time ./jfizz 1 5
	time ./nfizz 1 5
	time ./rfizz.rb 1 5

# Cleanup
clean:
	rm -f *.o *.so *.lst *.class *.exe cfizz nfizz
	$(MAKE) -C ruby clean
	rm -f ruby/Makefile

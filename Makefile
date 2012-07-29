CC = gcc
CFLAGS = -Wall -O0 -ansi

all: cfizz jfizz nfizz

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

# Assembly code
fizzy.o: fizzy.asm
	nasm -f elf -l fizzy.lst -w+orphan-labels -o fizzy.o fizzy.asm

test: all
	time ./cfizz 1 5
	time ./jfizz 1 5
	time ./nfizz 1 5

# Cleanup
clean:
	rm -f *.o *.so *.lst *.class *.exe cfizz nfizz

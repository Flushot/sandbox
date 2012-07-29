CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: fizz

fizz: JFizz.class libJFizz.so
libJFizz.so: libJFizz.c JFizz.h ../fizzy.o
	$(CC) $(CFLAGS) -I$(JAVA_HOME)/include -shared -o libJFizz.so libJFizz.c ../fizzy.o
JFizz.class: JFizz.java
	${JAVA_HOME}/bin/javac JFizz.java
JFizz.h: JFizz.class
	${JAVA_HOME}/bin/javah JFizz

test: all
	time ./fizz 1 5

clean:
	rm -f *.o *.so *.class

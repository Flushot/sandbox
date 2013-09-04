CC = gcc
CFLAGS = -Wall -O0 -g -ansi -m32
JAVA_SRC_OSX = /System/Library/Frameworks/JavaVM.framework/Versions/Current

.PHONY: fizz test

all: fizz

fizz: JFizz.class libjfizz.so

libjfizz.so: libjfizz.c JFizz.h ../fizzy.o
	$(CC) $(CFLAGS) -I${JAVA_HOME}/include -I$(JAVA_SRC_OSX)/Headers -shared -o libjfizz.so libjfizz.c ../fizzy.o

JFizz.class: JFizz.java
ifndef JAVA_HOME
	$(error JAVA_HOME environment variable not set)
endif
	javac JFizz.java

JFizz.h: JFizz.class
	javah JFizz

test: all
	time ./fizz 1 5

clean:
	rm -f *.o *.so *.class JFizz.h

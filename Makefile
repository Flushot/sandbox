CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: cfizz jfizz nfizz rfizz

cfizz: fizzy.o
	$(MAKE) -C c all
jfizz: fizzy.o
	$(MAKE) -C java all
nfizz: fizzy.o
	$(MAKE) -C net all
rfizz: fizzy.o
	$(MAKE) -C ruby all

fizzy.o: fizzy.asm
	nasm -f elf -l fizzy.lst -w+orphan-labels -o fizzy.o fizzy.asm

test: all
	$(MAKE) -C c test
	$(MAKE) -C java test
	$(MAKE) -C net test
	$(MAKE) -C ruby test

clean:
	rm -f fizzy.o fizzy.lst
	$(MAKE) -C c clean
	$(MAKE) -C java clean
	$(MAKE) -C net clean
	$(MAKE) -C ruby clean

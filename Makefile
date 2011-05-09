all: fizzbuzz

fizzbuzz: fizz.o
	gcc driver.c fizz.o -o fizzbuzz

fizz.o:
	nasm -f elf -l fizz.lst -w+orphan-labels -o fizz.o fizz.asm

clean:
	rm -f *.o fizz.lst fizzbuzz

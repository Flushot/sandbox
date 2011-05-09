all: fizzbuzz

fizzbuzz: fizzy.o fizzbuzz.c
	gcc fizzbuzz.c fizzy.o -o fizzbuzz

fizzy.o: fizzy.asm
	nasm -f elf -l fizzy.lst -w+orphan-labels -o fizzy.o fizzy.asm

clean:
	rm -f *.o *.lst fizzbuzz

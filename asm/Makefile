OS = OSX
#OS = LINUX
#OS = WINDOWS

all: fizz

fizz: fizz.asm ../fizzy.o
ifeq ($(OS),LINUX)
	nasm -f elf -D OS=$(OS) -l fizz.lst -w+orphan-labels -o fizz.o fizz.asm
endif
ifeq ($(OS),OSX)
	nasm -f macho32 -D OS=$(OS) -w+orphan-labels -o fizz.o fizz.asm
endif
	gcc -m32 -o fizz fizz.o ../fizzy.o

test: fizz
	./fizz 1 5

clean:
	rm -f fizz.o fizz fizz.lst


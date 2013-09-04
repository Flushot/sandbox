OS = OSX
#OS = LINUX
#OS = WINDOWS

.PHONY: cfizz jfizz nfizz rfizz pyfizz test

all: cfizz jfizz csfizz rfizz pyfizz

cfizz: fizzy.o
	$(MAKE) -C c all
jfizz: fizzy.o
	$(MAKE) -C java all
csfizz: fizzy.o
	$(MAKE) -C csharp all
rfizz: fizzy.o
	$(MAKE) -C ruby all
pyfizz: fizzy.o
	$(MAKE) -C python all

fizzy.o: fizzy.asm
ifeq ($(OS),LINUX)
	nasm -f elf -D OS=$(OS) -l fizzy.lst -w+orphan-labels -o fizzy.o fizzy.asm
endif
ifeq ($(OS),OSX)
	nasm -f macho32 -D OS=$(OS) -w+orphan-labels -o fizzy.o fizzy.asm
endif

test: all
	$(MAKE) -C c test
	$(MAKE) -C java test
	$(MAKE) -C csharp test
	$(MAKE) -C ruby test
	$(MAKE) -C python test

clean:
	rm -f fizzy.o fizzy.lst
	$(MAKE) -C c clean
	$(MAKE) -C java clean
	$(MAKE) -C csharp clean
	$(MAKE) -C ruby clean
	$(MAKE) -C python clean

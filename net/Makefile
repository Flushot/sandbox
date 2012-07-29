CC = gcc
CFLAGS = -Wall -O0 -g -ansi

all: fizz

fizz: NFizz.cs libfizzy.so
	mcs -out:fizz NFizz.cs
	chmod 755 fizz
libfizzy.so: ../fizzy.o
	$(CC) $(CFLAGS) -shared -o libfizzy.so ../fizzy.o

test: all
	time ./fizz 1 5

clean:
	rm -f *.so fizz


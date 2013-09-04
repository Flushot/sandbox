CC = gcc
CFLAGS = -Wall -O0 -g -ansi -m32
PYTHON = python

.PHONY: fizz test

all: fizz

fizz:
	$(PYTHON) setup.py build
	cp build/*/fizzmodule.so .

test: all
	time ./fizz 1 5

clean:
	$(PYTHON) setup.py clean
	rm -f *.so
	rm -rf build

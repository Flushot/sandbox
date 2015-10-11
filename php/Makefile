all: ext/build/fizzy.so

ext/config.h:
	cd ext ; phpize ; ./configure --enable-fizzy

ext/build/fizzy.so: ext/config.h
	$(MAKE) -C ext

clean:
	$(MAKE) -C ext clean
	cd ext ; phpize --clean ; rmdir include

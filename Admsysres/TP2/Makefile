all:
	gcc -c test.c -o test.o -I /tmp/graphic/usr/include
	gcc -o test test.o -L /tmp/graphic/usr/lib -lgraphic -lX11 -lrt
	LD_LIBRARY_PATH=/tmp/graphic/usr/lib
	export LD_LIBRARY_PATH
clean:
	rm -f *.o test


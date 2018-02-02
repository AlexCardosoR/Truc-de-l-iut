export CC=gcc
export CFLAGS=-Wall -c -o
export LDFLAGS=
$PREFIX=/tmp/root

all :
	make -C src $@
	make -C doc $@
depends :
	make -C src $@
install :
	install -D ./warcraft $(PREFIX)/usr/share/man/man6/warcraft.6.gz
clean :
	make -C src $@
	make -C doc $@


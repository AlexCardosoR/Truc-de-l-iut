all : editeur warcraft
editeur : editeur.o video.o perso.o
	gcc -o editeur editeur.o video.o perso.o
editeur.o : editeur.c editeur.h video.h perso.h
	gcc -Wall -c -o editeur.o editeur.c
clean :
	rm -f *.o editeur warcraft
# DO NOT DELETE

editeur.o: perso.h video.h editeur.h
perso.o: perso.h video.h
video.o: video.h
warcraft.o: video.h perso.h warcraft.h

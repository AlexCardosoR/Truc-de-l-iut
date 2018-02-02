#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include <wait.h>

#define TAILLE_BUF 64

void codeDuFils(int tube, int i){
	char buf[TAILLE_BUF];
	FILE *f;

	if((f=fdopen(tube,"r"))==NULL){
		perror("problème ouverture tube"); 
		exit(errno);
	}

	while(fgets(buf, TAILLE_BUF, f)){
		printf("%d->%s", i+1, buf);
	}
	printf("Fin fils n°%d\n", i+1);
	fclose(f);
	close(tube);
	exit(0);
}

int main(int argc, char **argv) {
	bool trouve=false;
	int n, **tube, i, j, t=0;
	char msg[TAILLE_BUF], *curseur;
	
	if(argc == 2){
		if(sscanf(argv[1],"%d",&n)!=1){
			fprintf(stderr,"erreur arg, ne peut pas être lu comme un nombre\n");
			exit(1);
		}
	}
	else{
		fprintf(stderr,"erreur arg, nombre de fils absent\n");
		exit(1);
	}
	
	if((tube=(int**)malloc(sizeof(int*)*n))==NULL){
		printf("Problème allocation mémoire\n");
		exit(1);
	}
	
	for(i=0;i<n;i++){
		if((tube[i]=(int*)malloc(sizeof(int)*2))==NULL){
			printf("Problème allocation mémoire\n");
			exit(1);
		}
	}
	
	for(i=0;i<n;i++){
		if(pipe(tube[i])==-1){
			perror("pipe");
			exit(errno);
		}
		
		switch(fork()){
			case -1:
				perror("fork");
				exit(errno);
			case 0:
				for(j=0;j<=i;j++){
					close(tube[j][1]);
				}
				codeDuFils(tube[i][0], i);
				exit(0);
			default:
				close(tube[i][0]);
				
		}
	}

	while(fgets(msg, TAILLE_BUF, stdin) != NULL){

		if(sscanf(msg,"%d",&t)!=1){
			fprintf(stderr,"erreur num fils non trouvé\n");
		} 

		else if(t<1 || t>n){
			fprintf(stderr,"erreur num fils inexistant\n");
		} 

		else {
			curseur = msg;
			while((*curseur != ' ' || !trouve) && !isalpha(*curseur) && *curseur!='\n'){
				trouve=isdigit(*curseur)||trouve;
				curseur++;
			}

			if(write(tube[t-1][1], curseur, strlen(curseur)) == -1){
				perror("write");
				exit(errno);
			}
		}

	}

	
	for(i=0;i<n;i++){
		close(tube[i][1]);
		free(tube[i]);
		wait(NULL);
	}

	free(tube);

	exit(0);
}

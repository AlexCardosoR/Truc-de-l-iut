#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <wait.h>
#include <signal.h>

#define TAILLE_BUF 1024

int compteur = 1, pidFils;

void reset(int sig){
	compteur = 1;
}

void coucou(int sig){
	kill(pidFils,SIGUSR1);
}

void codeDuFils(int tube){
	char buf[TAILLE_BUF];
	FILE *f;
	struct sigaction action;
	sigemptyset(&action.sa_mask);
	action.sa_handler = reset;
	action.sa_flags = 0;
	
	if(sigaction(SIGUSR1, &action, NULL)){
		perror("Installation coucou");
		exit(1);
	}
	
	if((f=fdopen(tube,"r"))==NULL){
		perror("problème ouverture tube"); 
		exit(errno);
	}
	
	fgets(buf, TAILLE_BUF, f);
	while(!feof(f)){
		if(ferror(f))
			clearerr(f);
		else{
			printf("%d~%s", compteur, buf);
			compteur++;
		}
		fgets(buf, TAILLE_BUF, f);
	}
	printf("Fin fils\n");
	fclose(f);
	close(tube);
	exit(0);
}

int main(int argc, char **argv) {
	int tube[2];
	char msg[TAILLE_BUF];
	struct sigaction action;
	
	if(pipe(tube)==-1){
		perror("pipe");
		exit(errno);
	}
		
	switch(pidFils=fork()){
		case -1:
			perror("fork");
			exit(errno);
		case 0:
			close(tube[1]);
			codeDuFils(tube[0]);
			exit(0);
		default:
			close(tube[0]);
			break;
	}
	
	sigemptyset(&action.sa_mask);
	action.sa_handler = coucou;
	action.sa_flags = 0;
	
	if(sigaction(SIGUSR1, &action, NULL)){
		perror("Installation coucou");
		exit(1);
	}
	fgets(msg, TAILLE_BUF, stdin);
	while(!feof(stdin)){
		if(ferror(stdin))
			clearerr(stdin);
		else
			if(write(tube[1], msg, strlen(msg)) == -1){
				perror("write");
				exit(errno);
			}
		fgets(msg, TAILLE_BUF, stdin);
	}

	close(tube[1]);

	exit(0);
}

/*
kill -SIGUSR1 `ps -ef | grep ./ex1 | cut -d ' ' -f 3 | head -n 1`
*/

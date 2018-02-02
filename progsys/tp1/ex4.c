#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <wait.h>

int main(int argc, char **argv) {

	int i, j, n;
	struct timespec t={0,500000000};

	if(argc == 2){
		if(sscanf(argv[1],"%d",&n)!=1){
			fprintf(stderr,"erreur arg");
		}
	}

	for(j=0;j<n;j++){
		switch(fork()) {
			case -1 : /* Oups !!! fork n'a pas marché ! */
				perror("fork");
				exit(errno);

	        case  0 : /* Code du fils */
				for(i=0; i<10; i++){
					printf("id:%d-%d\n",j,i);
					nanosleep(&t,NULL);
				}
				return getpid();

			default :
				break;
		}
	}

	for(j=0;j<n;j++){
		wait(&i);
		printf("Processus fils %d fini\n", WEXITSTATUS(i));
	}
	
	printf("\nFin du processus père %d.\n", getpid());

	exit(0);
}

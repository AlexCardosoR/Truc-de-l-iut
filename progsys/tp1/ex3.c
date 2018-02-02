#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <wait.h>

int main(int argc, char **argv) {

	int i=0;
	struct timespec t={0,500000000};
	//t.tv_sec=0;
	//t.tv_nsec=500000000;

	switch(fork()) {

        case -1 : /* Oups !!! fork n'a pas marché ! */
			perror("fork");
			exit(errno);

        case  0 : /* Code du fils */
			for(i=0; i<10; i++){
				printf("%d\n",i);
				nanosleep(&t,NULL);
			}
			system("ps -f");
			return 2;

        default : /* Code du père */
			wait(&i);
			printf("\nProcessus fils fini avec comme code retour : %d\n", WEXITSTATUS(i));
			printf("Fin du processus père de pid %d.\n", getpid());

	}
	
	exit(0);
}

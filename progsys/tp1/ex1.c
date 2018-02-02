#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[]){
	int i;
	for(i=0; i<argc;i++){
		printf("arg[%d]=%s\n",i,argv[i]);
	}
	printf("---------------------------------\n");
	system("echo 'PATH => '. $PATH . '\n'");
	
	system("ps -f");
	
	printf("\n");
	
	execlp("ps","ps","-f",NULL);
	
	printf("\nTerminé !\n");
	
	exit(0);
}

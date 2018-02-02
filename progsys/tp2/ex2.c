#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

void parcourir(char *cheminDir){
	DIR * d;
	struct dirent *e;
	char *c;
	int l;
	
	
	if((d=opendir(cheminDir))==NULL) { perror("opendir"); return; }
	
	e=readdir(d);
	while(e!=NULL){
		if(strcmp(e->d_name,".")!=0 && strcmp(e->d_name,"..")!=0){
			printf("%s/%s\n", cheminDir, e->d_name);
			if(e->d_type == DT_DIR){
				l=strlen(cheminDir)+strlen(e->d_name)+2;
				c=(char*)malloc(sizeof(char)*l);
				if(c==NULL){
					printf("Problème allocation mémoire\n");
					exit(1);
				}
				strcpy(c,cheminDir);
				strcat(strcat(c,"/"),e->d_name);
				parcourir(c);
				free(c);		
			}
		}
		e=readdir(d);
	}
	closedir(d);
}

int main(int argc, char **argv) {
	
	int i;
	
	for(i=1;i<argc;i++){
		printf("%s\n", argv[i]);
		parcourir(argv[i]);
	}
	
	exit(0);
}

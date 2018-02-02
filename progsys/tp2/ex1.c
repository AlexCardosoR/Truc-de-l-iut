#include <stdio.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	struct stat buf;
	
	if(argc != 2){
		fprintf(stderr,"erreur arg");
		exit(1);
	}
	
	if(stat(argv[1], &buf)){
		printf("erreur\n");
		exit(1);
	}
	
	printf("%s\ni-node: %ld\tuid: %ld\tgid: %ld\ttaille: %ld\n", argv[1], (long) buf.st_ino, (long) buf.st_uid, (long) buf.st_gid, (long) buf.st_size);

	exit(0);
}

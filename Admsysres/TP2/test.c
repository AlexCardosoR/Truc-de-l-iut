#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "graphic.h"
#include <semaphore.h>

#define N 200

typedef struct {
	int x,y,color;
} Point;



int fils(sem_t *sem,Point* points) {
	int i;
	int ppid=getppid();
	
	while (1){
		if (ppid==1){
			perror("ppid"),exit(2);
		}
		else{
			if(sem_post(sem) == -1)
                		perror("sem_post"), exit(1);
			/* mise à jour des points */
			for(i=0; i<N; ++i) {
				points[i].x+=g_random()%2?1:-1;
				points[i].y+=g_random()%2?1:-1;
			}	
			if(sem_wait(sem) == -1)
                		perror("sem_wait"), exit(1);
			g_msleep(20);
		}	
	}
        exit(0);
}



int main() {
	sem_t *sem;
	Point *points;
	int i;
	int shmfd, *shmaddr;
 
	if ((shmfd=shm_open("/shmem", O_RDWR|O_CREAT|O_EXCL, 0600)) == -1 )
        	perror("shm_open"), exit(1);

	if (ftruncate(shmfd, sizeof(int))) perror("fseek"), exit(1);
 
	if ((points=(Point *)mmap(0, sizeof(Point)*N,
                PROT_READ|PROT_WRITE, MAP_SHARED, shmfd, 0)) == MAP_FAILED)
                perror("mmap"), exit(1);
	
  	/*initialisation d'un semaphore*/
        if ( (sem=sem_open("/sem1", O_CREAT|O_EXCL, 0666, 0))
                == SEM_FAILED) perror("sem_open"), exit(1);

	/* initialisation aléatoire des N points */
	for(i=0; i<N; ++i) {
		points[i].x=g_random()%(G_WIDTH-200)+100;
		points[i].y=g_random()%(G_HEIGHT-200)+100;
		points[i].color=g_random()%G_NB_COLORS;
	}

	g_init();
	
	for(i=0; i<N; ++i) {
		switch(fork()) {
                	case -1 : perror("fork"); exit(1);
                	case  0 : fils(sem,points);
        	}	
	}
	

	while(1) {
		if(sem_post(sem) == -1)
                	perror("sem_post"), exit(1);
		
		/* Affichage des points */
		g_clear();
		for(i=0; i<N; ++i) 
			g_draw(points[i].x, points[i].y, points[i].color);
		g_flush();
        	if(sem_wait(sem) == -1)
                	perror("sem_wait"), exit(1);
		g_msleep(20);
	}

	return 0;
}

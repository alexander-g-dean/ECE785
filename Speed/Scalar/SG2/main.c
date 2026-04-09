/*----------------------------------------------------------------------------
 *----------------------------------------------------------------------------*/
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include "geometry.h"

#define TEST1_LAT (45.0)
#define TEST1_LON (-79.0)

#define N_TESTS (100000)
#define PTS_PER_TEST (ppt)

extern int ppt;
/*----------------------------------------------------------------------------
  MAIN function
 *----------------------------------------------------------------------------*/
int main (void) {
	float dist, bearing, cur_pos_lat, cur_pos_lon;
	char * name;
	struct timespec start, end;
	unsigned long diff, total=0, min=1234567890;
	int n=0;
	float f_CPU_GHz = 1.5; // Change if needed

        printf("SG2 source code optimization version %d, CPU freq assumed to be %3.1f GHz\n", version,
	       f_CPU_GHz);
	
	cur_pos_lat = TEST1_LAT;
	cur_pos_lon = TEST1_LON;

	/*  printf("Current location is %f deg N, %f deg W\n", cur_pos_lat,
	       cur_pos_lon); */
	for (n=0; n<N_TESTS; n++) {
	  clock_gettime(CLOCK_THREAD_CPUTIME_ID, &start);
	  Find_Nearest_Waypoint(cur_pos_lat, cur_pos_lon,
				&dist, &bearing, &name);
	  clock_gettime(CLOCK_THREAD_CPUTIME_ID, &end);
	  /* printf("Closest waypoint is %s. %f km away at bearing %f degrees\n",
	       name, dist, bearing); */
	  diff = (1000000000 * (end.tv_sec - start.tv_sec)) +
	    end.tv_nsec - start.tv_nsec;
	  //	  printf("%2d: %8lu ns\n", n, diff);
	  total += diff;
	  if (diff < min)
	    min = diff;
	}
	/* printf("Closest waypoint is %s. %f km away at bearing %f degrees\n",
	   name, dist, bearing); */
	
	printf("Total time: %.3f us for %d tests\n", total/1000.0, N_TESTS);
	float avg_time_us =  total/(1000.0*N_TESTS);
	float min_time_us =  min/1000.0;
	printf("Per FNW call: Average %8.3f us %8.2f cycles, Min %8.3f us %8.2f cycles\n",
	       avg_time_us, 1000*avg_time_us*f_CPU_GHz, min_time_us, 1000*min_time_us*f_CPU_GHz); 
	printf("Per Waypoint: Average %8.3f us %8.2f cycles, Min %8.3f us %8.2f cycles\n",
	       avg_time_us/PTS_PER_TEST, 1000*avg_time_us*f_CPU_GHz/PTS_PER_TEST,
	       min_time_us/PTS_PER_TEST, 1000*min_time_us*f_CPU_GHz/PTS_PER_TEST); 

	exit(0);
}


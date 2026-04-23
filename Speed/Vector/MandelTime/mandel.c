#include "stdio.h"
#include <time.h>

#define MaxIters 20000
#define SIZE     60
#define BLACK    -1
#define LEFT     -2.0
#define RIGHT    1.0
#define TOP      1.0
#define BOTTOM   -1.0
#define CVT_SIZE 7

int main(int argc, char *argv[])
{
  short   x, y, count;
  float zr, zi, cr, ci;
  float rsquared, isquared;
  unsigned image[SIZE][SIZE];
  char cvt[CVT_SIZE+1] = "* .-+#@";
  struct timespec t1, t2;
  long int t;

  printf("asdf\n");

  clock_gettime(CLOCK_THREAD_CPUTIME_ID, &t1);
  for (y = 0; y < SIZE; y++) {
    for (x = 0; x < SIZE; x++) {
      zr = 0.0;
      zi = 0.0;
      cr = LEFT + x * (RIGHT - LEFT) / SIZE;
      ci = TOP + y * (BOTTOM - TOP) / SIZE;
      rsquared = zr * zr;
      isquared = zi * zi;
      for (count = 0; (rsquared + isquared <= 4.0) &&
	     (count < MaxIters); count++) {
	zi = zr * zi * 2;
	zi += ci;
	zr = rsquared - isquared;
	zr += cr;
	rsquared = zr * zr;
	isquared = zi * zi;
      }
      if (rsquared + isquared <= 4.0)
	image[x][y] = 0;
      else
	image[x][y] = count;

    }
  }
  clock_gettime(CLOCK_THREAD_CPUTIME_ID, &t2);

  t = (t2.tv_nsec - t1.tv_nsec) + 1000000*(t2.tv_sec - t1.tv_sec);

  printf("Thread CPU Time: %ld ns\n\t%f ms\n", t, t/1000000.0);

  if (argc > 1) {
    for (y = 0; y < SIZE; y++)
      {
	for (x = 0; x < SIZE; x++)
	  {
	    printf("%c", cvt[(image[x][y])/CVT_SIZE]);
	  }
	printf("\n");
      }
  }
  return 0;
}

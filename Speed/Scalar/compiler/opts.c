#include <stdio.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

#define ARRAY_SIZE (10000)
#define CLOCK_FREQ_GHZ (1.5)

#define N_TESTS (10000)

int a[ARRAY_SIZE],  b[ARRAY_SIZE],  c[ARRAY_SIZE];

void init(int mask_val) {
  for (int n=0; n<ARRAY_SIZE; n++) {
    a[n] = n & mask_val;
    b[n] = n;
  }
}

int do_test1(void) {
  int sum=0;
  for (int n=ARRAY_SIZE-1; n!=0; n--) {
    if (a[n] != 0)
      sum += b[n];
    else
      sum -= b[n];
  }
  return sum;
}

void do_test2(void) {
  for (int n=ARRAY_SIZE-1; n!=0; n--) {
    if (a[n] != 0)
      c[n] = a[n];
    else
      c[n] = b[n];
  }
}

int main (int argc, char * argv[]) {
  struct timespec start, end;
  unsigned long diff, total=0, min=1234567890;
  int n=0;
  volatile int ss=0;
  unsigned int mask=1, mask_len=1;

  if (argc == 2) {
    sscanf(argv[1],"%u", &mask_len);
  }

  printf("Assuming clock of %.1f GHz\n", CLOCK_FREQ_GHZ);
  printf("%d elements in array, %d tests, mask length is %d bits\n", ARRAY_SIZE, N_TESTS, mask_len);
  mask = (1<<mask_len) - 1;
  do {
    init(mask);
    total = 0;
    min = 1234567890;
    for (n=0; n<N_TESTS; n++) {
      clock_gettime(CLOCK_THREAD_CPUTIME_ID, &start);
      ss += do_test1();
      clock_gettime(CLOCK_THREAD_CPUTIME_ID, &end);
      diff = (1000000000 * (end.tv_sec - start.tv_sec)) +
	end.tv_nsec - start.tv_nsec;
      total += diff;
      if (diff < min)
	min = diff;
    }
    printf("Mask 0x%x leads to a[n]==0 every %u entries]\n", mask, mask+1);

#if 0
    printf("Time per test:            minimum %6.3f us, average %6.3f\n",
	   min/1000.0, total/(1000.0*N_TESTS));
    printf("Time per array element:   minimum %6.3f ns, average %6.3f ns\n",
	   min/(1.0*ARRAY_SIZE), total/(1.0*N_TESTS*ARRAY_SIZE));
#endif
    printf("Cycles per array element: minimum %6.3f,    average %6.3f\n",
	   CLOCK_FREQ_GHZ*min/(ARRAY_SIZE), CLOCK_FREQ_GHZ*total/(N_TESTS*ARRAY_SIZE));
    mask >>= 1;
  } while (mask > 0);

  exit(0);
 
}

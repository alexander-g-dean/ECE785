#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/stat.h>
#include <stdint.h>
#include <limits.h>

#include "is_options.h"
#include "image_proc.h"

extern void test_rotation(uint8_t *, uint8_t *); // DEV code

#define BITPLANE_SIZE ((int) (ISS_STRIDE*ISS_HEIGHT*1.5))
uint8_t bpin[BITPLANE_SIZE], bpout[BITPLANE_SIZE];

int main(int argc, char** argv) {
  char fnin[] = "Media/VIn/test3_.yuv";
  char fnout1[] = "Media/VOut/test3_dbg.yuv";
  char fnout2[] = "Media/VOut/test3_stab.yuv";
  size_t nb;
  FILE * fin, * fout1, * fout2;
  struct timespec t1, t2;
  long t=0;
  int images_processed = 0;
  double t_sum_ms = 0;
  long t_min = INT_MAX, t_max = 0;
  int fin_size;
  // Open files
  struct stat file_status;
  if (stat(fnin, &file_status) < 0) {
    printf("Couldn't open input file %s\n", fnin);
    return -1;
  }
  fin_size = file_status.st_size;
  
  fin  = fopen(fnin, "rb");
  if (!fin) {
    printf("Couldn't open input file %s\n", fnin);
    return -1;
  }
  fout1 = fopen(fnout1, "wb");
  if (!fout1) {
    printf("Couldn't open output file %s\n", fnout1);
    return -1;
  }
  fout2 = fopen(fnout2, "wb");
  if (!fout2) {
    printf("Couldn't open output file %s\n", fnout2);
    return -1;
  }
  
  printf("Assuming %s is YUV420 image W: %d, S: %d, H: %d\n",
	 fnin, ISS_WIDTH, ISS_STRIDE, ISS_HEIGHT);
  float num_images = fin_size/(ISS_STRIDE*ISS_HEIGHT*1.5);
  printf("%s is %d bytes long, with %5.3f image(s)\n", fnin, fin_size, num_images);
  
  for (int test_num = 0; test_num < NUM_TESTS; test_num++) {
    fseek(fin, 0, SEEK_SET);
    for (int img_num = 0; img_num < num_images; img_num++) {
      nb = fread(bpin, 1, BITPLANE_SIZE, fin);
      if (show_data > 0)
	printf("Read %ld bytes from %s.\n", nb, fnin);

      clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t1);
      //   Call processing code
      process_image_multi(bpin, bpout);
      clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t2);

      t = t2.tv_nsec - t1.tv_nsec;
      if (t<0)
	t += 1000000000;
      t_max = t > t_max ? t : t_max;
      t_min = t < t_min ? t : t_min;
      t_sum_ms += t/1000000.0;
      images_processed++;
      printf("Time for image %d: %9.6f ms\n", img_num, t/1000000.0);

      if (test_num == 0) { // save images on first test only 
	//   Save frame to file as yuv (later convert to jpg or png for viewing)
	// bpin - annotated
	nb = fwrite(bpin, 1, BITPLANE_SIZE, fout1);
	if (show_data > 0)
	  printf("Wrote %ld bytes to %s.\n", nb, fnout1);	       
	// bpout - stabilized
	nb = fwrite(bpout, 1, BITPLANE_SIZE, fout2);
	if (show_data > 0)
	  printf("Wrote %ld bytes to %s.\n", nb, fnout2);	       
      } // first test
    } // for img_num
    if (test_num == 0) { // close output files
      fclose(fout1);
      fclose(fout2);
    }
  } // for nt from 0 to NUM_TESTS
  fclose(fin);
  printf("%d Frames. Proc. time (ms) per frame: last %6.4f (min %6.4f, avg. %6.4f, max %6.4f)\n",
	 images_processed, t/1000000.0, t_min/1000000.0,
	 (float) (t_sum_ms/images_processed), t_max/1000000.0);
  return 0;
}


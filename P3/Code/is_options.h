#ifndef IS_OPTIONS_H
#define IS_OPTIONS_H
#include <stdint.h>
#include <stdio.h>

#define ISS_WIDTH (1280)
#define ISS_STRIDE (1280)
#define ISS_HEIGHT (720)
#define NUM_TESTS (10) // 100 tests is slow but gives more stable performance measurements

extern volatile int run;
extern int find_matches;
extern int invert, invert_rect;
extern int update_target_color;
extern int show_data;
extern int highlight_matches;
extern int color_threshold;
extern volatile int extend_threshold;
extern int imstab_servo;
extern int imstab_digital;
extern int chroma_subsample_sep;

extern float ServoTiltDegree;
extern float ServoPanDegree;

extern FILE * log_fp;

#endif // IS_OPTIONS_H

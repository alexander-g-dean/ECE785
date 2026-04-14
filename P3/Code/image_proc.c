#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>
#include <math.h>
#include <sys/param.h>

#include "image_proc.h"
#include "is_options.h"
#include "yuv.h"

#include "ansi_escapes.h"

unsigned char img2_bitplanes[ISS_STRIDE*ISS_HEIGHT*3/2];

unsigned char mask[ISS_STRIDE/2][ISS_HEIGHT/2];

#define CONTROL_LOOP_DIVIDER 2

void draw_overlay_info(YUV_IMAGE_T * i) {
  Draw_Circle(i, i->half_w, i->half_h, 10, &black, 0);
  Draw_Circle(i, i->half_w, i->half_h, 12, &orange, 0);
  Draw_Circle(i, i->half_w, i->half_h, 13, &orange, 0);
  Draw_Circle(i, i->half_w, i->half_h, 22, &black, 0);
  Draw_Circle(i, i->half_w, i->half_h, 24, &white, 0);
  Draw_Circle(i, i->half_w, i->half_h, 25, &white, 0);
}

void clear_term_screen(void) {
  printf("\033[2J");
}

void Draw_Match_Marker(YUV_IMAGE_T * i, int x, int y, int sep, YUV_T * color) {
  if (sep > 10)
    Draw_Rectangle(i, x, y, sep-2, sep-2, color, 0);
  else {
    Draw_Line(i, x-sep/2, y, x+sep/2, y, color);
    Draw_Line(i, x, y-sep/2, x, y+sep/2, color);
  }
}

int find_chroma_matches_multi(YUV_IMAGE_T * i, int num_target_colors, YUV_T * tc,
			      int * rc_col, int * rc_row, int * matches, int sep){
  int col, row;
  int diff, tcn, total_matches;
  YUV_T color;
  int c_col[MAX_TARGET_COLORS], c_row[MAX_TARGET_COLORS];
  YUV_T * match_color = &white;

  if (num_target_colors > MAX_TARGET_COLORS)
    num_target_colors = MAX_TARGET_COLORS;
  
  for (tcn=0; tcn < num_target_colors; tcn++) {
    c_col[tcn] = c_row[tcn] = matches[tcn] = 0;
  }
  
  for (row = sep/2; row <= i->h - sep/2; row += sep) {
    for (col = sep/2; col <= i->w - sep/2; col += sep) {
      Get_Pixel_yuv(i, col, row, &color);
      // Identify pixels with right color
      for (tcn=0; tcn < num_target_colors; tcn++) {
	diff = Sq_UV_Difference_yuv(&color, &tc[tcn]);
	if (diff < color_threshold) {
	  c_col[tcn] += col;
	  c_row[tcn] += row;
	  matches[tcn]++;
	  Draw_Match_Marker(i, col, row, sep, match_color);
	} // matching color
      } // for target color number
    } // for col
  } // for row
  
  total_matches = 0;
  for (tcn=0; tcn < num_target_colors; tcn++) {
    if (matches[tcn] > 0) {
      c_col[tcn] /= matches[tcn];
      c_row[tcn] /= matches[tcn];
      rc_col[tcn] = c_col[tcn];
      rc_row[tcn] = c_row[tcn];
      total_matches += matches[tcn];
    }
  } 
  return total_matches;
}
void process_image_multi(uint8_t * src_bitplanes, uint8_t * dst_bitplanes) {
  static YUV_IMAGE_T img, dst_img;
  int w=ISS_WIDTH, s=ISS_STRIDE, h=ISS_HEIGHT;
  int ntc = MAX_TARGET_COLORS;
  // Default target colors for test3_
  static YUV_T target_color[MAX_TARGET_COLORS] = {{144, 85, 125},   // Green 
      {81, 124, 243} // Magenta 
  };
  int total_matches;
  int centroid_x[MAX_TARGET_COLORS], centroid_y[MAX_TARGET_COLORS],
    num_matches[MAX_TARGET_COLORS], offsetX[MAX_TARGET_COLORS], offsetY[MAX_TARGET_COLORS];

  for (int i=0; i<MAX_TARGET_COLORS; i++) {
    centroid_x[i] = centroid_y[i] = num_matches[i] = offsetX[i] = offsetY[i] = 0;
  }
  
  // initialize YUV_IMAGE_T data structures describing images
  YUV_Image_Init(&img, src_bitplanes, w, s, h); // original image
  YUV_Image_Init(&dst_img, dst_bitplanes, w, s, h); // destination image

  // draw center circles
  draw_overlay_info(&img);

  // Find area matching target colors 
  total_matches = find_chroma_matches_multi(&img, ntc, target_color, centroid_x,
					    centroid_y, num_matches, chroma_subsample_sep);
  if (total_matches > 0) {
    for (int tcn=0; tcn < ntc; tcn++) { // annotate source image
      // Show centroid
      Draw_Circle(&img, centroid_x[tcn], centroid_y[tcn], 10, &white, 1);
      Draw_Line(&img, 0, 0, centroid_x[tcn], centroid_y[tcn], &yellow);
      Draw_Line(&img, img.w-1, 0, centroid_x[tcn], centroid_y[tcn], &yellow);

      offsetX[tcn] = img.half_w - centroid_x[tcn];
      offsetY[tcn] = img.half_h - centroid_y[tcn];
      if (show_data > 0) {
	printf("Match centroid at (%4d, %3d) with %5d samples\n",
	       centroid_x[tcn], centroid_y[tcn], num_matches[tcn]);
	if (show_data > 1) 
	  printf("Offset = %5d, %4d\n", offsetX[tcn], offsetY[tcn]);
      }
    }
  }
  
  // Did we find both centroids?
  if ((num_matches[0] > 0) && (num_matches[1] > 0)) {
    float angle; // Radians
    int cx, cy;
    int dx, dy;
    // Calculate how to rotate and translate image
    cx = (centroid_x[0] + centroid_x[1])/2; 
    cy = (centroid_y[0] + centroid_y[1])/2;
    dx = centroid_x[1] - centroid_x[0];
    dy = centroid_y[1] - centroid_y[0];
    angle = -atan2(dy, dx);

    // Correct image
    imstab_digital = 1;
    if (imstab_digital) {
      YUV_Image_Fill(&dst_img, &target_color[0]);
      YUV_Rotate_Translate_Image(&dst_img, &img, cx, cy, angle);
    }
  } else {
    printf("Match(es) not found\n");
  }
}

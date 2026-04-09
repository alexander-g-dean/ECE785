#include "geometry.h"
#include <stdint.h>
#include <math.h>
#include <string.h>
#define PI 3.14159265f
#define PI_OVER_180 (0.017453293f) // (3.1415927/180.0)

extern const PT_T waypoints[];

// Now defining VER as command line option to gcc in Makefile
// old: #define VER 13

int version = VER; // make visible to main

/*
11: radians in table, precalc'd sin, cos
12: Calc_Closeness
13: Don't do bearing
14: Don't call strcmp, but use uint32 comparison to detect END instead
*/

// Table holds precalculated sin/cos for p2. Table Lat/Lon values are in radians

#if VER==11
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
  // calculates distance in kilometers between locations (represented in radians)

  return acosf(p1->SinLat * p2->SinLat + 
	       p1->CosLat * p2->CosLat*
	       cosf(p2->Lon - p1->Lon))* 6371;
}
#endif

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
  // calculates bearing in degrees between locations (represented in radians)	
  float term1, term2;
  float angle;
	
  term1 = sinf(p2->Lon - p1->Lon)*p2->CosLat;
  term2 = p1->CosLat*p2->SinLat - 
    p1->SinLat*p2->CosLat*cosf(p2->Lon - p1->Lon);
  angle = atan2f(term1, term2) * (180/PI);
  if (angle < 0.0)
    angle += 360;
  return angle;
}

#if (VER>=12)
float Calc_Closeness( PT_T * p1,  const PT_T * p2) { 
  // calculates closeness (decreases as distance increases) of locations

  return p1->SinLat * p2->SinLat + 
    p1->CosLat * p2->CosLat*
    cosf(p2->Lon - p1->Lon);
}
#endif


void Find_Nearest_Waypoint(float cur_pos_lat, float cur_pos_lon, float * distance, float * bearing, 
			   char  * * name) {
  // cur_pos_lat and cur_pos_lon are in degrees
  // distance is in kilometers
  // bearing is in degrees
		
  int i=0, closest_i=0;
  PT_T ref;
  float d, b=0;

#if VER<=11
   float closest_d=1E10;
#else
   float c, max_c=0;
#endif
#if VER>=14
  char end_char[] = "END\0";
  uint32_t END_uint32 = *((uint32_t *) end_char);
#endif
  
  *distance = 0.0f;
  *bearing = 0;
  *name = '\0';

  ref.Lat = cur_pos_lat*PI/180;
  ref.Lon = cur_pos_lon*PI/180;
  ref.SinLat = sinf(ref.Lat);
  ref.CosLat = cosf(ref.Lat);
		
  strcpy(ref.Name, "Reference");
  while (
#if VER<14
	 strcmp(waypoints[i].Name, "END")
#else
    (*((uint32_t *) waypoints[i].Name) != END_uint32)
#endif
    ) {
#if VER==11
    d = Calc_Distance(&ref, &(waypoints[i]) );
    // if we found a closer waypoint, remember it and display it
    if (d<closest_d) {
      closest_d = d;
      closest_i = i;
    }
#else
    c = Calc_Closeness(&ref, &(waypoints[i]) );
    if (c>max_c) {
      max_c = c;
      closest_i = i;
    }
#endif

#if (VER==11) || (VER==12)
    b = Calc_Bearing(&ref, &(waypoints[i]) ); // Deletable!
#endif

    i++;
  }

  // Finish calcuations for the closest point

#if VER==11
  d = closest_d; 
#else
  d = acosf(max_c)*6371; // finish distance calcuation
#endif	

#if VER>=13
  b = Calc_Bearing(&ref, &(waypoints[closest_i]) );
#endif

  // return information to calling function about closest waypoint 
  *distance = d;
  *bearing = b;
  *name = (char * ) (waypoints[closest_i].Name);
}

#include "geometry.h"
#include <math.h>
#include <string.h>
#define PI 3.14159265f
#define PI_OVER_180 (PI/180)

#define VER 1

int version = VER; // make visible to main

extern const PT_T waypoints[];
///////////////////////////////////////////////////
// Step 1
#if VER==1	// Double precision mathlib functions
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
  return acos(sin(p1->Lat*PI/180)*
	      sin(p2->Lat*PI/180) +
	      cos(p1->Lat*PI/180)*
	      cos(p2->Lat*PI/180)*
	      cos(p2->Lon*PI/180 -
		  p1->Lon*PI/180)) *
    6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float angle = atan2(
		sin(p2->Lon*PI/180 -
		    p1->Lon*PI/180)*
		cos(p2->Lat*PI/180),
		cos(p1->Lat*PI/180)*
		sin(p2->Lat*PI/180) - 
		sin(p1->Lat*PI/180)*
		cos(p2->Lat*PI/180)*
		cos(p2->Lon*PI/180 -
		   p1->Lon*PI/180)
		) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}

#endif
///////////////////////////////////////////////////
// Step 2
#if VER==2	// Single precision mathlib functions
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
  return acosf(sinf(p1->Lat*PI/180)*
	       sinf(p2->Lat*PI/180) + 
	       cosf(p1->Lat*PI/180)*
	       cosf(p2->Lat*PI/180)*
	       cosf(p2->Lon*PI/180 -
	       p1->Lon*PI/180)) *
    6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float angle = atan2f(sinf(p2->Lon*PI/180 -
				  p1->Lon*PI/180)*
			     cosf(p2->Lat*PI/180),
			     cosf(p1->Lat*PI/180)*
			     sinf(p2->Lat*PI/180) - 
			     sinf(p1->Lat*PI/180)*
			     cosf(p2->Lat*PI/180)*
			     cosf(p2->Lon*PI/180 -
				  p1->Lon*PI/180))*
	  (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

///////////////////////////////////////////////////
// Step 3
#if VER==3  // Compile-time evaluation of expressions - Parenthesize PI/180 
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
  return acosf(sinf(p1->Lat*(PI/180))*
	       sinf(p2->Lat*(PI/180)) + 
	       cosf(p1->Lat*(PI/180))*
	       cosf(p2->Lat*(PI/180))*
	       cosf(p2->Lon*(PI/180) -
		    p1->Lon*(PI/180)))
    * 6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float angle = atan2f(
		sinf(p2->Lon*(PI/180) - p1->Lon*(PI/180))*cosf(p2->Lat*(PI/180)),
		cosf(p1->Lat*(PI/180))*sinf(p2->Lat*(PI/180)) - 
		sinf(p1->Lat*(PI/180))*cosf(p2->Lat*(PI/180))*cosf(p2->Lon*(PI/180) - p1->Lon*(PI/180))
		) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

//////////////////////////////////////////////////
// Step 4
#if VER==4	// force compile-time eval of PI/180 -- Skip this, since prev step did it
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
  return acosf(sinf(p1->Lat*PI_OVER_180)*sinf(p2->Lat*PI_OVER_180) + 
					cosf(p1->Lat*PI_OVER_180)*cosf(p2->Lat*PI_OVER_180)*
							cosf(p2->Lon*PI_OVER_180 - p1->Lon*PI_OVER_180)) * 6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float angle = atan2f(
		sinf(p2->Lon*(PI_OVER_180) - p1->Lon*(PI_OVER_180))*cosf(p2->Lat*(PI_OVER_180)),
		cosf(p1->Lat*(PI_OVER_180))*sinf(p2->Lat*(PI_OVER_180)) - 
		sinf(p1->Lat*(PI_OVER_180))*cosf(p2->Lat*(PI_OVER_180))*cosf(p2->Lon*(PI_OVER_180) - p1->Lon*(PI_OVER_180))
		) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

//////////////////////////////////////////////////
// Step 5
#if VER==5 // Copy lat and lon to local variables to reduce scope, enable some CSE
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
	float p1Lon, p1Lat, p2Lon, p2Lat;

	p1Lon = p1->Lon;
	p2Lon = p2->Lon;
	p1Lat = p1->Lat;
	p2Lat = p2->Lat;

	return acosf(sinf(p1Lat*PI_OVER_180)*
		     sinf(p2Lat*PI_OVER_180) + 
		     cosf(p1Lat*PI_OVER_180)*
		     cosf(p2Lat*PI_OVER_180)*
		     cosf(p2Lon*PI_OVER_180 -
			  p1Lon*PI_OVER_180)
	       ) * 6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float p1Lon, p1Lat, p2Lon, p2Lat;
	float angle;

	p1Lon = p1->Lon;
	p2Lon = p2->Lon;
	p1Lat = p1->Lat;
	p2Lat = p2->Lat;

	angle = atan2f(
		sinf(p2Lon*PI_OVER_180 -
		     p1Lon*PI_OVER_180)*
		cosf(p2Lat*PI_OVER_180),
		cosf(p1Lat*PI_OVER_180)*
		sinf(p2Lat*PI_OVER_180) - 
		sinf(p1Lat*PI_OVER_180)*
		cosf(p2Lat*PI_OVER_180)*
		cosf(p2Lon*PI_OVER_180 - p1Lon*PI_OVER_180)
		) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

//////////////////////////////////////////////////
// Step 6
#if VER==6 // Force some CSE by converting to radians early
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;

	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;

  return acosf(sinf(p1LatRad)*
	       sinf(p2LatRad) + 
	       cosf(p1LatRad)*
	       cosf(p2LatRad)*
	       cosf(p2LonRad - p1LonRad))
    * 6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;
	float angle;

	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;

	angle = atan2f(
		sinf(p2LonRad - p1LonRad)*
		cosf(p2LatRad),
		cosf(p1LatRad)*
		sinf(p2LatRad) - 
		sinf(p1LatRad)*
		cosf(p2LatRad)*
		cosf(p2LonRad - p1LonRad)
		       ) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

//////////////////////////////////////////////////
// Step 7
#if VER==7 // CB: manual CSE with intermediate terms to see if compiler does better
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;

	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;

  return acosf(sinf(p1LatRad)*sinf(p2LatRad) + 
	       cosf(p1LatRad)*cosf(p2LatRad)*
	       cosf(p2LonRad - p1LonRad))
    * 6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;
	float angle;

	float term1, term2;
	
	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;

	term1 = sinf(p2LonRad - p1LonRad)
	  *cosf(p2LatRad);
	term2 = cosf(p1LatRad)*sinf(p2LatRad) - 
	  sinf(p1LatRad)
	  *cosf(p2LatRad)
	  *cosf(p2LonRad - p1LonRad);
	angle = atan2f(term1, term2) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

//////////////////////////////////////////////////
// Step 8
#if VER==8 // CB: manual CSE of cos(p2->Lat in radians)
float Calc_Distance( PT_T * p1,  const PT_T * p2) { 
// calculates distance in kilometers between locations (represented in degrees)
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;

	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;

	return acosf(sinf(p1LatRad)*sinf(p2LatRad) + 
		     cosf(p1LatRad)*cosf(p2LatRad)*
		     cosf(p2LonRad - p1LonRad)) * 6371;
}

float Calc_Bearing( PT_T * p1,  const PT_T * p2){
// calculates bearing in degrees between locations (represented in degrees)	
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;
	float cosp2LatRad;
	float term1, term2;
	
	float angle;
	
	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;
	cosp2LatRad = cosf(p2LatRad);
	
	term1 = sinf(p2LonRad - p1LonRad)*cosp2LatRad;
	term2 = cosf(p1LatRad)*sinf(p2LatRad) - 
	  sinf(p1LatRad)*
	  cosp2LatRad*
	  cosf(p2LonRad - p1LonRad);
	angle = atan2f(term1, term2) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	return angle;
}
#endif

//////////////////////////////////////////////////
// Step 9
#if VER==9 // Merged functions with manual CSE 
void Calc_Distance_Bearing(float * distance, float * bearing, PT_T * p1,  const PT_T * p2){
// calculates distance and bearing in degrees between locations (represented in degrees)	
	float p1LonRad, p1LatRad, p2LonRad, p2LatRad;
	float cosp2LatRad;
	float term1, term2;
	
	float angle;
	
	p1LonRad = p1->Lon*PI_OVER_180;
	p2LonRad = p2->Lon*PI_OVER_180;
	p1LatRad = p1->Lat*PI_OVER_180;
	p2LatRad = p2->Lat*PI_OVER_180;
	cosp2LatRad = cosf(p2LatRad);
	
	
	*distance = acosf(sinf(p1LatRad)*sinf(p2LatRad) + 
			  cosf(p1LatRad)*cosf(p2LatRad)*
			  cosf(p2LonRad - p1LonRad)) * 6371;
	
	term1 = sinf(p2LonRad - p1LonRad)*cosp2LatRad;
	term2 = cosf(p1LatRad)*sinf(p2LatRad) - 
	  sinf(p1LatRad)*cosp2LatRad*cosf(p2LonRad - p1LonRad);
	angle = atan2f(term1, term2) * (180/PI);
	if (angle < 0.0)
		angle += 360;
	*bearing = angle;
}
#endif

void Find_Nearest_Waypoint(float cur_pos_lat, float cur_pos_lon, float * distance, float * bearing, 
			   char  * * name) {
  // cur_pos_lat and cur_pos_lon are in degrees
  // distance is in kilometers
  // bearing is in degrees
  
  int i=0, closest_i=0;
  PT_T ref;
  float d, b, closest_d=1E10;
  
  *distance = '\0';
  *bearing = '\0';
  *name = '\0';
  
  ref.Lat = cur_pos_lat;
  ref.Lon = cur_pos_lon;
  strcpy(ref.Name, "Reference");
  
  while (strcmp(waypoints[i].Name, "END")) {
#if VER!=9  
    d = Calc_Distance(&ref, &(waypoints[i]) );
    b = Calc_Bearing(&ref, &(waypoints[i]) );
#else
    Calc_Distance_Bearing(&d, &b, &ref, &(waypoints[i]));
#endif
			
    // if we found a closer waypoint, remember it and display it
    if (d<closest_d) {
      closest_d = d;
      closest_i = i;
    }
    i++;
  }
  
#if VER!=9
  //  d = Calc_Distance(&ref, &(waypoints[closest_i]) );
  d = closest_d;
  b = Calc_Bearing(&ref, &(waypoints[closest_i]) );
#else
  Calc_Distance_Bearing(&d, &b, &ref, &(waypoints[closest_i]));
#endif	
  // return information to calling function about closest waypoint 
  *distance = d;
  *bearing = b;
  *name = (char * ) (waypoints[closest_i].Name);
}

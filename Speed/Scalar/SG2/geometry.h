#ifndef GEOMETRY_H
#define GEOMETRY_H
// geometry 

#include "config.h"

extern int version;
void Find_Nearest_Waypoint(float cur_pos_lat, float cur_pos_lon, float * distance, float * bearing, 
			   char  * * name);

typedef struct {
	float Lat;
	float SinLat;
	float CosLat;
	float Lon;
	char Name[24];
} PT_T;
extern const PT_T waypoints[];

#endif

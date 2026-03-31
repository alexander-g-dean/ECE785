#ifndef GEOMETRY_H
#define GEOMETRY_H
// geometry 

extern int version; 
void Find_Nearest_Waypoint(float, float, float *, float *, char * *);

typedef struct {
	float Lat;
	float Lon;
	char Name[24];
} PT_T;

#endif

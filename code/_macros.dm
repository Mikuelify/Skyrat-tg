
//Takes a list of images, and a flag.
/*
	Checks if target's hudlist has an image for the supplied hud image type
		If so, adds that image to the supplied list
		If not, sets an update
*/
#define	add_hudlist(outputlist, mobref, hudtype)	if (mobref.hud_list[hudtype])\
{outputlist += mobref.hud_list[hudtype]}\
else\
{\
BITSET(mobref.hud_updateflag, hudtype)}


#define VECTOR_POOL_MAX	20000
#define VECTOR_POOL_FULL	4000

#define release_vector(A)	if (A && length(GLOB.vector_pool) < VECTOR_POOL_MAX){\
GLOB.vector_pool += A;}\
A = null;


#define release_vector_list(A)	for (var/vector2/v in A) {release_vector(v)}\
A = null;

#define release_vector_assoc_list(A)	for (var/b in A) {release_vector(A[b])}\
A = null;

#define NONSENSICAL_VALUE -99999

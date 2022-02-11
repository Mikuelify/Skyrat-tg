//Recursive function to find the atom on a turf which we're nested inside
/atom/proc/get_toplevel_atom()
	var/atom/A = src
	while(A.loc && !(isturf(A.loc)))
		A = A.loc

	return A

/turf/get_toplevel_atom()
	return src

/area/get_toplevel_atom()
	return src

/proc/trange(rad = 0, turf/centre = null) //alternative to range (ONLY processes turfs and thus less intensive)
	if(!centre)
		return

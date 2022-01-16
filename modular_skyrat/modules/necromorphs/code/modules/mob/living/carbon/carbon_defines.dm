/mob/living/carbon
	var/datum/species/species //Contains icon generation and language information, set during New().
// organ-related variables, see organ.dm and human_organs.dm
	//var/list/internal_organs = list()
	//var/list/organs = list()
	var/list/organs_by_name = list() // map organ names to organs
	var/list/internal_organs_by_name = list() // so internal organs have less ickiness too

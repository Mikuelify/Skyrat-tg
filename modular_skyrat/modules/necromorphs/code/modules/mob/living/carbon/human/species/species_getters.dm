/datum/species/proc/get_bodytype(var/mob/living/carbon/human/H)
	return name

/datum/species/proc/get_icobase(var/mob/living/carbon/human/H, var/get_deform)
	return (get_deform ? deform : icobase)

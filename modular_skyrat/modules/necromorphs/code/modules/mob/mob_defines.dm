


/mob
	var/list/grabbed_by = list()

//Returns what percentage of the limbs we use for movement, are still attached
/mob/living/carbon/human/proc/get_locomotive_limb_percent()

	var/current = length(get_locomotion_limbs(FALSE))
	var/max = LAZYLEN(species.locomotion_limbs)

	if (max > 0)
		return current / max

	return 1


//This proc tells how many legs we have
/mob/proc/get_locomotion_limbs(var/include_stump = FALSE)
	return list()

/mob/living/carbon/human/species/necromorph
	var/step_count
	var/step_interval	= 2

/mob/proc/get_organ(var/zone)
	return null

/mob/living/carbon/human/get_organ(var/zone)
	return organs_by_name[check_zone(zone)]

/mob/proc/get_organ_by_type(var/type)

/mob/living/carbon/human/get_organ_by_type(var/type)
	for (var/tag in organs_by_name)
		var/obj/O = organs_by_name[tag]
		if (istype(O, type))
			return O

/mob/living/carbon/human/get_locomotion_limbs(var/include_stump = FALSE)
	var/found = list()
	for (var/organ_tag in species.locomotion_limbs)
		var/obj/item/organ/external/E = get_organ(organ_tag)
		if (!E)
			continue

		//if (!include_stump && E.is_stump())
			//continue

		found |= E

	return found


/mob/living/carbon/human/get_locomotion_limbs(var/include_stump = FALSE)
	var/found = list()
	for (var/organ_tag in species.locomotion_limbs)
		var/obj/item/organ/external/E = get_organ(organ_tag)
		if (!E)
			continue

		//if (!include_stump && E.is_stump())
			//continue

		found |= E

	return found

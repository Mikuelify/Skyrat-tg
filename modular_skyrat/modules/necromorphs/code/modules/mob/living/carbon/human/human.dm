/mob/living/carbon/human

	var/list/stance_limbs
	var/list/grasp_limbs

/mob/living/carbon/human/species/necromorph/New(var/new_loc, var/new_species = null)
	grasp_limbs = list()
	stance_limbs = list()

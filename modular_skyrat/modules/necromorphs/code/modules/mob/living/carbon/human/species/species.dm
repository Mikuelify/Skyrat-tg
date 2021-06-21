/datum/species
	var/name_plural                                      // Pluralized name (since "[name]s" is not always valid)
	var/long_desc	=	""								 // An entire pageful of information. Generated at runtime from various variables and procs, check the description section below and override those
	var/blurb = "A completely nondescript species."      // A brief lore summary for use in the chargen screen.
	var/icon_lying = null
	var/icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/template.dmi' // Used for mob icon generation for non-32x32 species.
		// Damage overlay and masks.
	var/damage_overlays = 'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/human/damage_overlay.dmi'
	var/damage_mask =     'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/human/damage_mask.dmi'
	var/blood_mask =      'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/human/blood_mask.dmi'

	var/race_key = 0                          // Used for mob icon cache string.
	var/pixel_offset_x = 0                    // Used for offsetting large icons.
	var/pixel_offset_y = 0                    // Used for offsetting large icons.
	var/antaghud_offset_x = 0                 // As above, but specifically for the antagHUD indicator.
	var/antaghud_offset_y = 0                 // As above, but specifically for the antagHUD indicator.

	var/icobase =      'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/human/body.dmi'          // Normal icon set.
	var/deform =       'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/human/deformed_body.dmi' // Mutated icon set.
	var/preview_icon = 'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/human/preview.dmi'
	var/husk_icon =    'modular_skyrat/modules/necromorphs/icons/mob/human_races/species/default_husk.dmi'
	var/lying_rotation = 90 //How much to rotate the icon when lying down
	var/mob_type = /mob/living/carbon/human	//The mob we spawn in order to create a member of this species instantly


	/*--------------------------
		ORGAN HANDLING
	--------------------------*/


	var/list/has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest, "height" = new /vector2(1.25,1.65)),
//		BP_GROIN =  list("path" = /obj/item/organ/external/groin, "height" = new /vector2(1,1.25)),
		BP_HEAD =   list("path" = /obj/item/organ/external/head, "height" = new /vector2(1.65,1.85)),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm, "height" = new /vector2(0.9,1.60)),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right, "height" = new /vector2(0.9,1.60)),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg, "height" = new /vector2(0.1,1)),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right, "height" = new /vector2(0.1,1))
//		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right, "height" = new /vector2(0.8,0.9)),
//		BP_L_FOOT = list("path" = /obj/item/organ/external/foot, "height" = new /vector2(0,0.1)),
//		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right, "height" = new /vector2(0,0.1))
		)

	var/list/override_limb_types = list()	// Used for species that only need to change one or two entries in has_limbs.


	// The list for the bioprinter to print based on species
	var/list/bioprint_products = list(
//		BP_HEART    = list(/obj/item/organ/internal/heart,      25),
//		BP_LUNGS    = list(/obj/item/organ/internal/lungs,      25),
//		BP_KIDNEYS  = list(/obj/item/organ/internal/kidneys,    20),
//		BP_EYES     = list(/obj/item/organ/internal/eyes,       20),
//		BP_LIVER    = list(/obj/item/organ/internal/liver,      25),
//		BP_GROIN    = list(/obj/item/organ/external/groin,      80),
		BP_L_ARM    = list(/obj/item/organ/external/arm,        65),
		BP_R_ARM    = list(/obj/item/organ/external/arm/right,  65),
		BP_L_LEG    = list(/obj/item/organ/external/leg,        65),
		BP_R_LEG    = list(/obj/item/organ/external/leg/right,  65)
//		BP_L_FOOT   = list(/obj/item/organ/external/foot,       40),
//		BP_R_FOOT   = list(/obj/item/organ/external/foot/right, 40),
//		BP_L_HAND   = list(/obj/item/organ/external/hand,       40),
//		BP_R_HAND   = list(/obj/item/organ/external/hand/right, 40)
		)

	var/list/override_organ_types = list() // Used for species that only need to change one or two entries in has_organ
	var/list/has_organ = list() // which required-organ checks are conducted.

	//Stores organs that this species will use to defend itself from incoming strikes
	//An associative list of sublists, with the key being a category
	var/list/defensive_limbs = list(UPPERBODY = list(BP_L_ARM, BP_L_HAND, BP_R_ARM, BP_R_HAND), //Arms and hands are used to shield the face and body
	LOWERBODY = list(BP_L_LEG, BP_R_LEG))	//Legs, but not feet, are used to guard the groin

	//Used for species which have alternate organs in place of some default. For example, the leaper which has a tail instead of legs
	//This list should be in the format BP_ORIGINAL_ORGAN_TAG = BP_REPLACEMENT_ORGAN_TAG
	var/list/organ_substitutions = list()


/datum/species/New()

	// Modify organ lists if necessary.
	if(islist(override_limb_types))
		for(var/ltag in override_limb_types)
			if (override_limb_types[ltag])
				if (islist(override_limb_types[ltag]))
					has_limbs[ltag] = override_limb_types[ltag]
				else
					has_limbs[ltag] = list("path" = override_limb_types[ltag])
			else
				has_limbs.Remove(ltag)
/*
	if(islist(override_organ_types))
		for(var/ltag in override_organ_types)
			if (override_organ_types[ltag])
				has_organ[ltag] = list("path" = override_organ_types[ltag])
			else
				has_organ.Remove(ltag)
 */

/* /datum/species/proc/handle_npc(var/mob/living/carbon/human/H)
	return

//Mostly for toasters
/datum/species/proc/handle_limbs_setup(var/mob/living/carbon/human/H)
	return FALSE

/datum/species/proc/update_skin(var/mob/living/carbon/human/H)
	return */

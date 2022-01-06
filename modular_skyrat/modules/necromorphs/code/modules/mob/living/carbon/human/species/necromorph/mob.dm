

/*
	Code for the necromorph mob.
	Most of this is a temporary hack because we don't have proper icons for parts.

`	I am well aware this is not how human mobs and species are supposed to be used
*/

/mob/living/carbon/necromorph/
	name = "necromorph"
	//icon_state = "necromorph"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	icon_state = "twitcher"
	//race = /datum/species/necromorph
	var/use_singleIcon = FALSE

// /mob/living/carbon/necromorph/update_body() // we don't use the bodyparts or body layers for aliens.
// 	return

// /mob/living/carbon/necromorph/update_body_parts()//we don't use the bodyparts layer for aliens.
// 	return

/mob/living/carbon/necromorph/Initialize()
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	create_bodyparts() //initialize bodyparts

	create_internal_organs()

	. = ..()


///////////////////////////////////////////////////////
/mob/living/carbon/human/species/necromorph
	race = /datum/species/necromorph

/mob/living/carbon/human/species/necromorph/New(var/new_loc, var/new_species = SPECIES_NECROMORPH)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/Initialize()
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	create_bodyparts() //initialize bodyparts

	create_internal_organs()

	ADD_TRAIT(src, TRAIT_CAN_STRIP, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_NEVER_WOUNDED, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	. = ..()


/*
	Slasher Mob setup
*/
/mob/living/carbon/human/species/necromorph/slasher
	race = /datum/species/necromorph/slasher

/mob/living/carbon/human/species/necromorph/slasher/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_SLASHER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/slasher_enhanced/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_SLASHER_ENHANCED)
	..(new_loc, new_species)

/////////////////////////////////////////////////////////////

/mob/living/carbon/human/species/necromorph/divider/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_DIVIDER)
	..(new_loc, new_species)


/mob/living/carbon/human/species/necromorph/spitter/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_SPITTER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/puker/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_PUKER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/tripod/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_TRIPOD)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/twitcher/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_TWITCHER)
	..(new_loc, new_species)

//Variants need their own mobtype
/mob/living/carbon/human/species/necromorph/brute/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_BRUTE)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/bruteflesh/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_BRUTE_FLESH)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/exploder/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_EXPLODER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/leaper/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_LEAPER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/leaper/enhanced/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_LEAPER_ENHANCED)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/lurker/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_LURKER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/ubermorph/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_UBERMORPH)
	..(new_loc, new_species)


/* /mob/living/carbon/human/species/necromorph/hunter/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_HUNTER)
	..(new_loc, new_species) */

// #define DEBUG
// //Override all that complicated limb-displaying stuff, with singular icons
// /mob/living/carbon/human/species/necromorph/update_body(var/update_icons=1)
// 	var/datum/species/necromorph/N = species


// 	if (!istype(N))
// 		return

// 	//If single icon is turned off, do the normal thing
// 	if (!N.single_icon)
// 		return ..()

// 	stand_icon = N.icon_template
// 	icon = stand_icon

// 	if (stat == DEAD)
// 		icon_state = N.icon_dead

// 	else if (lying)
// 		icon_state = N.icon_lying
// 	else
// 		icon_state = N.icon_normal



//Generic proc to see if a thing is aligned with the necromorph faction
/datum/proc/is_necromorph()
	return FALSE

/* //We'll check the species on the brain first, before the rest of the body
/mob/living/carbon/human/species/is_necromorph()
	var/datum/species/S = get_mental_species_datum()
	return S.is_necromorph() */


/datum/species/necromorph/is_necromorph()
	return TRUE

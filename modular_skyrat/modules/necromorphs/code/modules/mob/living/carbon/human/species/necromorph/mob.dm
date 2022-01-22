

///////////////////////////////////////////////////////
/*
	Code for the necromorph species.
	Most of this is a temporary hack because we don't have proper icons for parts.

`	I am well aware this is not how human mobs and species are supposed to be used
*/
///////////////////////////////////////////////////////
/mob/living/carbon/human/species/necromorph
	race = /datum/species/necromorph
	name = "Necromorph"
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

/mob/living/carbon/human/species/necromorph/regenerate_icons()
	if(!..())
	// update_icons() //Handled in update_transform(), leaving this here as a reminder
		update_transform()


/*
	Slasher Mob setup
*/
/mob/living/carbon/human/species/necromorph/slasher
	race = /datum/species/necromorph/slasher
/mob/living/carbon/human/species/necromorph/divider
	race = /datum/species/necromorph/divider
/mob/living/carbon/human/species/necromorph/exploder
	race = /datum/species/necromorph/exploder
/mob/living/carbon/human/species/necromorph/leaper
	race = /datum/species/necromorph/leaper
/mob/living/carbon/human/species/necromorph/puker
	race = /datum/species/necromorph/puker
/mob/living/carbon/human/species/necromorph/spitter
	//race = /datum/species/necromorph/slasher/spitter
/mob/living/carbon/human/species/necromorph/tripod
	race = /datum/species/necromorph/tripod
/mob/living/carbon/human/species/necromorph/ubermorph
	race = /datum/species/necromorph/ubermorph
/mob/living/carbon/human/species/necromorph/brute
	race = /datum/species/necromorph/brute
	name = "Brute" //SPECIES_NECROMORPH_BRUTE
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi'
	icon_state = "brute-d"
	//status_flags = CANUNCONSCIOUS|CANPUSH|NOPAIN
	maxHealth = 400
	health = 450
	//icon_living = "brute-d"
	//icon_lying = "brute-d-dead"//Temporary icon so its not invisible lying down
	//icon_dead = "brute-d-dead"
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	melee_damage_lower = 30
	melee_damage_upper = 40
	see_in_dark = 8
	pixel_x = -16
	base_pixel_x = -16
	//biomass = 350
	pressure_resistance = 200 //Because big, stompy xenos should not be blown around like paper.
	butcher_results = list(/obj/item/food/meat/slab/xeno = 20, /obj/item/stack/sheet/animalhide/xeno = 3)

/mob/living/carbon/human/species/necromorph/brute/Initialize()
	. = ..()
/*
	Applies Icon to Single-Icon state mobs. Still needs overlays and support for dismemberment mask, damage mask, Blood Mask.
*/
/mob/living/carbon/human/species/necromorph/brute/update_body_parts()
	. = ..()
	remove_overlay(BODYPARTS_LAYER)
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi'
	icon_state = "brute-d"

/mob/living/carbon/human/species/necromorph/slasher/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_SLASHER)
	..(new_loc, new_species)

/mob/living/carbon/human/species/necromorph/slasher_enhanced/New(var/new_loc, var/new_species = SPECIES_NECROMORPH_SLASHER_ENHANCED)
	..(new_loc, new_species)

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

/mob/living/carbon/human/necromorph/update_icons()
	var/datum/species/necromorph/N = species
	message_admins("[N] single_icon is set to [N.single_icon]")
	.=..()
	if(N.single_icon == TRUE)
		message_admins("[N] single_icon is set to [N.single_icon]")
		update_appearance()



/*

	Control Individual Necromorph Icons. Currently it is not working.

update_body_parts()
will use the icons from the limbs as a standing overlay
you can remove that with remove_overlay(BODYPARTS_LAYER)
on the human level
and then you just set the icon and icon_state



// #define DEBUG
//Override all that complicated limb-displaying stuff, with singular icons
/mob/living/carbon/human/species/necromorph/update_body_parts()
	.=..()
	var/datum/species/necromorph/N = species
	if(!N.single_icon)
		remove_overlay(BODYPARTS_LAYER)
		icon = ""
		icon-state = ""
		//mutable_appearance('modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi', "brute-d")


	//If single icon is turned off, do the normal thing
*/





//Generic proc to see if a thing is aligned with the necromorph faction
/datum/proc/is_necromorph()
	return FALSE

/* //We'll check the species on the brain first, before the rest of the body
/mob/living/carbon/human/species/is_necromorph()
	var/datum/species/S = get_mental_species_datum()
	return S.is_necromorph() */


/datum/species/necromorph/is_necromorph()
	return TRUE


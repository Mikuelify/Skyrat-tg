/*
- Based off of modular_skyrat\modules\ds13\code\modules\mob\living\carbon\human\species\necromorph\necromorph_species.dm
Do we add BIOMASS in future for Marker Controller
- Limb Removal
- Abilities
- Necromorph Stats
*/
/mob/living/carbon/necromorph
	name = "necromorph"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	//gender = FEMALE //All xenos are girls!!
	dna = null
	faction = list(ROLE_NECROMORPH)
	sight = SEE_MOBS
	verb_say = "hisses"
	// initial_language_holder = /datum/language_holder/necromorph
	bubble_icon = "necromorph"
	type_of_meat = /obj/item/food/meat/slab/xeno // [TODO] Make Gibs and Individual Body Parts

	var/move_delay_add = 0 // movement delay to add

	// status_flags = CANUNCONSCIOUS|CANPUSH

	heat_protection = 0.5 // minor heat insulation
	var/biomass = 100

	var/leaping = FALSE
	gib_type = /obj/effect/decal/cleanable/xenoblood/xgibs
	unique_name = TRUE

// Icons Override
	var/single_icon = TRUE
	var/icon_normal = "slasher_d"
	var/icon_dead = "slasher_d_dead"

// Naming
	var/static/regex/necromorph_name_regex = new("necromorph (slasher|brute|drone|hunter|praetorian|queen)( \\(\\d+\\))?") // Should this be every Necro Variety



/mob/living/carbon/necromorph/Initialize()
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	create_bodyparts() //initialize bodyparts

	create_internal_organs()

	ADD_TRAIT(src, TRAIT_NEVER_WOUNDED, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	. = ..()

/* /mob/living/carbon/necromorph/create_internal_organs()
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/eyes
	internal_organs += new /obj/item/organ/ears
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/liver
	internal_organs += new /obj/item/organ/stomach
	internal_organs += new /obj/item/organ/appendix
	..() */


/* /mob/living/carbon/necromorph/create_bodyparts()
	HEAD += new /obj/item/organ/external/head
	LEG_LEFT += new /obj/item/organ/external/chest/standard

	. = ..()
	() */


/mob/living/carbon/necromorph/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null) // beepsky won't hunt aliums
	return -10
/mob/living/carbon/necromorph/reagent_check(datum/reagent/R, delta_time, times_fired) //can metabolize all reagents
	return FALSE

/mob/living/carbon/necromorph/get_status_tab_items()
	. = ..()
	. += "Combat mode: [combat_mode ? "On" : "Off"]"

/mob/living/carbon/necromorph/getTrail()
	if(getBruteLoss() < 200)
		return pick (list("xltrails_1", "xltrails2"))
	else
		return pick (list("xttrails_1", "xttrails2"))


/mob/living/carbon/necromorph/canBeHandcuffed()
	if(num_hands < 2)
		return FALSE
	return TRUE


/mob/living/carbon/necromorph/can_hold_items(obj/item/I)
	return (I && (I.item_flags & XENOMORPH_HOLDABLE || ISADVANCEDTOOLUSER(src)) && ..())

/mob/living/carbon/necromorph/on_lying_down(new_lying_angle)
	. = ..()
	update_icons()

/mob/living/carbon/necromorph/on_standing_up()
	. = ..()
	update_icons()

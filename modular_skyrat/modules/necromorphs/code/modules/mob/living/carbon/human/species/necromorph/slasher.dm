/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/slasher
	name = SPECIES_NECROMORPH_SLASHER
	id = SPECIES_NECROMORPH_SLASHER
	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	sexes = 0
	single_icon = FALSE
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"
	can_have_genitals = FALSE
	attack_effect = ATTACK_EFFECT_CLAW
	species_traits = list(HAS_FLESH, HAS_BONE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_FAKEDEATH,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOCLONELOSS,
	)


///////////////// Mutant Parts /////////////////
	mutanteyes = /obj/item/organ/eyes/night_vision
//	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/skrell_parts_greyscale.dmi'
//	eyes_icon = 'modular_skyrat/master_files/icons/mob/species/skrell_eyes.dmi'

	//Slashers hold their arms up in an overhead pose, so they override height too
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
	BODY_ZONE_L_ARM =  list("path" = /obj/item/organ/external/arm/blade/slasher, "height" = new /vector2(1.6,2)),
	BODY_ZONE_R_ARM =  list("path" = /obj/item/organ/external/arm/blade/slasher/right, "height" = new /vector2(1.6,2))
	)

/*
	Blade Arm
*/
/obj/item/organ/external/arm/blade/slasher
	limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/slasher/right
	organ_tag = BP_R_ARM
	name = "right arm"
	icon_name = "r_arm"
	body_part = ARM_RIGHT
	joint = "right elbow"
	amputation_point = "right shoulder"


/*Roughly speaking, enhanced versions of necromorphs have:
	250% biomass cost and max health
	140% damage on attacks and abilites
	80% windup and cooldown times, move and attack delays
*/



/* //Special death condition: Slashers die when they lose both blade arms
/datum/species/necromorph/slasher/handle_death_check(var/mob/living/carbon/human/species/H)
	.=..()
	if (!.)
		if (!H.has_organ(BP_L_ARM) && !H.has_organ(BP_R_ARM))
			return TRUE
 */


#undef SLASHER_DODGE_EVASION
#undef SLASHER_DODGE_DURATION

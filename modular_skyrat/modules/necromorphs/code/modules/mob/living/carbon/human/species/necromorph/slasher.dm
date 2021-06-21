/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/slasher
	name = SPECIES_NECROMORPH_SLASHER
//	name_plural =  "Slashers"
	mob_type = /mob/living/carbon/human/necromorph/slasher
//	blurb = "The frontline soldier of the necromorph horde. Slow when not charging, but its blade arms make for powerful melee attacks"
//	unarmed_types = list(/datum/unarmed_attack/blades, /datum/unarmed_attack/bite/weak) //Bite attack is a backup if blades are severed
//	total_health = 90
//	biomass = 50
//	mass = 70

//	biomass_reclamation_time	=	7 MINUTES

	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	damage_mask = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/damage_mask.dmi'
	//icon_lying = "_lying"
	pixel_offset_x = -8
	single_icon = FALSE
//	evasion = 0	//No natural evasion
//	spawner_spawnable = TRUE

	//Slashers hold their arms up in an overhead pose, so they override height too
	mutant_bodyparts = list(
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/blade/slasher, "height" = new /vector2(1.6,2)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/blade/slasher/right, "height" = new /vector2(1.6,2))
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
/datum/species/necromorph/slasher/handle_death_check(var/mob/living/carbon/human/H)
	.=..()
	if (!.)
		if (!H.has_organ(BP_L_ARM) && !H.has_organ(BP_R_ARM))
			return TRUE
 */


#undef SLASHER_DODGE_EVASION
#undef SLASHER_DODGE_DURATION

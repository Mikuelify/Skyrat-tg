/obj/item/organ/necromorph/external/arm/blade
	/* limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high
	organ_tag = BP_L_ARM
	name = "left blade"
	icon_name = "l_arm"
	max_damage = 60
	min_broken_damage = 40
	w_class = ITEM_SIZE_NORMAL
	body_part = ARM_LEFT
	parent_organ = BODY_ZONE_CHEST
	joint = "left elbow"
	amputation_point = "left shoulder"
	tendon_name = "palmaris longus tendon"
	artery_name = "basilic vein"
	arterial_bleed_severity = 0.75
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE
	base_miss_chance = 10 */

/obj/item/organ/necromorph/external/arm/blade/right
/* 	organ_tag = BP_R_ARM
	name = "right arm"
	icon_name = "r_arm"
	body_part = ARM_RIGHT
	joint = "right elbow"
	amputation_point = "right shoulder" */




//Giant limbs
//---------------
//Used by brute, these limbs have 4x the health, and half the evasion values
/obj/item/organ/necromorph/external/head/giant
//	max_damage = 260
//	min_broken_damage = 140
//	base_miss_chance = 10

/obj/item/organ/necromorph/external/chest/giant
//	min_broken_damage = 180
//	limb_flags = ORGAN_FLAG_HEALS_OVERKILL //| ORGAN_FLAG_GENDERED_ICON 	//No gendered icon
//
/obj/item/organ/necromorph/external/groin/giant
//	max_damage = 180
//	min_broken_damage = 90
//
/obj/item/organ/necromorph/external/arm/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 6
//
/obj/item/organ/necromorph/external/arm/right/giant
//	max_damage = 180
//	min_broken_damage = 100
//
/obj/item/organ/necromorph/external/leg/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 4
//
/obj/item/organ/necromorph/external/leg/right/giant
//	max_damage = 180
//	min_broken_damage = 100
//

/obj/item/organ/necromorph/external/foot/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 7.5
//
/obj/item/organ/necromorph/external/foot/right/giant
//	max_damage = 180
//	min_broken_damage = 100

/obj/item/organ/necromorph/external/hand/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 7.5

/obj/item/organ/necromorph/external/hand/right/giant
//	max_damage = 180
//	min_broken_damage = 100


/obj/item/organ/necromorph/external/head/ubermorph
//	glowing_eyes = FALSE
//	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_HEALS_OVERKILL
	var/eye_icon = 'icons/mob/necromorph/ubermorph.dmi'

/* /obj/item/organ/necromorph/external/head/ubermorph/replaced(var/mob/newowner)
	.=..()


	//Lets do a little animation for the eyes lighting up
	var/image/LR = image(eye_icon, newowner, "eyes_anim")
	LR.plane = EFFECTS_ABOVE_LIGHTING_PLANE
	LR.layer = EYE_GLOW_LAYER
	flick_overlay_source(LR, newowner, 3 SECONDS)

	//Activate the actual glow
	spawn(2.7 SECONDS)
		glowing_eyes = TRUE
		eye_icon_location = eye_icon
		owner.update_body(TRUE) */


/obj/item/organ/necromorph/external/head/simple/slasher_enhanced
//	normal_eyes = FALSE
//	glowing_eyes = TRUE
//	eye_icon_location = 'icons/mob/necromorph/slasher_enhanced.dmi'



//Torso Eyes and Brain
//-----------------------
//For mobs without a head, or whose head simply isn't considered a seperate bodypart in technical terms
/obj/item/organ/necromorph/internal/brain/undead/torso
//	parent_organ = BP_CHEST

/obj/item/organ/necromorph/internal/eyes/torso
//	parent_organ = BP_CHEST

/obj/item/organ/external
//	var/vector2/limb_height = new /vector2(0,1)	//Height is a range of where the limb extends vertically. The first value is the lower bound, second is the upper
	//Height values assume the mob is in its normal pose standing on the ground
	//All height values are in metres, and also tiles. A turf is 1 metre by 1 metre

/obj/item/organ/external/arm/blade/
	name = "hydraulic pump engine"
	desc = "An electronic device that handles the hydraulic pumps, powering one's robotic limbs."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "l_arm"
	limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/right
	icon_state = "r_arm"
/obj/item/organ/external/arm/blade/slasher
	limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/slasher/right

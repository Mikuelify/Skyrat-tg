/obj/item/organ/external
	name = "external"


	// Strings
	var/broken_description             // fracture string if any.
	var/damage_state = "00"            // Modifier used for generating the on-mob damage overlay for this limb.

	// Damage vars.
	var/brute_dam = 0                  // Actual current brute damage.
	var/brute_ratio = 0                // Ratio of current brute damage to max damage.
	var/burn_dam = 0                   // Actual current burn damage.
	var/burn_ratio = 0                 // Ratio of current burn damage to max damage.
	var/last_dam = -1                  // used in healing/processing calculations.
	var/pain = 0                       // How much the limb hurts.
	var/pain_disability_threshold      // Point at which a limb becomes unusable due to pain.
//	var/defensive_group	= UPPERBODY	   // If set, this dictates which set of limbs will be used in an attempt to shield this bodypart from attack. Should only be set on core parts, not limbs
	var/block_reduction = 3			   // When this limb is used to block a strike, this flat number is subtracted from the damage of the incoming hit


	// Physics
	var/vector2/limb_height = new /vector2(0,1)	//Height is a range of where the limb extends vertically. The first value is the lower bound, second is the upper
	//Height values assume the mob is in its normal pose standing on the ground
	//All height values are in metres, and also tiles. A turf is 1 metre by 1 metre


	//Retraction handling
	var/retracted	=	FALSE			//	Is this limb retracted into its parent?  If true, the limb is not rendered and all hits are passed to parent
	var/retract_timer					//	A timer handle used for temporary retractions or extensions

	// A bitfield for a collection of limb behavior flags.
//	var/limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_BREAK

	// Appearance vars.
	var/icon_name = null               // Icon state base.
	var/body_part = null               // Part flag
	var/icon_position = 0              // Used in mob overlay layering calculations.
	var/model                          // Used when caching robolimb icons.
	var/force_icon                     // Used to force override of species-specific limb icons (for prosthetics).
	var/icon/mob_icon                  // Cached icon for use in mob overlays.
	var/s_tone                         // Skin tone.
	var/s_base = ""                    // Skin base.
	var/list/s_col                     // skin colour
	var/s_col_blend = ICON_ADD         // How the skin colour is applied.
	var/list/h_col                     // hair colour
	var/body_hair                      // Icon blend for body hair if any.
	var/list/markings = list()         // Markings (body_markings) to apply to the icon
	var/best_direction	=	EAST		//When severed, draw the icon facing in this direction
//	blocksound = 'sound/effects/impacts/block.ogg'

	// Wound and structural data.
	var/wound_update_accuracy = 1      // how often wounds should be updated, a higher number means less often
	var/list/wounds = list()           // wound datum list.
	var/number_wounds = 0              // number of wounds, which is NOT wounds.len!
	var/obj/item/organ/external/parent // Master-limb.
	var/list/children                  // Sub-limbs.
	var/list/internal_organs = list()  // Internal organs of this body part
	var/list/implants = list()         // Currently implanted objects.
	var/base_miss_chance = 0          // Chance of missing.
	var/genetic_degradation = 0
//	biomass = 2	//By default, external organs are worth 2kg of biomass. Hella inaccurate, could find more exact values


	//Forensics stuff
	var/list/autopsy_data = list()    // Trauma data for forensics.

	// Joint/state stuff.
	var/joint = "joint"                // Descriptive string used in dislocation.
	var/amputation_point               // Descriptive string used in amputation.
	var/dislocated = 0                 // If you target a joint, you can dislocate the limb, causing temporary damage to the organ.
	var/encased                        // Needs to be opened with a saw to access the organs.
	var/artery_name = "artery"         // Flavour text for cartoid artery, aorta, etc.
	var/arterial_bleed_severity = 1    // Multiplier for bleeding in a limb.
	var/tendon_name = "tendon"         // Flavour text for Achilles tendon, etc.
	var/cavity_name = "cavity"

	// Surgery vars.
	var/cavity_max_w_class = 0
	var/hatch_state = 0
	var/stage = 0
	var/cavity = 0
	var/atom/movable/applied_pressure
	var/atom/movable/splinted

	// HUD element variable, see organ_icon.dm get_damage_hud_image()
	var/image/hud_damage_image

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


///obj/item/organ/necromorph/external/head/ubermorph
//	glowing_eyes = FALSE
//	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_HEALS_OVERKILL
//	var/eye_icon = 'icons/mob/necromorph/ubermorph.dmi'

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
///obj/item/organ/necromorph/internal/brain/undead/torso
//	parent_organ = BP_CHEST

///obj/item/organ/necromorph/internal/eyes/torso
//	parent_organ = BP_CHEST

///obj/item/organ/brain/necromorph

///obj/item/organ/eyes/necromorph

///obj/item/organ/lungs/necromorph

///obj/item/organ/heart/necromorph

///obj/item/organ/liver/necromorph

///obj/item/organ/tongue/necromorph

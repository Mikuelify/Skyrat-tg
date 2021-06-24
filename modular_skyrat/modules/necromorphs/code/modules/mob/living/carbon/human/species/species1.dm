/datum/species/necromorphs
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
	var/mob_type = /mob/living/carbon/human/species/necromorph	//The mob we spawn in order to create a member of this species instantly

	// Descriptors and strings.
	// Icon/appearance vars.
	var/lying_rotation = 90 //How much to rotate the icon when lying down
	var/health_doll_offset	= WORLD_ICON_SIZE+8	//For this species, the hud health doll is offset this many pixels to the right.
	//This default value is fine for humans and anything roughly the same width as a human, larger creatures will require different numbers
	//The value required depends not only on overall icon size, but also on the empty space on -both- sides of the sprite. Trial and error is the best way to find the right number

	var/icon/default_icon	//Constructed at runtime, this stores an icon which represents a typical member of this species with all values at default. This is mainly for use in UIs and reference

	//This icon_lying var pulls several duties
	//First, if its non-null, it indicates this species has some kind of special behaviour when lying down. This will trigger extra updates and things
	//Secondly, it is the string suffix added to organ iconstates
	//Thirdly, in single icon mode, it is the icon state for lying down

	// Damage overlay and masks.

	var/blood_color = COLOR_BLOOD_HUMAN               // Red.
	var/flesh_color = "#ffc896"               // Pink.
//	var/blood_oxy = 1
	var/base_color                            // Used by changelings. Should also be used for icon previes..
	var/limb_blend = ICON_ADD
	var/tail                                  // Name of tail state in species effects icon file.
	var/tail_animation                        // If set, the icon to obtain tail animation states from.
	var/tail_blend = ICON_ADD
	var/tail_hair

	var/list/hair_styles
	var/list/facial_hair_styles

	var/organs_icon		//species specific internal organs icons

	var/default_h_style = "Bald"
	var/default_f_style = "Shaved"


//	var/mob_size	= MOB_MEDIUM
//	var/strength    = STR_MEDIUM
//	var/show_ssd = "fast asleep"
//	var/virus_immune
	var/biomass	=	80	//How much biomass does it cost to spawn this (for necros) and how much does it yield when absorbed by a marker
		//This is in kilograms, and is thus approximately the mass of an average human male adult
	var/mass = 80	//Actual mass of the resulting mob

	var/layer = BASE_HUMAN_LAYER
	var/layer_lying	=	LYING_HUMAN_LAYER

//	var/light_sensitive                       // Ditto, but requires sunglasses to fix
//	var/blood_volume = SPECIES_BLOOD_DEFAULT  // Initial blood volume.
//	var/hunger_factor = DEFAULT_HUNGER_FACTOR // Multiplier for hunger.
//	var/taste_sensitivity = TASTE_NORMAL      // How sensitive the species is to minute tastes.

	var/min_age = 17
	var/max_age = 70

	// Language/culture vars.
//	var/default_language = LANGUAGE_GALCOM    // Default language is used when 'say' is used without modifiers.
//	var/language = LANGUAGE_GALCOM            // Default racial language, if any.
//	var/list/secondary_langs = list()         // The names of secondary languages that are available to this species.
//	var/assisted_langs = list()               // The languages the species can't speak without an assisted organ.
	var/num_alternate_languages = 0           // How many secondary languages are available to select at character creation
//	var/name_language = LANGUAGE_GALCOM       // The language to use when determining names for this species, or null to use the first name/last name generator
	var/additional_langs                      // Any other languages the species always gets.

	//Audio vars
	var/step_volume = 30	//Base volume of ALL footstep sounds for this mob
	var/step_range = -1		//Base volume of ALL footstep sounds for this mob. Each point of range adds or subtracts two tiles from the actual audio distance
	var/step_priority = 0	//Base priority of species-specific footstep sounds. Zero disables them
	var/pain_audio_threshold = 0	//If a mob takes damage equal to this portion of its total health, (and audio files exist), it will scream in pain
	var/list/species_audio = list()	//An associative list of lists, in the format SOUND_TYPE = list(sound_1, sound_2)
		//In addition, the list of sounds supports weighted picking (default weight 1 if unspecified).
		//For example: (sound_1, sound_2 = 0.5) will result in sound_2 being played half as often as sound_1
	var/list/speech_chance                    // The likelihood of a speech sound playing.
	var/list/species_audio_volume = list()		//An associative list, in the format SOUND_TYPE = VOLUME_XXX. Values set here will override the volume of species audio files

	// Health and Defense
	var/total_health = 120                   // Point at which the mob will enter crit.
	var/healing_factor	=	0.07				//Base damage healed per organ, per tick
	var/burn_heal_factor = 1				//When healing burns passively, the heal amount is multiplied by this
	var/max_heal_threshold	=	0.6			//Wounds can only autoheal if the damage is less than this * max_damage
	var/wound_remnant_time = 10 MINUTES	//How long fully-healed wounds stay visible before vanishing
	var/limb_health_factor	=	1	//Multiplier on max health of limbs
	var/pain_shock_threshold	=	50	//The mob starts going into shock when total pain reaches this value
	var/stability = 1	//Multiplier on resistance to physical forces. Higher value makes someone harder to knock down with forcegun/etc
	var/lasting_damage_factor = 0	//If nonzero, the mob suffers lasting damage equal to this percentage of all incoming damage



	var/list/natural_armour_values            // Armour values used if naked.
	var/brute_mod =      1                    // Physical damage multiplier.
	var/burn_mod =       1                    // Burn damage multiplier.
	var/oxy_mod =        1                    // Oxyloss modifier
	var/toxins_mod =     1                    // Toxloss modifier
	var/radiation_mod =  1                    // Radiation modifier
	var/flash_mod =      1                    // Stun from blindness modifier.
	var/metabolism_mod = 1                    // Reagent metabolism modifier
	var/stun_mod =       1                    // Stun period modifier.
	var/paralysis_mod =  1                    // Paralysis period modifier.
	var/weaken_mod =     1                    // Weaken period modifier.
	var/can_obliterate	=	TRUE			  // If false, this mob won't be deleted when gibbed. Though all their limbs will still be blasted off

	// Death vars.
//	var/meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/human
//	var/remains_type = /obj/item/remains/xeno
//	var/gibbed_anim = "gibbed-h"
//	var/dusted_anim = "dust-h"

	var/death_message = "seizes up and falls limp, their eyes dead and lifeless..."
	var/knockout_message = "collapses, having been knocked unconscious."
	var/halloss_message = "slumps over, too weak to continue fighting..."
	var/halloss_message_self = "The pain is too severe for you to keep going..."

	var/limbs_are_nonsolid
	var/spawns_with_stack = 0
	// Environment tolerance/life processes vars.
	var/reagent_tag                                             // Used for metabolizing reagents.
	var/breath_pressure = 16                                    // Minimum partial pressure safe for breathing, kPa
	var/breath_type = "oxygen"                                  // Non-oxygen gas breathed, if any.
	var/poison_types = list(MATERIAL_PHORON = TRUE, "chlorine" = TRUE) // Noticeably poisonous air - ie. updates the toxins indicator on the HUD.
	var/exhale_type = "carbon_dioxide"                          // Exhaled gas type.
	var/max_pressure_diff = 60                                  // Maximum pressure difference that is safe for lungs
	var/cold_level_1 = 243                                      // Cold damage level 1 below this point. -30 Celsium degrees
	var/cold_level_2 = 200                                      // Cold damage level 2 below this point.
	var/cold_level_3 = 120                                      // Cold damage level 3 below this point.
	var/heat_level_1 = 360                                      // Heat damage level 1 above this point.
	var/heat_level_2 = 400                                      // Heat damage level 2 above this point.
	var/heat_level_3 = 1000                                     // Heat damage level 3 above this point.
	var/passive_temp_gain = 0		                            // Species will gain this much temperature every second
	var/hazard_high_pressure = HAZARD_HIGH_PRESSURE             // Dangerously high pressure.
	var/warning_high_pressure = WARNING_HIGH_PRESSURE           // High pressure warning.
	var/warning_low_pressure = WARNING_LOW_PRESSURE             // Low pressure warning.
	var/hazard_low_pressure = HAZARD_LOW_PRESSURE               // Dangerously low pressure.
	var/body_temperature = 310.15	                            // Species will try to stabilize at this temperature.
	                                                            // (also affects temperature processing)
	var/heat_discomfort_level = 315                             // Aesthetic messages about feeling warm.
	var/cold_discomfort_level = 285                             // Aesthetic messages about feeling chilly.
	var/list/heat_discomfort_strings = list(
		"You feel sweat drip down your neck.",
		"You feel uncomfortably warm.",
		"Your skin prickles in the heat."
		)
	var/list/cold_discomfort_strings = list(
		"You feel chilly.",
		"You shiver suddenly.",
		"Your chilly flesh stands out in goosebumps."
		)

	// HUD data vars.
	var/datum/hud_data/hud
	var/hud_type
	var/health_hud_intensity = 1

//	var/grab_type = GRAB_NORMAL		// The species' default grab type.

	//Movement
	var/slowdown = 0              // Passive movement speed malus (or boost, if negative)
	// Move intents. Earlier in list == default for that type of movement.
//	var/list/move_intents = list(/decl/move_intent/walk, /decl/move_intent/run, /decl/move_intent/stalk)

	var/slow_turning = FALSE		//If true, mob goes on move+click cooldown when rotating in place, and can't turn+move in the same step
	var/list/locomotion_limbs = list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)	//What limbs does this species use to move? It goes slower when these are missing/broken/splinted
	var/lying_speed_factor = 0.25	//Our speed is multiplied by this when crawling


	//Interaction
	var/limited_click_arc = 0	  //If nonzero, the mob is limited to clicking on things in X degrees arc infront of it. Best combined with slow turning. Recommended values, 45 or 90
	var/list/grasping_limbs = list(BP_R_HAND, BP_L_HAND)	//What limbs does this mob use for interacting with objects?

	//Vision
	var/view_offset = 0			  //How far forward the mob's view is offset, in pixels.
	var/view_range = 7		  //Mob's vision radius, in tiles. It gets buggy with values below 7, but anything 7+ is flawless
	var/darksight_range = 2       // Native darksight distance.
//	var/darksight_tint = DARKTINT_NONE // How shadows are tinted.
	var/vision_flags = SEE_SELF               // Same flags as glasses.
//	var/short_sighted                         // Permanent weldervision.

	// Body/form vars.
	var/list/inherent_verbs 	  // Species-specific verbs.
	var/has_fine_manipulation = 1 // Can use small items.
	var/can_pickup	=	TRUE	  // Can pickup items at all
	var/siemens_coefficient = 1   // The lower, the thicker the skin and better the insulation.
	var/species_flags = 0         // Various specific features.
	var/appearance_flags = 0      // Appearance/display related features.
	var/spawn_flags = 0           // Flags that specify who can spawn as this species
	var/primitive_form            // Lesser form, if any (ie. monkey for humans)
//	var/greater_form              // Greater form, if any, ie. human for monkeys.
	var/holder_type
//	var/gluttonous                // Can eat some mobs. Values can be GLUT_TINY, GLUT_SMALLER, GLUT_ANYTHING, GLUT_ITEM_TINY, GLUT_ITEM_NORMAL, GLUT_ITEM_ANYTHING, GLUT_PROJECTILE_VOMIT
	var/stomach_capacity = 5      // How much stuff they can stick in their stomach
	var/rarity_value = 1          // Relative rarity/collector value for this species.
	                              // Determines the organs that the species spawns with and

	var/vision_organ              // If set, this organ is required for vision. Defaults to "eyes" if the species has them.
	var/breathing_organ           // If set, this organ is required for breathing. Defaults to "lungs" if the species has them.
	var/can_vomit = TRUE		//Whether this mob can vomit, added to disable it on necromorphs

//	var/obj/effect/decal/cleanable/blood/tracks/move_trail = /obj/effect/decal/cleanable/blood/tracks/footprints // What marks are left when walking

	var/list/skin_overlays = list()





	/*--------------------------
		ORGAN HANDLING
	--------------------------*/


	var/list/has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest, "height" = new /vector2(1.25,1.65)),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin, "height" = new /vector2(1,1.25)),
		BP_HEAD =   list("path" = /obj/item/organ/external/head, "height" = new /vector2(1.65,1.85)),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm, "height" = new /vector2(0.9,1.60)),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right, "height" = new /vector2(0.9,1.60)),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg, "height" = new /vector2(0.1,1)),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right, "height" = new /vector2(0.1,1)),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand, "height" = new /vector2(0.8,0.9)),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right, "height" = new /vector2(0.8,0.9)),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot, "height" = new /vector2(0,0.1)),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right, "height" = new /vector2(0,0.1))
		)



	var/list/override_limb_types 	// Used for species that only need to change one or two entries in has_limbs.

	// The list for the bioprinter to print based on species
	var/list/bioprint_products = list(
		BP_HEART    = list(/obj/item/organ/internal/heart,      25),
		BP_LUNGS    = list(/obj/item/organ/internal/lungs,      25),
		BP_KIDNEYS  = list(/obj/item/organ/internal/kidneys,    20),
		BP_EYES     = list(/obj/item/organ/internal/eyes,       20),
		BP_LIVER    = list(/obj/item/organ/internal/liver,      25),
		BP_GROIN    = list(/obj/item/organ/external/groin,      80),
		BP_L_ARM    = list(/obj/item/organ/external/arm,        65),
		BP_R_ARM    = list(/obj/item/organ/external/arm/right,  65),
		BP_L_LEG    = list(/obj/item/organ/external/leg,        65),
		BP_R_LEG    = list(/obj/item/organ/external/leg/right,  65),
		BP_L_FOOT   = list(/obj/item/organ/external/foot,       40),
		BP_R_FOOT   = list(/obj/item/organ/external/foot/right, 40),
		BP_L_HAND   = list(/obj/item/organ/external/hand,       40),
		BP_R_HAND   = list(/obj/item/organ/external/hand/right, 40)
		)

	var/list/override_organ_types // Used for species that only need to change one or two entries in has_organ

	var/list/has_organ = list(    // which required-organ checks are conducted.
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_APPENDIX = /obj/item/organ/internal/appendix,
		BP_EYES =     /obj/item/organ/internal/eyes
		)

	//Stores organs that this species will use to defend itself from incoming strikes
	//An associative list of sublists, with the key being a category
	var/list/defensive_limbs = list(UPPERBODY = list(BP_L_ARM, BP_L_HAND, BP_R_ARM, BP_R_HAND), //Arms and hands are used to shield the face and body
	LOWERBODY = list(BP_L_LEG, BP_R_LEG))	//Legs, but not feet, are used to guard the groin

	//Used for species which have alternate organs in place of some default. For example, the leaper which has a tail instead of legs
	//This list should be in the format BP_ORIGINAL_ORGAN_TAG = BP_REPLACEMENT_ORGAN_TAG
	var/list/organ_substitutions = list()

	// The basic skin colours this species uses
	var/list/base_skin_colours

	var/list/genders = list(MALE, FEMALE)

	// Bump vars
///	var/bump_flag = HUMAN	// What are we considered to be when bumped?
//	var/push_flags = ~HEAVY	// What can we push?
//	var/swap_flags = ~HEAVY	// What can we swap place with?
//	var/density_lying = FALSE	//Is this mob dense while lying down?
//	var/opacity = FALSE		//Does this mob block vision?

	var/pass_flags = 0
//	var/breathing_sound = 'sound/voice/monkey.ogg'
	var/list/equip_adjust = list()
	var/list/equip_overlays = list()

	var/list/base_auras

	var/sexybits_location	//organ tag where they are located if they can be kicked for increased pain

	var/list/prone_overlay_offset = list(0, 0) // amount to shift overlays when lying
	var/job_skill_buffs = list()				// A list containing jobs (/datum/job), with values the extra points that job recieves.

	var/disarm_cooldown = 0

/*
These are all the things that can be adjusted for equipping stuff and
each one can be in the NORTH, SOUTH, EAST, and WEST direction. Specify
the direction to shift the thing and what direction.

example:
	equip_adjust = list(
		slot_back_str = list(NORTH = list(SOUTH = 12, EAST = 7), EAST = list(SOUTH = 2, WEST = 12))
			)

This would shift back items (backpacks, axes, etc.) when the mob
is facing either north or east.
When the mob faces north the back item icon is shifted 12 pixes down and 7 pixels to the right.
When the mob faces east the back item icon is shifted 2 pixels down and 12 pixels to the left.

The slots that you can use are found in items_clothing.dm and are the inventory slot string ones, so make sure
	you use the _str version of the slot.
*/

/datum/species/necromorphs/New()

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

	if(islist(override_organ_types))
		for(var/ltag in override_organ_types)
			if (override_organ_types[ltag])
				has_organ[ltag] = list("path" = override_organ_types[ltag])
			else
				has_organ.Remove(ltag)

	//If the species has eyes, they are the default vision organ
	if(!vision_organ && has_organ[BP_EYES])
		vision_organ = BP_EYES
	//If the species has lungs, they are the default breathing organ
	if(!breathing_organ && has_organ[BP_LUNGS])
		breathing_organ = BP_LUNGS

	unarmed_attacks = list()
	for(var/u_type in unarmed_types)
		unarmed_attacks += new u_type()




	//Build organ descriptors
	for(var/limb_type in has_limbs)
		var/list/organ_data = has_limbs[limb_type]
		var/obj/item/organ/limb_path = organ_data["path"]
		organ_data["descriptor"] = initial(limb_path.name)



/*
	Setup Procs:
	Copying over vars to the mob, and doing any initial calculations
*/



/datum/species/necromorphs/proc/sanitize_name(var/name)
	return sanitizeName(name)

/datum/species/necromorphs/proc/create_organs(var/mob/living/carbon/human/H) //Handles creation of mob organs.

	H.mob_size = mob_size
	H.mass = src.mass
	H.biomass = src.biomass
	for(var/obj/item/organ/organ in H.contents)
		if((organ in H.organs) || (organ in H.internal_organs))
			qdel(organ)

	if(H.organs)                  H.organs.Cut()
	if(H.internal_organs)         H.internal_organs.Cut()
	if(H.organs_by_name)          H.organs_by_name.Cut()
	if(H.internal_organs_by_name) H.internal_organs_by_name.Cut()

	H.organs = list()
	H.internal_organs = list()
	H.organs_by_name = list()
	H.internal_organs_by_name = list()

	for(var/limb_type in has_limbs)
		var/list/organ_data = has_limbs[limb_type]
		var/limb_path = organ_data["path"]
		var/obj/item/organ/O = new limb_path(H)
		O.max_damage *= limb_health_factor

		//The list may contain height data
		var/vector2/organ_height = organ_data["height"]
		if (organ_height && istype(O, /obj/item/organ/external))
			var/obj/item/organ/external/E = O
			E.limb_height = organ_height.Copy()

	for(var/organ_tag in has_organ)
		var/organ_type = has_organ[organ_tag]
		var/obj/item/organ/O = new organ_type(H)
		if(organ_tag != O.organ_tag)
			warning("[O.type] has a default organ tag \"[O.organ_tag]\" that differs from the species' organ tag \"[organ_tag]\". Updating organ_tag to match.")
			O.organ_tag = organ_tag
		H.internal_organs_by_name[organ_tag] = O

	for(var/name in H.organs_by_name)
		H.organs |= H.organs_by_name[name]

	for(var/name in H.internal_organs_by_name)
		H.internal_organs |= H.internal_organs_by_name[name]

	for(var/obj/item/organ/O in (H.organs|H.internal_organs))
		O.owner = H
		post_organ_rejuvenate(O)

	H.sync_organ_dna()

/datum/species/necromorphs/proc/should_have_organ(var/organ_tag)
	return has_organ[organ_tag]



// Used to update alien icons for aliens.

// As above.


//Used by xenos understanding larvae and dionaea understanding nymphs.


/datum/species/necromorphs/proc/get_blood_name()
	return "blood"



//Mostly for toasters
/datum/species/necromorphs/proc/handle_limbs_setup(var/mob/living/carbon/human/H)
	return FALSE

// Impliments different trails for species depending on if they're wearing shoes.
/datum/species/necromorphs/proc/get_move_trail(var/mob/living/carbon/human/H)
	if( H.shoes || ( H.wear_suit && (H.wear_suit.body_parts_covered & FEET) ) )
		var/obj/item/clothing/shoes = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) ? H.wear_suit : H.shoes // suits take priority over shoes
		return shoes.move_trail
	else
		return move_trail

/datum/species/necromorphs/proc/update_skin(var/mob/living/carbon/human/H)
	return


/mob/living/carbon/human/verb/check_species()
	set name = "Check Species Information"
	set category = "IC"
	set src = usr


/datum/species/necromorphs/proc/post_organ_rejuvenate(var/obj/item/organ/org)
	return


/datum/species/necromorphs/proc/get_grasping_limb(var/mob/living/carbon/human/H, var/side)
	//True side means left, false is right
	var/obj/item/organ/external/temp
	if (!side)
		temp = H.organs_by_name[BP_R_HAND]
		if (!temp)//If no hand, maybe there's tentacle arms
			temp = H.organs_by_name[BP_R_ARM]
	else
		temp = H.organs_by_name[BP_L_HAND]
		if (!temp)
			temp = H.organs_by_name[BP_L_ARM]

	if (temp && (temp.limb_flags & ORGAN_FLAG_CAN_GRASP))
		return temp

	return null



/datum/species/necromorph
	name = SPECIES_NECROMORPH
	id = SPECIES_NECROMORPH
	sexes = TRUE
	can_have_genitals = FALSE
	default_color = "#FFF"
	var/info_text = "You are a <span class='danger'>Vampire</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	mutant_bodyparts = list()
	exotic_blood = /datum/reagent/copper
/////////////////////////////////////////////////////////////////////////////

	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,NO_SLIP_WHEN_WALKING)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOMETABOLISM,
		TRAIT_GENELESS,
		TRAIT_TOXIMMUNE,
		TRAIT_OXYIMMUNE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_UNDEAD
	say_mod = "warbles"

/////////////////////////////////////////////////////////////////////////////

	brutemod = 1.70
	burnmod = 0.60

	bodytemp_normal = (BODYTEMP_NORMAL + 70)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	bodytemp_cold_damage_limit = (T20C - 10)
	//species_language_holder = /datum/language_holder/necromorph
//	mutant_bodyparts = list()
	//default_mutant_bodyparts = list("necromorph_hair" = ACC_RANDOM)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
//	var/icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'

/////////////////////////////////////////////////////////////////////////////
////////////////////////// ORGANS FOR ALL SUBTYPES //////////////////////////
/////////////////////////////////////////////////////////////////////////////

	mutant_organs = list(
		/obj/item/organ/brain/necromorph,
		/obj/item/organ/eyes/night_vision/necromorph,
		/obj/item/organ/lungs/necromorph,
		/obj/item/organ/heart/necromorph,
		/obj/item/organ/liver/necromorph,
		/obj/item/organ/tongue/necromorph
	)

/////////////////////////////////////////////////////////////////////////////

	limbs_id = "necromorph"
	//Single iconstates. These are somewhat of a hack
	var/single_icon = FALSE
	var/icon_normal = "slasher_d"
	var/icon_dead = "slasher_d_dead"

/////////////////////////////////////////////////////////////////////////////

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph
	)

	mutant_bodyparts = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph
	)
/////////////////////////////////////////////////////////////////////////////



// /datum/species/necromorph/New()
// 	.=..()
//	breathing_organ = null //This is autoset to lungs in the parent if they exist.
	//We want it to be unset but we stil want to have our useless lungs


/* /datum/species/necromorph/get_random_name()
	return "[src.name] [rand(0,999)]" */

// /datum/species/necromorph/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
// 	handle_mutant_bodyparts(H)
// 	. = ..()
// 	to_chat(C, "[info_text]")


// 	C.update_body(0)
// /* 	if(isnull(batform))
// 		batform = new
// 		C.AddSpell(batform) */
// 	C.set_safe_hunger_level()


/datum/species/necromorph/on_species_loss(mob/living/carbon/C)
	. = ..()

/datum/species/necromorph/infectious/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()

	// Deal with the source of this zombie corruption
	//  Infection organ needs to be handled separately from mutant_organs
	//  because it persists through species transitions
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(!infection)
		infection = new()
		infection.Insert(C)

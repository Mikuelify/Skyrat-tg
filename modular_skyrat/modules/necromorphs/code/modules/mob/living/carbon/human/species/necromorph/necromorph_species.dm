
/datum/species/necromorph
	name = "Necromorph"
	id = "necromorph"
	sexes = 0
	default_color = "4B4B4B"
	var/info_text = "You are a <span class='danger'>Vampire</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."

	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,NO_SLIP_WHEN_WALKING)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_UNDEAD
	say_mod = "warbles"
	brutemod = 1.70
	burnmod = 0.60
	exotic_blood = /datum/reagent/copper
	bodytemp_normal = (BODYTEMP_NORMAL + 70)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	bodytemp_cold_damage_limit = (T20C - 10)
	//species_language_holder = /datum/language_holder/necromorph
//	mutant_bodyparts = list()
	liked_food = TOXIC | DAIRY | FRUIT
	//default_mutant_bodyparts = list("necromorph_hair" = ACC_RANDOM)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	//eyes_icon = 'modular_skyrat/modules/customization/icons/mob/species/necromorph_eyes.dmi'

	//Icon details. null out all of these, maybe someday they can be done
	deform 			=   null
	preview_icon 	= 	null
	husk_icon 		=   null
	damage_overlays =   null
	damage_mask 	=   null
	blood_mask 		=   null


/* 	mutantbrain = /obj/item/organ/brain/necromorph
	mutanteyes = /obj/item/organ/eyes/night_vision/necromorph
	mutantlungs = /obj/item/organ/lungs/necromorph
	mutantheart = /obj/item/organ/heart/necromorph
	mutantliver = /obj/item/organ/liver/necromorph
	mutanttongue = /obj/item/organ/tongue/necromorph */

	//Single iconstates. These are somewhat of a hack
	var/single_icon = FALSE
	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	var/icon_normal = "slasher_d"
	//icon_lying = "slasher_d_lying"
	var/icon_dead = "slasher_d_dead"

	bodypart_overides = list(
	    BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(1,1.65)),
	    BP_HEAD =   list("path" = /obj/item/organ/external/head/simple, "height" = new /vector2(1.65,1.85)),
	    BP_L_ARM =  list("path" = /obj/item/organ/external/arm/simple, "height" = new /vector2(0.8,1.60)),
	    BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/simple, "height" = new /vector2(0.8,1.60)),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/simple, "height" = new /vector2(0,1)),
	    BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/simple, "height" = new /vector2(0,1))
	)

/* 	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg,\
		BODY_ZONE_CHEST = list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(1,1.65))
	) */

/obj/item/organ/tongue/necromorph
	name = "internal vocal sacs"
	desc = "An Strange looking sac."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "tongue"
	taste_sensitivity = 5
	var/static/list/languages_possible_necromorph = typecacheof(list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/machine,
		/datum/language/slime,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/vox,
		/datum/language/dwarf,
		/datum/language/nekomimetic,
//		/datum/language/necromorph,
	))

/datum/species/necromorph/New()
	.=..()
//	breathing_organ = null //This is autoset to lungs in the parent if they exist.
	//We want it to be unset but we stil want to have our useless lungs

/datum/species/necromorph/get_icobase(var/mob/living/carbon/human/H)
	return icon_template //We don't need to duplicate the same dmi path twice

/* /datum/species/necromorph/get_random_name()
	return "[src.name] [rand(0,999)]" */

/datum/species/necromorph/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	. = ..()
	to_chat(C, "[info_text]")

	C.update_body(0)
/* 	if(isnull(batform))
		batform = new
		C.AddSpell(batform) */
	C.set_safe_hunger_level()


/datum/species/necromorph/on_species_loss(mob/living/carbon/C)
	. = ..()
/* 	if(!isnull(batform))
		C.RemoveSpell(batform)
		QDEL_NULL(batform) */


/datum/species/necromorph/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/random = rand(1,6)
	//Choose from a range of green-blue colors
	switch(random)
		if(1)
			main_color = "4F7"
		if(2)
			main_color = "2F8"
		if(3)
			main_color = "2FB"
		if(4)
			main_color = "2FF"
		if(5)
			main_color = "2BF"
		if(6)
			main_color = "26F"
	returned["mcolor"] = main_color
	returned["mcolor2"] = main_color
	returned["mcolor3"] = main_color
	return returned

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

/datum/species/necromorph/check_species_weakness(obj/item/weapon, mob/living/attacker)
	if(istype(weapon, /obj/item/nullrod/whip))
		return 2 //Whips deal 2x damage to vampires. Vampire killer.
	return 1

/obj/item/organ/heart/necromorph
	name = "necromorphian Heart"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "heart"

/obj/item/organ/brain/necromorph
	name = "spongy brain"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "brain2"

/obj/item/organ/eyes/night_vision/necromorph
	name = "undead eyes"
	desc = "Somewhat counterintuitively, these half-rotten eyes actually have superior vision to those of a living human."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/lungs/necromorph
	name = "necromorph lungs"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "lungs"
	safe_toxins_max = 40
	safe_co2_max = 40

	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BRUTE


	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/liver/necromorph
	name = "necromorph liver"
	icon_state = "liver"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	alcohol_tolerance = 5
	toxTolerance = 10 //can shrug off up to 10u of toxins.
	toxLethality = 0.8 * LIVER_DEFAULT_TOX_LETHALITY //20% less damage than a normal liver


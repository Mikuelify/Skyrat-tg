/obj/item/organ/genital/eggsack
	name 			= "Egg sack"
	desc 			= "An egg producing reproductive organ."
	icon_state 		= "egg_sack"
	icon 			= 'modular_skyrat/modules/organhaul/icons/obj/genitals/ovipositor.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	color			= null //don't use the /genital color since it already is colored
	internal = TRUE
//	var/egg_girth = EGG_GIRTH_DEF
//	var/cum_mult = CUM_RATE_MULT
//	var/cum_rate = CUM_RATE
//	var/cum_efficiency	= CUM_EFFICIENCY
//	var/obj/item/organ/ovipositor/linked_ovi
	mutantpart_key = "testicles"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Normal", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	visibility_preference = GENITAL_SKIP_VISIBILITY
	aroused = AROUSAL_CANT


/* /obj/item/organ/genital/womb
	name = "womb"
	desc = "A female reproductive organ."
	icon = 'modular_skyrat/modules/customization/icons/obj/genitals/vagina.dmi'
	icon_state = "womb"
	mutantpart_key = "womb"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Normal", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_WOMB
	visibility_preference = GENITAL_SKIP_VISIBILITY
	aroused = AROUSAL_CANT */

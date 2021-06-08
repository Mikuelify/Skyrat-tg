/obj/item/organ/genital/ovipositor
	name = "Ovipositor"
	desc = "An egg laying reproductive organ."
	icon_state = "ovi_knotted_2"
	icon = 'modular_skyrat/modules/organhaul/icons/obj/genitals/ovipositor.dmi'
	zone = "groin"
	slot = "penis"
	w_class = 3
	shape = "knotted"
//	size = 3
	var/length = 6								//inches
	var/girth  = 0
	var/girth_ratio = COCK_GIRTH_RATIO_DEF 		//citadel_defines.dm for these defines
	var/knot_girth_ratio = KNOT_GIRTH_RATIO_DEF
	var/list/oviflags = list()
	var/obj/item/organ/eggsack/linked_eggsack

/obj/item/organ/genital/ovipositor/Initialize()
	. = ..()
	/* I hate genitals.*/


/obj/item/organ/genital/eggsack
	name 			= "Egg sack"
	desc 			= "An egg producing reproductive organ."
	icon_state 		= "egg_sack"
	icon 			= 'modular_skyrat/modules/organhaul/icons/obj/genitals/ovipositor.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	color			= null //don't use the /genital color since it already is colored
	internal = TRUE
	//var/egg_girth = EGG_GIRTH_DEF
	//var/cum_mult = CUM_RATE_MULT
//	var/cum_rate = CUM_RATE
//	var/cum_efficiency	= CUM_EFFICIENCY
//	var/obj/item/organ/ovipositor/linked_ovi
	mutantpart_key = "testicles"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Normal", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	visibility_preference = GENITAL_SKIP_VISIBILITY
	aroused = AROUSAL_CANT

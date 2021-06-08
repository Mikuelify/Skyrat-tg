/obj/item/organ/genital/belly //I know, I know a belly aint a genital. but it is in the sake of code.
	name 					= "belly"
	desc 					= "You see a belly on their midsection."
	icon_state 				= "belly"
	icon 					= 'modular_skyrat/modules/organhaul/icons/obj/genitals/breasts.dmi'
	w_class 				= 3
//	size 				= 1
	var/statuscheck			= FALSE
	shape					= "Pair"
	masturbation_verb 		= "massage"
	can_climax				= FALSE
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start
	mutantpart_key = "belly"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA

/obj/item/organ/genital/belly/on_life()
	if(QDELETED(src))
		return
	if(!owner)
		return

/obj/item/organ/genital/belly/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [lowertext(genital_name)] vagina."
	if(lowertext(genital_name) == "cloaca")
		returned_string = "You see a cloaca." //i deserve a pipebomb for this
	switch(aroused)
		if(AROUSAL_NONE)
			returned_string += " It seems dry."
		if(AROUSAL_PARTIAL)
			returned_string += " It's glistening with arousal."
		if(AROUSAL_FULL)
			returned_string += " It's bright and dripping with arousal."
	return returned_string

/obj/item/organ/genital/belly/build_from_dna(datum/dna/DNA, associated_key)
	..()
/obj/item/organ/genital/belly/get_sprite_size_string()
	var/is_dripping = 0
	if(aroused == AROUSAL_FULL)
		is_dripping = 1
	return "[genital_type]_[is_dripping]"

/* /obj/item/organ/genital/belly/update_genital_icon_state()
	return
	var/string
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner))
				var/mob/living/carbon/human/H = owner
				color = "#[skintone2hex(H.skin_tone)]"
		else
			color = "#[owner.dna.features["belly_color"]]"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			icon_state = sanitize_text(string)
			H.update_genitals()

			icon_state = sanitize_text(string) */


/* /obj/item/organ/genital/vagina/update_appearance()
	. = ..()
	icon_state = "vagina"
	var/lowershape = lowertext(shape)
	var/details

	switch(lowershape)
		if("tentacle")
			details = "Its opening is lined with several tentacles and "
		if("dentata")
			details = "There's teeth inside it and it "
		if("hairy")
			details = "It has quite a bit of hair growing on it and "
		if("human")
			details = "It is taut with smooth skin, though without much hair and "
		if("gaping")
			details = "It is gaping slightly open, though without much hair and "
		if("spade")
			details = "It is a plush canine spade, it "
		if("furred")
			details = "It has neatly groomed fur around the outer folds, it "
		else
			details = "It has an exotic shape and "
	if(aroused_state)
		details += "is slick with female arousal."
	else
		details += "seems to be dry."

	desc = "You see a vagina. [details]"

	if(owner)
		if(owner.dna.species.use_skintones)
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		else
			color = "#[owner.dna.features["vag_color"]]"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			H.update_genitals()


/obj/item/organ/genital/vagina/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones)
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "[D.features["vag_color"]]"
	shape = "[D.features["vag_shape"]]"
	toggle_visibility(D.features["vag_visibility"], FALSE)
 */





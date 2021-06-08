//////Kitchen Spike
#define VIABLE_MOB_CHECK(X) (isliving(X) && !issilicon(X) && !isbot(X))

/obj/structure/bondage/bondage_rack_frame//SKYRAT EDIT - ICON OVERRIDEN BY AESTHETICS - SEE MODULE
	name = "Bondage Rack"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spikeframe"
	desc = "The frame of a meat spike."
	density = TRUE
	anchored = FALSE
	max_integrity = 200

/obj/structure/bondage/bondage_rack//SKYRAT EDIT - ICON OVERRIDEN BY AESTHETICS - SEE MODULE
	name = "Bondage Rack"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spike"
	desc = "A spike for collecting meat from animals."
	density = TRUE
	anchored = TRUE
	buckle_lying = 0
	can_buckle = 1
	max_integrity = 250

/obj/structure/bondage/bondage_rack/crowbar_act(mob/living/user, obj/item/I)
	if(has_buckled_mobs())
		to_chat(user, "<span class='warning'>You can't do that while something's on the spike!</span>")
		return TRUE

	if(I.use_tool(src, user, 20, volume=100))
		to_chat(user, "<span class='notice'>You pry the spikes out of the frame.</span>")
		deconstruct(TRUE)
	return TRUE

/obj/structure/bondage/bondage_rack/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE) //Don't want them getting put on the rack other than by spiking
	return

/obj/structure/bondage/bondage_rack/user_unbuckle_mob(mob/living/buckled_mob, mob/living/carbon/human/user)
	if(buckled_mob)
		var/mob/living/M = buckled_mob
		if(M != user)
			M.visible_message("<span class='notice'>[user] tries to pull [M] free of [src]!</span>",\
				"<span class='notice'>[user] is trying to pull you off [src], opening up fresh wounds!</span>",\
				"<span class='hear'>You hear a squishy wet noise.</span>")
			if(!do_after(user, 300, target = src))
				if(M?.buckled)
					M.visible_message("<span class='notice'>[user] fails to free [M]!</span>",\
					"<span class='notice'>[user] fails to pull you off of [src].</span>")
				return

		else
			M.visible_message("<span class='warning'>[M] struggles to break free from [src]!</span>",\
			"<span class='notice'>You struggle to break free from [src], exacerbating your wounds! (Stay still for two minutes.)</span>",\
			"<span class='hear'>You hear a wet squishing noise..</span>")
			M.adjustBruteLoss(30)
			if(!do_after(M, 1200, target = src))
				if(M?.buckled)
					to_chat(M, "<span class='warning'>You fail to free yourself!</span>")
				return
		if(!M.buckled)
			return
		release_mob(M)

/obj/structure/bondage/bondage_rack/proc/release_mob(mob/living/M)
	var/matrix/m180 = matrix(M.transform)
	m180.Turn(180)
	animate(M, transform = m180, time = 3)
	M.pixel_y = M.base_pixel_y + PIXEL_Y_OFFSET_LYING
	M.adjustBruteLoss(30)
	src.visible_message(text("<span class='danger'>[M] falls free of [src]!</span>"))
	unbuckle_mob(M,force=1)
	M.emote("scream")
	M.AdjustParalyzed(20)

/obj/structure/bondage/bondage_rack/Destroy()
	if(has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			release_mob(L)
	return ..()

/obj/structure/bondage/bondage_rack/deconstruct(disassembled = TRUE)
	if(disassembled)
		var/obj/F = new /obj/structure/bondage/bondage_rack_frame(src.loc)
		transfer_fingerprints_to(F)
	else
		new /obj/item/stack/sheet/iron(src.loc, 4)
	new /obj/item/stack/rods(loc, 4)
	qdel(src)

#undef VIABLE_MOB_CHECK

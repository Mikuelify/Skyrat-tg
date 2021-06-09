/mob/living/carbon/necromorph/humanoid
	name = "necromorph"
	//icon_state = "necromorph"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/48x48necros.dmi'
	icon_state = "twitcher"
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/food/meat/slab/xeno = 5, /obj/item/stack/sheet/animalhide/xeno = 1)
	limb_destroyer = 1
//	hud_type = /datum/hud/necromorph
	melee_damage_lower = 20 //Refers to unarmed damage, necromorphs do unarmed attacks.
	melee_damage_upper = 20
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/caste = ""
	//var/alt_icon = 'icons/mob/necromorphleap.dmi' //used to switch between the two necromorph icon files.
	var/leap_on_click = 0
	var/pounce_cooldown = 0
	var/pounce_cooldown_time = 30
	var/sneaking = 0 //For sneaky-sneaky mode and appropriate slowdown
	var/drooling = 0 //For Neruotoxic spit overlays
	deathsound = 'sound/voice/hiss6.ogg'
//	mutant_bodyparts = list()
/* 	bodyparts = list(
		/obj/item/bodypart/chest,
		/obj/item/bodypart/head,
		/obj/item/bodypart/l_arm,
		/obj/item/bodypart/r_arm,
		/obj/item/bodypart/r_leg,
		/obj/item/bodypart/l_leg,
		) */

/* 	internal_organs = list(
		/obj/item/organ/internal/heart/undead,
		/obj/item/organ/internal/lungs/undead,
		/obj/item/organ/internal/liver/undead,
		/obj/item/organ/internal/kidneys/undead,
		/obj/item/organ/internal/brain/undead,
		/obj/item/organ/internal/eyes/undead,
	) */

/mob/living/carbon/necromorph/humanoid/Initialize()
	. = ..()
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_CLAW, 0.5, -11)

/mob/living/carbon/alien/humanoid/drone/create_internal_organs()
	internal_organs += new /obj/item/organ/alien/plasmavessel/large
	internal_organs += new /obj/item/organ/alien/resinspinner
	internal_organs += new /obj/item/organ/alien/acid
	..()

/* /mob/living/carbon/necromorph/humanoid/show_inv(mob/user)
	user.set_machine(src)
	var/list/dat = list()
	dat += "<table>"
	for(var/i in 1 to held_items.len)
		var/obj/item/I = get_item_for_held_index(i)
		dat += "<tr><td><B>[get_held_index_name(i)]:</B></td><td><A href='?src=[REF(src)];item=[ITEM_SLOT_HANDS];hand_index=[i]'>[(I && !(I.item_flags & ABSTRACT)) ? I : "<font color=grey>Empty</font>"]</a></td></tr>"
	dat += "</td></tr><tr><td>&nbsp;</td></tr>"
	dat += "<tr><td><A href='?src=[REF(src)];pouches=1'>Empty Pouches</A></td></tr>"

	if(handcuffed)
		dat += "<tr><td><B>Handcuffed:</B> <A href='?src=[REF(src)];item=[ITEM_SLOT_HANDCUFFED]'>Remove</A></td></tr>"
	if(legcuffed)
		dat += "<tr><td><B>Legcuffed:</B> <A href='?src=[REF(src)];item=[ITEM_SLOT_LEGCUFFED]'>Remove</A></td></tr>"

	dat += {"</table>
	<A href='?src=[REF(user)];mach_close=mob[REF(src)]'>Close</A>
	"}

	var/datum/browser/popup = new(user, "mob[REF(src)]", "[src]", 440, 510)
	popup.set_content(dat.Join())
	popup.open()
 */

/mob/living/carbon/necromorph/humanoid/Topic(href, href_list)
	//strip panel
	if(href_list["pouches"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		visible_message("<span class='danger'>[usr] tries to empty [src]'s pouches.</span>", \
						"<span class='userdanger'>[usr] tries to empty your pouches.</span>")
		if(do_mob(usr, src, POCKET_STRIP_DELAY * 0.5))
			dropItemToGround(r_store)
			dropItemToGround(l_store)

	..()


/mob/living/carbon/necromorph/humanoid/cuff_resist(obj/item/I)
	playsound(src, 'sound/voice/hiss5.ogg', 40, TRUE, TRUE)  //necromorph roars when starting to break free
	..(I, cuff_break = INSTANT_CUFFBREAK)

/mob/living/carbon/necromorph/humanoid/resist_grab(moving_resist)
	if(pulledby.grab_state)
		visible_message("<span class='danger'>[src] breaks free of [pulledby]'s grip!</span>", \
						"<span class='danger'>You break free of [pulledby]'s grip!</span>")
	pulledby.stop_pulling()
	. = 0

/mob/living/carbon/necromorph/humanoid/get_permeability_protection(list/target_zones)
	return 0.8

//For necromorph evolution/promotion/queen finder procs. Checks for an active necromorph of that type
/proc/get_necromorph_type(necromorphpath)
	for(var/mob/living/carbon/necromorph/humanoid/A in GLOB.alive_mob_list)
		if(!istype(A, necromorphpath))
			continue
		if(!A.key || A.stat == DEAD) //Only living necromorphs with a ckey are valid.
			continue
		return A
	return FALSE


/mob/living/carbon/necromorph/humanoid/check_breath(datum/gas_mixture/breath)
	if(breath && breath.total_moles() > 0 && !sneaking)
		playsound(get_turf(src), pick('sound/voice/lowHiss2.ogg', 'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg'), 50, FALSE, -5)
	..()

/mob/living/carbon/necromorph/humanoid/set_name()
	if(numba)
		name = "[name] ([numba])"
		real_name = name

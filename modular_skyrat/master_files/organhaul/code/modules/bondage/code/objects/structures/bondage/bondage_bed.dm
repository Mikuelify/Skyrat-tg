/* Beds... get your mind out of the gutter, they're for sleeping!
 * Contains:
 * Beds
 * Roller beds
 */

/*
 * Beds
 */
/obj/structure/bondage/bed
	name = "bed"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "bed"
	icon = 'icons/obj/objects.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	var/buildstacktype = /obj/item/stack/sheet/iron
	var/buildstackamount = 2
	var/bolts = TRUE

/obj/structure/bondage/bed/examine(mob/user)
	. = ..()
	if(bolts)
		. += "<span class='notice'>It's held together by a couple of <b>bolts</b>.</span>"

/obj/structure/bondage/bed/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/bondage/bed/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/bondage/bed/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct(TRUE)
		return ..()

/obj/structure/bondage/bed/maint
	name = "dirty mattress"
	desc = "An old grubby mattress. You try to not think about what could be the cause of those stains."
	icon_state = "dirty_mattress"

/obj/structure/bondage/bed/maint/Initialize()
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2,4), 25)

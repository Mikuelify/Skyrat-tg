/datum/outfit/modular_erts/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/implant/mindshield/L = new/obj/item/implant/mindshield(H)//hmm lets have centcom officials become revs
	L.implant(H, null, 1)

/datum/outfit/modular_erts/ert/purge
	name = "Purge Squad"
	head = /obj/item/clothing/head/hos/beret/faction
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/headset_faction/bowman/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/faction_command
	l_pocket = /obj/item/flamethrower
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,/obj/item/storage/box/faction_access_cards=1, /obj/item/storage/box/zipties,/obj/item/melee/classic_baton/telescopic=1, /obj/item/ammo_box/magazine/m45=2, /obj/item/gun/ballistic/automatic/pistol/m1911=1, /obj/item/stack/spacecash/c10000=1)

/datum/outfit/modular_erts/ert/purge/officer
	name = "Purge Squad Officer"
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	suit_store = /obj/item/gun/ballistic/automatic/wt550
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/headset_faction/bowman
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/faction_crew
	l_pocket = /obj/item/melee/transforming/energy/sword
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,/obj/item/ammo_box/magazine/wt550m9=2, /obj/item/ammo_box/magazine/m45=2, /obj/item/melee/classic_baton=1, /obj/item/gun/ballistic/automatic/pistol/m1911=1,/obj/item/stack/spacecash/c1000=1)

/datum/outfit/modular_erts/ert/hazmat
	name = "Purge Squad"
	head = /obj/item/clothing/head/hos/beret/faction
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/headset_faction/bowman/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/gun/energy/e_gun
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/faction_command
	l_pocket = /obj/item/flamethrower
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,/obj/item/storage/box/faction_access_cards=1, /obj/item/storage/box/zipties,/obj/item/melee/classic_baton/telescopic=1, /obj/item/ammo_box/magazine/m45=2, /obj/item/gun/ballistic/automatic/pistol/m1911=1, /obj/item/stack/spacecash/c10000=1)



/datum/outfit/modular_erts/ert/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CENTCOM)
	R.freqlock = TRUE

	var/obj/item/card/id/W = H.wear_id
	if(W)
		W.registered_name = H.real_name
		W.update_label()
		W.update_icon()
	return ..()

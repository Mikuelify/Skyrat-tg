var/global/list/human_icon_cache = list()
var/global/list/tail_icon_cache = list() //key is [species.race_key][r_skin][g_skin][b_skin]
var/global/list/light_overlay_cache = list()

/proc/overlay_image(icon,icon_state,color,flags)
	var/image/ret = image(icon,icon_state)
	ret.color = color
	ret.appearance_flags = flags
	return ret

/mob/living/carbon/human
//	var/list/overlays_standing[TOTAL_LAYERS]
	var/previous_damage_appearance // store what the body last looked like, so we only have to update it if something changed
	var/icon_updates = 0

/mob/living/carbon/human/update_icons()

	update_hud()		//TODO: remove the need for this
	overlays.Cut()

	var/list/overlays_to_apply = list()
	if (icon_update)
		if (species.icon_lying && lying != lying_prev)
			regenerate_icons()

		var/list/visible_overlays
		if(is_cloaked())
			icon = 'icons/mob/human.dmi'
			icon_state = "blank"
			visible_overlays = list(visible_overlays[R_HAND_LAYER], visible_overlays[L_HAND_LAYER])
		else
			icon = stand_icon
			icon_state = null
			visible_overlays = overlays_standing

		var/matrix/M = matrix()
		if(lying && (species.prone_overlay_offset[1] || species.prone_overlay_offset[2]))
			M.Translate(species.prone_overlay_offset[1], species.prone_overlay_offset[2])
		for(var/entry in visible_overlays)
			if(istype(entry, /image))
				var/image/overlay = entry
				overlay.transform = M
				overlays_to_apply += overlay
			else if(istype(entry, /list))
				for(var/image/overlay in entry)
					overlay.transform = M
					overlays_to_apply += overlay

		var/obj/item/organ/external/head/head = organs_by_name[BP_HEAD]
		if(istype(head) && !head.is_stump())
			var/image/I = head.get_eye_overlay()
			if(I) overlays_to_apply += I
	lying_prev = lying	//so we don't update overlays for lying/standing unless our stance changes again

	if(auras)
		overlays_to_apply += auras

	overlays = overlays_to_apply

	var/matrix/M = get_default_transform()
	if(lying)
		M.Turn(species.lying_rotation)
		M.Translate(1,-6)
	else
		M.Translate(0, 16*(default_scale-1))
	transform = M


var/global/list/damage_icon_parts = list()

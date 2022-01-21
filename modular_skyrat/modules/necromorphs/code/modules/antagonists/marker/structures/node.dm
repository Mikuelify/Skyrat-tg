/obj/structure/marker/special/node
	name = "Growth"
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "growth"
	desc = "Corruption spreads out in all directions from this horrible mass."
	max_integrity = MARKER_NODE_MAX_HP
	health_regen = MARKER_NODE_HP_REGEN
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 65, ACID = 90)
	point_return = MARKER_REFUND_NODE_COST
	claim_range = MARKER_NODE_CLAIM_RANGE
	pulse_range = MARKER_NODE_PULSE_RANGE
	expand_range = MARKER_NODE_EXPAND_RANGE
	resistance_flags = LAVA_PROOF
	max_slashers = MARKER_NODE_MAX_SLASHERS
	ignore_syncmesh_share = TRUE

/obj/structure/marker/special/node/Initialize()
	GLOB.marker_nodes += src
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/marker/special/node/scannerreport()
	return "This node acts as a heart for corruption spread, allowing it to extend out up to [MARKER_NODE_EXPAND_RANGE] tiles in all directions from the node. It must be placed on existing corruption from another propagator node, or from the marker."

/obj/structure/marker/special/node/update_icon()
	color = null
	return ..()

/obj/structure/marker/special/node/update_overlays()
	. = ..()
	var/mutable_appearance/marker_overlay = mutable_appearance('icons/mob/blob.dmi', "blob")
	if(overmind)
		marker_overlay.color = COLOR_MARKER_RED
	. += marker_overlay
	. += mutable_appearance('modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi', "growth")

/obj/structure/marker/special/node/creation_action()
	if(overmind)
		overmind.node_markers += src

/obj/structure/marker/special/node/Destroy()
	GLOB.marker_nodes -= src
	STOP_PROCESSING(SSobj, src)
	if(overmind)
		overmind.node_markers -= src
	return ..()

/obj/structure/marker/special/node/process(delta_time)
	if(overmind)
		pulse_area(overmind, claim_range, pulse_range, expand_range)
		//reinforce_area(delta_time)
		produce_slashers()

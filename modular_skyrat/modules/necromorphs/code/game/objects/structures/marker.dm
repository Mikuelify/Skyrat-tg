
#define HALLUCINATION_RANGE(P) (min(7, round(P ** 0.25)))

/obj/structure/necromorphs/marker
	name = "The Marker"
	desc = "A sturdy wooden shelf to store a variety of items on."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_active"
	density = TRUE
	anchored = TRUE
	layer = MOB_LAYER
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1 | RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	light_range = 4
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/active
	var/spread_biomass = TRUE
	var/blob_type = BIO_BLOB_TYPE_FUNGUS// NEEDS TO BE DEPRECATED NOT NEEDED!
	///The amount of damage we have currently
	var/damage = 0
	///The damage we had before this cycle. Used to limit the damage we can take each cycle, and for safe_alert
	var/damage_archived = 0
	///Refered to as eer on the moniter. This value effects gas output, heat, damage, and radiation.
	var/power = 0
	///How much hallucination should we produce per unit of power?
	var/hallucination_power = 0.1
	///Boolean used for logging if we've been powered
	var/has_been_powered = FALSE
	///Boolean used for logging if we've passed the emergency point
	var/has_reached_emergency = FALSE
	///Our soundloop
	var/datum/looping_sound/supermatter/soundloop
	var/datum/marker_controller/our_controller


/obj/structure/necromorphs/marker/Initialize()
	if(!blob_type)
		blob_type = pick(BIO_BLOB_TYPE_FUNGUS)
	. = ..()
	new /datum/marker_controller(src, blob_type)
	soundloop = new(list(src),  TRUE)
	update_overlays()

/obj/structure/necromorphs/marker/Destroy()
	playsound(src.loc, 'sound/effects/splat.ogg', 30, TRUE)
	soundloop.stop()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/necromorphs/marker/examine(mob/user)
	. = ..()
	var/immune = HAS_TRAIT(user, TRAIT_SUPERMATTER_MADNESS_IMMUNE) || (user.mind && HAS_TRAIT(user.mind, TRAIT_SUPERMATTER_MADNESS_IMMUNE))
	if(isliving(user) && !immune && (get_dist(user, src) < HALLUCINATION_RANGE(power)))
		. += "<span class='danger'>You get headaches just from looking at it.</span>"
	if(isobserver(user))
		if(power > 5)
			. += "<span class='notice'>The supermatter appears active at [power] MeV.</span>"
		else
			. += "<span class='notice'>The supermatter appears inactive or outputting minimal power.</span>"


// BIOMASS SPREAD
// Slowing taking over the station!

/datum/looping_sound/core_heartbeat
	mid_length = 3 SECONDS
	mid_sounds = list('modular_skyrat/master_files/sound/effects/heart_beat_loop3.ogg'=1)
	volume = 20

/obj/structure/necromorphs/marker/resin
	name = "Organic Mass"
	desc = "It looks like flesh and skin, it writhes and reaches out around itself."
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_resin.dmi'
	icon_state = "blob_floor"
	density = FALSE
	plane = FLOOR_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 50
	var/blooming = FALSE
	//Are we a floor resin? If not then we're a wall resin
	var/floor = TRUE


/obj/structure/necromorphs/marker/resin/Initialize(mapload, passed_blob_type)
	. = ..()
	switch(blob_type)
		if(BIO_BLOB_TYPE_FUNGUS)
			desc += " It looks like it's rotting."
		if(BIO_BLOB_TYPE_FIRE)
			desc += " It feels hot to the touch."
		if(BIO_BLOB_TYPE_EMP)
			desc += " You can notice small sparks travelling in the vines."
		if(BIO_BLOB_TYPE_TOXIC)
			desc += " It feels damp and smells of rat poison."

/obj/structure/necromorphs/marker/resin/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(blooming)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_overlay", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_overlay", 0, EMISSIVE_PLANE, dir, alpha)
		var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
		var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
		overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

/obj/structure/necromorphs/marker/resin/proc/CalcDir()
	var/direction = 16
	var/turf/location = loc
	for(var/wallDir in GLOB.cardinals)
		var/turf/newTurf = get_step(location,wallDir)
		if(newTurf && newTurf.density)
			direction |= wallDir

	for(var/obj/structure/necromorphs/marker/resin/tomato in location)
		if(tomato == src)
			continue
		if(tomato.floor) //special
			direction &= ~16
		else
			direction &= ~tomato.dir

	var/list/dirList = list()

	for(var/i=1,i<=16,i <<= 1)
		if(direction & i)
			dirList += i

	if(dirList.len)
		var/newDir = pick(dirList)
		if(newDir == 16)
			setDir(pick(GLOB.cardinals))
		else
			floor = FALSE
			setDir(newDir)
			switch(dir) //offset to make it be on the wall rather than on the floor
				if(NORTH)
					pixel_y = 32
				if(SOUTH)
					pixel_y = -32
				if(EAST)
					pixel_x = 32
				if(WEST)
					pixel_x = -32
			icon_state = "blob_wall"
			plane = GAME_PLANE
			layer = ABOVE_NORMAL_TURF_LAYER

	if(prob(7))
		blooming = TRUE
		set_light(2, 1, LIGHT_COLOR_LAVA)
		update_overlays()

///////////////////////////////////////////
////////////// Marker Structures //////////

#define BLOB_BULB_ALPHA 100

/obj/structure/necromorphs/marker/structure/bulb
	name = "empty bulb"
	density = TRUE
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_bulb.dmi'
	icon_state = "blob_bulb_empty"
	density = FALSE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	var/is_full = FALSE
	var/list/registered_turfs = list()
	max_integrity = 100

/obj/structure/necromorphs/marker/structure/bulb/Initialize()
	. = ..()
	make_full()
	for(var/t in get_adjacent_open_turfs(src))
		registered_turfs += t
		RegisterSignal(t, COMSIG_ATOM_ENTERED, .proc/proximity_trigger)

/obj/structure/necromorphs/marker/structure/bulb/proc/proximity_trigger(datum/source, atom/movable/AM)
	if(!isliving(AM))
		return
	var/mob/living/L = AM
	if(!(MOLD_FACTION in L.faction))
		discharge()

/obj/structure/necromorphs/marker/structure/bulb/proc/make_full()
	//Called by a timer, check if we exist
	if(QDELETED(src))
		return
	is_full = TRUE
	name = "filled bulb"
	icon_state = "blob_bulb_full"
	set_light(2,1,LIGHT_COLOR_LAVA)
	density = TRUE
	update_overlays()

/obj/structure/necromorphs/marker/structure/bulb/proc/discharge()
	if(!is_full)
		return
	var/turf/T = get_turf(src)
	visible_message("<span class='warning'>The [src] ruptures!</span>")
	switch(blob_type)
		if(BIO_BLOB_TYPE_FUNGUS)
			var/datum/reagents/R = new/datum/reagents(300)
			R.my_atom = src
			R.add_reagent(/datum/reagent/cordycepsspores, 50)
			var/datum/effect_system/smoke_spread/chem/smoke = new()
			smoke.set_up(R, 5)
			smoke.attach(src)
			smoke.start()
		if(BIO_BLOB_TYPE_FIRE)
			T.atmos_spawn_air("o2=20;plasma=20;TEMP=600")
		if(BIO_BLOB_TYPE_EMP)
			if(prob(50))
				empulse(src, 3, 4)
				for(var/mob/living/M in get_hearers_in_view(3, T))
					if(M.flash_act(affect_silicon = 1))
						M.Paralyze(20)
						M.Knockdown(20)
					M.soundbang_act(1, 20, 10, 5)
			else
				tesla_zap(src, 4, 10000, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE)
		if(BIO_BLOB_TYPE_TOXIC)
			var/datum/reagents/R = new/datum/reagents(300)
			R.my_atom = src
			R.add_reagent(/datum/reagent/toxin, 30)
			var/datum/effect_system/foam_spread/foam = new
			foam.set_up(40, T, R)
			foam.start()

	is_full = FALSE
	name = "empty bulb"
	icon_state = "blob_bulb_empty"
	playsound(src, 'sound/effects/bamf.ogg', 100, TRUE)
	set_light(0)
	update_overlays()
	density = FALSE
	addtimer(CALLBACK(src, .proc/make_full), 150 SECONDS, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)

/obj/structure/necromorphs/marker/structure/bulb/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	discharge()
	. = ..()

/obj/structure/necromorphs/marker/structure/bulb/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	for(var/t in registered_turfs)
		UnregisterSignal(t, COMSIG_ATOM_ENTERED)
	registered_turfs = null
	return ..()

/obj/structure/necromorphs/marker/structure/bulb/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(is_full)
		SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", layer, plane, dir, BLOB_BULB_ALPHA)
		SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", 0, EMISSIVE_PLANE, dir, alpha)
		var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
		var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
		overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

#undef BLOB_BULB_ALPHA


/obj/structure/necromorphs/marker/structure/wall
	name = "mold wall"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	opacity = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_RESIN)
	max_integrity = 200
	CanAtmosPass = ATMOS_PASS_DENSITY

/obj/structure/necromorphs/marker/structure/wall/Destroy()
	if(our_controller)
		our_controller.ActivateAdjacentResin(get_turf(src))
		our_controller.other_structures -= src
	return ..()

/obj/structure/necromorphs/marker/structure/spawner
	name = "hatchery"
	density = FALSE
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_spawner.dmi'
	icon_state = "blob_spawner"
	density = FALSE
	layer = LOW_OBJ_LAYER
	max_integrity = 150
	var/monster_types = list()
	var/max_spawns = 1
	var/spawn_cooldown = 600 //In deciseconds

/obj/structure/necromorphs/marker/structure/spawner/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	return ..()

/obj/structure/necromorphs/marker/structure/spawner/Initialize()
	. = ..()
	switch(blob_type)
		if(BIO_BLOB_TYPE_FUNGUS)
			monster_types = list(/mob/living/simple_animal/hostile/biohazard_blob/diseased_rat)
			max_spawns = 2
			spawn_cooldown = 500
		if(BIO_BLOB_TYPE_FIRE)
			monster_types = list(/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler)
		if(BIO_BLOB_TYPE_EMP)
			monster_types = list(/mob/living/simple_animal/hostile/biohazard_blob/electric_mosquito)
			max_spawns = 2
			spawn_cooldown = 500
		if(BIO_BLOB_TYPE_TOXIC)
			monster_types = list(/mob/living/simple_animal/hostile/poison/giant_spider) //Laziness

	AddComponent(/datum/component/spawner, monster_types, spawn_cooldown, list(MOLD_FACTION), "emerges from", max_spawns)


///////////////////////////////////////////
/////////////    FURNITURE    /////////////

/obj/structure/decorative/markergiantactive
	name = "marker_giant_active"
	desc = "A sturdy wooden shelf to store a variety of items on."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_active"
	density = 0
	anchored = TRUE
	layer = MOB_LAYER

/obj/structure/decorative/markergiantanim
	name = "marker_giant_active"
	desc = "A sturdy wooden shelf to store a variety of items on."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_active_anim"
	density = 0
	anchored = TRUE

/obj/structure/decorative/marker_normal
	name = "Marker"
	desc = "A sturdy wooden shelf to store a variety of items on."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_normal.dmi'
	icon_state = "marker_normal_dormant"
	density = 0
	anchored = TRUE

/obj/structure/decorative/marker_normal_unknown
	name = "Unknown Object"
	desc = "A seemingly inert statue, symbols seem to run up and down its length. You get chills looking at it.."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_normal.dmi'
	icon_state = "marker_normal_dormant"
	density = 0
	anchored = TRUE


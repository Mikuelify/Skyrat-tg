/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/



/datum/species/necromorph/brute
	name = SPECIES_NECROMORPH_BRUTE
	id = SPECIES_NECROMORPH_BRUTE
	single_icon = TRUE
//	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi'
//	icon_state = 'brute-d'
	can_have_genitals = FALSE
	say_mod = "hisses"
//	limbs_id = "slasher"
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi'
	//body_position_pixel_x_offset = 0
	//body_position_pixel_y_offset = 0
	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/brute.dmi'
	//eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
//	mutant_bodyparts = list()


	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		NO_UNDERWEAR,
		FACEHAIR
	)

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID


/*
	Slasher variant. Damage Calculation and Effects
*/

	damage_overlay_type = "xeno"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"
	speedmod = 2
	armor = 55
	attack_effect = ATTACK_EFFECT_CLAW

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOCLONELOSS,
	)


/*
	Slasher variant. Mutant Parts
*/
	mutanteyes = /obj/item/organ/eyes/night_vision
	mutanttongue = /obj/item/organ/tongue/zombie

	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph)
/*
	//Audio
	step_volume = 10 //Brute stomps are low pitched and resonant, don't want them loud
	step_range = 4
	step_priority = 5
	pain_audio_threshold = 0.03 //Gotta set this low to compensate for his high health
	species_audio = list(SOUND_FOOTSTEP = list('sound/effects/footstep/brute_step_1.ogg',
	'sound/effects/footstep/brute_step_2.ogg',
	'sound/effects/footstep/brute_step_3.ogg',
	'sound/effects/footstep/brute_step_4.ogg',
	'sound/effects/footstep/brute_step_5.ogg',
	'sound/effects/footstep/brute_step_6.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/brute/brute_pain_1.ogg',
	 'sound/effects/creatures/necromorph/brute/brute_pain_2.ogg',
	 'sound/effects/creatures/necromorph/brute/brute_pain_3.ogg',
	 'sound/effects/creatures/necromorph/brute/brute_pain_extreme.ogg' = 0.2),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/brute/brute_death.ogg'),
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/brute/brute_attack_1.ogg',
	'sound/effects/creatures/necromorph/brute/brute_attack_2.ogg',
	'sound/effects/creatures/necromorph/brute/brute_attack_3.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/brute/brute_shout_1.ogg',
	'sound/effects/creatures/necromorph/brute/brute_shout_2.ogg',
	'sound/effects/creatures/necromorph/brute/brute_shout_3.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/brute/brute_shout_long.ogg')
	)
*/

	variants = list(SPECIES_NECROMORPH_BRUTE = list(WEIGHT = 1),
	SPECIES_NECROMORPH_BRUTE_FLESH = list(WEIGHT = 1))


#define BRUTE_PASSIVE_1	"<h2>PASSIVE: Tunnel Vision:</h2><br>\
The brute has extremely restricted vision, able only to see a few tiles infront of it, and none behind it. This makes it very vulnerable to flanking attacks. Keep the enemy infront of you!"

#define BRUTE_PASSIVE_2	"<h2>PASSIVE: Organic Plating:</h2><br>\
The brute's front and side are covered in tough armor, impenetrable to most light weapons. This armor has a 95% chance to intercept attacks, and blocks a flat 25 damage at the front, or 15 at the side.<br>\
Any projectiles completely blocked in this matter will ricochet off and possibly hit something else. Melee attackers will be stunned, opening them to a counter attack.<br>\
<br>\
The unarmored areas are extremely vulnerable, and there's no armor on the rear. Any hit that isn't caused by armor will send the brute into a forced curl for 5 seconds. This forcing effect has a 1 minute cooldown."


#define BRUTE_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then starts barrelling towards the target at moderate speed. While charging, the brute will hit all mobs it passes near.<br>\
This charge has high momentum, and will keep going for a long time, or until stopped by an obstacle<br>\
If the user hits a solid obstacle while charging, they will be stunned and take some minor damage. The obstacle will also be hit hard, and destroyed in some cases. <br>\
<br>\
The brute's charge is a high risk move. If used correctly, it's like bowling people, allowing you to smash through a crowd and send them flying. But you will be stunned and vulnerable afterwards, and easily surrounded."


#define BRUTE_SLAM_DESC "<h2>Slam:</h2><br>\
<h3>Hotkey: Alt Click</h3><br>\
<h3>Cooldown: 8 seconds</h3><br>\
The brute's signature move. Slam causes the user to rear back over 1.25 seconds, and then smash down in a devastating hit. The resulting strike hits a 3x2 area of effect infront of the user.<br>\
Mobs hit by slam will take up to 40 damage depending on distance, and will be knocked down. This damage is doubled if the victim was already lying down when hit, making it an excellent finishing move<br>\
<br>\
Slam deals massive damage to any objects caught in its radius, making it an excellent obstacle-clearing ability. It will easily break through doors, barricades, machinery, girders, windows, etc. With repeated uses and some patience, you can even dig your way through solid walls, creating new paths<br>\
Slam is heavily telegraphed, and hard to land hits with. Don't count on reliably hitting humans with it if they have any space to dodge"

#define BRUTE_BOMB_DESC	"<h2>Bio-bomb:</h2><br>\
<h3>Hotkey: Middle Click </h3><br>\
<h3>Cooldown: 10 seconds</h3><br>\
The user rears back, and launches an organic explosive from their belly. Deals 10 damage on direct impact, and an additional variable damage (up to 25) in burn and acid over a small area of effect.<br>\
Biobomb is a weak, low risk poking and initiation ability, intended to force the enemy to charge at you. It can be used as a way to deal damage and slow down agile humans who keep at a distance. <br>\
It is certainly no use in close combat, and is generally easy to dodge due to being heavily telegraphed. Use it to force a fight up close, and then switch to your melee abilities for serious damage dealing."


#define BRUTE_CURL "<h2>Curl:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
The user curls up into a ball, attempting to shield their vulnerable parts from damage, but becoming unable to turn, move or attack. While curled up, the strength of the brute's organic armor is massively increased (75% more!) and its coverage is increased to 100%<br>\
This causes the brute to be practically invincible to attacks from the front and side, however the rear is still completely undefended.<br>\
Brute will be forced into a reflexive curl under certain circumstances, but it can also be used manually. With the right timing, you can tank an entire firing squad while they waste ammo and deal no damage to you, leaving them vulnerable for your allies to attack from another angle."

/datum/species/necromorph/brute/get_ability_descriptions()
	.= ""
	. += BRUTE_PASSIVE_1
	. += "<hr>"
	. += BRUTE_PASSIVE_2
	. += "<hr>"
	. += BRUTE_CHARGE_DESC
	. += "<hr>"
	. += BRUTE_SLAM_DESC
	. += "<hr>"
	. += BRUTE_BOMB_DESC
	. += "<hr>"
	. += BRUTE_CURL

/datum/species/necromorph/brute/fleshy
	name = SPECIES_NECROMORPH_BRUTE_FLESH
	//icon_normal = "brute-f"
	//icon_lying = "brute-f-dead"//Temporary icon so its not invisible lying down
	//icon_dead = "brute-f-dead"
	//mob_type = /mob/living/carbon/human/necromorph/bruteflesh

	NECROMORPH_VISUAL_VARIANT


/atom/movable/proc/brute_charge(var/atom/A)
	set name = "Charge"
	set category = "Abilities"


	.= brute_charge_attack(A, _delay = 1.25 SECONDS, _speed = 4, _lifespan = 8 SECONDS, _inertia = TRUE)
	if (.)
		var/mob/living/carbon/human/H = src
		if (istype(H))
			H.face_atom(A)
			if (isliving(A) && prob(40)) //When we're charging a mob, sometimes do the long shout
				H.play_species_audio(H, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 5)
			else
				H.play_species_audio(H, SOUND_SHOUT, VOLUME_HIGH, 1, 5)
		shake_camera(50)

/*
/atom/movable/proc/brute_slam(var/atom/A)
	set name = "Slam"
	set category = "Abilities"

	var/direction = get_dir(src, A)
	A = get_step(src, direction)


	if (!A)
		A = get_step(src, dir)


	.=slam_attack(A, _damage = 35, _power = 1, _cooldown = 8 SECONDS, _windup_time = 1.65 SECONDS)
	if (.)
		var/mob/living/carbon/human/H = src
		H.play_species_audio(H, SOUND_SHOUT, VOLUME_HIGH, 1, 3)
*/

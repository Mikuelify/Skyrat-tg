//Global defines for most of the unmentionables.
//Be sure to update the min/max of these if you do change them.
//Measurements are in imperial units. Inches, feet, yards, miles. Tsp, tbsp, cups, quarts, gallons, etc

//organ defines
#define COCK_SIZE_MIN		1
#define COCK_SIZE_MAX		36

#define COCK_GIRTH_RATIO_MAX		0.42
#define COCK_GIRTH_RATIO_DEF		0.25
#define COCK_GIRTH_RATIO_MIN		0.15

#define KNOT_GIRTH_RATIO_MAX		3
#define KNOT_GIRTH_RATIO_DEF		2.1
#define KNOT_GIRTH_RATIO_MIN		1.25

#define BALLS_VOLUME_BASE	25
#define BALLS_VOLUME_MULT	1

#define BALLS_SIZE_MIN		1 //Hyper - Unchanged
#define BALLS_SIZE_DEF		8 //Changed from 2
#define BALLS_SIZE_MAX		40 //Changed from 3

#define BALLS_SACK_SIZE_MIN 1
#define BALLS_SACK_SIZE_DEF	8
#define BALLS_SACK_SIZE_MAX 40

#define CUM_RATE			5
#define CUM_RATE_MULT		1
#define CUM_EFFICIENCY		1 //amount of nutrition required per life()

#define EGG_GIRTH_MIN		1 //inches
#define EGG_GIRTH_DEF		6
#define EGG_GIRTH_MAX		16
#define EGG_NUM_MAX

#define BREASTS_VOLUME_BASE	50	//base volume for the reagents in the breasts, multiplied by the size then multiplier. 50u for A cups, 850u for HH cups.
#define BREASTS_VOLUME_MULT	1	//global multiplier for breast volume.
#define BREASTS_SIZE_FLAT	0
#define BREASTS_SIZE_A		1
#define BREASTS_SIZE_B		2
#define BREASTS_SIZE_C		3
#define BREASTS_SIZE_D		4
#define BREASTS_SIZE_E		5
#define BREASTS_SIZE_F		6
#define BREASTS_SIZE_G		7
#define BREASTS_SIZE_H		8
#define BREASTS_SIZE_I		9
#define BREASTS_SIZE_J		10
#define BREASTS_SIZE_K		11
#define BREASTS_SIZE_L		12
#define BREASTS_SIZE_M		13
#define BREASTS_SIZE_N		14
#define BREASTS_SIZE_O		15
#define BREASTS_SIZE_HUGE		16
#define BREASTS_SIZE_MASSIVE		17
#define BREASTS_SIZE_GIGA		25
#define BREASTS_SIZE_IMPOSSIBLE		30

//Bodysize Limits
#define MIN_BODYSIZE		50
#define MAX_BODYSIZE		200

#define BREASTS_SIZE_MIN 	BREASTS_SIZE_A
#define BREASTS_SIZE_DEF	BREASTS_SIZE_D
#define BREASTS_SIZE_MAX 	BREASTS_SIZE_IMPOSSIBLE

#define MILK_RATE			5
#define MILK_RATE_MULT		1
#define MILK_EFFICIENCY		1

#define AROUSAL_MINIMUM_DEFAULT 	0
#define AROUSAL_MAXIMUM_DEFAULT 	100
#define AROUSAL_START_VALUE			1


//Damage stuffs
#define AROUSAL "arousal"

//DNA stuffs. Remember to change this if upstream adds more snowflake options


//Species stuffs. Remember to change this if upstream updates species flags
//#define MUTCOLORS2		35
//#define MUTCOLORS3		36
#define NOAROUSAL		37 //Stops all arousal effects
#define NOGENITALS		38 //Cannot create, use, or otherwise have genitals
#define MATRIXED		39	//if icon is color matrix'd
#define SKINTONE		40	//uses skin tones

//Citadel istypes
#define isgenital(A) (istype(A, /obj/item/organ/genital))

#define isborer(A) (istype(A, /mob/living/simple_animal/borer))


//Citadel toggles because bitflag memes
#define MEDIHOUND_SLEEPER	(1<<0)
#define EATING_NOISES		(1<<1)
#define DIGESTION_NOISES	(1<<2)

#define TOGGLES_CITADEL (EATING_NOISES|DIGESTION_NOISES)

//component stuff
#define COMSIG_COMBAT_TOGGLED "combatmode_toggled" //called by combat mode toggle on all equipped items. args: (mob/user, combatmode)

#define COMSIG_VORE_TOGGLED "voremode_toggled" // totally not copypasta

//belly sound pref things
#define NORMIE_HEARCHECK 4

#define WOMB_CAPACITY
#define WOMB_STATUS

#define PREGNANT_MIN_TIME
#define PREGNANT_MAX_TIME
#define PREGNANT_TRAITS

#define PREGNANT_INSEMINATION_CHANCE
#define PREGNANT_OVULATING
#define PREGNANT_STATUS

#define PREGNANT_TRIMESTER_1
#define PREGNANT_TRIMESTER_2
#define PREGNANT_TRIMESTER_3

#define REPRODUCTIVE_INHEAT
#define REPRODUCTIVE_PHASE_FOLLICULAR
#define REPRODUCTIVE_PHASE_OVULATORY
#define REPRODUCTIVE_PHASE_LUTEAL
#define REPRODUCTIVE_PHASE_MENSTRUAL

// Defines for some extra traits
#define TRAIT_PREGNANT "repro_pregnant"

#define TRAIT_HEAT_DETECT	"heat_detect"
#define TRAIT_HEAT


//organ slots
#define ORGAN_SLOT_URETHRA "urethra"
//#define ORGAN_SLOT_VAGINA "vagina"


//#define ORGAN_SLOT_EGGSACK "penis"
/* #define ORGAN_SLOT_WOMB "womb"
#define ORGAN_SLOT_VAGINA "vagina"
#define ORGAN_SLOT_TESTICLES "testicles"
#define ORGAN_SLOT_BREASTS "breasts" */

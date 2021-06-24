///////////////////// Hazmat Team /////////////////////
// Designed to help with Viral and Biological Outbreaks

/datum/antagonist/ert/hazmat_team
	name = "Asset Protection Specialist"
	outfit = /datum/outfit/modular_erts/ert/hazmat
	role = "Specialist"
	rip_and_tear = TRUE

/datum/antagonist/ert/hazmat_team/New()
	. = ..()
	name_source = GLOB.commando_names

/datum/antagonist/ert/hazmat_team/leader
	name = "Asset Protection Officer"
	outfit = /datum/outfit/modular_erts/ert/hazmat
	role = "Officer"

///////////////////// Purge Squad /////////////////////
// Designed to purge the station of all biological Life.

/datum/antagonist/ert/purge_team
	name = "Asset Protection Specialist"
	outfit = /datum/outfit/modular_erts/ert/purge
	role = "Specialist"
	rip_and_tear = TRUE

/datum/antagonist/ert/purge_team/New()
	. = ..()
	name_source = GLOB.commando_names

/datum/antagonist/ert/purge_team/leader
	name = "Asset Protection Officer"
	outfit = /datum/outfit/modular_erts/ert/purge
	role = "Officer"

///////////////////// Evacuation Team /////////////////////
// Designed to provide support to people attempting to evacuate the station.

///////////////////// Code Orange Team /////////////////////
// Dedicated Engineering team for station repairs. Not designed for Combat

///////////////////// Removal Team /////////////////////
// Tasked with removing stubborn heads of staff.

///////////////////// Riot Squad /////////////////////
// Emergency Law Enforcement designed to help regain order of station.
// Designed for Non-Lethal Combat

///////////////////// Supermatter Technician /////////////////////
// Designed to remove SM Crystals or modify them. Need to make gloves or machine to safelty move it.
// Nullifier that turns SM into Hugbox mode.

///////////////////// Assault Squad /////////////////////
// Clears out Syndicate Hotspots.

///////////////////// Drop Squad ////////////////////////
// Ideally give a droppable mech with the team.

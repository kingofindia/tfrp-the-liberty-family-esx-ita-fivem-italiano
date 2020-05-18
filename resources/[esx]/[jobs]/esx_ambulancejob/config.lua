Config                            = {}

Config.NPCJobEarnings = {min = 500, max = 1000}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 0, g = 127, b = 255 }
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.5 }
--Config.Type						  = 27
Config.ReviveReward               = 500  -- revive reward, set to 0 if you don't want it enable
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 20 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 60 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.PagaLaRianimazione		  = false
Config.EarlyRespawnFineAmounts	  = 1000

Config.Blip = {
	Pos     = {x = -449.327, y = -341.241, z = 34.502},
	Sprite  = 61,
	Display = 4,
	Scale   = 1.2,
	Colour  = 2
}

Config.HelicopterSpawner = {
	SpawnPoint = { x = 300.646, y = -1453.58, z = 46.51 },
	Heading    = 0.0
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {

	{
		model = 'polf430',
		label = 'Ferrari'
	},
	{
		model = 'audiq8',
		label = 'Audi Q8'
	},
	{
		model = 'ambulance4',
		label = 'Ambulanza'
	}
}

Config.Zones = {

	HospitalInteriorEntering1 = { -- Main entrance
		Pos	= { x = -447.965, y = -341.164, z = 33.522 },
		Type = 27
	},

	HospitalInteriorInside1 = {
		Pos	= { x = -457.365, y = -363.805, z = -187.461 },
		Type = -1
	},

	HospitalInteriorOutside1 = {
		Pos	= {x = -450.471, y = -340.827, z = 33.502 },
		Type = -1
	},

	HospitalInteriorExit1 = {
		Pos	= { x = -458.34, y = -368.03, z = -187.461 },  --steam:11000010f1b851d
		Type = 27
	},

	HospitalInteriorEntering2 = { -- Lift go to the roof
		Pos	= { x = -456.104, y = -368.021, z = -187.461 },
		Type = 27
	},

	HospitalInteriorInside2 = { -- Roof outlet
		Pos	= { x = -442.661, y = -327.721, z = 78.168 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Lift back from roof
		Pos	= { x = -457.365, y = -363.805, z = -186.461 },
		Type = -1
	},

	HospitalInteriorExit2 = { -- Roof entrance
		Pos	= { x = -443.621, y = -331.895, z = 77.208 },
		Type = 27
	},

	AmbulanceActions = { -- Cloakroom
		Pos	= {x = -473.59, y = -342.703, z = -187.38},
		Type = 27
	},

	VehicleSpawner = {
		Pos	= {x = -451.558, y = -336.666, z = 33.364},
		Type = 27
	},

	VehicleSpawner2 = {
		Pos = {x = 359.27, y = -592.768, z = 27.646},
		Type = 27
	},

	VehicleSpawner3 = {
		Pos = {x = 311.452, y = -1377.288, z = 30.93},
		Type = 27
	},

	VehicleSpawnPoint = {
		Pos	= {x = -467.704, y = -317.298, z = 33.33},
		Type = -1
	},

	VehicleSpawnPoint2 = {
		Pos = {x = 365.888, y = -607.673, z = 27.742},
		Type = -1
	},

	VehicleSpawnPoint3 = {
		Pos = {x = 311.86, y = -1373.15, z = 31.845},
		Type = -1
	},

	VehicleDeleter = {
		Pos	= {x = -476.957, y = -325.491, z = 33.371},
		Type = 27
	},

	Pharmacy = {
		Pos	= { x = 0, y = 0, z = 0 },
		Type = 27
	},

	boss_menu_coords = {
		Pos  = {x = -449.407, y = -375.767, z = -187.461},
		Type = 27
	},
	

--[[ 	ParkingDoorGoOutInside = {
		Pos	= { x = 234.56, y = -1373.77, z = 20.97 },
		Type = 27
	},

	ParkingDoorGoOutOutside = {
		Pos	= { x = 320.98, y = -1478.62, z = 28.81 },
		Type = -1
	},

	ParkingDoorGoInInside = {
		Pos	= { x = 238.64, y = -1368.48, z = 23.53 },
		Type = -1
	},

	ParkingDoorGoInOutside = {
		Pos	= { x = 317.97, y = -1476.13, z = 28.97 },
		Type = 27
	},

	StairsGoTopTop = {
		Pos	= { x = 251.91, y = -1363.3, z = 38.53 },
		Type = -1
	},

	StairsGoTopBottom = {
		Pos	= { x = 237.45, y = -1373.89, z = 26.30 },
		Type = -1
	},

	StairsGoBottomTop = {
		Pos	= { x = 256.58, y = -1357.7, z = 37.30 },
		Type = -1
	},

	StairsGoBottomBottom = {
		Pos	= { x = 235.45, y = -1372.89, z = 26.30 },
		Type = -1
	} ]]

}

--Config.JobLocations = { {x = 295.52, y = -1440.74, z = 29.38}, } 


Config.JobLocations = {
	{x = -491.262, y = -336.76, z = 34.373}
}
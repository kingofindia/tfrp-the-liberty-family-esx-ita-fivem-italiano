Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, 30.6),
			vector3(1855.744, 3692.598, 34.267)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6),
			vector3(1843.022, 3688.888, 34.267)
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(470.893, -1093.445, 29.201), --x = 470.893, y = -1093.445, z = 29.201
				SpawnPoints = {
					{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
					{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(470.893, -1093.445, 29.201),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(1862.541, 3679.02, 33.655),
				InsideShop = vector3(1866.252, 3700.584, 33.497),
				SpawnPoints = {
					{ coords = vector3(1864.941, 3679.528, 33.627), heading = 230.1, radius = 6.0},
					{ coords = vector3(1870.766, 3683.627, 33.671), heading = 230.1, radius = 6.0}
				}
			},

			{
				Spawner = vector3(-470.314, 6029.759, 31.341),
				InsideShop = vector3(-470.314, 6029.759, 31.341),
				SpawnPoints = {
					{ coords = vector3(-470.314, 6029.759, 31.341), heading = 230.0, radius = 6.0},
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(448.924, -980.805, 43.692),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			},

			{
				Spawner = vector3(1833.24, 3681.337, 40.518),
				InsideShop = vector3(1833.24, 3681.337, 40.518),
				SpawnPoints = {
					{ coords = vector3(1833.24, 3681.337, 40.518), heading = 92.6, radius = 10.0 }
				}
			},

			{
				Spawner = vector3(-474.861, 5990.309, 31.337),
				InsideShop = vector3(-474.861, 5990.309, 31.337),
				SpawnPoints = {
					{ coords = vector3(-474.861, 5990.309, 31.337), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6),
			vector3(1853.247, 3689.514, 34.267),
			vector3(-449.292, 6012.439, 31.716)
		}

	}

}

Config.StashWeapons = {
	{name = 'WEAPON_ASSAULTSMG', label = 'Assault smg'},
	{name = 'WEAPON_COMBATPDW', label = 'Combat pdw'},
	{name = 'WEAPON_ASSAULTRIFLE', label = 'Assault rifle'},
	{name = 'WEAPON_CARBINERIFLE', label = 'Carbine rifle'},
	{name = 'WEAPON_ADVANCEDRIFLE', label= 'Advanced rifle'},
	{name = 'WEAPON_SPECIALCARBINE', label= 'Special carbine'},
	{name = 'WEAPON_BULLPUPRIFLE', label='Bullpup Rifle'},
	{name = 'WEAPON_COMPACTRIFLE', label= 'Compactrifle'},
	{name = 'WEAPON_PUMPSHOTGUN', label='Pumpshotgun'},
	{name = 'WEAPON_BULLPUPSHOTGUN', label='Bullpup shotgun'},
	{name = 'WEAPON_ASSAULTSHOTGUN', label='Assaut shotgun'},
	{name = 'WEAPON_HEAVYSHOTGUN', label='Heavy shotgun'},
	{name = 'WEAPON_SAWNOFFSHOTGUN', label='Sawoff shotgun'},
	{name = 'WEAPON_MUSKET', label='Musket'},
	{name = 'WEAPON_DBSHOTGUN', label='DB shotgun'},
	{name = 'WEAPON_AUTOSHOTGUN', label='Auto shotgun'},
	{name = 'WEAPON_COMBATMG', label='Combat smg'},
	{name = 'WEAPON_MG', label='Mg'},
	{name = 'WEAPON_SMG', label='SMG'},
	{name = 'WEAPON_GUSENBERG', label='Gunseberg'},
}

Config.AuthorizedWeapons = {
	recruit = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 80 }
	},

	officer = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 50000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_APPISTOL', price = 10000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 70000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 }
	},

	ufficiale = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 15000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 35000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 50000 },
	},

	intendent = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 15000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 35000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 50000 },
	},

	lieutenant = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 15000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 35000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 50000 },
	},

	comandante = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 15000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 35000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 50000 },
	},

	vicecapitano = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 15000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 35000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 50000 },
	},

	boss = {
		{ weapon = 'WEAPON_COMBATPISTOL', price = 1000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 30000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_SMOKEGRENADE', price = 100 },
		{ weapon = 'WEAPON_CARBINERIFLE', price = 15000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 35000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 50000 },
	}
}

Config.AuthorizedVehicles = {
	Shared = {
	},

	recruit = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},

	},

	officer = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
	},

	sergeant = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
		{ model = 'pol718', 	label = 'Porsche Cayman', 		price = 0 },
		{ model = 'polp1', 	    label = 'McLaren P1',		price = 0 },
		{ model = 'polaventa', 	label = 'Lamborghini Aventador',		price = 0 },
		{ model = 'polcoquette', 	label = 'Coquette Borghese',		price = 0 },
		{ model = 'bearcat',		label = 'Blindato',			price = 0 },
        { model = 'srt8',		label = 'Grand Cherokee',			price = 0 },
		{ model = 'sspres',		label = 'Suv Presidenziale',	price = 0},
	},

	ufficiale = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
		{ model = 'pol718', 	label = 'Porsche Cayman', 		price = 0 },
		{ model = 'polp1', 	    label = 'McLaren P1',		price = 0 },
		{ model = 'polaventa', 	label = 'Lamborghini Aventador',		price = 0 },
		{ model = 'polcoquette', 	label = 'Coquette Borghese',		price = 0 },
		{ model = 'bearcat',		label = 'Blindato',			price = 0 },
        { model = 'srt8',		label = 'Grand Cherokee',			price = 0 },
		{ model = 'sspres',		label = 'Suv Presidenziale',	price = 0},
	},

	intendent = {

	},

	lieutenant = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
		{ model = 'pol718', 	label = 'Porsche Cayman', 		price = 0 },
		{ model = 'polp1', 	    label = 'McLaren P1',		price = 0 },
		{ model = 'polaventa', 	label = 'Lamborghini Aventador',		price = 0 },
		{ model = 'polcoquette', 	label = 'Coquette Borghese',		price = 0 },
		{ model = 'bearcat',		label = 'Blindato',			price = 0 },
        { model = 'srt8',		label = 'Grand Cherokee',			price = 0 },
		{ model = 'sspres',		label = 'Suv Presidenziale',	price = 0},
	},

	comandante = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
		{ model = 'pol718', 	label = 'Porsche Cayman', 		price = 0 },
		{ model = 'polp1', 	    label = 'McLaren P1',		price = 0 },
		{ model = 'polaventa', 	label = 'Lamborghini Aventador',		price = 0 },
		{ model = 'polcoquette', 	label = 'Coquette Borghese',		price = 0 },
		{ model = 'bearcat',		label = 'Blindato',			price = 0 },
        { model = 'srt8',		label = 'Grand Cherokee',			price = 0 },
		{ model = 'sspres',		label = 'Suv Presidenziale',	price = 0},
	},

	vicecapitano = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
		{ model = 'pol718', 	label = 'Porsche Cayman', 		price = 0 },
		{ model = 'polp1', 	    label = 'McLaren P1',		price = 0 },
		{ model = 'polaventa', 	label = 'Lamborghini Aventador',		price = 0 },
		{ model = 'polcoquette', 	label = 'Coquette Borghese',		price = 0 },
		{ model = 'bearcat',		label = 'Blindato',			price = 0 },
        { model = 'srt8',		label = 'Grand Cherokee',			price = 0 },
		{ model = 'sspres',		label = 'Suv Presidenziale',	price = 0},
	},

	boss = {
		{ model = 'tahoe', 	    label = 'Suv Tahoe', 		price = 0 },
		{ model = 'polgs350',	label = 'Lexus',		price = 0},
		{ model = 'pol718', 	label = 'Porsche Cayman', 		price = 0 },
		{ model = 'polp1', 	    label = 'McLaren P1',		price = 0 },
		{ model = 'polaventa', 	label = 'Lamborghini Aventador',		price = 0 },
		{ model = 'polcoquette', 	label = 'Coquette Borghese',		price = 0 },
		{ model = 'bearcat',		label = 'Blindato',			price = 0 },
        { model = 'srt8',		label = 'Grand Cherokee',			price = 0 },
		{ model = 'sspres',		label = 'Suv Presidenziale',	price = 0},
	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
		{ model = 'polmav', label = 'Elicottero polizia', livery = 0, price = 100000 }
	},

	comandante = {
		{ model = 'polmav', label = 'Elicottero polizia', livery = 0, price = 100000 }
	},

	vicecapitano = {
		{ model = 'polmav', label = 'Elicottero polizia', livery = 0, price = 100000 }
	},

	boss = {
		{ model = 'polmav', label = 'Elicottero polizia', livery = 0, price = 100000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	ufficiale_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	comandante_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	vicecapitano_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}
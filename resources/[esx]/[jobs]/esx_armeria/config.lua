Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 27
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 255, g = 255, b = 255 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos     = { x = 812.39, y = -2154.061, z = 29.619 },
			Sprite  = 110,
			Display = 4,
			Scale   = 1.4,
			Colour  = 5,
		},
		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
		},

		Cloakrooms = {
			{x = 827.433, y = -2153.473, z = 28.719},
		},

		Armories = {
			{x = 808.652, y = -2159.476, z = 28.719},
		},

		Vehicles = {
			{
				Spawner    = {x = 814.25, y = -2146.52, z = 28.515},
				SpawnPoint = {x = 822.06, y = -2138.405, z = 28.284},
				Heading    = 224.98,
			}
		},

		VehicleDeleters = {
			{x = 814.341, y = -2119.899, z = 28.429}
		},

		BossActions = {
			{x = 819.44, y = -2151.881, z = 28.719}
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
        {
			model = 'terbyte',
			label = 'M939 5-Ton Truck'
		},
		{
			model = 'rumpo3',
			label = 'Rumpo 3'
		}
	},

	dipendente = {
        
	},

	soldato = {
        
	},
	
	caporale = {
        
	},

	sergente = {
        
	},

	tenente = {
        
	},

	boss = {

	},


	chef = {

	},

}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	dipendente_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	soldato_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	caporale_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	sergente_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	tenente_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	boss_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	intendent_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	chef_wear = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 36,   ['shoes_2'] = 3,
			['bags_1'] = 45,   ['bags_2'] = 0,
		},
			female = {
				['tshirt_1'] = 51,  ['tshirt_2'] = 0,
				['torso_1'] = 7,   ['torso_2'] = 1,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 3,
				['pants_1'] = 7,   ['pants_2'] = 0,
				['shoes_1'] = 0,   ['shoes_2'] = 0
			}
		},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	}

}
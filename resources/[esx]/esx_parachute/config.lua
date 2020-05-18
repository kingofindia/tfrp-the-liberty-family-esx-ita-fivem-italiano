Config              			= {}
Config.Locale					= 'en'

Config.ZoneBlipColour 			= 5 
Config.ZoneBlipSprite 			= 5

Config.DestinationMarkerType	= 1 -- If '-1' all jump markers not be displayed
Config.DestinationMarkerColour	= {r = 204, 	g = 204, 		b = 0}
Config.DestinationBlipColour	= 6
Config.DestinationBlipSprite	= 229


Config.Zones = {
	Zone1 = {
		Pos				= {x = 759.01, 	y = -3195.18, 	z = 4.97},
		Size			= {x = 3.0, 	y = 3.0, 		z = 1.0},
		MarkerColour	= {r = 204, 	g = 204, 		b = 0},
		MarkerType		= 27, -- If '-1' marker not be displayed
		Title			= _U("parachute_jump"), --to replace point name delete _U()
	},
}

Config.Jumps = {
	Jump1 = {
		DepartPos		= vector3(1400.5, 1129.0, 114.3),
		DestinationPos	= {x = 759.01, 	y = -3195.18, 	z = 4.97},
		DestinationSize	= {x = 3.0, 	y = 3.0, 		z = 1.0},
	},
}

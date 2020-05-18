Config              = {}
Config.MarkerType   = -1 -- Marker visible or not. -1 = hiden  Set to 1 for a visible marker. To have a list of avaible marker go to https://docs.fivem.net/game-references/markers/
Config.DrawDistance = 100.0 --Distance where the marker be visible from
Config.ZoneSize     = {x = 5.0, y = 5.0, z = 3.0} -- Size of the marker
Config.MarkerColor  = {r = 0, g = 255, b = 0} --Color of the marker

Config.RequiredCopsCoke  = 3 --Ammount of cop that need to be online to be able to harvest/process/sell coke
Config.RequiredCopsMeth  = 3 --Ammount of cop that need to be online to be able to harvest/process/sell meth
Config.RequiredCopsWeed  = 3 --LSD
Config.RequiredCopsOpium = 3 --Ammount of cop that need to be online to be able to harvest/process/sell opium

Config.TimeToFarmWeed     = 3  * 1000 -- Ammount of time to harvest weed
Config.TimeToProcessWeed  = 5  * 1000 -- Ammount of time to process weed
Config.TimeToSellWeed     = 1  * 1000 -- Ammount of time to sell weed

Config.TimeToFarmOpium    = 3  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessOpium = 5  * 1000 -- Ammount of time to process coke
Config.TimeToSellOpium    = 1  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmCoke     = 3  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessCoke  = 5  * 1000 -- Ammount of time to process coke
Config.TimeToSellCoke     = 1  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmMeth     = 3  * 1000 -- Ammount of time to harvest meth
Config.TimeToProcessMeth  = 5 * 1000 -- Ammount of time to process meth
Config.TimeToSellMeth     = 1  * 1000 -- Ammount of time to sell meth

Config.Locale = 'en'

Config.Zones = {
	CokeField =			{x=93.186, y=3755.3, z=40.773},
	CokeProcessing =	{x=28.369, y=3666.203, z=40.441},
	CokeDealer =		{x=959.117,   y=-121.055,   z=74.963},
	MethField =			{x=1247.529, y=-3033.653, z=9.36},
	MethProcessing =	{x=1208.739, y=-3113.445, z=5.54},
	MethDealer =		{x=7.981,     y=6469.067,   z=31.528},
	WeedField =			{x=-578.874, y=-1628.622, z=33.026}, -- LSD
	WeedProcessing =	{x=-594.88, y=-1599.943, z=27.011}, -- LSD
	WeedDealer =		{x = 85.58,   y= -1959.34,  z= 20.13}, -- LSD
	OpiumField =		{x=2433.804,  y=4969.196,   z=42.348},
	OpiumProcessing =	{x=2434.43,   y=4964.18,    z=42.348},
	OpiumDealer =		{x=-3155.608, y=1125.368,   z=20.858}
}

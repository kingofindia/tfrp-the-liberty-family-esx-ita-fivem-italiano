Config                      = {}

Config.DrawDistance         = 100.00
Config.MarkerType           = 27
Config.MarkerSize           = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor          = {r = 102, g = 204, b = 102}

Config.Zones = {}

Config.ChangingRooms = {
	{x = -1242.57,  y = -1537.92,   z = 3.30},  	--	Beach near Gym
	{x = -1612.26,	y = -1028.92,	z = 12.15},		--	On the Pier
	{x = -2221.73,	y = -366.26,	z = 12.26},		--	Pipeline Inn Backroom
	{x = -2963.02,	y = 454.53,		z = 14.10},		--	Tidemarks
	{x = -773.37,	y = 5598.06,	z = 32.61},		--	Outdoor Clothing
	{x = 1469.82,	y = 6550.41,	z = 13.90},		--	Paleto Public Bathrooms
	--{x = 2329.50,	y = 2571.59,	z = 45.68},		--	Hippie Tool Shed
	{x = 1891.28,	y = -1019.47,	z = 77.49},		--	Oiler's Outfit Rooms
	{x = 886.38,	y = -1588.31,	z = 29.96},		--	Industrial Area Shed
	{x = 380.06,	y = -1814.20,	z = 28.07},		--	Hood Motel #16
	{x = -787.98,	y = -600.12,	z = 29.28},		--	Little Seoul Lady 'n' Boy
	{x = -811.84,	y = 175.07,		z = 75.75},		-- 	Michael's House
	{x = 308.16,	y = -213.35,	z = 53.22},		--	Uptown Motel #4
	{x = 795.21,	y = -2971.34,	z = 5.02},		--	Jetsam Terminal
	{x = -1595.087, y = 2102.324, z = 69.296},
	--{x = 929.562, y = 1265.562, z = 369.11},
	{x = 456.205, y = -988.538, z = 29.689},
	{x = -214.42, y = -1339.28, z = 33.894}
}

for i=1, #Config.ChangingRooms, 1 do
	Config.Zones['Changing_Rooms' .. i] = {
		Pos   = Config.ChangingRooms[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
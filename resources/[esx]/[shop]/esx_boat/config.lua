Config               = {}

Config.Locale        = 'en'

Config.LicenseEnable = true -- enable boat license? Requires esx_license
Config.LicensePrice  = 10000

Config.MarkerType    = 27
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

Config.StoreMarker = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

Config.Zones = {
	
	Garages = {

	},

	BoatShops = {

		{ -- Shank St, nearby campaign boat garage
			Outside = {x = -830.187, y = -1359.825, z = 4.001},
			Inside  = {x = -859.908, y = -1372.999, z = 0.389, h = 120.00 },
		}

	}

}

Config.Vehicles = {

	{
		model = 'seashark',
		label = 'Seashark (Random Color)',
		price = 40000
	},

	{
		model = 'seashark3',
		label = 'Seashark (Dark Blue)',
		price = 40000
	},

	{
		model = 'suntrap',
		label = 'Suntrap',
		price = 50000
	},

	{
		model = 'jetmax',
		label = 'Jetmax',
		price = 70000
	},

	{
		model = 'tropic2',
		label = 'Tropic',
		price = 90000
	},

	{
		model = 'dinghy2',
		label = 'Dinghy (Black)',
		price = 52000
	},

	{
		model = 'dinghy',
		label = 'Dinghy 2 (Random Color)',
		price = 52000
	},

	{
		model = 'speeder',
		label = 'Speeder',
		price = 150000
	},

	{
		model = 'squalo',
		label = 'Squalo (Random Color)',
		price = 78950
	},

	{
		model = 'toro',
		label = 'Toro',
		price = 169000
	},

	{
		model = 'submersible',
		label = 'Submersible',
		price = 2000000
	}

}
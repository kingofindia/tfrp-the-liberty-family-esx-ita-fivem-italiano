Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_fib_door1',
		objYaw = 70.0,
		objCoords  = vector3(-31.72353, -1101.846, 26.57225),
		textCoords = vector3(-31.72353, -1101.846, 27.57225),
		authorizedJobs = { 'cardealer' },
		locked = true
	},

	{
		objName = 'v_ilev_fib_door1',
		objYaw = 70.0,
		objCoords  = vector3(-33.80989, -1107.579, 26.57225),
		textCoords = vector3(-33.80989, -1107.579, 27.57225),
		authorizedJobs = { 'cardealer' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = 0.0,
		objCoords  = vector3(462.796, -1000.888, 35.931),
		textCoords = vector3(461.996, -1000.888, 35.931),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	{
		textCoords = vector3(446.084, -999.125, 30.724),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_ilev_gtdoor',
				objYaw = 180.0,
				objCoords = vector3(446.384, -999.125, 30.724)
			},

			{
				objName = 'v_ilev_gtdoor',
				objYaw = 0.0,
				objCoords = vector3(445.543, -999.041, 30.724)
			}
		}
	},

	{
		textCoords = vector3(469.947, -1010.605, 26.386),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor003',
				objYaw = -90.0,
				objCoords = vector3(469.947, -1011.105, 26.386)
			},

			{
				objName = 'v_ilev_ph_gendoor003',
				objYaw = 90.0,
				objCoords = vector3(469.877, -1009.962, 26.386)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Main Cells
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(468.074, -996.547, 24.915),
		textCoords = vector3(467.574, -996.547, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(472.43, -996.339, 24.915),
		textCoords = vector3(471.93, -996.339, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(476.797, -996.545, 24.915),
		textCoords = vector3(476.297, -996.545, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(481.016, -996.527, 24.915),
		textCoords = vector3(480.516, -996.527, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(480.775, -1003.638, 24.915),
		textCoords = vector3(480.275, -1003.638, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 180.0,
		objCoords  = vector3(476.3, -1003.502, 24.915),
		textCoords = vector3(476.3, -1003.502, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(472.314, -1003.553, 24.915),
		textCoords = vector3(471.814, -1003.553, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	{
		objName = 'v_ilev_gtdoor',
		objYaw = 180.0,
		objCoords  = vector3(467.852, -1003.456, 24.915),
		textCoords = vector3(467.052, -1003.456, 24.915),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'v_ilev_fh_frontdoor',
		objCoords  = vector3(7.5179, 539.526, 176.1781),
		textCoords = vector3(8.5179, 539.526, 176.1781),
		authorizedJobs = { 'maluma' },
		locked = true,
		distance = 5,
		size = 1
	},
}
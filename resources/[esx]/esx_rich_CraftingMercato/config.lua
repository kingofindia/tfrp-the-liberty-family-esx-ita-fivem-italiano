Config = {}
Config.Locale = 'en'
Config.EnableHotkey = true

Config.Craftables = {
	
	pistola = {
	
		Label = "Ak",
		
		Require = {
			{ Name = "copper", Amount = 1000 },
			{ Name = "iron", Amount = 700 },
			{ Name = "gold", Amount = 300 },
			{ Name = "diamond", Amount = 40 }
		},
		
		Reward = {Item = "ak", Count = 1, Type = 'item'},
		Time = 25000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	}, 

	--[[ cecchino = {
	
		Label = "Cecchino",
		
		Require = {
			{ Name = "copper", Amount = 1000 },
			{ Name = "iron", Amount = 1000 },
			{ Name = "gold", Amount = 400 },
			{ Name = "diamond", Amount = 140 }
		},
		
		Reward = {Item = "cecchino", Count = 1, Type = 'item'},
		Time = 50000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},

	mcecchino = {

		Label = "Bossoli Cecchino",

		Require = {
			{ Name = "copper", Amount = 200 },
			{ Name = "iron", Amount = 100 }
		},

		Reward = {Item = "mcecchino", Count = 150, Type = 'item'},
		Time = 10000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	}, ]]

	mak = {

		Label = "Bossoli AK",

		Require = {
			{ Name = "copper", Amount = 100 },
			{ Name = "iron", Amount = 50 },
		},

		Reward = {Item = "mak", Count = 180, Type = 'item'},
		Time = 10000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},
}

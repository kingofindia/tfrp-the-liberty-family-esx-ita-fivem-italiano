Config = {}
Config.Locale = 'en'
Config.EnableHotkey = true

Config.Craftables = {
	
	pistola = {
	
		Label = "Pistola",
		
		Require = {
			{ Name = "copper", Amount = 100 },
			{ Name = "iron", Amount = 100 },
		},
		
		Reward = {Item = "pistola", Count = 1, Type = 'item'},
		Time = 25000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	}, 

	mpistola = {
	
		Label = "Munizioni Pistola",
		
		Require = {
			{ Name = "copper", Amount = 10 },
			{ Name = "iron", Amount = 10 },
		},
		
		Reward = {Item = "mpistola", Count = 250, Type = 'item'},
		Time = 5000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},

	mcom = {
	
		Label = "Munizioni Pistola da combattimento",
		
		Require = {
			{ Name = "copper", Amount = 10 },
			{ Name = "iron", Amount = 10 },
		},
		
		Reward = {Item = "mcom", Count = 250, Type = 'item'},
		Time = 5000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},

	ak = {
	
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

	mpompa = {
	
		Label = "Munizioni Fucile a pompa",
		
		Require = {
			{ Name = "copper", Amount = 50 },
			{ Name = "iron", Amount = 50 },
		},
		
		Reward = {Item = "mpompa", Count = 250, Type = 'item'},
		Time = 10000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},

	msmg = {
	
		Label = "Munizioni SMG",
		
		Require = {
			{ Name = "copper", Amount = 70 },
			{ Name = "iron", Amount = 70 },
		},
		
		Reward = {Item = "msmg", Count = 250, Type = 'item'},
		Time = 15000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},
	
	combattimento = {
	
		Label = "Pistola da combattimento",
		
		Require = {
			{ Name = "copper", Amount = 150 },
			{ Name = "iron", Amount = 150 },
		},
		
		Reward = {Item = "combattimento", Count = 1, Type = 'item'},
		Time = 30000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},  
	
	pompa = {
	
		Label = "Fucile a pompa",
		
		Require = {
			{ Name = "copper", Amount = 400 },
			{ Name = "iron", Amount = 400 },
			{ Name = "gold", Amount = 50 },
			{ Name = "diamond", Amount = 2 },
		},
		
		Reward = {Item = "pompa", Count = 1, Type = 'item'},
		Time = 45000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},
	
	smg = {
	
		Label = "SMG",
		
		Require = {
			{ Name = "copper", Amount = 500 },
			{ Name = "iron", Amount = 500 },
			{ Name = "gold", Amount = 70 },
			{ Name = "diamond", Amount = 5 },
		},
		
		Reward = {Item = "smg", Count = 1, Type = 'item'},
		Time = 70000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},
	
	silencer = {
	
		Label = "Silenziatore",
		
		Require = {
			{ Name = "copper", Amount = 50 },
			{ Name = "iron", Amount = 50 },
		},
		
		Reward = {Item = "silencieux", Count = 1 , Type = 'item'},
		Time = 20000,
		Scenario = "WORLD_HUMAN_WELDING",
	},
	
	grip = {
	
		Label = "Impugnatura",
		
		Require = {
			{ Name = "iron", Amount = 70 },
			{ Name = "diamond", Amount = 10 },
		},
		
		Reward = {Item = "grip", Count = 1 , Type = 'item'},
		Time = 20000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},
	
	flashlight = {
	
		Label = "Torcia",
		
		Require = {
			{ Name = "copper", Amount = 100 },
			{ Name = "iron", Amount = 100 },
		},
		
		Reward = {Item = "flashlight", Count = 1 , Type = 'item'},
		Time = 20000,
		Scenario = "WORLD_HUMAN_WELDING",
	},
	
	gunskin = {
	
		Label = "Skin arma",
		
		Require = {
			{ Name = "copper", Amount = 150 },
			{ Name = "gold", Amount = 30 },
		},
		
		Reward = {Item = "yusuf", Count = 1 , Type = 'item'},
		Time = 20000,
		Scenario = "WORLD_HUMAN_HAMMERING",
	},
	
}

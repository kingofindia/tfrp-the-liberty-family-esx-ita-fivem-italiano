Config = {}

Config.WeaponAmmo = 42

--Config.Time = 5000
Config.Scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE'
Config.Number1 = 10
Config.Number2 = 5


Config.Recipes = {
	["medikit"] = {

		{item = "radicedimungere", quantity = 4, remove = true}, 
		{item = "fogliecentella", quantity = 2, remove = true},
		{item = "glucomannano", quantity = 3, remove = true},
		{item = "tiroxina", quantity = 10, remove = true}
	},

	["bandage"] = {

		{item = "radicedimungere", quantity = 2, remove = true},
		{item = "fogliecentella", quantity = 2, remove = true},
		{item = "fioridiverbena", quantity = 4, remove = true},
		{item = "bromobiatomico", quantity = 10, remove = true}
	},
}
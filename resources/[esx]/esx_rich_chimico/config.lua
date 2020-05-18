Config = {}

Config.DrawDistance = 100
Config.Size         = {x = 1.0, y = 1.0, z = 0.5}
Config.Color        = {r = 0, g = 123, b = 255} --230
Config.Type         = 0

Config.EnablePed    = true

Config.Locale = 'en'

Config.Zones = {

    Distributor = {
        Items = {
           -- {label = "Acqua per piante",    name = "acqua",           price = 20},
            --{label = "Fertilizzante",       name = "fertilizzante",   price = 30},
            {label = "Semi di Marijuana",   name = "cannabis",        price = 250},
            {label = "Radice di Mungere",   name = "radicedimungere", price = 10},
            {label = "Foglie di Centella",  name = "fogliecentella",  price = 10},
            {label = "Glucomannano",        name = "glucomannano",    price = 15},
            {label = "L-tiroxina",          name = "tiroxina",        price = 25},
            {label = "Fiori di Verbena",    name = "fioridiverbena",  price = 20},
            {label = "Bromo biatomico",     name = "bromobiatomico",  price = 20},
        },
        Pos = {
            {x = 3537.718, y = 3665.458, z = 27.122},
        }
    }
}

Config.Locations1 = {
    {x = 3537.718, y = 3665.458, z = 27.122, heading = 100.29 },
    {x = 3536.564, y = 3662.653, z = 27.122, heading = 180.00 },
    {x = 3536.356, y = 3668.31, z = 27.122, heading = 0.00},
    {x = 3540.505, y = 3667.848, z = 27.122, heading = 30.00},
    {x = 3535.496, y = 3660.503, z = 27.122, heading = 350.00},
    {x = 3559.774, y = 3674.543, z = 27.122, heading = 174.00},
    {x = 3559.072, y = 3672.335, z = 27.122, heading = 345.00}
}

Config.Zone = {}

for i=1, #Config.Locations1, 1 do
	Config.Zone['Shops_' .. i] = {
		Pos   = Config.Locations1[i]
	}
end
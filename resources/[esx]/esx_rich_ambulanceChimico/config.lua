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
            {label = "Pomata per la rosacea",   name = "pomata",            price = 80},
            {label = "Antibiotico",             name = "antibiotico",       price = 50},
            {label = "Sciroppo per la tosse",   name = "sciroppo",          price = 50},
        },
        Pos = {
            {x = -466.818, y = -336.974, z = -187.474},
            {x = 361.375, y = -571.117, z = 27.791},
            {x = 333.941, y = -1419.459, z = 31.50}
        }
    }
}

Config.Locations1 = {
    {x = -467.688, y = -339.8, z = -187.461, heading = 100.29 },
    {x = -466.204, y = -343.244, z = -187.455, heading = 175.00},
    {x = -468.653, y = -343.216, z = -187.466, heading = 173.00},
    {x = -470.802, y = -341.259, z = -187.473, heading = 100.00},
    {x = -466.818, y = -336.974, z = -187.474, heading = 232.00},
    {x = -459.487, y = -335.49, z = -187.455, heading = 173.00},
    {x = -450.328, y = -343.102, z = -187.466, heading = 252.00},
    {x = -453.208, y = -336.496, z = -187.461, heading = 15.00},
    {x = -452.495, y = -346.176, z = -187.46, heading = 20.00},
    {x = -452.961, y = -353.179, z = -187.481, heading = 145.00},
    {x = -449.896, y = -363.008, z = -187.455, heading = 170.00},
    {x = -447.228, y = -356.201, z = -187.461, heading = 5.00},
    {x = -474.448, y = -375.822, z = -187.461, heading = 340.00},
    {x = -472.209, y = -375.834, z = -187.461, heading = 350.00},
    {x = -469.072, y = -370.995, z = -187.458, heading = 170.00},
    {x = -460.889, y = -369.906, z = -187.478, heading = 280.00},
    {x = -463.589, y = -376.628, z = -187.47, heading = 190.00},
    {x = -473.548, y = -350.973, z = -187.468, heading = 100.00},
    {x = -463.472, y = -361.738, z = -187.458, heading = 200.00},
    {x = -461.183, y = -360.849, z = -187.467, heading = 10.00},
}

Config.Zone = {}

for i=1, #Config.Locations1, 1 do
	Config.Zone['Shops_' .. i] = {
		Pos   = Config.Locations1[i]
	}
end
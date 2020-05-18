Config                            = {}
Config.Locale                     = 'en'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = true
Config.EnableBlips = true


--- #### PRICES	
Config.PriceTriBike = 20
Config.PriceScorcher = 30
Config.PriceCruiser = 50
Config.PriceBmx = 40


--- #### MARKER EDITS
Config.TypeMarker = 27
Config.MarkerScale = {{x = 2.000,y = 2.000,z = 0.500}}
Config.MarkerColor = {{r = 0,g = 0,b = 255}}
	
Config.MarkerZones = { 

    {x = -1036.054,y = -2734.843,z = 20.169},
    {x = -240.899,y = -992.692,z = 29.289}, 
    {x = -1262.36,y = -1438.98,z = 3.45},
    {x = 1703.601,y = 3774.294,z = 34.55},
    {x = 169.857,y = 6627.238,z = 31.729},

}


-- Edit blip titles
Config.BlipZones = { 

   {title="Noleggio Bici", colour=2, id=376, x = -1036.054, y = -2734.843, z = 20.169},
   {title="Noleggio Bici", colour=2, id=376, x = -240.899, y = -992.692, z = 29.289},
   {title="Noleggio Bici", colour=2, id=376, x = -1262.36, y = -1438.98, z = 3.45},
   {title="Noleggio Bici", colour=2, id=376, x = 1703.601, y = 3774.294, z = 34.55},
   {title="Noleggio Bici", colour=2, id=376, x = 169.857, y = 6627.238, z = 31.729},
}

local blips = {
     {title="Shop Vanilla/Bahamas/Tequila 1", colour=46, id=11, x = -2955.242, y = 385.897, z = 14.041},
     {title="Shop Vanilla/Bahamas/Tequila 2", colour=46, id=11, x = 178.028, y = 307.467, z = 104.392},
     {title="Shop Vanilla/Bahamas/Tequila 3", colour=46, id=11, x = 98.675, y = -1809.498, z = 26.095},
     {title="Shop Vanilla/Bahamas/Tequila 4", colour=46, id=11, x = 26.979, y = -1343.457, z = 28.517},
     {title="Tequila", colour=46, id=79, x = -564.892, y = 274.196, z = 83.02},
     {title="Chiesa", colour=4, id=305, x = -1560.67834, y = 108.03022, z = 56.0563507},
     {title="Luxor Resort", colour=50, id=93, x = -2223.816, y = -622.764, z = 15.615}
  }
      
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)

      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)

	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
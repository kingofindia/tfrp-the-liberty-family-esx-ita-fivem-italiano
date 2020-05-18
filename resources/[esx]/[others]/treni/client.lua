ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local blips = {
  {title="Stazione Ferroviaria", colour=47, id=280, x = -216.964, y = -1038.245, z = 30.144},
  {title="Stazione Ferroviaria", colour=47, id=280, x = -487.521, y = 5260.139, z = 87.011},
  {title="Stazione Ferroviaria", colour=47, id=280, x = 2620.431, y = 2930.545, z = 40.423},
}

Citizen.CreateThread(function()
 for _, info in pairs(blips) do
  info.blip = AddBlipForCoord(info.x, info.y, info.z)
  nome = "Stazione Ferroviaria"
  SetBlipSprite(info.blip, info.id)
  SetBlipDisplay(info.blip, 4)
  SetBlipScale(info.blip, 0.6)
  SetBlipColour(info.blip, info.colour)
  SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(nome)
  EndTextCommandSetBlipName(info.blip)
 end
end)

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end

local inTrain = false
local trainstations = {
 ['Innocence Blvd | LS'] = {x = -540.505, y = -1278.430, z = 26.901, price = 25, name = 'Innocence Blvd'},
 ['Strawberry Ave | LS'] = {x = 278.274, y = -1201.312, z = 38.899, price = 25, name = 'Strawberry Ave'},
 ['Alta Street | LS'] = {x = -216.964, y = -1038.245, z = 30.144, price = 25, name = 'Alta Street'},
 ['Davis Quartz | Sandy'] = {x = 2620.431, y = 2930.545, z = 40.423, price = 25, name = 'Davis Quartz'},
 ['LSIA | LS'] = {x = -1083.957, y = -2709.498, z = -7.410, price = 25, name = 'LSIA'},
 ['LSIA 2 | LS'] = {x = -884.825, y = -2313.427, z = -11.733, price = 25, name = 'LSIA 2'},
 ['San Vitus Blvd | LS'] = {x = -819.573, y = -134.744, z = 19.950, price = 25, name = 'San Vitus Blvd'},
 ['South Boulevard | LS'] = {x = -1356.867, y = -463.774, z = 15.045, price = 25, name = 'South Boulevard'},
 ['San Andreas Ave | LS'] = {x = -500.879, y = -668.453, z = 11.809, price = 25, name = 'San Andreas Ave'},
 ['Lumber Yard | Paleto'] = {x = -487.521, y = 5260.139, z = 87.011, price = 25, name = 'Lumber Yard'},
}

prezzo = 25

Citizen.CreateThread(function()
  WarMenu.CreateMenu('trainmenu', 'Stazioni')
 while true do
  Wait(5)
 for k,v in pairs(trainstations) do
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 30) then
   DrawMarker(27, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 1.2,1.2,1.0, 255,100,1, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) and not inTrain then
    drawTxt("~b~Premi ~g~E~w~ ~b~per vedere le stazioni dei treni")
    if IsControlPressed(0, 38) then
     WarMenu.OpenMenu('trainmenu')
    end
   end 
   if WarMenu.IsMenuOpened('trainmenu') then
    for ind,v in pairs(trainstations) do 
     if WarMenu.Button(''..ind, "~g~$"..v.price) then
        ESX.TriggerServerCallback('treni:checkMoney', function(soldiplayer)
          if soldiplayer >= prezzo then     
            inTrain = true
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent("treni:price", prezzo)
            WarMenu.CloseMenu('trainmenu')
            FreezeEntityPosition(GetPlayerPed(-1), true)
            SwitchOutPlayer(PlayerPedId(), 0, 1)
            exports.pNotify:SendNotification({text = "Stai entrando nel treno"})
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "train", 0.3)
            Citizen.Wait(30000)
            SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z+0.75)
            Wait(4500)
            exports.pNotify:SendNotification({text = "Sei arrivato a destinazione"})
            SwitchInPlayer(PlayerPedId())
            Citizen.Wait(4550)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            inTrain = false
          else
            exports.pNotify:SendNotification({text = "Non hai abbastanza soldi"})
          end
        end)
     end
    end
     WarMenu.Display()
    end
   end
  end
 end
end)

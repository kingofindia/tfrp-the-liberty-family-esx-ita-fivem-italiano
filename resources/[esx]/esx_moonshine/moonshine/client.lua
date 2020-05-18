local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
staimbottigliando = false
OpeningHour = 0
ClosingHour = 6

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  local numero = 1
  local hour = GetClockHours()
  local ClosingTime = ClosingHour-1    
  Citizen.Wait(5)
   if(GetDistanceBetweenCoords(coords, 1009.5, -3196.6, -38.99682, true) < 10.0) and not staimbottigliando then
    DrawMarker(27, 1009.5, -3196.6, -38.99682-0.96, 0, 0, 0, 0, 0, 0, 1.6,1.6,0.5, 232, 210, 132, 155, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 1009.5, -3196.6, -38.99682, true) < 1.5) then
     drawTxt('~b~Premi ~g~E~b~ per imbottigliare il Whisky')
     if IsControlJustReleased(0, 38) then
      staimbottigliando = true
      if hour < OpeningHour or hour > ClosingTime then
        TriggerEvent('mt:missiontext', 'Attività disponibile dalle 00:00 alle 06:00', 3000)
        staimbottigliando = false
      else
        ESX.TriggerServerCallback('esx_moonshine:conteggio', function(CopsConnected)
          if CopsConnected >= 3 then
            staimbottigliando = true
            ProgressBar('Bottiglia Moonshine', 55)
            Citizen.Wait(6250)
            TriggerServerEvent('esx_moonshine:inventario', numero)
            Citizen.Wait(2000)
            staimbottigliando = false
          else
            staimbottigliando = false
          end
          end)
      end
     end
    end
   end
  -- Enter And Exiting Weed Farm
  if(GetDistanceBetweenCoords(coords, 743.028, -1797.229, 29.292, true) < 20) then
   DrawMarker(27, 743.028, -1797.229, 29.292-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0,255,123,255, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 743.028, -1797.229, 29.292, true) < 1.2) then
    drawTxt('~b~Premi ~g~E~b~ per entrare')
    if IsControlJustPressed(0, 38) then
     Teleport(997.286, -3200.582, -36.394)
    end
   end
  elseif (GetDistanceBetweenCoords(coords, 997.286, -3200.582, -36.394, true) < 20) then
   DrawMarker(27, 997.286, -3200.582, -36.394-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0,255,123,255, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 997.286, -3200.582, -36.394, true) < 1.2) then
    drawTxt('~b~Premi ~g~E~b~ per uscire')
    if IsControlJustPressed(0, 38) then
     Teleport(743.028, -1797.229, 29.292)
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    rped = GetRandomPedAtCoord(pos['x'], pos['y'], pos['z'], 1.3, 1.35, 1.35, 3, _r)
    if DoesEntityExist(rped) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      if IsControlJustReleased(0, 38) then
        ESX.TriggerServerCallback('esx_moonshine:conteggio', function(CopsConnected)
        if CopsConnected >= 3 then
          ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
          if quantity >= 1 then
           TaskStandStill(rped, 7000)
           TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)
           ProgressBar('Offri Whisky', 55)
           Citizen.Wait(6250)
           if math.random(1,100) > 85 then
           --SendDistressSignal()
           exports.pNotify:SendNotification({text = "Offerta rifiutata! Il civile ha chiamato la Polizia!"})
           local playerPed = PlayerPedId()
           PedPosition        = GetEntityCoords(playerPed)

           local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

           TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'C\'è una persona che vuole vendermi del whisky!', PlayerCoords, {

           PlayerCoords = { x = pos.x, y = pos.y, z = pos.z },
           })
           else
           sellMoonshine()
           end
           ClearPedTasksImmediately(rped)
           ClearPedTasksImmediately(GetPlayerPed(-1))
           Wait(5000)
           DeleteEntity(rped)
           nearNPC = false
          end
          end, 'moonshine')
        end
        end)
      end
    end
  end
end)

function sellMoonshine()
  
  ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
    if quantity >= 7 then
      local moonshineSold = math.random(1, 7)
      local moonshinePriceBottle = math.random(700,800)
      local moonshineSoldPrice = math.floor(moonshineSold * moonshinePriceBottle)

      TriggerEvent("pNotify:SendNotification", {text = "Hai venduto " .. moonshineSold .." Bottiglie di Whisky al prezzo di <font color='lightgreen'>$".. moonshineSoldPrice})
      TriggerServerEvent('esx_moonshine:vendita', moonshineSold, moonshineSoldPrice)
    end
  end, 'moonshine')
end


local ill = false
local stomaco = false
local pelle = false
local chance = 7 
local chancestomaco = 5
local chancepelle = 5
local display = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() -- tosse

    while true do
		Citizen.Wait(3600000)

    local chanceill = math.random(1, 100)

        if chanceill <= chance and not ill and not stomaco and not pelle then 
            display = true
            ill = true 
            TriggerServerEvent('esx_malattie:malato')
            TriggerEvent('logo:display', true)
            TriggerEvent('mt:missiontext', 'Hai una brutta ~r~ tosse. ~w~ Prendi lo sciroppo dai medici.', 10000)
        end
    end
end)

Citizen.CreateThread(function() -- stomaco

  while true do
  Citizen.Wait(5400000)

  local chanceillstomaco = math.random(1, 120)

      if chanceillstomaco <= chancestomaco and not ill and not stomaco and not pelle then 
          display = true
          stomaco = true 
          TriggerServerEvent('esx_malattie:malatostomaco')
          TriggerEvent('logo:display', true)
          TriggerEvent('mt:missiontext', 'Hai l\'~r~ influenza intestinale. ~w~ Prendi l\'antibiotico dai medici.', 10000)
      end
  end
end)

Citizen.CreateThread(function() -- pelle

  while true do
  Citizen.Wait(3600000)

  local chanceillpelle = math.random(1, 120)
  local playerPed = PlayerPedId()

      if chanceillpelle <= chancepelle and not ill and not stomaco and not pelle then 
          display = true
          pelle = true 
          TriggerServerEvent('esx_malattie:malatopelle')
          TriggerEvent('logo:display', true)
          TriggerEvent('mt:missiontext', 'Hai la~r~ rosacea. ~w~ Prendi la pomata per la rosacea dai medici.', 10000)
          SetPedHeadOverlay(playerPed, 5,	26, (3 / 10) + 0.0)
          SetPedHeadOverlayColor(playerPed, 5, 2,	0)	
          SetPedHeadOverlay(playerPed, 7,	9,	(10 / 10) + 0.0)
      end
  end
end)

Citizen.CreateThread(function() -- tosse

  while true do

    local chansatthosta = math.random(30000, 60000)

	  Citizen.Wait(chansatthosta)

    if ill then

	    RequestAnimDict("timetable@gardener@smoking_joint")
      while not HasAnimDictLoaded("timetable@gardener@smoking_joint") do
      Citizen.Wait(100)
      end

      TaskPlayAnim(GetPlayerPed(-1), "timetable@gardener@smoking_joint", "idle_cough", 8.0, 8.0, -1, 50, 0, false, false, false)
      Citizen.Wait(3000)
      ClearPedSecondaryTask(GetPlayerPed(-1))
      --TriggerEvent('mt:missiontext', 'Hai una brutta ~r~ tosse. ~w~ Prendi lo sciroppo dai medici.', 10000)
    end
  end
end)

Citizen.CreateThread(function()  --vomito

  while true do

    local chansatthostastomaco = math.random(900000, 1200000)
    local playerPed = GetPlayerPed(-1)
    local maxHealth = GetEntityMaxHealth(playerPed)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health - maxHealth/19))

	  Citizen.Wait(chansatthostastomaco)

    if stomaco then

	    RequestAnimDict("oddjobs@taxi@tie")
      while not HasAnimDictLoaded("oddjobs@taxi@tie") do
      Citizen.Wait(100)
      end

      TaskPlayAnim(GetPlayerPed(-1), "oddjobs@taxi@tie", "vomit_outside", 8.0, 8.0, -1, 50, 0, false, false, false)
      Citizen.Wait(7000)

      ClearPedSecondaryTask(GetPlayerPed(-1))
      SetEntityHealth(playerPed, newHealth)
    end
  end
end)

Citizen.CreateThread(function() -- rosacea

  while true do

    local chansatthostapelle = 60000
    local playerPed = GetPlayerPed(-1)

	  Citizen.Wait(chansatthostapelle)

    if pelle then
      SetPedHeadOverlay(playerPed, 5,	26, (3 / 10) + 0.0)	
      SetPedHeadOverlayColor(playerPed, 5, 2,	0)	
      SetPedHeadOverlay(playerPed, 7,	10,	(10 / 10) + 0.0)
    end
  end
end)

RegisterNetEvent('esx_malattie:guarigionetosse')
AddEventHandler('esx_malattie:guarigionetosse', function()

  ill = false
  display = false

  Citizen.Wait(3000)

  TriggerServerEvent('esx_malattie:guarito')
  TriggerEvent('logo:display', false)
  TriggerEvent('mt:missiontext', '~g~ Non hai più la tosse!', 10000)
  
end)

RegisterNetEvent('esx_malattie:guarigionestomaco')
AddEventHandler('esx_malattie:guarigionestomaco', function()

  stomaco = false
  display = false
  local playerPed  = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

  RequestAnimDict("mp_suicide")
  while not HasAnimDictLoaded("mp_suicide") do
  Citizen.Wait(100)
  end

  TaskPlayAnim(GetPlayerPed(-1), "mp_suicide", "pill_fp", 8.0, 8.0, -1, 50, 0, false, false, false)
  Citizen.Wait(3000)
  ClearPedSecondaryTask(GetPlayerPed(-1))
  TriggerServerEvent('esx_malattie:guaritostomaco')
  TriggerEvent('logo:display', false)
  TriggerEvent('mt:missiontext', '~g~ Non hai più l\'influenza intestinale', 10000)
  SetEntityHealth(playerPed, maxHealth)
  
end)

RegisterNetEvent('esx_malattie:guarigionepelle')
AddEventHandler('esx_malattie:guarigionepelle', function()

  pelle = false
  display = false
  local playerPed  = GetPlayerPed(-1)
  --local maxHealth = GetEntityMaxHealth(playerPed)

  RequestAnimDict("mp_suicide")
  while not HasAnimDictLoaded("mp_suicide") do
  Citizen.Wait(100)
  end

  TaskPlayAnim(GetPlayerPed(-1), "mp_suicide", "pill_fp", 8.0, 8.0, -1, 50, 0, false, false, false)
  Citizen.Wait(3000)
  ClearPedSecondaryTask(GetPlayerPed(-1))
  TriggerServerEvent('esx_malattie:guaritopelle')
  TriggerEvent('logo:display', false)
  TriggerEvent('mt:missiontext', '~g~ Non hai più la rosacea', 10000)
  --SetEntityHealth(playerPed, maxHealth)
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
    TriggerEvent('skinchanger:loadSkin', skin)
  end)
  
end)

AddEventHandler('playerSpawned', function()
	ESX.TriggerServerCallback('esx_malattie:quadroclinico', function(malato)
    if malato == 'no' then
      display = false
      ill = false
      TriggerServerEvent('esx_malattie:guarito')
      TriggerEvent('logo:display', false)
    elseif malato == 'si' then
      ill = true
      display = true
      TriggerServerEvent('esx_malattie:malato')
      TriggerEvent('logo:display', true)
      TriggerEvent('mt:missiontext', 'Hai una brutta ~r~ tosse. ~w~ Prendi lo sciroppo dai medici.', 10000)
		end
  end)
  ESX.TriggerServerCallback('esx_malattie:quadroclinicostomaco', function(malatostomaco)
    if malatostomaco == 'no' then
      display = false
      stomaco = false
      TriggerServerEvent('esx_malattie:guaritostomaco')
      TriggerEvent('logo:display', false)
    elseif malatostomaco == 'si' then
      stomaco = true
      display = true
      TriggerServerEvent('esx_malattie:malatostomaco')
      TriggerEvent('logo:display', true)
      TriggerEvent('mt:missiontext', 'Hai l\'~r~ influenza intestinale. ~w~ Prendi l\'antibiotico dai medici.', 10000)
		end
  end)
  ESX.TriggerServerCallback('esx_malattie:quadroclinicopelle', function(malatopelle)
    if malatopelle == 'no' then
      display = false
      pelle = false
      TriggerServerEvent('esx_malattie:guaritopelle')
      TriggerEvent('logo:display', false)
    elseif malatopelle == 'si' then
      local playerPed = PlayerPedId()
      pelle = true
      display = true
      TriggerServerEvent('esx_malattie:malatopelle')
      TriggerEvent('logo:display', true)
      TriggerEvent('mt:missiontext', 'Hai la~r~ rosacea. ~w~ Prendi la pomata dai medici.', 10000)
		end
	end)
end)

RegisterNetEvent('logo:display')
AddEventHandler('logo:display', function(value)
  SendNUIMessage({
    type = "logo",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end


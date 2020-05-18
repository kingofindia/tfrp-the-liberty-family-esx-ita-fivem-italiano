local PlayerData              = {}

ESX                         = nil

inMenu                      = true
local cJ = false
local eJE = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  Citizen.Wait(5000)
  PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 168) and PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'fbi' or PlayerData.job.name == 'sceriffo') then
			inMenu = true
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openGeneral'})
		end
        
    if IsControlJustPressed(1, 322) then
	  inMenu = false
      SetNuiFocus(false, false)
      SendNUIMessage({type = 'close'})
    end
    end
end)

RegisterNUICallback('cella1', function(data)
	TriggerServerEvent('jail:cella1', data.achi, data.minutini)
end)                                                                                               

RegisterNetEvent("JP1")
AddEventHandler("JP1", function(minutini)
  if cJ == true then
    return
  end
  local pP = GetPlayerPed(-1)
  if DoesEntityExist(pP) then
    
    Citizen.CreateThread(function()
      local playerOldLoc = GetEntityCoords(pP, true)
      SetEntityCoords(pP, 459.5500793457, -994.46508789063, 23.914855957031)
      cJ = true
      eJE = false
      while minutini > 0 and not eJE do
        pP = GetPlayerPed(-1)
        RemoveAllPedWeapons(pP, true)
        SetEntityInvincible(pP, false)
        if IsPedInAnyVehicle(pP, false) then
          ClearPedTasksImmediately(pP)
        end
        if minutini % 60 == 0 then
          jTmin = minutini / 60
          exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "Hai ancora " .. jTmin .. " minuti prima del rilascio." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          TriggerServerEvent('updateJailTime', jTmin)
        end
        Citizen.Wait(500)
        local pL = GetEntityCoords(pP, true)
        local D = Vdist(459.5500793457, -994.46508789063, 23.914855957031, pL['x'], pL['y'], pL['z'])
        if D > 2 then
          SetEntityCoords(pP, 459.5500793457, -994.46508789063, 23.914855957031)
          if D > 4 then
            minutini = minutini + 60
            if minutini > 1500 then
              minutini = 1500
            end
            exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "La tua pena è stata aumentata per un tentativo di fuga, o per esserti disconnesso o per aver effettuato il respawn." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          end
        end
        minutini = minutini - 0.5
      end
      TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." è stato scagionato.")
      TriggerServerEvent('unjailPlayer')
      SetEntityCoords(pP, 489.98, -1019.59, 28.07)
      cJ = false
      SetEntityInvincible(pP, false)
    end)
  end
end)

RegisterNUICallback('cella2l', function(data)
	TriggerServerEvent('jail:cella2', data.achidue, data.minutinidue)
end)

RegisterNetEvent("JP2")
AddEventHandler("JP2", function(minutinidue)
  if cJ == true then
    return
  end
  local pP = GetPlayerPed(-1)
  if DoesEntityExist(pP) then
    
    Citizen.CreateThread(function()
      local playerOldLoc = GetEntityCoords(pP, true)
      SetEntityCoords(pP, 458.41693115234, -997.93572998047, 23.914854049683)
      cJ = true
      eJE = false
      while minutinidue > 0 and not eJE do
        pP = GetPlayerPed(-1)
        RemoveAllPedWeapons(pP, true)
        SetEntityInvincible(pP, false)
        if IsPedInAnyVehicle(pP, false) then
          ClearPedTasksImmediately(pP)
        end
        if minutinidue % 60 == 0 then
          jTmin = minutinidue / 60
          exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "Hai ancora " .. jTmin .. " minuti prima del rilascio." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          TriggerServerEvent('updateJailTime', jTmin)
        end
        Citizen.Wait(500)
        local pL = GetEntityCoords(pP, true)
        local D = Vdist(458.41693115234, -997.93572998047, 23.914854049683, pL['x'], pL['y'], pL['z'])
        if D > 2 then
          SetEntityCoords(pP, 458.41693115234, -997.93572998047, 23.914854049683)
          if D > 4 then
            minutinidue = minutinidue + 60
            if minutinidue > 1500 then
              minutinidue = 1500
            end
            exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "La tua pena è stata aumentata per un tentativo di fuga, o per esserti disconnesso o per aver effettuato il respawn." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          end
        end
        minutinidue = minutinidue - 0.5
      end
      TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." è stato scagionato.")
      TriggerServerEvent('unjailPlayer')
      SetEntityCoords(pP, 489.98, -1019.59, 28.07)
      cJ = false
      SetEntityInvincible(pP, false)
    end)
  end
end)

RegisterNUICallback('fermo', function(data)
  TriggerServerEvent('jail:fermo', data.achitre, data.minutinitre)
  
end)

RegisterNetEvent("JP3")
AddEventHandler("JP3", function(minutinitre) 
  if cJ == true then
    return
  end
  local pP = GetPlayerPed(-1)
  if DoesEntityExist(pP) then
    
    Citizen.CreateThread(function()
      local playerOldLoc = GetEntityCoords(pP, true)
      SetEntityCoords(pP, 458.29275512695, -1001.5576782227, 23.914852142334)
      cJ = true
      eJE = false
      while minutinitre > 0 and not eJE do
        pP = GetPlayerPed(-1)
        RemoveAllPedWeapons(pP, true)
        SetEntityInvincible(pP, false)
        if IsPedInAnyVehicle(pP, false) then
          ClearPedTasksImmediately(pP)
        end
        if minutinitre % 60 == 0 then
          jTmin = minutinitre / 60
          exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "Hai ancora " .. jTmin .. " minuti prima del rilascio." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          TriggerServerEvent('updateJailTime', jTmin)
        end
        Citizen.Wait(500)
        local pL = GetEntityCoords(pP, true) 
        local D = Vdist(458.29275512695, -1001.5576782227, 23.914852142334, pL['x'], pL['y'], pL['z'])
        if D > 2 then
          SetEntityCoords(pP, 458.29275512695, -1001.5576782227, 23.914852142334)
          if D > 4 then
            minutinitre = minutinitre + 60
            if minutinitre > 1500 then
              minutinitre = 1500
            end
            exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "La tua pena è stata aumentata per un tentativo di fuga, o per esserti disconnesso o per aver effettuato il respawn." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          end
        end
        minutinitre = minutinitre - 0.5
      end
      TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." è stato scagionato.")
      TriggerServerEvent('unjailPlayer')
      SetEntityCoords(pP, 489.98, -1019.59, 28.07)
      cJ = false
      SetEntityInvincible(pP, false)
    end)
  end
end)

RegisterNUICallback('carcere', function(data)
	TriggerServerEvent('jail:carcere', data.to, data.amountt)
	
end)

RegisterNetEvent("JP")
AddEventHandler("JP", function(amountt)
  if cJ == true then
    return
  end
  local pP = GetPlayerPed(-1)
  if DoesEntityExist(pP) then
    
    Citizen.CreateThread(function()
      local playerOldLoc = GetEntityCoords(pP, true)
      
      TriggerEvent('skinchanger:getSkin', function(skin)
  
        if skin.sex == 0 then

          local clothesSkin = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 146, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 3, ['pants_2'] = 7,
            ['shoes_1'] = 12, ['shoes_2'] = 12,
            ['chain_1'] = 50, ['chain_2'] = 0
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

        else

          local clothesSkin = {
            ['tshirt_1'] = 3, ['tshirt_2'] = 0,
            ['torso_1'] = 38, ['torso_2'] = 3,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 2,
            ['pants_1'] = 3, ['pants_2'] = 15,
            ['shoes_1'] = 66, ['shoes_2'] = 5,
            ['chain_1'] = 0, ['chain_2'] = 2
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

        end

        local playerPed = GetPlayerPed(-1)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
        ResetPedMovementClipset(playerPed, 0)
      end)  
      
      
      SetEntityCoords(pP, 1798.4055175781, 2483.2380371094, -123.70260620117)
      cJ = true
      eJE = false
      while amountt > 0 and not eJE do
        pP = GetPlayerPed(-1)
        RemoveAllPedWeapons(pP, true)
        SetEntityInvincible(pP, false)
        if IsPedInAnyVehicle(pP, false) then
          ClearPedTasksImmediately(pP)
        end
        if amountt % 60 == 0 then
          jTmin = amountt / 60
          exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "Hai ancora " .. jTmin .. " minuti prima del rilascio." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          TriggerServerEvent('updateJailTime', jTmin)
        end
        Citizen.Wait(500)
        local pL = GetEntityCoords(pP, true)
        local D = Vdist(1798.4055175781, 2483.2380371094, -123.70260620117, pL['x'], pL['y'], pL['z'])
        if D > 150 then
          SetEntityCoords(pP, 1798.4055175781, 2483.2380371094, -123.70260620117)
          if D > 90 then
            amountt = amountt + 60
            if amountt > 1500 then
              amountt = 1500
            end
            exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "La tua pena è stata aumentata per un tentativo di fuga, o per esserti disconnesso o per aver effettuato il respawn." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          
          end
        end
        amountt = amountt - 0.5
      end
      TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." è stato scarcerato.")
      TriggerServerEvent('unjailPlayer')
      SetEntityCoords(pP, 489.98, -1019.59, 28.07)
      cJ = false
      SetEntityInvincible(pP, false)
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
      end)
    end)
  end
end)

RegisterNUICallback('multa', function(data)
  TriggerServerEvent('jail:multa', data.multato, data.multone)
  
end)

RegisterNUICallback('cortile', function(data)
  TriggerServerEvent('jail:cortile', data.pl, data.tempo)
  
end)

RegisterNetEvent("JPC")
AddEventHandler("JPC", function(tempo)
  if cJ == true then
    return
  end
  local pP = GetPlayerPed(-1)
  if DoesEntityExist(pP) then
    
    Citizen.CreateThread(function()
      local playerOldLoc = GetEntityCoords(pP, true)
      
      TriggerEvent('skinchanger:getSkin', function(skin)
  
        if skin.sex == 0 then

          local clothesSkin = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 146, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 3, ['pants_2'] = 7,
            ['shoes_1'] = 12, ['shoes_2'] = 12,
            ['chain_1'] = 50, ['chain_2'] = 0
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

        else

          local clothesSkin = {
            ['tshirt_1'] = 3, ['tshirt_2'] = 0,
            ['torso_1'] = 38, ['torso_2'] = 3,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 2,
            ['pants_1'] = 3, ['pants_2'] = 15,
            ['shoes_1'] = 66, ['shoes_2'] = 5,
            ['chain_1'] = 0, ['chain_2'] = 2
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

        end

        local playerPed = GetPlayerPed(-1)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
        ResetPedMovementClipset(playerPed, 0)
      end)  
      
      
      SetEntityCoords(pP, 1680.026, 2512.73, 45.565) 
      cJ = true
      eJE = false
      while tempo > 0 and not eJE do
        pP = GetPlayerPed(-1)
        RemoveAllPedWeapons(pP, true)
        SetEntityInvincible(pP, false)
        if IsPedInAnyVehicle(pP, false) then
          ClearPedTasksImmediately(pP)
        end
        if tempo % 60 == 0 then
          jTmin = tempo / 60
          exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "Hai ancora " .. jTmin .. " minuti prima del rilascio." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          TriggerServerEvent('updateJailTime', jTmin)
        end
        Citizen.Wait(500)
        local pL = GetEntityCoords(pP, true)
        local D = Vdist(1680.026, 2512.73, 45.565, pL['x'], pL['y'], pL['z'])
        if D > 150 then
          SetEntityCoords(pP, 1680.026, 2512.73, 45.565)
          if D > 90 then
            tempo = tempo + 60
            if tempo > 1500 then
              tempo = 1500
            end
            exports.pNotify:SetQueueMax("left", 1)
              exports.pNotify:SendNotification({
                  text = "La tua pena è stata aumentata per un tentativo di fuga, o per esserti disconnesso o per aver effettuato il respawn." ,
                  type = "error",
                  timeout = math.random(1000, 10000),
                  layout = "centerLeft",
                  queue = "left"
              })
          
          end
        end
        tempo = tempo - 0.5
      end
      TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." è stato scarcerato.")
      TriggerServerEvent('unjailPlayer')
      SetEntityCoords(pP, 1855.807, 2601.949, 45.323)
      cJ = false
      SetEntityInvincible(pP, false)
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
      end)
    end)
  end
end)

Citizen.CreateThread(function()
  while true do
    
    local sleepThread = 500

    local Packages = Config.PrisonWork["Packages"]

    local Ped = PlayerPedId()
    local PedCoords = GetEntityCoords(Ped)

    for posId, v in pairs(Packages) do

      local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

      if DistanceCheck <= 1.0 then

        sleepThread = 5

        DisplayHelpText('Premi E per prendere il pacco')


        if not v["state"] then
          DisplayHelpText('Già preso')
        end

        --ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)
        --DisplayHelpText('Pacco')

        if DistanceCheck <= 1.5 then

          if IsControlJustPressed(0, 38) then

            if v["state"] then
              ESX.ShowNotification("Una volta preparato, porta il pacco verso il punto di consegna (blip verde)")
              PackPackage(posId)
            else
              ESX.ShowNotification("Hai già preso questo pacco")
            end

          end

        end

      end

    end

    Citizen.Wait(sleepThread)

  end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Annullato!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Preparazione pacco... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Lascia il pacco", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("esx_jailsystem:prisonWorkReward")
				end
			end
		end

	end

end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1605.011, 2564.178, 45.857, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1616.531, 2530.406, 45.857, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1605.004, 2543.215, 45.856, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1621.929, 2502.811, 45.857, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1638.077, 2489.473, 45.856, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1655.492, 2490.116, 45.854, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1669.663, 2487.809, 45.825, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1682.468, 2476.271, 45.825, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1703.293, 2476.236, 45.825, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1716.217, 2487.791, 45.826, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 128, 255, 100, 0, 0, 0, 0)	
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DrawMarker(28, 1598.174, 2553.932, 45.613, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 100, 0, 0, 0, 0)	
  end
end)

RegisterNUICallback('libera', function(data)
  TriggerServerEvent('jail:libera', data.achiquattro)
  
end)

RegisterNetEvent("UnJP")
AddEventHandler("UnJP", function()
  eJE = true
  TriggerServerEvent('unjailPlayer')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
end)

RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false, false)
  SendNUIMessage({type = 'closeAll'})
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

AddEventHandler('playerSpawned', function()
  TriggerServerEvent('checkIfIsJailed')
end)
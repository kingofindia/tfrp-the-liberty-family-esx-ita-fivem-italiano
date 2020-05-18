ESX               = nil

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

local isRunningWorkaround = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function StartWorkaroundTask()
	if isRunningWorkaround then
		return
	end

	local timer = 0
	local playerPed = PlayerPedId()
	isRunningWorkaround = true

	while timer < 100 do
		Citizen.Wait(0)
		timer = timer + 1

		local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

		if DoesEntityExist(vehicle) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 2 then
				ClearPedTasks(playerPed)
			end
		end
	end

	isRunningWorkaround = false
end

function ToggleVehicleLock()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle

	Citizen.CreateThread(function()
		StartWorkaroundTask()
	end)

	if IsPedInAnyVehicle(playerPed) then
		vehicle = GetVehiclePedIsIn(playerPed, false)

	if not DoesEntityExist(vehicle) then
		return
	end

	ESX.TriggerServerCallback('esx_vehiclelock:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 1 then -- unlocked
				SetVehicleDoorsLocked(vehicle, 2)
				SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'lock', 0.4)
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = false,
					args = {"", "Veicolo bloccato!"}
				  })
				--TriggerEvent('chat:addMessage', "Veicolo bloccato", vehicle, 2000)
			elseif lockStatus == 2 then -- locked
				SetVehicleDoorsLocked(vehicle, 1)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'unlock', 0.4)
				--TriggerEvent('chat:addMessage', "Veicolo sbloccato", vehicle, 2000)
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = false,
					args = {"", "Veicolo sbloccato!"}
				  })
			end
		else
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = false,
				args = {"", "Questo veicolo non è tuo!"}
			  })
          --TriggerEvent('chat:addMessage', "Questo veicolo non è tuo", vehicle, 2000)
        end

	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
	
	else
		local coords    = GetEntityCoords(playerPed)
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 4.0) then
		vehicle = GetClosestVehicle(coords, 8.0, 0, 70)
		
	if not DoesEntityExist(vehicle) then
		return
	end

	ESX.TriggerServerCallback('esx_vehiclelock:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 1 then -- unlocked
				SetVehicleDoorsLocked(vehicle, 2)
				SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
				
				loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, -8, -1, 49, 0, 0, 0, 0)
				
				Wait(600)
				TriggerEvent('lockLights')
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'lockunlock', 0.2)
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = false,
					args = {"", "Veicolo bloccato"}
				  })
				--TriggerEvent('chat:addMessage', "Veicolo bloccato", vehicle, 2000)
				Wait(500)              
                ClearPedTasks(GetPlayerPed(-1))
			elseif lockStatus == 2 then -- locked
				SetVehicleDoorsLocked(vehicle, 1)
				
				loadAnimDict("anim@mp_player_intmenu@key_fob@")
                TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, -8, -1, 49, 0, 0, 0, 0)
				
				Wait(600)
				TriggerEvent('lockLights')
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'lockunlock', 0.2)
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = false,
					args = {"", "Veicolo sbloccato"}
				  })
				--TriggerEvent('chat:addMessage', "Veicolo sbloccato", vehicle, 2000)
				Wait(500)
                ClearPedTasks(GetPlayerPed(-1))
			end
		else
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = false,
				args = {"", "Questo veicolo non è tuo!"}
			  })
          --TriggerEvent('chat:addMessage', "Questo veicolo non è tuo.", vehicle, 2000)
        end

	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
	end
	end
end

RegisterNetEvent('lockLights')
AddEventHandler('lockLights',function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
		vehicle = GetClosestVehicle(coords, 8.0, 0, 70)
		
    SetVehicleLights(vehicle, 2)
    Wait (100)
    SetVehicleLights(vehicle, 0)
    Wait (100)
    SetVehicleLights(vehicle, 2)
    Wait (100)
    SetVehicleLights(vehicle, 0)
	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['M']) and IsInputDisabled(0) then
			ToggleVehicleLock()
			Citizen.Wait(300)
	
		-- D-pad down on controllers works, too!
		elseif IsControlJustReleased(0, 244) and not IsInputDisabled(0) then
			ToggleVehicleLock()
			Citizen.Wait(300)
		end
	end
end)

---- Piece of code from Scott's InteractSound script : https://forum.fivem.net/t/release-play-custom-sounds-for-interactions/8282
-- I've decided to use only one part of its script so that administrators don't have to download more scripts. I hope you won't forget to thank him!
RegisterNetEvent('InteractSound_CL:PlayWithinDistance')
AddEventHandler('InteractSound_CL:PlayWithinDistance', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Fix RAM leaks by collecting garbage

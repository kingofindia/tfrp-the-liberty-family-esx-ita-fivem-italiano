Keys = {
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

local FirstSpawn, PlayerLoaded = true, false

IsDead = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('playerSpawned', function()
	IsDead = false

	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end

				ESX.ShowNotification(_U('combatlog_message'))
				RemoveItemsAfterRPDeath()
			end
		end)
	end
end)

-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if IsDead then
			DisableAllControlActions(0)
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
			EnableControlAction(0, Keys['TOP'], true)
			EnableControlAction(0, Keys['DOWN'], true)
			EnableControlAction(0, Keys['ENTER'], true)
		else
			Citizen.Wait(500)
		end
	end
end)

function OnPlayerDeath()
	IsDead = true
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)

	StartDeathTimer()

	StartScreenEffect('DeathFailOut', 0, false)

end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(100)
			end

			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(100)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)

----------------------------- ADVANCED 911 SYSTEM

function AmbMex()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)

	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'EMS',
	}, function (data2, menu)
		Testo = tostring(data2.value)
		if Testo == nil then
			ESX.ShowNotification('Messaggio non valido')
		else
			menu.close()
			ESX.TriggerServerCallback('esx_ambulancejob:contamedici', function(EmsConnected)
				if EmsConnected == 0 then
					ESX.ShowNotification('Non ci sono unità mediche disponibili')
				else

          TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', Testo, PlayerCoords, {

		      PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
			    })
					ESX.ShowNotification('Messaggio inviato alle unità mediche disponibili')
				end
			end)
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

function PolMex()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)

	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
		title = 'LSPD',
	}, function (data2, menu)
		Testo2 = tostring(data2.value)
		if Testo2 == nil then
			ESX.ShowNotification('Messaggio non valido')
		else
			menu.close()
      ESX.TriggerServerCallback('esx_ambulancejob:contapoliziotti', function(CopsConnected)
				if CopsConnected == 0 then
					ESX.ShowNotification('Non ci sono pattuglie disponibili')
				else
          TriggerServerEvent('esx_addons_gcphone:startCall', 'police', Testo2, PlayerCoords, {

		      PlayerCoords2 = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
			    })
					ESX.ShowNotification('Messaggio inviato alle pattuglie disponibili')
				end
			end)
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

function emergenza()
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), '911_system',
			{
				title    = '911 - Scegli il servizio di emergenza',
				elements = {
					{label = 'LSPD', value = 'lspd'},
					{label = 'EMS', value = 'ems'},
				}
			},
			function(data, menu)
				local val = data.current.value
				
				if val == 'lspd' then
				      menu.close()
							PolMex()
				elseif val == 'ems' then
				      menu.close()
							AmbMex()
				end
			end,
			function(data, menu)
				menu.close()
			end
		)
	end

RegisterCommand("911",function(source, args)
	local playerPed = PlayerPedId()

	if IsPedDeadOrDying(playerPed) then
		emergenza()
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 25, "emergenza", 0.3)
	else
		ESX.ShowNotification('Questo sistema di emergenza può essere usato solo in casi gravi, utilizza il cellulare!')
	end
end, false)

------------------------------------------------------------- ADVANCED 911 SYSTEM

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			--if not Config.EarlyRespawnFine then
				--text = text .. _U('respawn_bleedout_prompt')

				--if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					--RemoveItemsAfterRPDeath()
					--break
				--end
			--elseif Config.EarlyRespawnFine and canPayFine then
				--text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				--if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					--TriggerServerEvent('esx_ambulancejob:payFine')
					--RemoveItemsAfterRPDeath()
					--break
				--end
			--end

			--if IsControlPressed(0, Keys['E']) then
				--timeHeld = timeHeld + 1
			--else
				--timeHeld = 0
			--end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
			
		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			RespawnPed(PlayerPedId(), Config.Zones.HospitalInteriorInside1.Pos)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

function RespawnPed(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

function RespawnPed2(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	--ClearPedBloodDamage(ped)
	Citizen.Wait(2000)
	SetEntityHealth(ped, 100)

	ESX.UI.Menu.CloseAll()
end

function TeleportFadeEffect(entity, coords)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(1)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)
	end)
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name		= 'Ambulance',
		number		= 'ambulance',
		base64Icon	= 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(reason)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		RespawnPed2(playerPed, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

RegisterNetEvent('esx_ambulancejob:revivecomm')
AddEventHandler('esx_ambulancejob:revivecomm', function()
	local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		RespawnPed(playerPed, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function piastacazzodemacchina()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'prendi_veicolo',
	  {
		  title    = 'Elicottero',
		  elements = {
			  {label = 'Elicottero', value = 'uno'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
			if val == 'uno' then
			menu.close()
			TriggerEvent('esx:spawnVehicle', "supervolito")
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
  end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then --and ESX.PlayerData.job.grade_name == 'banker' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, -458.198, -288.29, 78.168, true) < 20.0 then
					DrawMarker(34, -458.198, -288.29, 78.168, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 0, 127, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, -458.198, -288.29, 78.168, true) < 1.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per prendere l\'elicottero.')
					if IsControlJustReleased(1, 51) then
						piastacazzodemacchina()
					end
			    end
		    end
		
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then --and ESX.PlayerData.job.grade_name == 'banker' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, -449.78, -306.821, 78.168, true) < 20.0 then
					DrawMarker(34, -449.78, -306.821, 78.168, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, -449.78, -306.821, 78.168, true) < 5.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per eliminare l\'elicottero.')
					if IsControlJustReleased(1, 51) then
						if IsPedInAnyVehicle(playerPed, false) then
							local vehicle, distance = ESX.Game.GetClosestVehicle({
								x = coords.x,
								y = coords.y,
								z = coords.z
							})
				
							if distance ~= -1 and distance <= 1.0 then
								ESX.Game.DeleteVehicle(vehicle)
							end
						end
					end
			    end
		    end
		
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then --and ESX.PlayerData.job.grade_name == 'banker' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 351.964, -589.006, 74.166, true) < 20.0 then
					DrawMarker(34, 351.964, -589.006, 74.166, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 0, 127, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 351.964, -589.006, 74.166, true) < 1.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per prendere l\'elicottero.')
					if IsControlJustReleased(1, 51) then
						piastacazzodemacchina()
					end
			    end
		    end
		
		end
	end
end)

---------------------------------------- Gruppo Sanguigno
Citizen.CreateThread(function ()
	Wait(10000)
	TriggerServerEvent('esx_ambulancejob:creaGruppo')
end)
---------------------------------------------------------
-----------------------------------------Donazione

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

hadonato = false
animDict3 = 'missfbi5ig_0'
animName3 = 'lyinginpain_loop_steve'

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, -465.859, -373.628, -186.476, true) < 20.0 and hadonato == false then
					--DrawMarker(27, -465.859, -373.628, -187.476, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 5.0, 102, 0, 102, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, -465.859, -373.628, -186.476, true) < 1.0 then
					DrawText3D(-465.459, -373.628, -185.9990, '[~g~E~s~] Dona sangue', 0.5)
					if IsControlJustReleased(1, 51) then
							SetEntityCoords(playerPed, -465.68000000, -373.52000000, -186.94000000, 1, 1, 0, 0)
							SetEntityHeading(playerPed, 90.0)
							--SetEntityHeading(GetPlayerPed(-1), v.heading)
							RequestAnimDict('anim@gangops@morgue@table@')
    						while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        					Citizen.Wait(1)
    						end
    					TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )
							--TaskPlayAnim(playerPed, animDict3, animName3, 8.0, 1.0, -1, 45, 1.0, -465.68000000, -373.52000000, -186.94000000)
						ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
							if account == 'A+' or account == 'A-' or account == 'B+' or account == 'B-' or account == 'AB+' or account == 'AB-' or account == '0+' or account == '0-' then
								FreezeEntityPosition(playerPed, true)
								hadonato = true
								SendNUIMessage({
									setDisplay = true
				
								})
								Citizen.Wait(30000)
								SendNUIMessage({
									setDisplay = false
				
								})
								ClearPedTasks(PlayerPedId())
						    TriggerServerEvent('esx_ambulancejob:donazione')
								FreezeEntityPosition(playerPed, false)
								Citizen.Wait(300000)
								hadonato = false
							end
						end)
					end
			  end
		  end
	end
end)
------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- Inventario

function ApriInventario()

	local elements = {
		{label = 'Prendi oggetto',  value = 'get_stock'},
		{label = 'Deposita oggetto', value = 'put_stock'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	{
		title    = 'Inventario',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()

	end)

end

function OpenGetStocksMenu()

ESX.TriggerServerCallback('esx_ambulancejob:getStockItems', function(items)


	local elements = {}

	for i=1, #items, 1 do
		table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
	{
		title    = 'Inventario Medici',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		local itemName = data.current.value

		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
			title = 'Quantità'
		}, function(data2, menu2)

			local count = tonumber(data2.value)

			if count == nil then
				ESX.ShowNotification('Quantità non valida')
			else
				menu2.close()
				menu.close()
				TriggerServerEvent('esx_ambulancejob:getStockItem', itemName, count)

				Citizen.Wait(300)
				OpenGetStocksMenu()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

	end, function(data, menu)
		menu.close()
	end)

end)

end

function OpenPutStocksMenu()

ESX.TriggerServerCallback('esx_ambulancejob:getPlayerInventory', function(inventory)

	local elements = {}

	for i=1, #inventory.items, 1 do
		local item = inventory.items[i]

		if item.count > 0 then
			table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
	{
		title    = 'Inventario Medici',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		local itemName = data.current.value

		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
			title = 'Quantità'
		}, function(data2, menu2)

			local count = tonumber(data2.value)

			if count == nil then
				ESX.ShowNotification('Quantità non valida')
			else
				menu2.close()
				menu.close()
				TriggerServerEvent('esx_ambulancejob:putStockItems', itemName, count)

				Citizen.Wait(300)
				OpenPutStocksMenu()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

	end, function(data, menu)
		menu.close()
	end)
end)

end

Citizen.CreateThread(function()
while true do

	Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		
		if GetDistanceBetweenCoords(coords, -464.563, -358.629, -186.489, true) < 10.0 and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
				DrawMarker(27, -464.563, -358.629, -187.489, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -464.563, -358.629, -186.489, true) < 1.0 then
				DisplayHelpText('Premi ~INPUT_PICKUP~ per aprire il menu inventario')
				if IsControlJustReleased(1, 51) then
					ApriInventario()
				end
				end
			end
end
end)

------------------------------------------------------------- uso sacche

RegisterNetEvent('esx_ambulancejob:curacompleta')
AddEventHandler('esx_ambulancejob:curacompleta', function()
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	Citizen.Wait(10000)
	SetEntityHealth(playerPed, maxHealth)
	FreezeEntityPosition(playerPed, false)
	ESX.ShowNotification('~g~ Cure completate')
end)

--[[ RegisterCommand("wipe",function(source, args)
	local playerPed = PlayerPedId()

	TriggerServerEvent('cancellatutto:porcodio')
	FreezeEntityPosition(playerPed, true)
end, false) ]]

RegisterNetEvent('esx_ambulancejob:saccasbagliata')
AddEventHandler('esx_ambulancejob:saccasbagliata', function()
	local playerPed = PlayerPedId()
	
	SetEntityHealth(playerPed, 0)
	ESX.ShowNotification('~r~ SACCA DI SANGUE ERRATA')
	Wait(3000)
	RemoveItemsAfterRPDeath()
	ESX.ShowNotification('~r~ Sei morto a causa di una trasfusione di sangue errata!')
	Wait(5000)
	TriggerServerEvent('cancellatutto:porcodio')
	FreezeEntityPosition(playerPed, true)

end)
RegisterNetEvent('esx_ambulancejob:controllausoo+')
AddEventHandler('esx_ambulancejob:controllausoo+', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'AB+' or account == 'A+' or account == 'B+' or account == '0+' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:controllausoa-')
AddEventHandler('esx_ambulancejob:controllausoa-', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'AB+' or account == 'A+' or account == 'AB-' or account == 'A-' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:controllausoa+')
AddEventHandler('esx_ambulancejob:controllausoa+', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'AB+' or account == 'A+' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:controllausob-')
AddEventHandler('esx_ambulancejob:controllausob-', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'AB+' or account == 'AB-' or account == 'B+' or account == 'B-' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:controllausob+')
AddEventHandler('esx_ambulancejob:controllausob+', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'B+' or account == 'AB+' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:controllausoab-')
AddEventHandler('esx_ambulancejob:controllausoab-', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'AB-' or account == 'AB+' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

RegisterNetEvent('esx_ambulancejob:controllausoab+')
AddEventHandler('esx_ambulancejob:controllausoab+', function()
	local playerPed = PlayerPedId()
	
	ESX.TriggerServerCallback('esx_ambulancejob:verifica', function(account)
		if account == 'AB+' then
			TriggerEvent('esx_ambulancejob:curacompleta')
		else
			TriggerEvent('esx_ambulancejob:saccasbagliata')
		end
	end)

end)

-- Lettini e barelle

local lettini = {
	{x=-448.56000000, y=-356.19990000, z=-186.94000000, heading = 0}, -- v_med_bed2
	{x=-451.31000000, y=-356.21380000, z=-186.94000000, heading = 0}, -- v_med_bed2
	{x=-448.56000000, y=-362.90000000, z=-186.95000000, heading = 180}, -- v_med_bed2
	{x=-451.91000000, y=-362.89000000, z=-186.96630000, heading = 180}, -- v_med_bed2 WHAT
	{x=-451.31000000, y=-345.84000000, z=-186.94000000, heading = 0}, -- v_med_bed2
	{x=-448.31000000, y=-345.84000000, z=-186.94000000, heading = 0}, -- v_med_bed2 	TEST
	{x=-448.56000000, y=-353.42000000, z=-186.94000000, heading = 180}, -- v_med_bed2
	{x=-451.91000000, y=-353.40000000, x=-186.94000000, heading = 0}, -- v_med_bed2
	{x=-451.90000000, y=-336.28000000, z=-186.94000000, heading = 0}, -- v_med_bed2		TESTED
	{x=-448.91000000, y=-336.27000000, z=-186.94000000, heading = 0}, -- v_med_bed2		TESTED
	{x=-448.81880000, y=-343.03490000, z=-186.94000000, heading = 180}, -- v_med_bed2   TESTED
	{x=-451.70730000, y=-343.01170000, z=-186.94000000, heading = 180}, -- v_med_bed2   TESTED
	{x=-454.02000000, y=-373.56500000, z=-186.96080000, heading = 0}, -- v_med_bed1
    {x=-455.42000000, y=-354.07000000, z=-186.95000000, heading = 0}, --V_Med_emptybed
	{x=-470.37160000, y=-367.91490000, z=-186.95000000, heading = 90}, --V_Med_emptybed
	{x=-473.10020000, y=-346.27690000, z=-186.94000000, heading = 0}, --V_Med_emptybed
	{x=-477.39680000, y=-376.49030000, z=-186.94000000, heading = 0}, --V_Med_emptybed
	{x=-477.38000000, y=-373.96000000, z=-186.94000000, heading = 0}, --V_Med_emptybed
	{x=-451.76300000, y=-353.37300000, z=-186.94000000, heading= 180},
	--[[ {x = 348.819, y = -596.286, z = 28.0, heading = 80.00},
	{x = 341.528, y = -574.488, z = 28.0, heading = 0.00},
	{x = 346.896, y = -576.222, z = 28.0, heading = 250.00},
	{x = 348.912, y = -571.266, z = 28.0, heading = 250.00},
	{x = 351.723, y = -568.584, z = 28.0, heading = 160.00},
	{x = 355.346, y = -569.717, z = 28.0, heading = 160.00},
	{x = 358.619, y = -570.928, z = 28.0, heading = 160.00},
	{x = 361.096, y = -564.828, z = 28.0, heading = 340.00},
	{x = 357.811, y = -563.411, z = 28.0, heading = 350.00},
	{x = 354.216, y = -562.274, z = 28.0, heading = 320.00},
	{x = 366.228, y = -568.109, z = 28.0, heading = 240.00},
	{x = 364.724, y = -572.091, z = 28.0, heading = 270.00},
	{x = 336.474, y = -574.727, z = 28.0, heading = 160.00},
	{x = 330.223, y = -572.287, z = 28.0, heading = 160.00},
	{x = 327.085, y = -562.893, z = 28.0, heading = 240.00},
	{x = 318.675, y = -572.619, z = 28.0, heading = 170.00},
	{x = 324.047, y = -576.948, z = 28.0, heading = 60.00},
	{x = 307.178, y = -574.221, z = 28.0, heading = 150.00},
	{x = 310.266, y = -575.197, z = 28.0, heading = 180.00},
	{x = 304.277, y = -572.645, z = 28.0, heading = 150.00},
	{x = 303.789, y = -567.624, z = 28.0, heading = 70.00}, ]]
	--{x=-465.68000000, y=-373.52000000, z=-186.94000000, heading= -90},
}

local inLettino = false
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'

function vicinoLettino()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(lettini) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3 then
			return true
		end
	end

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		lettinovicino = vicinoLettino()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if lettinovicino then
			for _, search in pairs(lettini) do

				local playerPed  = PlayerPedId()
				local coords     = GetEntityCoords(playerPed)

				if GetDistanceBetweenCoords(coords, search.x, search.y, search.z, true) < 2.0 and not inLettino then

					DrawText3D(search.x, search.y, search.z+1, '[~g~E~s~] Sdraiarti', 0.5)

					if IsControlJustPressed(0, Keys['E']) then

						if not HasAnimDictLoaded(animDict) then
							RequestAnimDict(animDict)
						end

						SetEntityCoords(playerPed, search.x, search.y, search.z, 1, 1, 0, 0)
						SetEntityHeading(playerPed, search.heading + 180.0)

						RequestAnimDict('anim@gangops@morgue@table@')
    					while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        					Citizen.Wait(1)
    					end
    					TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )

						inLettino = true
	
					end				
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if inLettino then
			DisplayHelpText("Premi ~INPUT_VEH_DUCK~ per scendere dal lettino ~b~")
			if IsControlJustReleased(0, Keys['X']) then
				inLettino = false
				ClearPedTasks(PlayerPedId())
			end
		end

	end
end)
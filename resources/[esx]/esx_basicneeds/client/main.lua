ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

RegisterNetEvent('esx_basicneeds:gotheal2')
AddEventHandler('esx_basicneeds:gotheal2', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

RegisterNetEvent('esx_basicneeds:gotheal')
AddEventHandler('esx_basicneeds:gotheal', function()
	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:bulletproof')
AddEventHandler('esx_basicneeds:bulletproof', function()
	local playerPed = GetPlayerPed(-1)

	SetPedComponentVariation(playerPed, 9, 27, 9, 2)
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)

RegisterNetEvent('esx_basicneeds:collana')
AddEventHandler('esx_basicneeds:collana', function()
	local playerPed = GetPlayerPed(-1)

	SetPedComponentVariation(playerPed, 7, 49, 1, 2)
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)

RegisterNetEvent('esx_basicneeds:vinodrugs')
AddEventHandler('esx_basicneeds:vinodrugs', function()
	local playerPed = GetPlayerPed(-1)

	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)

RegisterNetEvent('esx_basicneeds:oxygen_mask')
AddEventHandler('esx_basicneeds:oxygen_mask', function()
	local playerPed  = GetPlayerPed(-1)
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 12844)
	local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
	
	ESX.Game.SpawnObject('p_s_scuba_mask_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		ESX.Game.SpawnObject('p_s_scuba_tank_s', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object2)
			AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)
			
			ESX.ShowNotification('Ossigeno ~g~100 %.')
			Citizen.Wait(240000)
			ESX.ShowNotification('Ossigeno ~y~50 %.')
			Citizen.Wait(120000)
			ESX.ShowNotification('Ossigeno ~r~25 %.')
			Citizen.Wait(120000)
			ESX.ShowNotification('Ossigeno ~r~0 %.')
			
			SetPedDiesInWater(playerPed, true)
			DeleteObject(object)
			DeleteObject(object2)
			ClearPedSecondaryTask(playerPed)
		end)
	end)
end)

----------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:onEat2')
AddEventHandler('esx_basicneeds:onEat2', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_steak'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEat3')
AddEventHandler('esx_basicneeds:onEat3', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_hotdog_01'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEat4')
AddEventHandler('esx_basicneeds:onEat4', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_food_cb_nugets'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEat5')
AddEventHandler('esx_basicneeds:onEat5', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_candy_pqs'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onEat6')
AddEventHandler('esx_basicneeds:onEat6', function(prop_name)
	if not IsAnimated then
		RequestModel( GetHashKey( "a_c_fish" ) )--
        while ( not HasModelLoaded( GetHashKey( "a_c_fish" ) ) ) do--
        Citizen.Wait( 1 )--
        end--
		--local prop_name = prop_name or 'prop_candy_pqs'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			--prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			local prop = CreatePed(28, 0x2FD800B7, x, y, z+0.2, 304.335, true)
			SetEntityHealth(prop, 0)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeletePed(prop)
			--DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_extraitems:donut')
AddEventHandler('esx_extraitems:donut', function()
	local playerPed  = GetPlayerPed(-1)
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 18905)
	local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

	RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
	while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
		Citizen.Wait(1)
	end
	
	ESX.Game.SpawnObject('prop_donut_02', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
		AttachEntityToEntity(object, playerPed, boneIndex2, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
		TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
		Citizen.Wait(3000)
		TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
		Citizen.Wait(3000)
		TriggerEvent("InteractSound_CL:PlayOnOne", "mangiare", 1.0)
		Citizen.Wait(6500)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2, true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			TriggerEvent("InteractSound_CL:PlayOnOne", "bere", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink2')
AddEventHandler('esx_basicneeds:onDrink2', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_milk_01'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2, true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			TriggerEvent("InteractSound_CL:PlayOnOne", "bere", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('esx_basicneeds:onDrink3')
AddEventHandler('esx_basicneeds:onDrink3', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'ng_proc_sodacan_01b'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2, true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			TriggerEvent("InteractSound_CL:PlayOnOne", "bere", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

function drunk2()
	DoScreenFadeOut(1000)
	Citizen.Wait(500)
	TriggerEvent("esx:statusdrunkaf") -- Funktionen som gör dig dragen
	TriggerEvent("esx:statusdrunkaf")
	Citizen.Wait(500)
	DoScreenFadeIn(1000)
end
  
RegisterNetEvent('esx_basicneeds:onDrink4')
AddEventHandler('esx_basicneeds:onDrink4', function()
	
  local pP = GetPlayerPed(-1)
	
	TaskPlayAnim(pP, "amb@world_human_partying@female@partying_beer@base", "enter", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
	TriggerEvent("InteractSound_CL:PlayOnOne", "bere", 1.0)
	TaskStartScenarioInPlace(pP, "world_human_DRINKING", 0, true)
	Wait(3000)
	ESX.ShowNotification("Sei ubriaco")
	Wait(3000)
	drunk2()
	Wait(1000)
	ESX.ShowNotification("Premi \"X\" per smettere di bere")
  
end)

RegisterNetEvent('esx_basicneeds:sciroppo')
AddEventHandler('esx_basicneeds:sciroppo', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'ng_proc_drug01a002'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2, true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			TriggerEvent("InteractSound_CL:PlayOnOne", "bere", 1.0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------------------------

function MunPis()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo = tonumber(data2.value)
		local playerPed  = PlayerPedId()
        local weaponHash = GetHashKey("WEAPON_PISTOL")
        local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo + Testo)
		local fregatura = math.floor(250 - pedAmmo)
		
		ESX.TriggerServerCallback('esx_armeria:contrmpistol', function(pistolaQuantity)
		if Testo ~= nil and pistolaQuantity >= Testo and Testo <= 25 and pedAmmo < 250 and HasPedGotWeapon(PlayerPedId(), weaponHash, false) and Testo <= fregatura then
		    menu.close()
			SetPedAmmo(playerPed, weaponHash, finalAmmo)
			TriggerServerEvent('esx_armeria:toglimpistola', Testo)
		else
			menu.close()
			ESX.ShowNotification('Valore non valido')
		end
	end, 'mpistola')
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_basicneeds:onPistol')
AddEventHandler('esx_basicneeds:onPistol', function()

MunPis()

end)

function MunCecchino()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo8 = tonumber(data2.value)
		local playerPed  = PlayerPedId()
        local weaponHash8 = GetHashKey("WEAPON_MARKSMANRIFLE")
        local pedAmmo8 = GetAmmoInPedWeapon(playerPed, weaponHash8)
		local finalAmmo8 = math.floor(pedAmmo8 + Testo8)
		local fregatura8 = math.floor(250 - pedAmmo8)
		
		ESX.TriggerServerCallback('esx_armeria:contrmcecchino', function(cecchinoQuantity)
		if Testo8 ~= nil and cecchinoQuantity >= Testo8 and Testo8 <= 25 and pedAmmo8 < 250 and HasPedGotWeapon(PlayerPedId(), weaponHash8, false) and Testo8 <= fregatura8 then
		    menu.close()
			SetPedAmmo(playerPed, weaponHash8, finalAmmo8)
			TriggerServerEvent('esx_armeria:toglimcecchino', Testo8)
		else
			menu.close()
			ESX.ShowNotification('Valore non valido')
		end
	end, 'mcecchino')
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_basicneeds:onCecchino')
AddEventHandler('esx_basicneeds:onCecchino', function()
	MunCecchino()
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------

function MunPom()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo2 = tonumber(data2.value)
		local playerPed  = PlayerPedId()
        local weaponHash2 = GetHashKey("WEAPON_PUMPSHOTGUN")
        local pedAmmo2 = GetAmmoInPedWeapon(playerPed, weaponHash2)
		local finalAmmo2 = math.floor(pedAmmo2 + Testo2)
		local fregatura2 = math.floor(250 - pedAmmo2)
		
		ESX.TriggerServerCallback('esx_armeria:contrmpompa', function(pompaQuantity)
		if Testo2 ~= nil and pompaQuantity >= Testo2 and Testo2 <= 25 and pedAmmo2 < 250 and HasPedGotWeapon(PlayerPedId(), weaponHash2, false) and Testo2 <= fregatura2 then
		    menu.close()
			SetPedAmmo(playerPed, weaponHash2, finalAmmo2)
			TriggerServerEvent('esx_armeria:toglimpompa', Testo2)
		else
			menu.close()
			ESX.ShowNotification('Valore non valido')
		end
	end, 'mpompa')
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_basicneeds:onPomp')
AddEventHandler('esx_basicneeds:onPomp', function()

MunPom()

end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------

function MunSmg()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo3 = tonumber(data2.value)
		local playerPed  = PlayerPedId()
        local weaponHash3 = GetHashKey("WEAPON_SMG")
        local pedAmmo3 = GetAmmoInPedWeapon(playerPed, weaponHash3)
		local finalAmmo3 = math.floor(pedAmmo3 + Testo3)
		local fregatura3 = math.floor(250 - pedAmmo3)
		
		ESX.TriggerServerCallback('esx_armeria:contrmsmg', function(smgQuantity)
		if Testo3 ~= nil and smgQuantity >= Testo3 and Testo3 <= 25 and pedAmmo3 < 250 and HasPedGotWeapon(PlayerPedId(), weaponHash3, false) and Testo3 <= fregatura3 then
		    menu.close()
			SetPedAmmo(playerPed, weaponHash3, finalAmmo3)
			TriggerServerEvent('esx_armeria:toglimsmg', Testo3)
		else
			menu.close()
			ESX.ShowNotification('Valore non valido')
		end
	end, 'msmg')
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_basicneeds:onSmg')
AddEventHandler('esx_basicneeds:onSmg', function()

MunSmg()

end)

function MunAK()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo6 = tonumber(data2.value)
		local playerPed  = PlayerPedId()
        local weaponHash6 = GetHashKey("WEAPON_ASSAULTRIFLE")
        local pedAmmo6 = GetAmmoInPedWeapon(playerPed, weaponHash6)
		local finalAmmo6 = math.floor(pedAmmo6 + Testo6)
		local fregatura6 = math.floor(250 - pedAmmo6)
		
		ESX.TriggerServerCallback('esx_armeria:contrmak', function(makQUANTUT)
		if Testo6 ~= nil and makQUANTUT >= Testo6 and Testo6 <= 25 and pedAmmo6 < 250 and HasPedGotWeapon(PlayerPedId(), weaponHash6, false) and Testo6 <= fregatura6 then
		    menu.close()
			SetPedAmmo(playerPed, weaponHash6, finalAmmo6)
			TriggerServerEvent('esx_armeria:toglimak', Testo6)
		else
			menu.close()
			ESX.ShowNotification('Valore non valido')
		end
	end, 'mak')
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_basicneeds:onAK')
AddEventHandler('esx_basicneeds:onAK', function()

MunAK()

end)
--------------------------------------------------------------------------------------------------------------------------------------------------------

function MunCom()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo4 = tonumber(data2.value)
		local playerPed  = PlayerPedId()
        local weaponHash4 = GetHashKey("WEAPON_COMBATPISTOL")
        local pedAmmo4 = GetAmmoInPedWeapon(playerPed, weaponHash4)
		local finalAmmo4 = math.floor(pedAmmo4 + Testo4)
		local fregatura4 = math.floor(250 - pedAmmo4)
		
		ESX.TriggerServerCallback('esx_armeria:contrmcom', function(comQuantity)
		if Testo4 ~= nil and comQuantity >= Testo4 and Testo4 <= 25 and pedAmmo4 < 250 and HasPedGotWeapon(PlayerPedId(), weaponHash4, false) and Testo4 <= fregatura4 then
		    menu.close()
			SetPedAmmo(playerPed, weaponHash4, finalAmmo4)
			TriggerServerEvent('esx_armeria:toglimcom', Testo4)
		else
			menu.close()
			ESX.ShowNotification('Valore non valido')
		end
	end, 'mcom')
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_basicneeds:onCom')
AddEventHandler('esx_basicneeds:onCom', function()

MunCom()

end)
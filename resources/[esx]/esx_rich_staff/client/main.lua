local group
local PlayerData            = {}
local states                = {}
local anticheat             = true
states.frozen               = false
states.frozenPos            = nil

ESX                         = nil

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
		Citizen.Wait(0)
		if (AntiCheat == true) then
			SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
		else
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)

		rgb = RGBRainbow(1)

		SetTextColour(rgb.r, rgb.g, rgb.b, 255)

		SetTextFont(1)
		SetTextScale(0.4, 0.4)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(2, 2, 0, 0, 0)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString("discord.gg/ktDMKpz")
		DrawText(0.005, 0.001)
	end
end)

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

RegisterNetEvent('esx_rich_staff:setGroup')
AddEventHandler('esx_rich_staff:setGroup', function(g)
	group = g
end)

local noclip = false

local noclip2 = false
local noclip2_speed = 1.0

RegisterCommand('reviveall', function(source)
    if group == 'admin' or group == 'mod' or group == 'superadmin' then
        TriggerServerEvent('esx_rich_revive:reviveAll')
        TriggerEvent("chatMessage", "[REVIVE] ", {0, 0, 255}, "Hai rianimato anche dio!")
    else
        TriggerEvent("chatMessage", "[REVIVE] ", {255, 0, 0}, "Non puoi farlo!")
    end
end, false)

RegisterCommand('freezeall', function(source)
    if group == 'admin' or group == 'mod' or group == 'superadmin' then
        TriggerServerEvent('esx_rich_revive:freezeAll')
        TriggerEvent("chatMessage", "[REVIVE] ", {0, 0, 255}, "Hai freezato anche dio!")
    else
        TriggerEvent("chatMessage", "[REVIVE] ", {255, 0, 0}, "Non puoi farlo!")
    end
end, false)

RegisterCommand('unfreezeall', function(source)
    if group == 'admin' or group == 'mod' or group == 'superadmin' then
        TriggerServerEvent('esx_rich_revive:unfreezeAll')
        TriggerEvent("chatMessage", "[REVIVE] ", {0, 0, 255}, "Hai non freezato anche dio!")
    else
        TriggerEvent("chatMessage", "[REVIVE] ", {255, 0, 0}, "Non puoi farlo!")
    end
end, false)

local freezeAll = false
local frozenPose = nil

RegisterNetEvent('esx_rich:freeze')
AddEventHandler('esx_rich:freeze', function()
    local player = PlayerId()
    local ped = GetPlayerPed(-1)

    freezeAll = true

    frozenPose = GetEntityCoords(ped, false)
        
    if not IsEntityVisible(ped) then
        SetEntityVisible(ped, true)
    end

    if not IsPedInAnyVehicle(ped) then
        SetEntityCollision(ped, true)
    end

    FreezeEntityPosition(ped, false)
    --SetCharNeverTargetted(ped, false)
    SetPlayerInvincible(player, false)
end)

RegisterNetEvent('esx_rich:unfreeze')
AddEventHandler('esx_rich:unfreeze', function()
    local player = PlayerId()
    local ped = GetPlayerPed(-1)
        
    freezeAll = false

    frozenPose = nil

    SetEntityCollision(ped, false)
    FreezeEntityPosition(ped, true)
    --SetCharNeverTargetted(ped, true)
    SetPlayerInvincible(player, true)
    --RemovePtfxFromPed(ped)

    if not IsPedFatallyInjured(ped) then
        ClearPedTasksImmediately(ped)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if freezeAll then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), frozenPose)
		end
	end
end)

RegisterNetEvent("esx_rich_staff:quick")
AddEventHandler("esx_rich_staff:quick", function(t, target)
    if t == "slay" then 
        SetEntityHealth(PlayerPedId(), 0) 
    end
    if t == "goto" then
        SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
    end
    if t == "bring" then
        states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
        SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
    end
    if t == "crash" then
        Citizen.Trace("Sei crashato :/")
        Citizen.CreateThread(function()
            while true do end
        end)
    end
    if t == "slap" then
        ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    end
    if t == "noclip" then
        local msg = "disabilitato"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
		end

		noclip = not noclip

		if(noclip)then
			msg = "abilitato"
		end

        TriggerEvent("chatMessage", "[MENU STAFF] ", {255, 0, 0}, "Il noclip è stato ^2^*" .. msg)
    end
    if t == "noclip2" then
        local msg = "disabilitato"
        if(noclip2 == false)then
        end

        noclip2 = not noclip2

        if(noclip2)then
            msg = "abilitato"
        end

        TriggerEvent("chatMessage", "[MENU STAFF] ", {255, 0, 0}, "Il noclip è stato ^2^*" .. msg)
    end
    if t == "freeze" then
        local player = PlayerId()

		local ped = GetPlayerPed(-1)

		states.frozen = not states.frozen
        states.frozenPos = GetEntityCoords(ped, false)
        
        if not state then
            if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
            SetPlayerInvincible(player, true)
            
            if not IsPedFatallyInjured(ped) then
                ClearPedTasksImmediately(ped)
            end
        end
    elseif t == 'revive' then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

        Citizen.CreateThread(function()
            --DoScreenFadeOut(800)
    
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
            --DoScreenFadeIn(800)
        end)
    end
end)

function RespawnPed(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip2)then
		local ped = GetPlayerPed(-1)
        local x,y,z = getPosition()
        local dx,dy,dz = getCamDirection()
        local speed = noclip2_speed
		SetEntityVisible(GetPlayerPed(-1), false, false)
		SetEntityInvincible(GetPlayerPed(-1), true)

      -- reset velocity
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
      if IsControlPressed(0, 21) then
      	speed = speed + 3
      	end
      if IsControlPressed(0, 19) then
      	speed = speed - 0.5
      end
      -- forward
             if IsControlPressed(0,32) then -- MOVE UP
        	  x = x+speed*dx
        	  y = y+speed*dy
        	  z = z+speed*dz
      	     end

      -- backward
      	     if IsControlPressed(0,269) then -- MOVE DOWN
        	  x = x-speed*dx
        	  y = y-speed*dy
        	  z = z-speed*dz
      	     end
        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      	  else
      	  SetEntityVisible(GetPlayerPed(-1), true, false)
      	  SetEntityInvincible(GetPlayerPed(-1), false)

	     end
	end
end)

local heading = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip)then
			SetEntityCoordsNoOffset(GetPlayerPed(-1),  noclip_pos.x,  noclip_pos.y,  noclip_pos.z,  0, 0, 0)

			if(IsControlPressed(1,  34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			end
			if(IsControlPressed(1,  32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1,  27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
			end
			if(IsControlPressed(1,  173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, -1.0)
			end
		end
	end
end)

RegisterNetEvent('esx_rich_staff:freezePlayer')
AddEventHandler("esx_rich_staff:freezePlayer", function(state)
	local player = PlayerId()

	local ped = GetPlayerPed(-1)

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

--[[ RegisterNetEvent('esx_rich_staff:spawnVehicle')
AddEventHandler('esx_rich_staff:spawnVehicle', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end) ]]

function _LoadModel( mdl )
    while ( not HasModelLoaded( mdl ) ) do 
        RequestModel( mdl )
        Citizen.Wait( 5 )
    end 
end 

function toggleRadio(playerPed)
	if(IsPedInAnyVehicle(playerPed, false))then
		local veh = GetVehiclePedIsUsing(playerPed)
		SetVehicleRadioEnabled(veh, not featureRadioAlwaysOff)
	end

	SetUserRadioControlEnabled(not featureRadioAlwaysOff)
end

local function _SetEntityAsNoLongerNeeded(entity)
	Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(entity))
end

local lastVehicle

local function SpawnVehicle(model, x, y, z, heading, ped)

    if not lastVehicle and GetVehiclePedIsIn(ped, false) then
		lastVehicle = GetVehiclePedIsIn(ped, false)
	end

    if IsModelValid(model) then
        _LoadModel( model )
        local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )

		if Config.featureSpawnInsideCar then
			SetPedIntoVehicle(ped, veh, -1)
		end

		if Config.featureDeleteLastVehicle then
			_SetEntityAsNoLongerNeeded(veh)
			-- Remove the last vehicle.
			if (lastVehicle) then
				if(GetVehicleNumberOfPassengers(lastVehicle) ~= 0 or IsVehicleSeatFree(lastVehicle, -1) == false) then
					TriggerEvent("pNotify:SendNotification",{
                        text = "Impossibile eliminare l'ultimo veicolo!",
                        type = "error",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
				else
					SetEntityAsMissionEntity(lastVehicle, true, true)
					DeleteVehicle(lastVehicle)
				end
			end
		end

		TriggerEvent("pNotify:SendNotification",{
            text = "Veicolo spawnato!",
            type = "success",
            timeout = 5000,
            layout = "bottomCenter",
            queue = "global"
        })
		lastVehicle = veh
		--UpdateVehicleFeatureVariables( veh )
		toggleRadio(ped)

        SetModelAsNoLongerNeeded( veh )
        
        return veh
    else
        TriggerEvent("pNotify:SendNotification",{
            text = "Devi inserire un modello valido!",
            type = "error",
            timeout = 5000,
            layout = "bottomCenter",
            queue = "global"
        })
    end        
end

RegisterNetEvent('esx_rich_staff:teleportUser')
AddEventHandler('esx_rich_staff:teleportUser', function(x, y, z)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('esx_rich_staff:slap')
AddEventHandler('esx_rich_staff:slap', function()
	local ped = GetPlayerPed(-1)

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('esx_rich_staff:kill')
AddEventHandler('esx_rich_staff:kill', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('esx_rich_staff:heal')
AddEventHandler('esx_rich_staff:heal', function()
	SetEntityHealth(GetPlayerPed(-1), 200)
end)

RegisterNetEvent('esx_rich_staff:crash')
AddEventHandler('esx_rich_staff:crash', function()
	while true do
	end
end)

RegisterNetEvent("esx_rich_staff:noclip")
AddEventHandler("esx_rich_staff:noclip", function(t)
	local msg = "disabilitato"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "abilitato"
	end

	TriggerEvent("chatMessage", "[MENU STAFF]", {255, 0, 0}, "Il noclip è stato ^2^*" .. msg)
end)

RegisterNetEvent("es_admin:noclip2")
AddEventHandler("es_admin:noclip2", function(t)
	local msg = "disabilitato"
	if(noclip2 == false)then
	end

	noclip2 = not noclip2

	if(noclip2)then
		msg = "abilitato"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Il noclip è stato ^2^*" .. msg)
end)

RegisterNetEvent("esx_rich_staff:impostasoldi")
AddEventHandler("esx_rich_staff:impostasoldi", function(id, money)

    local id = nil
    local money = nil

    local targetgetted = false
    local impostatoimporto = false

    if not targetgetted then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
            title = 'ID Giocatore',
        }, function (data2, menu)
            id = tonumber(data2.value)

            if id == nil then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Devi inserire un ID valido!",
                    type = "error",
                    timeout = (5000),
                    layout = "bottomCenter",
                    queue = "global"
                })
                targetgetted = false
                menu.close()
            else
                targetgetted = true
                menu.close()
                if targetgetted and not impostatoimporto then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                        title = "Importo da impostare",
                    }, function(data9, menu)
                        money = (data9.value)

                        if money == nil then
                            TriggerEvent("pNotify:SendNotification",{
                                text = "Devi inserire un IMPORTO valido!",
                                type = "error",
                                timeout = (5000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            impostatoimporto = false
                            menu.close()
                        else
                            impostatoimporto = true
                            TriggerServerEvent('esx_rich_staff:SetMoney', id, money)
                            menu.close()
                        end
                    end)
                end
            end
        end)
    end
end)

-- "esx_rich_staff:givemoneyblack"

RegisterNetEvent("esx_rich_staff:givemoneyblack")
AddEventHandler("esx_rich_staff:givemoneyblack", function(id, amount)

    local id = nil
    local amount = nil

    local targetgetted = false
    local amountgetted = false

    if not targetgetted then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
            title = 'ID Giocatore',
        }, function(data2, menu)
            id = tonumber(data2.value)

            if id == nil then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Devi inserire un ID valido!",
                    type = "error",
                    timeout = (5000),
                    layout = "bottomCenter",
                    queue = "global"
                })
                targetgetted = false
                menu.close()
            else
                targetgetted = true
                menu.close()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                    title = 'Importo da givvare',
                }, function (data7, menu)
                    amount = data7.value

                    if amount == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un IMPORTO valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        amountgetted = false
                        menu.close()
                    else
                        amountgetted = true
                        if targetgetted and amountgetted then
                            TriggerServerEvent("esx_rich_staff:GiveMoneyServerBlackMoney", id, amount)
                        end
                        menu.close()
                    end
                end)
            end
        end)
    end
end)

RegisterNetEvent("esx_rich_staff:givemoneybank")
AddEventHandler("esx_rich_staff:givemoneybank", function(id, amount)

    local id = nil
    local amount = nil

    local targetgetted = false
    local amountgetted = false

    if not targetgetted then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
            title = 'ID Giocatore',
        }, function(data2, menu)
            id = tonumber(data2.value)

            if id == nil then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Devi inserire un ID valido!",
                    type = "error",
                    timeout = (5000),
                    layout = "bottomCenter",
                    queue = "global"
                })
                targetgetted = false
                menu.close()
            else
                targetgetted = true
                menu.close()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                    title = 'Importo da givvare',
                }, function (data7, menu)
                    amount = data7.value

                    if amount == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un IMPORTO valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        amountgetted = false
                        menu.close()
                    else
                        amountgetted = true
                        if targetgetted and amountgetted then
                            TriggerServerEvent("esx_rich_staff:GiveMoneyServerBank", id, amount)
                        end
                        menu.close()
                    end
                end)
            end
        end)
    end
end)

-- esx_rich_staff:SetJob

RegisterNetEvent("esx_rich_staff:impostalavoro")
AddEventHandler("esx_rich_staff:impostalavoro", function(id, job, grade)

    local id = nil
    local job = nil
    local grade = 0

    local targetgetted = false
    local itemselected = false
    local qttyselected = false

    if not targetgetted then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
            title = 'ID Giocatore',
        }, function (data2, menu)
            id = tonumber(data2.value)

            if id == nil then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Devi inserire un ID valido!",
                    type = "error",
                    timeout = (5000),
                    layout = "bottomCenter",
                    queue = "global"
                })
                targetgetted = false
                menu.close()
            else
                targetgetted = true
                menu.close()
                if targetgetted and not itemselected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                        title = 'Lavoro da impostare',
                    }, function (data7, menu)
                        job = (data7.value)

                        if job == nil then
                            TriggerEvent("pNotify:SendNotification",{
                                text = "Devi inserire un oggetto valido!",
                                type = "error",
                                timeout = (5000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            itemselected = false
                            menu.close()
                        else
                            itemselected = true
                            menu.close()
                            if itemselected and not qttyselected then
                                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                                    title = 'Grado da assegnare',
                                }, function (data8, menu)
                                    grade = tonumber(data8.value)
                        
                                    if grade == nil then
                                        grade = 0
                                        qttyselected = true
                                        menu.close()
                                    else
                                        qttyselected = true
                                        if targetgetted and itemselected and qttyselected then

                                            local lavoro = nil

                                            if job == 'polizia' then
                                                lavoro = 'police'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'ambulanza' or job == 'ems' or job == 'medico' then
                                                lavoro = 'ambulance'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'meccanico' then
                                                lavoro = 'mecano'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'venditoreauto' or job == 'auto' then
                                                lavoro = 'cardealer'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'taglialegna' then
                                                lavoro = 'lumberjack'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'benzinaio' or job == 'petroliere' then
                                                lavoro = 'fueler'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'giornalista' then
                                                lavoro = 'journaliste'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'minatore' then
                                                lavoro = 'miner'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'piscina' then
                                                lavoro = 'poolcleaner'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'immobiliare' then
                                                lavoro = 'realestateagent'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'macellaio' then
                                                lavoro = 'slaughterer'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'stato' then
                                                lavoro = 'state'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'sarto' then
                                                lavoro = 'tailor'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'camionista' then
                                                lavoro = 'trucker'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            elseif job == 'vino' then
                                                lavoro = 'vigne'
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, lavoro, grade)
                                            else
                                                TriggerServerEvent("esx_rich_staff:SetJob", id, job, grade)
                                            end
                                        end
                                        menu.close()
                                    end
                                end)
                            end
                        end
                    end)
                end
            end
        end)
    end
end)

RegisterNetEvent("esx_rich_staff:GiveObject")
AddEventHandler("esx_rich_staff:GiveObject", function(id, item, qtty)

    local id = nil
    local item = nil
    local qtty = 1

    local targetgetted = false
    local itemselected = false
    local qttyselected = false

    if not targetgetted then
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
            title = 'ID Giocatore',
        }, function (data2, menu)
            id = tonumber(data2.value)

            if id == nil then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Devi inserire un ID valido!",
                    type = "error",
                    timeout = (5000),
                    layout = "bottomCenter",
                    queue = "global"
                })
                targetgetted = false
                menu.close()
            else
                targetgetted = true
                menu.close()
                if targetgetted and not itemselected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                        title = 'Oggetto da Givvare',
                    }, function (data7, menu)
                        item = (data7.value)

                        if item == nil then
                            TriggerEvent("pNotify:SendNotification",{
                                text = "Devi inserire un oggetto valido!",
                                type = "error",
                                timeout = (5000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            itemselected = false
                            menu.close()
                        else
                            itemselected = true
                            menu.close()
                            if itemselected and not qttyselected then
                                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                                    title = 'Quantità Oggetto',
                                }, function (data8, menu)
                                    qtty = tonumber(data8.value)
                        
                                    if qtty == nil then
                                        TriggerEvent("pNotify:SendNotification",{
                                            text = "Devi inserire una quantità valida!",
                                            type = "error",
                                            timeout = (5000),
                                            layout = "bottomCenter",
                                            queue = "global"
                                        })
                                        qttyselected = false
                                        menu.close()
                                    else
                                        qttyselected = true
                                        if targetgetted and itemselected and qttyselected then
                                            TriggerServerEvent("esx_rich_staff:GiveObjectServer", id, item, qtty)
                                        end
                                        menu.close()
                                    end
                                end)
                            end
                        end
                    end)
                end
            end
        end)
    end
end)

function requestInput(exampleText, maxLength)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", exampleText, "", "", "", maxLength + 1)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait( 0 )
    end

    local result = GetOnscreenKeyboardResult()

    UnblockMenuInput()

    if result ~= "" and result ~= exampleText then
        return result
    else
        return false
    end
end

function UnblockMenuInput()
    Citizen.CreateThread( function()
        Citizen.Wait( 150 )
        blockinput = false 
    end )
end

function getPlayers()
	local players = {}
	for i = 0,256 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, {id = GetPlayerServerId(i), name = GetPlayerName(i)})
		end
	end
	return players
end

function OpenPrincipalMenu()

    local elements = {
        {label = "Azioni Giocatori", value = "player_actions"},
        {label = "Azioni Personali", value = "personal_actions"},
        {label = "Azioni Generali",  value = "general_actions"},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pincipal_staff',
        {
            title = "Menù " .. group ,
            align = "top-left",
            elements = elements
        },
        function(data3, menu)

            if data3.current.value == "player_actions" then
                OpenStaffMenu()
            elseif data3.current.value == "personal_actions" then
                OpenPersonalActions()
            elseif data3.current.value == "general_actions" then
                OpenGeneralActions()
            end
        end,
        function(data3, menu)
            menu.close()
        end
    )
end

function OpenPersonalActions()

    local elements = {}

    if group == "superadmin" then
        table.insert(elements, {label = "Rianimati", value = "revive"})
        table.insert(elements, {label = "Curati", value = "heal"})
        --table.insert(elements, {label = "Noclip", value = "noclip"})
    elseif group == "admin" then
        table.insert(elements, {label = "Rianimati", value = "revive"})
        table.insert(elements, {label = "Curati", value = "heal"})
        --table.insert(elements, {label = "Noclip", value = "noclip"})
    elseif group == "mod" then
        table.insert(elements, {label = "Rianimati", value = "revive"})
        table.insert(elements, {label = "Curati", value = "heal"})
        --table.insert(elements, {label = "Noclip", value = "noclip"})
    elseif group == "helper" then
        table.insert(elements, {label = "Rianimati", value = "revive"})
        table.insert(elements, {label = "Curati", value = "heal"})
        --table.insert(elements, {label = "Noclip", value = "noclip"})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'personal_actions', 
        {
        title = "Azioni Personali",
        align = 'top-left',
        elements = elements,
        },
        function(data2, menu)
            
            local opzion = data2.current.value
            local _source = source

            local Testo = _source

            local type = opzion

            if opzion == "revive" then
                TriggerEvent('esx_ambulancejob:revivecomm', _source)
            elseif opzion == "heal" then
                TriggerEvent('esx_basicneeds:healPlayer', _source)
            elseif opzion == "noclip" then
                TriggerServerEvent("esx_rich_staff:quick", Testo, type)
            end
        
        end, 
        function(data2, menu)
            menu.close()
    end)
end

function OpenGeneralActions()

    local elements = {}

    if group == "superadmin" then
        table.insert(elements, {label = "Spawna Veicolo", value = "car"})
        table.insert(elements, {label = "Elimina Veicolo", value = "dv"})
        table.insert(elements, {label = "Ripara Veicolo", value = "repair"})
        table.insert(elements, {label = "Pulisci Veicolo", value = "wash"})
        table.insert(elements, {label = "Sporca Veicolo", value = "dirty"})
    elseif group == "admin" then
        table.insert(elements, {label = "Spawna Veicolo", value = "car"})
        table.insert(elements, {label = "Elimina Veicolo", value = "dv"})
        table.insert(elements, {label = "Ripara Veicolo", value = "repair"})
        table.insert(elements, {label = "Pulisci Veicolo", value = "wash"})
        table.insert(elements, {label = "Sporca Veicolo", value = "dirty"})
    elseif group == "mod" then
        table.insert(elements, {label = "Spawna Veicolo", value = "car"})
        table.insert(elements, {label = "Elimina Veicolo", value = "dv"})
        table.insert(elements, {label = "Ripara Veicolo", value = "repair"})
        table.insert(elements, {label = "Pulisci Veicolo", value = "wash"})
        table.insert(elements, {label = "Sporca Veicolo", value = "dirty"})
    elseif group == "helper" then
        table.insert(elements, {label = "Spawna Veicolo", value = "car"})
        table.insert(elements, {label = "Elimina Veicolo", value = "dv"})
        table.insert(elements, {label = "Ripara Veicolo", value = "repair"})
        table.insert(elements, {label = "Pulisci Veicolo", value = "wash"})
        table.insert(elements, {label = "Sporca Veicolo", value = "dirty"})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'general_actions',
        {
            title = "Azioni Generali",
            align = 'top-left',
            elements = elements,
        },
        function(data4, menu)

            local azione = data4.current.value
            local _source = source

            if azione == 'car' then
                
                local result = requestInput("", 60)

                local playerPed = GetPlayerPed(-1)
                local carid = GetHashKey(result)

                local playerCoords = GetEntityCoords(playerPed)

                if result == nil then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi inserire un modello valido!",
                        type = "error",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    RequestModel(carid)
                    while not HasModelLoaded(carid) do
                        Citizen.Wait(0)
                    end

                    veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
                    SetVehicleAsNoLongerNeeded(veh)
                    TaskWarpPedIntoVehicle(playerPed, veh, -1)
                    menu.close()
                end
            elseif azione == 'dv' then

                local playerPed = PlayerPedId()
                local vehicle = nil

                if IsPedInAnyVehicle(playerPed, true) then
                    vehicle = GetVehiclePedIsIn(playerPed, false)
                elseif IsPedInAnyVehicle(playerPed, false) then
                    vehicle = GetVehiclePedIsIn(playerPed, false)
                end

                if vehicle == nil then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi essere in un veicolo!",
                        type = "error",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    if DoesEntityExist(vehicle) then
                        SetEntityAsMissionEntity(vehicle, true, true)
                        DeleteVehicle(vehicle)
                    end
                end

            elseif azione == "repair" then

                local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)

                if playerVeh <= 0 then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi essere in un veicolo!",
                        type = "error",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    SetVehicleFixed(playerVeh)
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Hai riparato il veicolo!",
                        type = "success",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                end

            elseif azione == "wash" then

                local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                
                if playerVeh <= 0 then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi essere in un veicolo!",
                        type = "error",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    SetVehicleDirtLevel(playerVeh, 0.0)
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Hai pulito il veicolo!",
                        type = "success",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                end

            elseif azione == "dirty" then

                local playerPed = GetPlayerPed(-1)
                local playerVeh = GetVehiclePedIsIn(playerPed, false)
                
                if playerVeh <= 0 then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi essere in un veicolo!",
                        type = "error",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    SetVehicleDirtLevel(playerVeh, 15.0)
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Hai sporcato il veicolo!",
                        type = "success",
                        timeout = 5000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                end

            end

        end,
        function(data4, menu)
            menu.close()
        end
    )
end

function OpenStaffMenu()

    local elements = {}

    if group == "superadmin" then
        table.insert(elements, {label = "Specta Giocatore", value = "spectate"})
        table.insert(elements, {label = "Imposta lavoro", value = "setjob"})                    --  ALL DONE
        table.insert(elements, {label = "Imposta Soldi", value = "setmoney"})                   --  ALL DONE
        table.insert(elements, {label = "Dai soldi in banca", value = "givebankmoney"})         --  ALL DONE
        table.insert(elements, {label = "Dai soldi sporchi", value = "giveblackmoney"})         --  ALL DONE
        table.insert(elements, {label = "Dai oggetto", value = "giveobject"})                   --  ALL DONE
        table.insert(elements, {label = "Dai arma", value = "giveweapon"})                      --  ALL DONE
        table.insert(elements, {label = "Rianima", value = "revive"})                           --  ALL DONE
        table.insert(elements, {label = "Heal", value = "heal"})                                --  ALL DONE
        table.insert(elements, {label = "Uccidi", value = "slay"})                              --  ALL DONE
        table.insert(elements, {label = "Noclip", value = "noclip"})                            --  ALL DONE
        table.insert(elements, {label = "Congela", value = "freeze"})                           --  ALL DONE
        table.insert(elements, {label = "Crash", value = "crash"})                              --  ALL DONE
        table.insert(elements, {label = "Teletrasporta da te", value = "bring"})                --  ALL DONE
        table.insert(elements, {label = "Teletrasporta", value = "goto"})                       --  ALL DONE
        table.insert(elements, {label = "Lancia", value = "slap"})                              --  ALL DONE
        table.insert(elements, {label = "Espelli", value = "kick"})                             --  ALL DONE
    elseif group == "admin" then
        --table.insert(elements, {label = "Specta Giocatore", value = "spectate"})
        table.insert(elements, {label = "Imposta lavoro", value = "setjob"})
        table.insert(elements, {label = "Imposta Soldi", value = "setmoney"})
        table.insert(elements, {label = "Dai soldi in banca", value = "givebankmoney"})
        table.insert(elements, {label = "Dai soldi sporchi", value = "giveblackmoney"})
        table.insert(elements, {label = "Dai oggetto", value = "giveobject"})
        table.insert(elements, {label = "Dai arma", value = "giveweapon"})
        table.insert(elements, {label = "Rianima", value = "revive"})
        table.insert(elements, {label = "Uccidi", value = "slay"})
        table.insert(elements, {label = "Noclip", value = "noclip"})
        table.insert(elements, {label = "Congela", value = "freeze"})
        table.insert(elements, {label = "Teletrasporta da te", value = "bring"})
        table.insert(elements, {label = "Teletrasporta", value = "goto"})
        table.insert(elements, {label = "Lancia", value = "slap"})
        table.insert(elements, {label = "Espelli", value = "kick"})
        table.insert(elements, {label = "Crash", value = "crash"}) 
    elseif group == "mod" then
        --table.insert(elements, {label = "Specta Giocatore", value = "spectate"})
        table.insert(elements, {label = "Imposta lavoro", value = "setjob"})
        table.insert(elements, {label = "Dai oggetto", value = "giveobject"})
        table.insert(elements, {label = "Rianima", value = "revive"})
        table.insert(elements, {label = "Uccidi", value = "slay"})
        table.insert(elements, {label = "Noclip", value = "noclip"})
        table.insert(elements, {label = "Congela", value = "freeze"})
        table.insert(elements, {label = "Teletrasporta da te", value = "bring"})
        table.insert(elements, {label = "Teletrasporta", value = "goto"})
        table.insert(elements, {label = "Lancia", value = "slap"})
        table.insert(elements, {label = "Espelli", value = "kick"})
    elseif group == 'helper' then
        --table.insert(elements, {label = "Specta Giocatore", value = "spectate"})
        table.insert(elements, {label = "Rianima", value = "revive"})
        table.insert(elements, {label = "Congela", value = "freeze"})
        table.insert(elements, {label = "Teletrasporta da te", value = "bring"})
        table.insert(elements, {label = "Teletrasporta", value = "goto"})
        table.insert(elements, {label = "Espelli", value = "kick"})
    elseif Config.DevelopingMode then
        table.insert(elements, {label = "NOPE - NOPE", value = "nil"})
    end
    
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'staffmenu',
        {
            title = "Azioni Giocatori",
            align = 'top-left',
            elements = elements
        }, 
        
        function(data, menu)

            local opzione = data.current.value

            local type = opzione

            if opzione == 'slay' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end, function(data, menu)
                    menu.close()
                end)

            elseif opzione == "nil" then

                menu.close()

            elseif opzione == "spectate" then

                local playerPed = PlayerPedId()
                local target = nil

                if NetworkIsInSpectatorMode() then
                    DoScreenFadeOut(500)
                    while IsScreenFadingOut() do
                        Wait(0)
                    end
                    NetworkSetInSpectatorMode(false, 0)
                    DoScreenFadeIn(500)
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Hai finito di spectare",
                        type = "success",
                        timeout = 4000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                        title = 'ID Giocatore',
                    }, function (data2, menu)
                        Testo = tonumber(data2.value)

                        if Testo == nil then
                            TriggerEvent("pNotify:SendNotification",{
                                text = "Devi inserire un ID valido!",
                                type = "error",
                                timeout = (5000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            menu.close()
                        else
                            target = GetPlayerPed(GetPlayerFromServerId(Testo))

                            DoScreenFadeOut(500)
                            while IsScreenFadingOut() do
                                Wait(0)
                            end
                            NetworkSetInSpectatorMode(false, 0)
                            NetworkSetInSpectatorMode(true, target)
                            DoScreenFadeIn(500)
                            menu.close()
                        end
                    end, function(data, menu)
                        menu.close()
                    end)
                end

            elseif opzione == "setmoney" then

                TriggerEvent("esx_rich_staff:impostasoldi")

            elseif opzione == "setjob" then

                TriggerEvent("esx_rich_staff:impostalavoro")

            elseif opzione == "giveblackmoney" then

                TriggerEvent("esx_rich_staff:givemoneyblack")

            elseif opzione == "givebankmoney" then

                TriggerEvent("esx_rich_staff:givemoneybank")

            elseif opzione == "heal" then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerEvent('esx_basicneeds:healPlayer', Testo)
                        menu.close()
                    end
                end)

            elseif opzione == "giveweapon" then

                local result = requestInput("weapon_", 60)
                local Testo = nil

                if result == nil then
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi inserire un'arma valida!",
                        type = "error",
                        timeout = (5000),
                        layout = "bottomCenter",
                        queue = "global"
                    })
                else
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
                        title = 'ID Giocatore',
                    }, function (data2, menu)
                        Testo = tonumber(data2.value)
                        
                        if Testo == nil then
                            TriggerEvent("pNotify:SendNotification",{
                                text = "Devi inserire un ID valido!",
                                type = "error",
                                timeout = (5000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            menu.close()
                        else
                            TriggerServerEvent("esx_rich_staff:GiveWeapon", Testo, result)
                            menu.close()
                        end
                    end)
                end

            elseif opzione == "giveobject" then

                TriggerEvent("esx_rich_staff:GiveObject")

            elseif opzione == "revive" then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerEvent('esx_ambulancejob:revivecomm', Testo)
                        menu.close()
                    end
                end)

            elseif opzione == 'noclip' then
                
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu3', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'freeze' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu4', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'crash' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu5', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'bring' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu6', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'goto' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu7', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'slap' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu8', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'kick' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu9', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            elseif opzione == 'ban' then

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu10', {
                    title = 'ID Giocatore',
                }, function (data2, menu)
                    Testo = tonumber(data2.value)

                    if Testo == nil then
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi inserire un ID valido!",
                            type = "error",
                            timeout = (5000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        menu.close()
                    else
                        TriggerServerEvent("esx_rich_staff:quick", Testo, type)
                        menu.close()
                    end
                end)

            end

        end,
        function (data, menu)
            menu.close()
        end
    )
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
    
        if IsControlJustReleased(1, Config.KeysOpen) and IsInputDisabled(0) then
            
            if group ~= "user" then
                OpenPrincipalMenu()
            elseif Config.AllUser then
                OpenPrincipalMenu()
            elseif Config.DevelopingMode then
                OpenPrincipalMenu()
                ESX.ShowNotification("Modalità Dev")
            else
                if Config.DebugMode then
                    ESX.ShowNotification("Non hai i permessi per aprire il menu STAFF")
                end
            end
        end
    end
end)
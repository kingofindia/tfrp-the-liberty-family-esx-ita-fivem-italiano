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

local keyParam = Keys["K"]
local open = false
ESX 				= nil
local PlayerData 	= {}

local wallet = nil
local wallet2 = nil

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
		ESX.PlayerData = ESX.GetPlayerData()
	end

end)

--[[ RegisterCommand("close", function()

	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})

	walleto = GetHashKey('prop_ld_wallet_pickup')
	if IsEntityAttachedToEntity(walleto, GetPlayerPed(PlayerId())) then
		DetachEntity(walleto, ped, true)
--		DeleteObject(walleto)
	end

end) ]]

RegisterNUICallback('NUIFocusOff', function()
	--animazionePortafoglio()
	open = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
end)

local once = false

RegisterNUICallback('bank', function()
ESX.PlayerData = ESX.GetPlayerData()
	if not once then
		--animazionePortafoglio()
        once = true
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'close'})
		Wait(500)
		ESX.PlayerData = ESX.GetPlayerData()
        for i=1, #ESX.PlayerData.accounts, 1 do
            if ESX.PlayerData.accounts[i].name == 'bank' then
            ESX.ShowNotification('Il tuo saldo disponibile è <span style="color:green;">' .. ESX.PlayerData.accounts[i].money .." $ </span>")
            end
        end
        once = false
    end
end)


RegisterNUICallback('cash', function()

	if not once then
		--animazionePortafoglio()
        once = true
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'close'})
        Wait(500)
            pengarmeny()
        once = false
    end

end)


function pengarmeny()
    local playerPed = PlayerPedId()
	local elements  = {}
    ESX.PlayerData = ESX.GetPlayerData()

           -- local formattedMoney = 'SEK ', ESX.Math.GroupDigits(ESX.PlayerData.money)
	
            table.insert(elements, {
                label     = 'Contanti: <span style="color:green;"> ' .. ESX.PlayerData.money .. ' $',
                count     = ESX.PlayerData.money,
                type      = 'item_money',
                value     = 'money',
                usable    = false,
                rare      = false,
                canRemove = true
            })

            for i=1, #ESX.PlayerData.accounts, 1 do
	        if ESX.PlayerData.accounts[i].name == 'black_money' then


			table.insert(elements, {
                label     = 'Soldi sporchi: <span style="color:red;"> ' ..ESX.PlayerData.accounts[i].money .. ' $',
				count     = ESX.PlayerData.accounts[i].money,
				type      = 'item_account',
				value     = ESX.PlayerData.accounts[i].name,
				usable    = false,
                rare      = false,
                canRemove = true
			})
		    end
        end

            
        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory',
        {
            title    = 'Contanti',
            align    = 'top-left',
            elements = elements,
        }, function(data, menu)
            menu.close()

            local player, distance = ESX.Game.GetClosestPlayer()
            local elements = {}

            if data.current.canRemove then
                if player ~= -1 and distance <= 3.0 then
                    table.insert(elements, {label = 'Dai', action = 'give', type = data.current.type, value = data.current.value})
                end

                table.insert(elements, {label = 'Rimuovi', action = 'remove', type = data.current.type, value = data.current.value})
            end



            table.insert(elements, {label = 'Indietro', action = 'return'})

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory_item',
            {
                title    = data.current.label,
                align    = 'top-left',
                elements = elements,
            }, function(data1, menu1)

                local item = data1.current.value
                local type = data1.current.type
                local playerPed = PlayerPedId()

                if data1.current.action == 'give' then

				local players      = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
				local foundPlayers = false
				local elements     = {}
			
				for i=1, #players, 1 do
					if players[i] ~= PlayerId() then
						foundPlayers = true

						table.insert(elements, {
							label = GetPlayerName(players[i]),
							player = players[i]
						})
					end
				end

				if not foundPlayers then
					ESX.ShowNotification('players_nearby')
					return
				end

				foundPlayers = false

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to',
				{
					title    = 'Dai contanti',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)

					local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

					for i=1, #players, 1 do
						if players[i] ~= PlayerId() then
							
							if players[i] == data2.current.player then
								foundPlayers = true
								nearbyPlayer = players[i]
								break
							end
						end
					end

					if not foundPlayers then
						ESX.ShowNotification('players_nearby')
						menu2.close()
						return
					end

					if type == 'item_weapon' then

						local closestPed = GetPlayerPed(nearbyPlayer)
						local sourceAmmo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(item))

						if IsPedSittingInAnyVehicle(closestPed) then
							ESX.ShowNotification('in_vehicle')
							return
						end

						TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(nearbyPlayer), type, item, sourceAmmo)
						menu2.close()
						menu1.close()

					else

						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_give', {
							title = 'Importo'
						}, function(data3, menu3)
							local quantity = tonumber(data3.value)
							local closestPed = GetPlayerPed(nearbyPlayer)

							if IsPedSittingInAnyVehicle(closestPed) then
								ESX.ShowNotification('in_vehicle')
								return
							end

							if quantity ~= nil then
								TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(nearbyPlayer), type, item, quantity)

								menu3.close()
								menu2.close()
								menu1.close()
							else
								ESX.ShowNotification('Non valido')
							end

						end, function(data3, menu3)
							menu3.close()
						end)
					end
				end, function(data2, menu2)
					menu2.close()
end) -- give end
                elseif data1.current.action == 'remove' then

				if IsPedSittingInAnyVehicle(playerPed) then
					return
				end

				if type == 'item_weapon' then

					TriggerServerEvent('esx:removeInventoryItem', type, item)
					menu1.close()

				else -- type: item_standard

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_remove', {
						title = 'Importo'
					}, function(data2, menu2)
						local quantity = tonumber(data2.value)

						if quantity == nil then
							ESX.ShowNotification('Non valido')
						else
							TriggerServerEvent('esx:removeInventoryItem', type, item, quantity)
							menu2.close()
							menu1.close()
						end

					end, function(data2, menu2)
						menu2.close()
					end)
				end

			elseif data1.current.action == 'use' then
				TriggerServerEvent('esx:useItem', item)

			elseif data1.current.action == 'return' then
				ESX.UI.Menu.CloseAll()
				pengarmeny()
			
			end

		end, function(data1, menu1)
			ESX.UI.Menu.CloseAll()
			pengarmeny()
		end)

	end, function(data, menu)
		menu.close()
end)
end

RegisterNUICallback('idselect', function()
	local ped = PlayerPedId()
	--animazionePortafoglio()
        open = false
        SetNuiFocus(false, false)
		SendNUIMessage({type = 'close'})

        Wait(500)
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'id_card_menu',
            {
                title    = 'Documenti',
                align = 'top-left',
                elements = {
                    {label = 'Guarda la tua carta d\'identità', value = 'checkID'},
		            {label = 'Mostra la tua carta d\'identità', value = 'showID'},
		            {label = 'Guarda la tua patente di guida', value = 'checkDriver'},
		            {label = 'Mostra la tua patente di guida', value = 'showDriver'},
                }
            },
            function(data2, menu2)
                local val = data2.current.value
                if val == 'checkID' then
			        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		        elseif val == 'checkDriver' then
	                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                elseif val == 'showID' then
                    local player, distance = ESX.Game.GetClosestPlayer()

                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('Ingen i närheten')
                    end
                elseif val == 'showDriver' then
                    local player, distance = ESX.Game.GetClosestPlayer()

                    if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                    else
                        ESX.ShowNotification('Nessuno nelle vicinanze')
                    end
                end
            end,
            function(data2, menu2)
                menu2.close()
            end
        )
end)

RegisterNetEvent("wallet:open")
AddEventHandler("wallet:open", function()
    SendNUIMessage({
    	action = "close",
        array = source
    })
    ESX.UI.Menu.CloseAll()
    Wait(250)
	if not open then
        --animazionePortafoglio()
        SetNuiFocus(true, true)
        open = true
        SendNUIMessage({
            action = "open",
            array = source
        })
    end
end)

--[[ function animazionePortafoglio()
	if not open then
		loadAnim("mp_arrest_paired")
		loadAnim("anim@amb@board_room@supervising@")
		loadAnim("amb@world_human_smoking@male@male_a@idle_a")
		loadObj("prop_ld_wallet_02")
		
		local ped = PlayerPedId()
		
		wallet = CreateObject(GetHashKey('prop_ld_wallet_02'), 0.0, 0.0, 0.0, 3, 1, 0)
		TaskPlayAnim(ped, "mp_arrest_paired", "cop_p1_rf_right_0", 4.0, -4.0, -1, 48, 0, false, false, false)
		TriggerEvent("InteractSound_CL:PlayOnOne", "grab", 0.2) --grab
		AttachEntityToEntity(wallet, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 6286), 0.11, 0.057, 0.025, 45.0, -10.0, 20.0, false, false, false, false, 0, true)

		Citizen.Wait(2000)
		
		TaskPlayAnim(ped, "anim@amb@board_room@supervising@", "dissaproval_01_lo_amy_skater_01", 1.0, -1.0, -1, 0, 0, false, false, false)
		
		Citizen.Wait(1000)
		
		DetachEntity(wallet, ped, true)
		DeleteObject(wallet)

		wallet2 = CreateObject(GetHashKey('prop_ld_wallet_pickup'), 0.0, 0.0, 0.0, 3, 1, 0)
		AttachEntityToEntity(wallet2, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 36029), 0.1, 0.025, 0.1, -40.0, -80.0, 300.0, false, false, false, false, 0, true)
		PlaySoundFrontend(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
	elseif open then
		local ped = PlayerPedId()
		
		DetachEntity(wallet2, ped, true)
		DeleteObject(wallet2)
		ClearPedTasks(ped)
	end
end

function loadAnim(anim)
	RequestAnimDict(anim) 
    while not HasAnimDictLoaded(anim) do 
    	Citizen.Wait(1) 
	end
end

function loadObj(obj)
	RequestModel(obj)
	while not HasModelLoaded(obj) do
		Citizen.Wait(1)
	end
end ]]

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

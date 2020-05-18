
ESX                = nil
PlayersHarvesting  = {}
PlayersCrafting    = {}
local CopsConnected       	   = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

local function Harvest(source)

	SetTimeout(4000, function()

		if PlayersHarvesting[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)
			local SqualoQuantity = xPlayer.getInventoryItem('squalo').count

			if SqualoQuantity >= 25 then
				TriggerClientEvent('esx:showNotification', source, '~r~Non hai più spazio')		
			else   
                xPlayer.addInventoryItem('squalo', 1)
			end
		end
	end)
end

RegisterServerEvent('caccia:startRecup')
AddEventHandler('caccia:startRecup', function()
	local _source = source
	PlayersHarvesting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Raccolta ~b~carne~s~...')
	Harvest(source)
end)

RegisterServerEvent('caccia:stopRecup')
AddEventHandler('caccia:stopRecup', function()
	local _source = source
	PlayersHarvesting[_source] = false
end)

local function Craft(source)

	SetTimeout(4000, function()

		if PlayersCrafting[source] == true and CopsConnected > 1 then

			local xPlayer  = ESX.GetPlayerFromId(source)
			local SqualoQuantity = xPlayer.getInventoryItem('squalo').count

			if SqualoQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, 'Non hai ~r~abbastanza~s~ carne')			
			else   
                xPlayer.removeInventoryItem('squalo', 1)
				xPlayer.addAccountMoney('black_money', 1900)
				
				Craft(source)
	        end
		else
		TriggerClientEvent('esx:showNotification', source, 'Ci devono essere almeno 2 poliziotti online')	
		end
	end)
end

RegisterServerEvent('caccia:startVente')
AddEventHandler('caccia:startVente', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, 'Vendita ~b~carne di squalo~s~')
	Craft(_source)
end)

RegisterServerEvent('caccia:stopVente')
AddEventHandler('caccia:stopVente', function()
	local _source = source
	PlayersCrafting[_source] = false
end)


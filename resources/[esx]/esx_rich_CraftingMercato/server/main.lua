--[[
	esx_mercatocrafting
	
	Simple crafting system for es_extended
]]--

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--debug
trace = false
function dbg(msg)
	if trace then
		Citizen.Trace("[esx_mercatocrafting: " .. tostring(msg) .. " ]\n")
	end 
end
--
--global array
PlayersCrafting = {}
--
RegisterServerEvent('esx_mercatocrafting:craftItem')
AddEventHandler('esx_mercatocrafting:craftItem', function (CraftableTemp)

	local Craftable = CraftableTemp
	local _source = source 
	
	if PlayersCrafting[_source] then
		TriggerClientEvent('esx:showNotification', _source, '~r~Azione Impossibile!')
	else
		PlayersCrafting[_source] = true
		TriggerClientEvent('esx_mercatocrafting:craft', _source, Craftable.Label, Craftable.Scenario)
		
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		for i = 1, #Craftable.Require, 1 do
			xPlayer.removeInventoryItem(Craftable.Require[i].Name, Craftable.Require[i].Amount)
		end

		ESX.SetTimeout(Craftable.Time, function()
			if Craftable.Reward.Type == 'item' then
				xPlayer.addInventoryItem(Craftable.Reward.Item, Craftable.Reward.Count)
			elseif Craftable.Reward.Type == 'weapon' then
				xPlayer.addWeapon(Craftable.Reward.Item, Craftable.Reward.Count)
			end
			PlayersCrafting[_source] = false
			TriggerClientEvent('esx_mercatocrafting:stopCraft', _source)
		end)
	end
end)



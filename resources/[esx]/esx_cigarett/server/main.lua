ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			xPlayer.removeInventoryItem('lighter', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
			TriggerClientEvent("esx_block:showNotification", source, "~r~Il fumo uccide!")
		else
			TriggerClientEvent("esx_block:showNotification", source, "~r~Ti serve un fiammifero!")
		end
end)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('beer', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_beer'))

end)

ESX.RegisterUsableItem('marijuana', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('marijuana', 1)

    TriggerClientEvent('esx_status:remove', source, 'hunger', 150000)
	TriggerClientEvent('esx_optionalneeds:onWeed', source)
end)

ESX.RegisterUsableItem('cocainag', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cocainag', 1)

    TriggerClientEvent('esx_optionalneeds:onCoke', source)
    TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
end)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_taglialegnasdr:legnatagliata')
AddEventHandler('esx_taglialegnasdr:legnatagliata', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('wood', Config.Wood)
end)

RegisterServerEvent('esx_taglialegnasdr:segatura')
AddEventHandler('esx_taglialegnasdr:segatura', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('cutted_wood', 100)
	xPlayer.removeInventoryItem('wood', 100)
end)

RegisterServerEvent('esx_taglialegnasdr:tavole')
AddEventHandler('esx_taglialegnasdr:tavole', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('packaged_plank', 100)
	xPlayer.removeInventoryItem('cutted_wood', 100)
end)

RegisterServerEvent('esx_taglialegnasdr:consegna')
AddEventHandler('esx_taglialegnasdr:consegna', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local guadagno = math.floor(100 * Config.Guadagno)

	xPlayer.addMoney(guadagno)
	xPlayer.removeInventoryItem('packaged_plank', 100)
	TriggerClientEvent('mt:missiontext', source, 'Hai guadagnato ~g~' .. guadagno .. ' dollari', 10000)
end)
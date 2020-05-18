ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_macellaiosdr:pollovassoio')
AddEventHandler('esx_macellaiosdr:pollovassoio', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('packaged_chicken', Config.Pollo)
end)

RegisterServerEvent('esx_macellaiosdr:consegna')
AddEventHandler('esx_macellaiosdr:consegna', function(Testo3)

	local xPlayer = ESX.GetPlayerFromId(source)
	local guadagno = math.floor(Testo3 * Config.Guadagno)

	xPlayer.addMoney(guadagno)
	xPlayer.removeInventoryItem('packaged_chicken', Testo3)
	TriggerClientEvent('mt:missiontext', source, 'Hai guadagnato ~g~' .. guadagno .. ' dollari', 10000)
end)

RegisterServerEvent('esx_macellaiosdr:consegnamaiale')
AddEventHandler('esx_macellaiosdr:consegnamaiale', function(Testo4)

	local xPlayer = ESX.GetPlayerFromId(source)
	local guadagno = math.floor(Testo4 * Config.Guadagnomaiale)

	xPlayer.addMoney(guadagno)
	xPlayer.removeInventoryItem('maiale', Testo4)
	TriggerClientEvent('mt:missiontext', source, 'Hai guadagnato ~g~' .. guadagno .. ' dollari', 10000)
end)

RegisterServerEvent('esx_macellaiosdr:carnemaiale')
AddEventHandler('esx_macellaiosdr:carnemaiale', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('maiale', Config.Maiale)
end)
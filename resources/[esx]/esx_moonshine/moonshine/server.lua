ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_moonshine:inventario')
AddEventHandler('esx_moonshine:inventario', function(numero)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('moonshine', numero)
end)

RegisterServerEvent('esx_moonshine:vendita')
AddEventHandler('esx_moonshine:vendita', function(moonshineSold, moonshineSoldPrice)

	local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.addAccountMoney('black_money', moonshineSoldPrice)
	xPlayer.removeInventoryItem('moonshine', moonshineSold)
end)

ESX.RegisterServerCallback('esx_moonshine:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

ESX.RegisterUsableItem('moonshine', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('moonshine', 1)

	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx_optionalneeds:moonshine', source)
	--TriggerClientEvent('esx:showNotification', source, _U('used_beer'))

end)
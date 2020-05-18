ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('treni:price')
AddEventHandler('treni:price', function(prezzo)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
		xPlayer.removeMoney((prezzo))
end)

ESX.RegisterServerCallback('treni:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local soldiplayer = xPlayer.get('money')

	cb(soldiplayer)
end)
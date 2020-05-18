ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vf_cinema:watch')
AddEventHandler('vf_cinema:watch', function(price)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
    local price = 10

	if xPlayer.get('money') >= price then

		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', _source, "Hai pagato 10 dollari per il cinema")
		TriggerClientEvent('vf_cinema:enter', _source, true)
	else
	   TriggerClientEvent('esx:showNotification', _source, "Non hai abbastanza soldi!")
    end
end)
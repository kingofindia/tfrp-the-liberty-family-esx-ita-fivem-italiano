ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("puttanatroia:removeMoney")
AddEventHandler("puttanatroia:removeMoney", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vanilla', function(account)
	account.addMoney(500)
    end)
	xPlayer.removeMoney(500)

end)

RegisterServerEvent("puttanatroia:removeMoney2")
AddEventHandler("puttanatroia:removeMoney2", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vanilla', function(account)
	account.addMoney(1500)
    end)
	xPlayer.removeMoney(1500)

end)

ESX.RegisterServerCallback("puttanatroia:checkMoney", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.get('money') >= 500)
end)

ESX.RegisterServerCallback("puttanatroia:checkMoney2", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.get('money') >= 1500)
end)
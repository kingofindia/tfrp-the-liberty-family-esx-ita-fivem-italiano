ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fineAmount')
AddEventHandler('fineAmount', function(mphspeed)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		societyAccount = account
	end)

	local truespeed = mphspeed
	if truespeed >= 55 and truespeed <= 65 then
	--xPlayer.removeMoney(Config.Fine)
	xPlayer.removeAccountMoney('bank', Config.Fine)
	societyAccount.addMoney(Config.Fine)
	end
	if truespeed >= 65 and truespeed <= 75 then
	xPlayer.removeAccountMoney('bank', Config.Fine2)
	societyAccount.addMoney(Config.Fine2)
	end
	if truespeed >= 75 and truespeed <= 85 then
	xPlayer.removeAccountMoney('bank', Config.Fine3)
	societyAccount.addMoney(Config.Fine3)
	end
	if truespeed >= 85 and truespeed <= 200 then
	xPlayer.removeAccountMoney('bank', Config.Fine4)
	societyAccount.addMoney(Config.Fine4)
	end
	CancelEvent()
end)

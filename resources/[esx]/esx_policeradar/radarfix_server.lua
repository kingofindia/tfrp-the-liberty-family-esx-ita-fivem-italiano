--[[ RegisterServerEvent('paiement:radar')
AddEventHandler('paiement:radar', function(prix)
  local source = source
    TriggerEvent('es:getPlayerFromId', source, function(user)
        user.removeBank(prix)
    end)
end) ]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('paiement:radar')
AddEventHandler('paiement:radar', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	--local xPlayers = ESX.GetPlayers()

	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		societyAccount = account
	end)

  --local unsesto = math.floor(societyAccount.money / 18)
  
    --xPlayer.removeMoney(250)
    societyAccount.addMoney(prixcontravention)
   
end)

RegisterServerEvent('pagamento:mecano')
AddEventHandler('pagamento:mecano', function()
  local source = source
  local xPlayer = ESX.getPlayerFromId(source)

  local societyAccount = nil
  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mecano', function(account)
    societyAccount = account
  end)

  societyAccount.removeMoney(prixcontravention)
end)
--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit2')
AddEventHandler('bank:deposit2', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('chatMessage', _source, "Importo non valido")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
	end
end)


RegisterServerEvent('bank:withdraw2')
AddEventHandler('bank:withdraw2', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('chatMessage', _source, "Importo non valido")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
	end
end)

RegisterServerEvent('bank:balance2')
AddEventHandler('bank:balance2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)


RegisterServerEvent('bank:transfer2')
AddEventHandler('bank:transfer2', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	
	--Thanks to (LuCampbell)
	TriggerEvent('es:getPlayerFromId', xPlayer, function(user)
		if (tonumber(user.money) >= tonumber(amountt)) then
			local player = user.identifier
			user:removeMoney((amountt))	
		
			TriggerEvent('es:getPlayerFromId', zPlayer, function(user2)
				local player2 = user2.identifier
				user2:addMoney((amountt))
				TriggerClientEvent("chatMessage", zPlayer , "Hai ricevuto denaro ", { 52, 201, 36 }, "Hai ricevuto la somma di "..amountt.." dollari")
				TriggerClientEvent("chatMessage", xPlayer, "Payment receipt ", { 255, 0, 0 }, "Il tuo pagamento di "..amountt.." dollari è stato confermato")
			end)	
		else
			if (tonumber(user.money) < tonumber(amountt)) then
			
				TriggerClientEvent("chatMessage", player, "", { 255, 0, 0 }, "Non hai abbastanza sold")
			end
		end
	end) 
end)






ESX               = nil
local ItemsLabels = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()

	MySQL.Async.fetchAll(
		'SELECT * FROM items',
		{},
		function(result)

			for i=1, #result, 1 do
				ItemsLabels[result[i].name] = result[i].label
			end

		end
	)

end)

ESX.RegisterServerCallback('esx_rich_ambulancechimico:requestDBItems', function(source, cb)

	MySQL.Async.fetchAll(
		'SELECT * FROM ambulancechimico',
		{},
		function(result)

			local distributorItems  = {}

			for i=1, #result, 1 do

				if distributorItems[result[i].name] == nil then
					distributorItems[result[i].name] = {}
				end

				table.insert(distributorItems[result[i].name], {
					name  = result[i].item,
					price = result[i].price,
					label = ItemsLabels[result[i].item]
				})

			end

			cb(distributorItems)

		end
	)

end)

RegisterServerEvent('esx_rich_ambulancechimico:buyItem')
AddEventHandler('esx_rich_ambulancechimico:buyItem', function(label, itemName, price)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	local itemQTY = xPlayer.getInventoryItem(itemName)

	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		societyAccount = account
	end)

	--if xPlayer.get('money') >= price then

		if itemQTY.limit ~= -1 and itemQTY.count >= itemQTY.limit then
			TriggerClientEvent('esx:showNotification', _source, 'Non hai abbastanza spazio nel tuo inventario')
		else
			TriggerClientEvent('esx:showNotification', _source, _U('bought') .. label)
			societyAccount.removeMoney(price)
			xPlayer.addInventoryItem(itemName, 1)
		end

		--TriggerClientEvent('esx:showNotification', _source, _U('bought') .. ItemsLabels[itemName])

	--else
	--	TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
	--end

end)

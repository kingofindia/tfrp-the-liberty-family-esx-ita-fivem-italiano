ESX = nil
local playersHealing = {}
local CopsConnected       	   = 0
local EmsConnected       	   = 0
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

function CountEms()

	local xPlayers = ESX.GetPlayers()

	EmsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			EmsConnected = EmsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountEms)
end

CountEms()

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		societyAccount = account
	end)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:revive', target)

		societyAccount.addMoney(Config.ReviveReward)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmounts

		ESX.showNotification('Hai pagato la rianimazione, 1000$')
		--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'antibiotico' and itemName ~= 'sciroppo' and itemName ~= 'pomata') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('esx_ambulancejob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('esx_ambulancejob:revivecomm', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:revivecomm', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

--ESX.RegisterUsableItem('medikit', function(source)
	--if not playersHealing[source] then
		--local xPlayer = ESX.GetPlayerFromId(source)
		--xPlayer.removeInventoryItem('medikit', 1)

		--playersHealing[source] = true
		--TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		--Citizen.Wait(10000)
		--playersHealing[source] = nil
	--end
--end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead']     = isDead
	})
end)

--------------- 911 ADVANCED SYSTEM

ESX.RegisterServerCallback('esx_ambulancejob:contapoliziotti', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

ESX.RegisterServerCallback('esx_ambulancejob:contamedici', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(EmsConnected)
end)

-------------------------------- gruppo sanguigno

local function getRandomChar()
	local validChars = {"A+", "A-", "B+", "B-", "AB+", "AB-", "0+", "0-"}
	return validChars[math.random(1, #validChars)]
end

RegisterServerEvent('esx_ambulancejob:creaGruppo')
AddEventHandler('esx_ambulancejob:creaGruppo', function( src )
  math.randomseed(math.floor(os.time() + math.random(1000)))

  local _source = source
  local identifier = nil

  if src == nil then
    identifier = ESX.GetPlayerFromId(_source).identifier
  else
    identifier = ESX.GetPlayerFromId(src).identifier
  end

  local account = getRandomChar()

  MySQL.Async.fetchAll('SELECT account FROM gruppo_sanguigno WHERE account = @account', {},
  function (result)
    if (result[1] == nil) then
      MySQL.Async.fetchAll('SELECT identifier FROM gruppo_sanguigno WHERE identifier = @identifier', {['@identifier'] = identifier},
      function (result)
        if (result[1] == nil) then
          MySQL.Async.execute('INSERT INTO gruppo_sanguigno (identifier, account) VALUES (@identifier, @account)',
            {
              ['@identifier']   = identifier,
              ['@account']      = account
            }
          )
        end
      end)
    else
      TriggerEvent('esx_ambulancejob:creaGruppo', _source)
    end
  end)
end)


ESX.RegisterServerCallback('esx_ambulancejob:verifica', function(source, cb)
  local _source = source
	local identifier = ESX.GetPlayerFromId(_source).identifier
  local userData = {}

      MySQL.Async.fetchAll('SELECT account FROM gruppo_sanguigno WHERE identifier = @identifier', {['@identifier'] = identifier},
      function (resulto)
        if (resulto[1] ~= nil) then
            account = resulto[1].account
          cb(account)
        end
      end)
end)

RegisterServerEvent('esx_ambulancejob:donazione')
AddEventHandler('esx_ambulancejob:donazione', function( src )

  local _source = source
	local identifier = nil
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.fetchAll('SELECT account FROM gruppo_sanguigno WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (resulto)
		if (resulto[1] ~= nil) then
				account = resulto[1].account
			cb(account)
		end
	end)
  
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)

			if account == 'AB+' then 
			  inventory.addItem('sangueab+', 1)
			elseif account == 'AB-' then
			  inventory.addItem('sangueab-', 1)
		  elseif account == 'A+' then
				inventory.addItem('sanguea+', 1)
			elseif account == 'A-' then
				inventory.addItem('sanguea-', 1)
			elseif account == 'B+' then
				inventory.addItem('sangueb+', 1)
			elseif account == 'B-' then
				inventory.addItem('sangueb-', 1)
			elseif account == '0+' then
				inventory.addItem('sangue0+', 1)
			elseif account == '0-' then
				inventory.addItem('sangue0-', 1)
			end
			TriggerClientEvent('mt:missiontext', _source, 'Il tuo gruppo sanguigno è ~g~' .. account, 10000)
		end)
end)

------------------------------------------------------------------------ inventario

ESX.RegisterServerCallback('esx_ambulancejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, 'Quantità non valida')
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, ('Hai prelevato' .. count .. inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, 'Quantità non valida')
		end
	end)

end)

RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, ('Hai depositato' .. count .. inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantità non valida')
		end

	end)

end)

-------------------------------------------------------------------------- USO DELLE SACCHE

ESX.RegisterUsableItem('sangue0-', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sangue0-', 1)
	TriggerClientEvent('esx_ambulancejob:curacompleta', source)

end)

ESX.RegisterUsableItem('sangue0+', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sangue0+', 1)
	TriggerClientEvent('esx_ambulancejob:controllausoo+', source)

end)

ESX.RegisterUsableItem('sanguea-', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sanguea-', 1)
	TriggerClientEvent('esx_ambulancejob:controllausoa-', source)

end)

ESX.RegisterUsableItem('sanguea+', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sanguea+', 1)
	TriggerClientEvent('esx_ambulancejob:controllausoa+', source)

end)

ESX.RegisterUsableItem('sangueb-', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sangueb-', 1)
	TriggerClientEvent('esx_ambulancejob:controllausob-', source)

end)

ESX.RegisterUsableItem('sangueb+', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sangueb+', 1)
	TriggerClientEvent('esx_ambulancejob:controllausob+', source)

end)

ESX.RegisterUsableItem('sangueab-', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sangueab-', 1)
	TriggerClientEvent('esx_ambulancejob:controllausoab-', source)

end)

ESX.RegisterUsableItem('sangueab+', function(source)	
	
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sangueab+', 1)
	TriggerClientEvent('esx_ambulancejob:controllausoab+', source)

end)

---------------------------------------------- wipe

RegisterServerEvent('cancellatutto:porcodio')
AddEventHandler('cancellatutto:porcodio', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('DELETE FROM users WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM characters WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM user_accounts WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM addon_account_data WHERE owner = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE owner = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM billing WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM jsfour_atm WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM jsfour_criminalrecord WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM jsfour_criminaluserinfo WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM motel WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM owned_properties WHERE owner = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM owned_shops WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM user_inventory WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM shipments WHERE identifier = @steamid',
{
	['@steamid']  = xPlayer.identifier
})
MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @steamid',
{
	['@steamid']  = xPlayer.identifier
})

TriggerClientEvent('esx:showNotification', source, 'IL TUO PERSONAGGIO E\' STATO RESETTATO. ESCI E RIENTRA!')
end)

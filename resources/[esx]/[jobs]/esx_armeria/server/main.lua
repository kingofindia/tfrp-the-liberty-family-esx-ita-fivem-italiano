ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'armeria', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'armeria', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'armeria', 'armeria', 'society_armeria', 'society_armeria', 'society_armeria', {type = 'public'})

RegisterServerEvent('esx_armeria:giveWeapon')
AddEventHandler('esx_armeria:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('esx_armeria:confiscatePlayerItem')
AddEventHandler('esx_armeria:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterServerEvent('esx_armeria:handcuff')
AddEventHandler('esx_armeria:handcuff', function(target)
  TriggerClientEvent('esx_armeria:handcuff', target)
end)

RegisterServerEvent('esx_armeria:drag')
AddEventHandler('esx_armeria:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_armeria:drag', target, _source)
end)

RegisterServerEvent('esx_armeria:putInVehicle')
AddEventHandler('esx_armeria:putInVehicle', function(target)
  TriggerClientEvent('esx_armeria:putInVehicle', target)
end)

RegisterServerEvent('esx_armeria:OutVehicle')
AddEventHandler('esx_armeria:OutVehicle', function(target)
    TriggerClientEvent('esx_armeria:OutVehicle', target)
end)

RegisterServerEvent('esx_armeria:getStockItem')
AddEventHandler('esx_armeria:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_armeria', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('esx_armeria:putStockItems')
AddEventHandler('esx_armeria:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_armeria', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('esx_armeria:getOtherPlayerData', function(source, cb, target)

  if Config.EnableESXIdentity then

    local xPlayer = ESX.GetPlayerFromId(target)

    local identifier = GetPlayerIdentifiers(target)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
      ['@identifier'] = identifier
    })

    local user          = result[1]
    local firstname     = user['firstname']
    local lastname      = user['lastname']
    local sex           = user['sex']
    local dob           = user['dateofbirth']
    local height        = user['height'] .. " Inches"

    local data = {
      name        = GetPlayerName(target),
      job         = xPlayer.job,
      inventory   = xPlayer.inventory,
      accounts    = xPlayer.accounts,
      weapons     = xPlayer.loadout,
      firstname   = firstname,
      lastname    = lastname,
      sex         = sex,
      dob         = dob,
      height      = height
    }

    TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    if Config.EnableLicenses then

      TriggerEvent('esx_license:getLicenses', target, function(licenses)
        data.licenses = licenses
        cb(data)
      end)

    else
      cb(data)
    end

  else

    local xPlayer = ESX.GetPlayerFromId(target)

    local data = {
      name       = GetPlayerName(target),
      job        = xPlayer.job,
      inventory  = xPlayer.inventory,
      accounts   = xPlayer.accounts,
      weapons    = xPlayer.loadout
    }

    TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    TriggerEvent('esx_license:getLicenses', target, function(licenses)
      data.licenses = licenses
    end)

    cb(data)

  end

end)

ESX.RegisterServerCallback('esx_armeria:getArmoryWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_armeria', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_armeria:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

  local xPlayer = ESX.GetPlayerFromId(source)

  if removeWeapon then
   xPlayer.removeWeapon(weaponName)
  end

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_armeria', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_armeria:removeArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_armeria', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)


ESX.RegisterServerCallback('esx_armeria:buy', function(source, cb, amount)

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_armeria', function(account)

    if account.money >= amount then
      account.removeMoney(amount)
      cb(true)
    else
      cb(false)
    end

  end)

end)

ESX.RegisterServerCallback('esx_armeria:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_armeria', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_armeria:getPlayerInventory', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)
  local items   = xPlayer.inventory

  cb({
    items = items
  })

end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'armeria' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_armeria:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_armeria:spawned')
AddEventHandler('esx_armeria:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'armeria' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_armeria:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_armeria:forceBlip')
AddEventHandler('esx_armeria:forceBlip', function()
	TriggerClientEvent('esx_armeria:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_armeria:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'armeria')
	end
end)

RegisterServerEvent('esx_armeria:message')
AddEventHandler('esx_armeria:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('esx_armeria:giub')
AddEventHandler('esx_armeria:giub', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= 800 then

    xPlayer.removeMoney(800)
    xPlayer.addInventoryItem('giub', 1)
  else
    TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
  end
end)

RegisterServerEvent('esx_armeria:coltello')
AddEventHandler('esx_armeria:coltello', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= 350 then

    xPlayer.removeMoney(350)
    xPlayer.addInventoryItem('coltello', 1)
  else
    TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
  end
end)

RegisterServerEvent('esx_armeria:mazza')
AddEventHandler('esx_armeria:mazza', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= 150 then

    xPlayer.removeMoney(150)
    xPlayer.addInventoryItem('mazza', 1)
  else
    TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
  end
end)

RegisterServerEvent('esx_armeria:torcia')
AddEventHandler('esx_armeria:torcia', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= 120 then

    xPlayer.removeMoney(120)
    xPlayer.addInventoryItem('torcia', 1)
  else
    TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
  end
end)

RegisterServerEvent('esx_armeria:gas')
AddEventHandler('esx_armeria:gas', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= 120000 then

    xPlayer.removeMoney(120000)
    xPlayer.addInventoryItem('gas', 25)
  else
    TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
  end
end)

RegisterServerEvent('esx_armeria:tanica')
AddEventHandler('esx_armeria:tanica', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= 150 then

    xPlayer.removeMoney(150)
    xPlayer.addInventoryItem('tanica', 1)
  else
    TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
  end
end)

  ESX.RegisterUsableItem('pistola', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('pistola', 1)
    xPlayer.addWeapon('WEAPON_PISTOL', 0)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato una pistola')
  end)

  ESX.RegisterServerCallback('esx_armeria:contrmpistol', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pistolaQuantity = xPlayer.getInventoryItem('mpistola').count

      cb(pistolaQuantity)
end)

  ESX.RegisterUsableItem('mpistola', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_basicneeds:onPistol', source)
end)

ESX.RegisterUsableItem('ak', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('ak', 1)
  xPlayer.addWeapon('WEAPON_ASSAULTRIFLE', 0)

  TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato un AK')
end)

ESX.RegisterUsableItem('mak', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_basicneeds:onAK', source)
end)

ESX.RegisterUsableItem('cecchino', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('cecchino', 1)
  xPlayer.addWeapon('WEAPON_MARKSMANRIFLE', 0)

  TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato un cecchino')
end)

ESX.RegisterUsableItem('mcecchino', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_basicneeds:onCecchino', source)
end)

ESX.RegisterServerCallback('esx_armeria:contrmak', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local makQUANTUT = xPlayer.getInventoryItem('mak').count

      cb(makQUANTUT)
end)

ESX.RegisterServerCallback('esx_armeria:contrmcecchino', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local cecchinoQuantity = xPlayer.getInventoryItem('mcecchino').count

      cb(cecchinoQuantity)
end)

RegisterServerEvent('esx_armeria:toglimcecchino')
AddEventHandler('esx_armeria:toglimcecchino', function(Testo9)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mcecchino', Testo9)

end)

RegisterServerEvent('esx_armeria:toglimpistola')
AddEventHandler('esx_armeria:toglimpistola', function(Testo)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mpistola', Testo)

end)

  ESX.RegisterUsableItem('coltello', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('coltello', 1)
    xPlayer.addWeapon('WEAPON_KNIFE', 1)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato un coltello')
  end)

  ESX.RegisterUsableItem('mazza', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('mazza', 1)
    xPlayer.addWeapon('WEAPON_BAT', 1)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato una mazza')
  end)

  ESX.RegisterUsableItem('torcia', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('torcia', 1)
    xPlayer.addWeapon('WEAPON_FLASHLIGHT', 1)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato una torcia')
  end)

  ESX.RegisterUsableItem('pompa', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('pompa', 1)
    xPlayer.addWeapon('WEAPON_PUMPSHOTGUN', 0)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato un fucile a pompa')
  end)

  ESX.RegisterServerCallback('esx_armeria:contrmpompa', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pompaQuantity = xPlayer.getInventoryItem('mpompa').count

      cb(pompaQuantity)
  end)

  ESX.RegisterUsableItem('mpompa', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_basicneeds:onPomp', source)
end)

RegisterServerEvent('esx_armeria:toglimpompa')
AddEventHandler('esx_armeria:toglimpompa', function(Testo2)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mpompa', Testo2)

end)
-------------------------------------------------------------------

  ESX.RegisterUsableItem('gas', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('gas', 1)
    xPlayer.addWeapon('WEAPON_SMOKEGRENADE', 1)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 25 granate a gas')
  end)

  ESX.RegisterUsableItem('tanica', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('tanica', 1)
    xPlayer.addWeapon('WEAPON_PETROLCAN', 250)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 1 tanica di benzina')
  end)

  ESX.RegisterUsableItem('smg', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('smg', 1)
    xPlayer.addWeapon('WEAPON_SMG', 0)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 1 SMG')
  end)

  ESX.RegisterServerCallback('esx_armeria:contrmsmg', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local smgQuantity = xPlayer.getInventoryItem('msmg').count

      cb(smgQuantity)
  end)

  ESX.RegisterUsableItem('msmg', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_basicneeds:onSmg', source)
end)

RegisterServerEvent('esx_armeria:toglimsmg')
AddEventHandler('esx_armeria:toglimsmg', function(Testo3)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('msmg', Testo3)

end)

RegisterServerEvent('esx_armeria:toglimak')
AddEventHandler('esx_armeria:toglimak', function(Testo6)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mak', Testo6)

end)

-----------------------------------------------------------------------------------

  ESX.RegisterUsableItem('manganello', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('manganello', 1)
    xPlayer.addWeapon('WEAPON_NIGHTSTICK', 1)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 1 manganello')
  end)

  ESX.RegisterUsableItem('combattimento', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('combattimento', 1)
    xPlayer.addWeapon('WEAPON_COMBATPISTOL', 0)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 1 pistola da combattimento')
  end)

  ESX.RegisterServerCallback('esx_armeria:contrmcom', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local comQuantity = xPlayer.getInventoryItem('mcom').count

      cb(comQuantity)
  end)

  ESX.RegisterUsableItem('mcom', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerClientEvent('esx_basicneeds:onCom', source)
end)

RegisterServerEvent('esx_armeria:toglimcom')
AddEventHandler('esx_armeria:toglimcom', function(Testo4)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mcom', Testo4)

end)
------------------------------------------------------------------------------------------------------------

  ESX.RegisterUsableItem('storditore', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('storditore', 1)
    xPlayer.addWeapon('WEAPON_STUNGUN', 250)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 1 storditore')
  end)

  ESX.RegisterUsableItem('gasdue', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeInventoryItem('gasdue', 1)
    xPlayer.addWeapon('WEAPON_BZGAS', 1)
  
    TriggerClientEvent('esx:showNotification', source, 'Hai equipaggiato 1 granata a gas')
  end)
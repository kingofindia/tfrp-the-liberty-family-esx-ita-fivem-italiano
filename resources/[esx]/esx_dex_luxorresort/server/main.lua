ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'nibba', 'Luxor Resort', 'society_nibba', 'society_nibba', 'society_nibba', {type = 'public'})

RegisterServerEvent('esx_dex_luxorresort:getStockItem')
AddEventHandler('esx_dex_luxorresort:getStockItem', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_nibba', function(inventory)

        local item = inventory.getItem(itemName)

        if item.count >= count then
            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)

            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Hai preso ' .. count .. ' ' .. item.label)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantità non valida')
        end
    end)
end)

RegisterServerEvent('esx_dex_luxorresort:putStockItems')
AddEventHandler('esx_dex_luxorresort:putStockItems', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_nibba', function(inventory)

        local item = inventory.getItem(itemName)

        if item.count >= 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)

            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Hai depositato ' .. count .. ' ' .. item.label)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantità non valida')
        end
    end)
end)

ESX.RegisterServerCallback('esx_dex_luxorresort:getArmoryWeapons', function(source, cb)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_nibba', function(store)
  
        local weapons = store.get('weapons')
  
        if weapons == nil then
            weapons = {}
        end
  
        cb(weapons)
  
    end)
end)
  
ESX.RegisterServerCallback('esx_dex_luxorresort:addArmoryWeapon', function(source, cb, weaponName)  
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.removeWeapon(weaponName)
  
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_nibba', function(store)
  
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
            table.insert(weapons, {name  = weaponName, count = 1})
        end
  
       store.set('weapons', weapons)
  
       cb()
  
    end)
end)
  
ESX.RegisterServerCallback('esx_dex_luxorresort:removeArmoryWeapon', function(source, cb, weaponName)  
    local xPlayer = ESX.GetPlayerFromId(source)
  
    xPlayer.addWeapon(weaponName, 1000)
  
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_nibba', function(store)
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
            table.insert(weapons, {name  = weaponName, count = 0})
        end
  
        store.set('weapons', weapons)
  
        cb()

    end)  
end)
  
ESX.RegisterServerCallback('esx_dex_luxorresort:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_nibba', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_dex_luxorresort:getBlackMoney')
AddEventHandler('esx_dex_luxorresort:getBlackMoney', function(type, item, count)
    if type == 'item_account' then
        
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nibba', function(account)
            local BlacKMoneyG = account.money

            if BlacKMoneyG >= count then
                account.removeMoney(count)
                xPlayer.addAccountMoney(item, count)
            else
                TriggerClientEvent('esx:showNotification', _source, 'Importo non valido')
            end
        end)
    end
end)

RegisterServerEvent('esx_dex_luxorresort:putBlackMoney')
AddEventHandler('esx_dex_luxorresort:putBlackMoney', function(type, item, count)
    local _source      = source
    local xPlayer      = ESX.GetPlayerFromId(_source)
    
    if type == 'item_account' then
        
        local playerAccountMoney = xPlayer.getAccount(item).money

        if playerAccountMoney >= count and count > 0 then
            xPlayer.removeAccountMoney(item, count)

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nibba', function(account)
                account.addMoney(count)
            end)
        else
            TriggerClientEvent('esx:showNotification', _source, 'Importo non valido')
        end
    end
end)

ESX.RegisterServerCallback('esx_dex_luxorresort:getStockBlackMoney', function(source, cb)
    local blackMoney = 0

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nibba', function(account)
        blackMoney = account.money
        
        cb(blackMoney)
	end)
end)
  
ESX.RegisterServerCallback('esx_dex_luxorresort:getPlayerInventory', function(source, cb)  
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount('black_money').money
    local items   = xPlayer.inventory
  
    cb({
        blackMoney = blackMoney,
        items = items
    })  
end)
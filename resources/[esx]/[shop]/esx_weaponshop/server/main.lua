ESX = nil
local CopsConnected       	   = 0
local shopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'armeria' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM weashops', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end

			table.insert(shopItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				label = ESX.GetWeaponLabel(result[i].item)
			})
		end

		TriggerClientEvent('esx_weaponshop:sendShop', -1, shopItems)
	end)

end)

function LoadLicenses (source)
	TriggerEvent('esx_license:getLicenses', source, function (licenses)
	  TriggerClientEvent('esx_weashop:loadLicenses', source, licenses)
	end)
  end

ESX.RegisterServerCallback('esx_weaponshop:getShop', function(source, cb)
	cb(shopItems)
end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		--TriggerEvent('esx_license:addLicense', source, 'testarmi', function()
			cb(true)
		--end)
	else
		cb(false)
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
	end
end)

ESX.RegisterServerCallback('esx_weaponshop:buyWeapon', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)

	if price == 0 then
		print(('esx_weaponshop: %s attempted to buy a unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('esx:showNotification', source, _U('already_owned'))
		cb(false)
	else
		if zone == 'BlackWeashop' then

			if xPlayer.getAccount('black_money').money >= price then
				xPlayer.removeAccountMoney('black_money', price)
				xPlayer.addWeapon(weaponName, 42)

				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_black'))
				cb(false)
			end

		else

			if xPlayer.getMoney() >= price then
				xPlayer.removeMoney(price)
				xPlayer.addWeapon(weaponName, 42)

				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
				cb(false)
			end
	
		end
	end
end)

RegisterServerEvent('esx_weaponshop:licenzaok')
AddEventHandler('esx_weaponshop:licenzaok', function ()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_license:addLicense', source, 'testarmi', function()
		LoadLicenses(_source)
		end)

end)

RegisterServerEvent('esx_weaponshop:buyItem')
AddEventHandler('esx_weaponshop:buyItem', function(weaponName, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = GetPrice(weaponName, zone)

	--if xPlayer.hasWeapon(weaponName) then
		--TriggerClientEvent('esx:showNotification', _source, _U('already_owned'))
		--return
	--end

	if zone == 'BlackWeashop' then

		if xPlayer.getAccount('black_money').money >= price then
			xPlayer.removeAccountMoney('black_money', price)
			xPlayer.addWeapon(weaponName, 42)
			TriggerClientEvent('esx:showNotification', _source, _U('buy', ESX.GetWeaponLabel(weaponName), price))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_black'))
		end

	else
        if CopsConnected < 1 then
		    if xPlayer.getMoney() >= price then
			    xPlayer.removeMoney(price)
			    xPlayer.addWeapon(weaponName, 42)
			    TriggerClientEvent('esx:showNotification', _source, _U('buy', ESX.GetWeaponLabel(weaponName), price))
			else
				local missingMoney = price - xPlayer.get('money')
			    TriggerClientEvent('esx:showNotification', _source, 'Non hai abbastanza soldi! Ti mancano ' .. missingMoney .. ' ~b~dollari!')
			end
		else
			TriggerClientEvent('esx:showNotification', _source, 'Ci sono già ~r~' .. CopsConnected .. ' ~b~venditori di armi online')
        end
	end
end)

function GetPrice(weaponName, zone)
	local result = MySQL.Sync.fetchAll('SELECT price FROM weashops WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	return result[1].price
end

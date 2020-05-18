local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				local array = {
					user = user,
					licenses = licenses
				}
				TriggerClientEvent('jsfour-idcard:open', _source, array, type)
			end)
		end
	end)
end)

RegisterServerEvent('jsfour-idcard:pistola')
AddEventHandler('jsfour-idcard:pistola', function(pedAmmo)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)


  xPlayer.removeWeapon('WEAPON_PISTOL', 250)
  xPlayer.addInventoryItem('pistola', 1)
  xPlayer.addInventoryItem('mpistola', pedAmmo)
	
end)

RegisterServerEvent('jsfour-idcard:munizionipistola')
AddEventHandler('jsfour-idcard:munizionipistola', function(Testo)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  

  xPlayer.addInventoryItem('mpistola', Testo)
	
end)

RegisterServerEvent('jsfour-idcard:ak')
AddEventHandler('jsfour-idcard:ak', function(pedAmmo91)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)

    xPlayer.removeWeapon('WEAPON_ASSAULTRIFLE', 250)
    xPlayer.addInventoryItem('ak', 1)
    xPlayer.addInventoryItem('mak', pedAmmo91)
	
end)

RegisterServerEvent('jsfour:message')
AddEventHandler('jsfour:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('jsfour-idcard:coltello')
AddEventHandler('jsfour-idcard:coltello', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_KNIFE', 1)
	xPlayer.addInventoryItem('coltello', 1)
	
end)

RegisterServerEvent('jsfour-idcard:mazza')
AddEventHandler('jsfour-idcard:mazza', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_BAT', 1)
	xPlayer.addInventoryItem('mazza', 1)
	
end)

RegisterServerEvent('jsfour-idcard:pompa')
AddEventHandler('jsfour-idcard:pompa', function(pedAmmo2)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_PUMPSHOTGUN', 250)
    xPlayer.addInventoryItem('pompa', 1)
    xPlayer.addInventoryItem('mpompa', pedAmmo2)
	
end)

RegisterServerEvent('jsfour-idcard:munizionipompa')
AddEventHandler('jsfour-idcard:munizionipompa', function(Testo2)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  

  xPlayer.addInventoryItem('mpompa', Testo2)
	
end)

RegisterServerEvent('jsfour-idcard:gas')
AddEventHandler('jsfour-idcard:gas', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_SMOKEGRENADE', 1)
	xPlayer.addInventoryItem('gas', 1)
	
end)

RegisterServerEvent('jsfour-idcard:uzi')
AddEventHandler('jsfour-idcard:uzi', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_MICROSMG', 500)
	xPlayer.addInventoryItem('uzi', 1)
	
end)

RegisterServerEvent('jsfour-idcard:torcia')
AddEventHandler('jsfour-idcard:torcia', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_FLASHLIGHT', 1)
	xPlayer.addInventoryItem('torcia', 1)
	
end)

RegisterServerEvent('jsfour-idcard:tanica')
AddEventHandler('jsfour-idcard:tanica', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_PETROLCAN', 500)
	xPlayer.addInventoryItem('tanica', 1)
	
end)

RegisterServerEvent('jsfour-idcard:smg')
AddEventHandler('jsfour-idcard:smg', function(pedAmmo3)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_SMG', 500)
    xPlayer.addInventoryItem('smg', 1)
    xPlayer.addInventoryItem('msmg', pedAmmo3)
	
end)

RegisterServerEvent('jsfour-idcard:munizionismg')
AddEventHandler('jsfour-idcard:munizionismg', function(Testo3)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  

  xPlayer.addInventoryItem('msmg', Testo3)
	
end)

RegisterServerEvent('jsfour-idcard:munizionicarabinaspeciale')
AddEventHandler('jsfour-idcard:munizionicarabinaspeciale', function(TestoCiao)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.addInventoryItem('mcarabinaspeciale', TestoCiao)
end)

RegisterServerEvent('jsfour-idcard:carabina')
AddEventHandler('jsfour-idcard:carabina', function(testo16)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon('WEAPON_CARBINERIFLE', 500)
  xPlayer.addInventoryItem('carabina', 1)
  xPlayer.addInventoryItem('mcarabinaspeciale', testo16)
end)

RegisterServerEvent('jsfour-idcard:cecchino')
AddEventHandler('jsfour-idcard:cecchino', function(pedAmmo9)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)

    xPlayer.removeWeapon('WEAPON_MARKSMANRIFLE', 500)
    xPlayer.addInventoryItem('cecchino', 1)
    xPlayer.addInventoryItem('mcecchino', pedAmmo9)
	
end)

RegisterServerEvent('jsfour-idcard:manganello')
AddEventHandler('jsfour-idcard:manganello', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_NIGHTSTICK', 1)
	xPlayer.addInventoryItem('manganello', 1)
	
end)

RegisterServerEvent('jsfour-idcard:combattimento')
AddEventHandler('jsfour-idcard:combattimento', function(pedAmmo4)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_COMBATPISTOL', 500)
    xPlayer.addInventoryItem('combattimento', 1)
    xPlayer.addInventoryItem('mcom', pedAmmo4)
	
end)

RegisterServerEvent('jsfour-idcard:munizionicom')
AddEventHandler('jsfour-idcard:munizionicom', function(Testo4)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  

  xPlayer.addInventoryItem('mcom', Testo4)
	
end)

RegisterServerEvent('jsfour-idcard:storditore')
AddEventHandler('jsfour-idcard:storditore', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_STUNGUN', 500)
	xPlayer.addInventoryItem('storditore', 1)
	
end)

RegisterServerEvent('jsfour-idcard:gasdue')
AddEventHandler('jsfour-idcard:gasdue', function()

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

    xPlayer.removeWeapon('WEAPON_BZGAS', 1)
	xPlayer.addInventoryItem('gasdue', 1)
	
end)

RegisterServerEvent('jsfour-idcard:handcuff')
AddEventHandler('jsfour-idcard:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('jsfour-idcard:handcuff', target)

end)

RegisterServerEvent('jsfour-idcard:compramanette')
AddEventHandler('jsfour-idcard:compramanette', function()
local _source = source
local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeMoney(20000)
  xPlayer.addInventoryItem('manette', 1)

end)

ESX.RegisterServerCallback('jsfouridcard:haisoldi', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.get('money') >= 20000)
end)

ESX.RegisterServerCallback('jsfour-idcard:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)


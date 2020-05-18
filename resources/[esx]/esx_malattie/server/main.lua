ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('sciroppo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sciroppo', 1)

	TriggerClientEvent('esx_basicneeds:sciroppo', source)
  	TriggerClientEvent('esx_malattie:guarigionetosse', source)
	
end)

ESX.RegisterUsableItem('antibiotico', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('antibiotico', 1)

	TriggerClientEvent('esx_basicneeds:sciroppo', source)
	TriggerClientEvent('esx_malattie:guarigionestomaco', source)
	
end)

ESX.RegisterUsableItem('pomata', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pomata', 1)

	TriggerClientEvent('esx_malattie:guarigionepelle', source)

end)

RegisterServerEvent('esx_malattie:malato')
AddEventHandler('esx_malattie:malato', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET malato = @malato WHERE identifier = @identifier',
	{
		['@malato'] = 'si',
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_malattie:malatostomaco')
AddEventHandler('esx_malattie:malatostomaco', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET malatostomaco = @malatostomaco WHERE identifier = @identifier',
	{
		['@malatostomaco'] = 'si',
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_malattie:malatopelle')
AddEventHandler('esx_malattie:malatopelle', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET malatopelle = @malatopelle WHERE identifier = @identifier',
	{
		['@malatopelle'] = 'si',
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_malattie:guarito')
AddEventHandler('esx_malattie:guarito', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET malato = @malato WHERE identifier = @identifier',
	{
		['@malato'] = 'no',
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_malattie:guaritostomaco')
AddEventHandler('esx_malattie:guaritostomaco', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET malatostomaco = @malatostomaco WHERE identifier = @identifier',
	{
		['@malatostomaco'] = 'no',
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_malattie:guaritopelle')
AddEventHandler('esx_malattie:guaritopelle', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET malatopelle = @malatopelle WHERE identifier = @identifier',
	{
		['@malatopelle'] = 'no',
		['@identifier']  = xPlayer.identifier
	})

end)

ESX.RegisterServerCallback('esx_malattie:quadroclinico', function(source, cb)
  local _source = source
	local identifier = ESX.GetPlayerFromId(_source).identifier
  local userData = {}

      MySQL.Async.fetchAll('SELECT malato FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
      function (resulto)
        if (resulto[1] ~= nil) then
            malato = resulto[1].malato
          cb(malato)
        end
      end)
end)

ESX.RegisterServerCallback('esx_malattie:quadroclinicostomaco', function(source, cb)
  local _source = source
	local identifier = ESX.GetPlayerFromId(_source).identifier
  local userData = {}

      MySQL.Async.fetchAll('SELECT malatostomaco FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
      function (resulto)
        if (resulto[1] ~= nil) then
            malatostomaco = resulto[1].malatostomaco
          cb(malatostomaco)
        end
      end)
end)

ESX.RegisterServerCallback('esx_malattie:quadroclinicopelle', function(source, cb)
	local _source = source
	local identifier = ESX.GetPlayerFromId(_source).identifier
	local userData = {}

	MySQL.Async.fetchAll('SELECT malatopelle FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (resulto)
		if (resulto[1] ~= nil) then
			malatopelle = resulto[1].malatopelle
			cb(malatopelle)
		end
	end)
end)
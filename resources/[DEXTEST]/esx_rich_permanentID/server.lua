ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function GetIdentifier(id)
    local identifiers = GetPlayerIdentifiers(id)
    local player = GetIdentifiant(identifiers)
    return player
end

TriggerEvent('es:addGroupCommand', 'getname', 'admin', function(source, args, user)
    if args[1] then
        MySQL.Async.fetchAll('SELECT name, identifier FROM users WHERE id = @id', {
            ['@id'] = args[1]
        }, function(ris)
            TriggerClientEvent('chat:addMessage', source, { args = { '^1Informazioni', 'Nome del giocatore: ' .. ris[1].name .. ' identificativo: ' .. ris[1].identifier } })
        end)
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Devi inserire l\'id permanente' } })
    end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Permessi insufficeinti.' } })
end, {help = 'Restituisce il nome e le informazioni del giocatore dell\'id permanente inserito'})

ESX.RegisterServerCallback('esx_rich_id:getNearID', function(source, cb, target)
    MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier = @identifier', {
        ['@identifier'] = GetIdentifier(target)
    }, function(riusltato)
		cb(riusltato[1].id)
    end)
end)

AddEventHandler('es:firstSpawn', function(source, user) 
	local xPlayers = ESX.GetPlayers()

	MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetIdentifier(source)
	}, function(result)
		for k, v in pairs(xPlayers) do
			TriggerClientEvent('esx_rich_permanentID:addUser', source, k, v)
			TriggerClientEvent('esx_rich_permanentID:addUser', v, result[1].id, source)
		end
	end)
end)

--[[ AddEventHandler('es:playerDropped', function(user)
	local xPlayers = ESX.GetPlayers()

	MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier = @identifier', {
		['@identifier'] = user.GetIdentifiant
	}, function(result)
		for k, v in pairs(xPlayers) do
			TriggerClientEvent('esx_rich_permanentID:removeUser', v, result[1].id)
		end
	end)
end) ]]

AddEventHandler('playerDropped', function(source, reason)
    local xPlayers = ESX.GetPlayers()

	MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetIdentifier(source)
	}, function(result)
		for k, v in pairs(xPlayers) do
			TriggerClientEvent('esx_rich_permanentID:removeUser', v, result[1].id)
		end
	end)
end)
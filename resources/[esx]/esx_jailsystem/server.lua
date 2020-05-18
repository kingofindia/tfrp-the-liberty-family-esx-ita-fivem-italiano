ESX = nil
local Jail = {}

local function JailPlayer(prison, time)
	local self = {}

	self.prison = prison
	self.time	= time

	local class = {}

	class.get = function(k)
		return self[k]
	end

	class.set = function(k, v)
		self[k] = v
	end

	return class
end

local function getUser(identifier, cb)
	if(Jail[identifier])then
		cb(Jail[identifier])
	else
		cb(false)
	end
end

AddEventHandler('playerDropped', function()
	local identifier = GetPlayerIdentifiers(source)[1]

	for k, v in pairs(Jail) do
		if(k == identifier)then
			MySQL.Sync.execute('UPDATE users SET jail = @data WHERE identifier = @identifier', {
				identifier = identifier,
				data = json.encode({prison = v.get('prison'), time = v.get('time')})
			})
		end
	end
end)

AddEventHandler('onMySQLReady', function()
		local result = MySQL.Sync.fetchAll('SELECT * FROM users')

		if(result[1])then
			for _, v in ipairs(result) do
				if(v.jail and v.jail ~= 0)then
					local data = json.decode(v.jail)
					if(data and data ~= 0)then
						local identifier = v.identifier
						Jail[identifier] = JailPlayer(data.prison, data.time)
					end
				end
			end
		end
end)

RegisterServerEvent('checkIfIsJailed')
AddEventHandler('checkIfIsJailed', function()
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]

	for k, v in pairs(Jail) do
		if(k == identifier)then

			local time = tonumber(v.get('time')) * 60
			TriggerClientEvent(v.get('prison'), src, time)
		end
	end
end)

RegisterServerEvent('updateJailTime')
AddEventHandler('updateJailTime', function(time)
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]

	getUser(identifier, function(user)
		user.set('time', time)
	end)
end)


RegisterServerEvent('unjailPlayer')
AddEventHandler('unjailPlayer', function()
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]

	MySQL.Async.execute('UPDATE users SET jail = @data', {data = 0})
	Jail[identifier] = nil
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jail:cella1')
AddEventHandler('jail:cella1', function(achi, minutini)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(achi)
    local defaultsecs = 5
    --local spese = 235
	
	jTsecs = minutini * 60

	if tonumber(achi) ~= nil and tonumber(minutini) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		TriggerClientEvent("JP1", achi, jTsecs)
		--xPlayer.addAccountMoney('bank', spese)
		--zPlayer.removeMoney(spese)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Hai messo in stato di fermo " .. GetPlayerName(achi) .. "!" ,
		type = "success",
		queue = "lmao",
		timeout = 10000,
		layout = "centerLeft"
		})
		TriggerClientEvent("pNotify:SendNotification", achi, {
		text = "Sei stato messo in stato di fermo per " .. minutini .. " minuti!" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
						--sounds = {
			            --sources = {"porcodio.ogg"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
			            --volume = 0.2,
			            --conditions = {"docVisible"} -- This means it will play the sound when the notification becomes visible.
		                --}
					})
					--TriggerClientEvent("pNotify:SendNotification", _source, {
						--text = "Il detenuto ha pagato 235 euro di spese" ,
						--type = "error",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})
					--TriggerClientEvent("pNotify:SendNotification", to, {
						--text = "Ti sono stati addebitati 235 euro di spese" ,
						--type = "error",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})

					local identifier = GetPlayerIdentifiers(achi)[1]
					Jail[identifier] = JailPlayer("JP1", jTsecs)
	end
	end
end)


RegisterServerEvent('jail:cella2')
AddEventHandler('jail:cella2', function(achidue, minutinidue)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(achidue)
    local defaultsecs = 5
    --local spese = 235
	
	jTsecs = minutinidue * 60

	if tonumber(achidue) ~= nil and tonumber(minutinidue) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		TriggerClientEvent("JP2", achidue, jTsecs)
		--xPlayer.addAccountMoney('bank', spese)
		--zPlayer.removeMoney(spese)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Hai messo in stato di fermo " .. GetPlayerName(achidue) .. "!" ,
		type = "success",
		queue = "lmao",
		timeout = 10000,
		layout = "centerLeft"
		})
		TriggerClientEvent("pNotify:SendNotification", achidue, {
		text = "Sei stato messo in stato di fermo per " .. minutinidue .. " minuti!" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
						--sounds = {
			            --sources = {"porcodio.ogg"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
			            --volume = 0.2,
			            --conditions = {"docVisible"} -- This means it will play the sound when the notification becomes visible.
		                --}
					})
					--TriggerClientEvent("pNotify:SendNotification", _source, {
						--text = "Il detenuto ha pagato 235 euro di spese" ,
						--type = "error",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})
					--TriggerClientEvent("pNotify:SendNotification", to, {
						--text = "Ti sono stati addebitati 235 euro di spese" ,
						--type = "error",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})

					local identifier = GetPlayerIdentifiers(achidue)[1]
					Jail[identifier] = JailPlayer("JP2", jTsecs)
	end
end
end)

RegisterServerEvent('jail:fermo')
AddEventHandler('jail:fermo', function(achitre, minutinitre)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(achitre)
    local defaultsecs = 5
    --local spese = 235
	
	jTsecs = minutinitre * 60

	if tonumber(achitre) ~= nil and tonumber(minutinitre) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		TriggerClientEvent("JP3", achitre, jTsecs)
		--xPlayer.addAccountMoney('bank', spese)
		--zPlayer.removeMoney(spese)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Hai messo in stato di fermo " .. GetPlayerName(achitre) .. "!" ,
		type = "success",
		queue = "lmao",
		timeout = 10000,
		layout = "centerLeft"
		})
		TriggerClientEvent("pNotify:SendNotification", achitre, {
		text = "Sei stato messo in stato di fermo per " .. minutinitre .. " minuti!" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
						--sounds = {
			            --sources = {"porcodio.ogg"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
			            --volume = 0.2,
			            --conditions = {"docVisible"} -- This means it will play the sound when the notification becomes visible.
		                --}
					})
					--TriggerClientEvent("pNotify:SendNotification", _source, {
						--text = "Il detenuto ha pagato 235 euro di spese" ,
						--type = "error",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})
					--TriggerClientEvent("pNotify:SendNotification", to, {
						--text = "Ti sono stati addebitati 235 euro di spese" ,
						--type = "error",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})

					local identifier = GetPlayerIdentifiers(achitre)[1]
					Jail[identifier] = JailPlayer("JP3", jTsecs)
	end
end
end)


RegisterServerEvent('jail:carcere')
AddEventHandler('jail:carcere', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
    local defaultsecs = 5
	local spese = 235
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
    societyAccount = account
    end)
	
	jTsecs = amountt * 60

	if tonumber(to) ~= nil and tonumber(amountt) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		TriggerClientEvent("JP", to, jTsecs)
		societyAccount.addMoney(spese)
		--xPlayer.addAccountMoney('bank', spese)
		zPlayer.removeAccountMoney('bank', spese)
		--zPlayer.removeMoney(spese)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Hai messo in carcere " .. GetPlayerName(to) .. "!" ,
		type = "success",
		queue = "lmao",
		timeout = 10000,
		layout = "centerLeft"
		})
		TriggerClientEvent("pNotify:SendNotification", to, {
		text = "Sei stato messo in carcere per " .. amountt .. " minuti!" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
						--sounds = {
			            --sources = {"porcodio.ogg"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
			            --volume = 0.2,
			            --conditions = {"docVisible"} -- This means it will play the sound when the notification becomes visible.
		                --}
					})
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = "Il detenuto ha pagato 235 euro di spese" ,
						type = "info",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
					})
					TriggerClientEvent("pNotify:SendNotification", to, {
						text = "Ti sono stati addebitati 235 euro di spese" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
					})

					local identifier = GetPlayerIdentifiers(to)[1]
					Jail[identifier] = JailPlayer("JP", jTsecs)
	end
end
end)

RegisterServerEvent('jail:cortile')
AddEventHandler('jail:cortile', function(pl, tempo)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(pl)
    local defaultsecs = 5
	local spese = 235
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
    societyAccount = account
    end)
	
	jTsecs = tempo * 60

	if tonumber(pl) ~= nil and tonumber(tempo) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		TriggerClientEvent("JPC", pl, jTsecs)
		societyAccount.addMoney(spese)
		--xPlayer.addAccountMoney('bank', spese)
		zPlayer.removeAccountMoney('bank', spese)
		--zPlayer.removeMoney(spese)
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Hai messo in carcere " .. GetPlayerName(pl) .. "!" ,
		type = "success",
		queue = "lmao",
		timeout = 10000,
		layout = "centerLeft"
		})
		TriggerClientEvent("pNotify:SendNotification", pl, {
		text = "Sei stato messo in carcere per " .. tempo .. " minuti!" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
						--sounds = {
			            --sources = {"porcodio.ogg"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
			            --volume = 0.2,
			            --conditions = {"docVisible"} -- This means it will play the sound when the notification becomes visible.
		                --}
					})
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = "Il detenuto ha pagato 235 euro di spese" ,
						type = "info",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
					})
					TriggerClientEvent("pNotify:SendNotification", pl, {
						text = "Ti sono stati addebitati 235 euro di spese" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
					})

					local identifier = GetPlayerIdentifiers(pl)[1]
					Jail[identifier] = JailPlayer("JPC", jTsecs)
	end
end
end)

RegisterServerEvent('jail:multa')
AddEventHandler('jail:multa', function(multato, multone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(multato)
	local multone = tonumber(multone)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
    societyAccount = account
  end)
	
	--jTsecs = tempo * 60

	if tonumber(multato) ~= nil and tonumber(multone) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		--TriggerClientEvent("JPC", pl, jTsecs)
		--xPlayer.addAccountMoney('bank', spese)
		--zPlayer.removeMoney(multone)
		societyAccount.addMoney(multone)
		zPlayer.removeAccountMoney('bank', multone)
		TriggerClientEvent('chatMessage', -1, 'Polizia di Los Santos', { 0, 0, 255 }, "ID "..multato.." è stato multato per ".. multone.." dollari!")
		TriggerClientEvent("pNotify:SendNotification", source, {
		text = "Hai multato " .. GetPlayerName(multato) .. "!" ,
		type = "success",
		queue = "lmao",
		timeout = 10000,
		layout = "centerLeft"
		})
		TriggerClientEvent("pNotify:SendNotification", multato, {
		text = "Sei stato multato per " .. multone .. " dollari!" ,
						type = "warning",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
						--sounds = {
			            --sources = {"porcodio.ogg"}, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
			            --volume = 0.2,
			            --conditions = {"docVisible"} -- This means it will play the sound when the notification becomes visible.
		                --}
					})
					--TriggerClientEvent("pNotify:SendNotification", _source, {
						--text = "Il detenuto ha pagato 235 euro di spese" ,
						--type = "info",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})
					--TriggerClientEvent("pNotify:SendNotification", pl, {
						--text = "Ti sono stati addebitati 235 euro di spese" ,
						--type = "warning",
						--queue = "lmao",
						--timeout = 10000,
						--layout = "centerLeft"
					--})

					--ocal identifier = GetPlayerIdentifiers(pl)[1]
					--Jail[identifier] = JailPlayer("JPC", jTsecs)
	end
end
end)

RegisterServerEvent('jail:libera')
AddEventHandler('jail:libera', function(achiquattro)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(achiquattro)
    local defaultsecs = 5
    local spese = 235

	if tonumber(achiquattro) ~= nil then
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
		TriggerClientEvent("UnJP", achiquattro)
		TriggerClientEvent("pNotify:SendNotification", source, {
						text = "Hai liberato " .. GetPlayerName(achiquattro) .. "!" ,
						type = "success",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
					})
					TriggerClientEvent("pNotify:SendNotification", achiquattro, {
						text = "Sei stato liberato" ,
						type = "success",
						queue = "lmao",
						timeout = 10000,
						layout = "centerLeft"
					})

					local identifier = GetPlayerIdentifiers(achiquattro)[1]

				Jail[identifier] = nil
				MySQL.Async.execute('UPDATE users SET jail = @data', {data = 0})
	end
end
end)

RegisterServerEvent("esx_jailsystem:prisonWorkReward")
AddEventHandler("esx_jailsystem:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(13, 21))

	TriggerClientEvent("esx:showNotification", src, "Ecco un piccolo contributo...")
end)






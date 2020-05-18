local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_rapinanegozietto:toofar')
AddEventHandler('esx_rapinanegozietto:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			TriggerClientEvent('esx_rapinanegozietto:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_rapinanegozietto:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_rapinanegozietto:endrob')
AddEventHandler('esx_rapinanegozietto:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent('esx_rapinanegozietto:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_rapinanegozietto:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_rapinanegozietto:rob')
AddEventHandler('esx_rapinanegozietto:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < 600 and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_rapinanegozietto:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (600 - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
				cops = cops + 1
			end
		end


		if rob == false then

			if(cops >= Config.RequiredCopsRob)then

				rob = true
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
							TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
							TriggerClientEvent('esx_rapinanegozietto:setblip', xPlayers[i], Stores[robb].position)
					end
				end

				TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
				TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
				TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			    TriggerClientEvent('esx_rapinanegozietto:currentlyrobbing', source, robb)
                CancelEvent()
				Stores[robb].lastrobbed = os.time()
			else
				--TriggerClientEvent('esx_rapinanegozietto:togliblip', source)
				TriggerClientEvent('esx:showNotification', source, _U('min_two_police'))
			end
		else
			--TriggerClientEvent('esx_rapinanegozietto:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_rapinanegozietto:gioielli1')
AddEventHandler('esx_rapinanegozietto:gioielli1', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addAccountMoney('black_money', Config.DenaroCassa)
	TriggerClientEvent('mt:missiontext', source, 'Hai ottenuto ~g~' .. Config.DenaroCassa .. ' dollari', 10000)
end)

RegisterServerEvent('esx_rapinanegozietto:gioielli2')
AddEventHandler('esx_rapinanegozietto:gioielli2', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addAccountMoney('black_money', Config.DenaroCassetta)
	TriggerClientEvent('mt:missiontext', source, 'Hai ottenuto ~g~' .. Config.DenaroCassetta .. ' dollari', 10000)
end)


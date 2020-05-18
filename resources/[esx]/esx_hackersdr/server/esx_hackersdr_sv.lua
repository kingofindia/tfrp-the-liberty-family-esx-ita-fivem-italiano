local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_hackersdr:toofar')
AddEventHandler('esx_hackersdr:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at'))
			TriggerClientEvent('esx_hackersdr:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_hackersdr:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled'))
	end
end)

RegisterServerEvent('esx_hackersdr:endrob')
AddEventHandler('esx_hackersdr:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], 'Los Santos è al buio')
			TriggerClientEvent('esx_hackersdr:killblip', xPlayers[i])
		end
		TriggerClientEvent('esx_hackersdr:buio', xPlayers[i])
	end
	if(robbers[source])then
		TriggerClientEvent('esx_hackersdr:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_hackersdr:elucefu')
AddEventHandler('esx_hackersdr:elucefu', function()
	local source = source
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sceriffo' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], 'La situazione è tornata nella norma')
		end
		TriggerClientEvent('esx_hackersdr:luce', xPlayers[i])
	end

end)

RegisterServerEvent('esx_hackersdr:rob')
AddEventHandler('esx_hackersdr:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < 6000 and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_hackersdr:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (6000 - (os.time() - store.lastrobbed)) .. _U('seconds'))
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

			if(cops >= 5)then

				rob = true
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sceriffo' then
							TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog'))
							TriggerClientEvent('esx_hackersdr:setblip', xPlayers[i], Stores[robb].position)
					end
				end

				TriggerClientEvent('esx:showNotification', source, _U('started_to_rob'))
				TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
				TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			    TriggerClientEvent('esx_hackersdr:currentlyrobbing', source, robb)
                CancelEvent()
				Stores[robb].lastrobbed = os.time()
			else
				TriggerClientEvent('esx:showNotification', source, _U('min_two_police'))
			end
		else
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

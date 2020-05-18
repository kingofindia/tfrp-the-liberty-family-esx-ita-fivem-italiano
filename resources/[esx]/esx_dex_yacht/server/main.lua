ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local cooldown = 0
local cooldowntime = 600 * 6000

function Timer()
	cooldown = 1
	Citizen.Wait(cooldowntime)
	cooldown = 0
end

RegisterServerEvent('esx_yacht:robbery')
AddEventHandler('esx_yacht:robbery', function(text)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local police = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			police = police+1
		end
	end
		if police > Config.LSPD-1 and cooldown == 0 then
			TriggerClientEvent("esx_yacht:start", source)
			TriggerClientEvent("esx_yacht:true", source)
			TriggerClientEvent("esx_yacht:notification", source, "Rapina iniziata, cerca nello yacht per trovare una valigia con i soldi.")
			LSPD()
			Citizen.Wait(1000)
			Timer()
		end

		if cooldown == 1 then
			TriggerClientEvent("esx_yacht:notification", source, "Questo yacht è stato rapinato di recente, riprova più tardi.")
		end

		if police < Config.LSPD then
			TriggerClientEvent("esx_yacht:notification", source, "Non c'è abbastanza polizia.")
		end
end)

RegisterServerEvent('esx_yacht:reward')
AddEventHandler('esx_yacht:reward', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addMoney(Config.Reward)
end)

function LSPD()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent("esx_yacht:notify", -1)
		end
	end
end
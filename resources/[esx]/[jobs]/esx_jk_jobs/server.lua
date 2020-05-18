ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_empregos:setJobt')
AddEventHandler('esx_empregos:setJobt', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("unemployed", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('esx_empregos:setJobRybak')
AddEventHandler('esx_empregos:setJobRybak', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("trucker", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('esx_empregos:setJobGórnik')
AddEventHandler('esx_empregos:setJobGórnik', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("tailor", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('esx_empregos:setJobRafiner')
AddEventHandler('esx_empregos:setJobRafiner', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("poolcleaner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobRzeźnik')
AddEventHandler('esx_empregos:setJobRzeźnik', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("miner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobKrawiec')
AddEventHandler('esx_empregos:setJobKrawiec', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("lumberjack", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobDrwal')
AddEventHandler('esx_empregos:setJobDrwal', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("slaughterer", 0)
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobReporter')
AddEventHandler('esx_empregos:setJobReporter', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("fueler", 0)
	TriggerClientEvent('esx:showNotification', source, 'hai un nuovo lavoro ~g~' .. xPlayer.getName())	
end)
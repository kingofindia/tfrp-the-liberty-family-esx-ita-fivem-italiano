ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('trump', function(source)
    if PlayerData.job ~= nil and PlayerData.job.name == 'state' and PlayerData.job.grade_name == 'boss' then
        local pedHash = 's_m_m_pilot_01'

        if IsModelInCdimage(pedHash) then
            RequestModel(pedHash)

            while not HasModelLoaded(pedHash) do
                Citizen.Wait(5)
            end

            SetPlayerModel(PlayerId(), pedHash)
        end
    end
end, false)

RegisterCommand('prete', function(source)
    if PlayerData.job ~= nil and PlayerData.job.name == 'death' and PlayerData.job.grade_name == 'ilpadredelkiller' then
        local pedHash = 'ig_priest'

        if IsModelInCdimage(pedHash) then
            RequestModel(pedHash)

            while not HasModelLoaded(pedHash) do
                Citizen.Wait(5)
            end

            SetPlayerModel(PlayerId(), pedHash)
        end
    end
end, false)

--[[ RegisterCommand('joker', function(source)
    if PlayerData.job ~= nil and PlayerData.job.name == 'fbi' then
        local pedHash = 'a_m_y_vindouche_01'

        if IsModelInCdimage(pedHash) then
            RequestModel(pedHash)

            while not HasModelLoaded(pedHash) do
                Citizen.Wait(5)
            end

            SetPlayerModel(PlayerId(), pedHash)
        end
    end
end, false) ]]


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_rich-dext_effect:syncServer')
AddEventHandler('esx_rich-dext_effect:syncServer', function(dict, name, pos, dur)
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        TriggerClientEvent('esx_rich-dext_effect:syncClient', xPlayers[i], dict, name, pos, dur)
    end
end)
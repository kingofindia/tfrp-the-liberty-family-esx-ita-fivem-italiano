ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_rich_k9:RequestVehicleToggle")
AddEventHandler("esx_rich_k9:RequestVehicleToggle", function()
    local src = source
    print("esx_rich_k9:RequestVehicleToggle")
    TriggerClientEvent("esx_rich_k9:ToggleVehicle", src)
end)

function GetPlayerId(type, id)
    local identifiers = GetPlayerIdentifiers(id)
    for i = 1, #identifiers do
        if string.find(identifiers[i], type, 1) ~= nil then
            return identifiers[i]
        end
    end
    return false
end
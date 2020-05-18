ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_rich_Turbine:vendi')
AddEventHandler('esx_rich_Turbine:vendi', function(number)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = number

    local prezzo = math.random(400, 600)

    local prezzofinale = prezzo*amount

    xPlayer.addAccountMoney('bank', prezzofinale)

    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Hai riparato una turbina, guadagno: " .. prezzofinale .. "$",
        type = "success",
        queue = "lmao",
        timeout = 10000,
        layout = "bottomCenter"
    })

end)

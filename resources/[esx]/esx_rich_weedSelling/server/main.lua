ESX = nil
local PoliceConnected = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord (name,message)
    local DiscordWebHook = "https://discordapp.com/api/webhooks/595742809856802835/JVYecbAq7TfZVKV01BO3e58alEBLhmghy4hPclFLYFJbvXicjRziNmqceKQhMWWjGq8o" -- Chat #Log-Chat
  
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "The Liberty Family - Discord Bot Log",
            },
        }
    }
  
    if message == nil or message == '' then 
        return FALSE 
    end

    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('esx_rich:GetPoliceOnline', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
  
    PoliceConnected = 0
  
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            PoliceConnected = PoliceConnected + 1
       end
    end

  cb(PoliceConnected)

end)

RegisterServerEvent('esx_rich_sellingweed:vendi')
AddEventHandler('esx_rich_sellingweed:vendi', function(number)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    local amount = number

    local prezzo = math.random(300, 500)

    local prezzofinale = prezzo*amount

    xPlayer.removeInventoryItem('marijuana', amount)
    xPlayer.addAccountMoney('black_money', prezzofinale)

    TriggerClientEvent("pNotify:SendNotification", source, {
        text = "Hai venduto x" .. amount .. " di marijuana al prezzo di " .. prezzofinale .. "$",
        type = "success",
        queue = "lmao",
        timeout = 10000,
        layout = "bottomCenter"
    })

    sendToDiscord('📝 Log Weed', 'Il giocatore __**' .. playerName .. '**__ ha venduto **x' .. amount .. '** di __**marijuana**__ al prezzo di **' .. prezzofinale .. '$**')

end)

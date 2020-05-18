TriggerEvent("es:addGroup", "helper", "user", function(group) end)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('esx_rich_staff:setGroup', Source, user.getGroup())
end)

local banned = ""
local bannedTable = {}

function banUser(id)
	banned = banned .. id .. "\n"
	SaveResourceFile("es_admin2", "data/bans.txt", banned, -1)
	bannedTable[id] = true
end

RegisterServerEvent("esx_rich_staff:quick")
AddEventHandler("esx_rich_staff:quick", function(id, type)
    local Source = source
    TriggerEvent("es:getPlayerFromId", source, function(user)
        TriggerEvent("es:getPlayerFromId", id, function(target)
            --TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
                --if canTarget then
                    if type == "slay" then 
                        TriggerClientEvent('esx_rich_staff:quick', id, type) 
                    end
                    if type == "noclip" then 
                        TriggerClientEvent('esx_rich_staff:quick', id, type) 
                    end
                    if type == "noclip3" then
                        TriggerClientEvent('esx_rich_staff:quick', Source, 'noclip') 
                    end
                    if type == "noclip2" then
                        TriggerClientEvent('esx_rich_staff:quick', Source, type)
                    end
                    if type == "freeze" then 
                        TriggerClientEvent('esx_rich_staff:quick', id, type) 
                    end
                    if type == "crash" then 
                        TriggerClientEvent('esx_rich_staff:quick', id, type) 
                    end
                    if type == "bring" then 
                        TriggerClientEvent('esx_rich_staff:quick', id, type, Source) 
                    end
                    if type == "goto" then 
                        TriggerClientEvent('esx_rich_staff:quick', Source, id, type) 
                    end
                    if type == "slap" then 
                        TriggerClientEvent('esx_rich_staff:quick', id, type) 
                    end
                    if type == "kick" then
                        DropPlayer(id, 'Sei stato espulso') 
                    end

                    if type == "ban" then
                        for k,v in ipairs(GetPlayerIdentifiers(id)) do
                            banUser(v)
                        end
                        DropPlayer(id, GetConvar("es_admin_banreason", "Sei stato bannato da questo server"))
                    end

                    if type == "revive" then
                        TriggerClientEvent('esx_rich_staff:quick', id, type)
                    end
                    
                --else
                    --TriggerClientEvent('chatMessage', Source, '[MENU STAFF] ', {255, 0, 0}, "Permesso rifiutato.")
                --end
            --end)
        end)
    end)
end)

RegisterServerEvent('esx_rich_revive:reviveAll')
AddEventHandler('esx_rich_revive:reviveAll', function()
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        TriggerClientEvent('esx_ambulancejob:revivecomm', xPlayers[i])
    end
end)

RegisterServerEvent('esx_rich_revive:freezeAll')
AddEventHandler('esx_rich_revive:freezeAll', function()
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        TriggerClientEvent('esx_rich:freeze', xPlayers[i])
    end
end)

RegisterServerEvent('esx_rich_revive:unfreezeAll')
AddEventHandler('esx_rich_revive:unfreezeAll', function()
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        TriggerClientEvent('esx_rich:unfreeze', xPlayers[i])
    end
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('esx_rich_staff:setGroup', Source, user.getGroup())
end)

RegisterServerEvent("esx_rich_staff:SetMoney")
AddEventHandler("esx_rich_staff:SetMoney", function(id, money)

    local _source = source
    local target = id

    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        xPlayer.setAccountMoney('bank', money)
        TriggerClientEvent('chatMessage', _source, "[MENU STAFF] ", {255, 0, 0}, "Hai impostato $" .. money .. " soldi in banca a " .. xPlayer.name)
    else
        TriggerClientEvent('chatMessage', _source, "[MENU STAFF] ", {255, 0, 0}, "Giocatore non online.")
    end

    print('[MENU STAFF]: ' .. GetPlayerName(_source) .. ' ha impostato $' .. money .. ' (banca) a ' .. xPlayer.name)

end)

RegisterServerEvent("esx_rich_staff:GiveWeapon")
AddEventHandler("esx_rich_staff:GiveWeapon", function(id, weapon)

    local target = id
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)


    if weapon ~= "weapon_" then
        if xPlayer then
            xPlayer.addWeapon(weapon, 250)
            TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Hai dato ' .. weapon .. ' con 250 munizioni a ' .. xPlayer.name } })
        else
            TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Giocatore non in sessione.' } })
        end
    end

end)

RegisterServerEvent("esx_rich_staff:GiveBankMoney")
AddEventHandler("esx_rich_staff:GiveBankMoney", function(id, qtty)
    
    local target = id
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)

    local amount = qtty
    
    if amount ~= nil then
        if xPlayer.getAccount('bank') ~= nil then
            xPlayer.addAccountMoney('bank', amount)
            TriggerClientEvent('chat:addMessage', _source, {args = {'^1[MENU STAFF] ', 'Hai dato ' .. amount .. ' soldi in banca a ' .. xPlayer.name } })
        end
    else
        TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Importo non valido.' } })
    end

end)

RegisterServerEvent("esx_rich_staff:GiveBlackMoney")
AddEventHandler("esx_rich_staff:GiveBlackMoney", function(id, qtty)

    local target = id
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)

    local amount = qtty
    
    if amount ~= nil then
        if xPlayer.getAccount('black_money') ~= nil then
            xPlayer.addAccountMoney('black_money', amount)
            TriggerClientEvent('chat:addMessage', _source, {args = {'^1[MENU STAFF] ', 'Hai dato ' .. amount .. ' soldi sporchi a ' .. xPlayer.name } })
        end
    else
        TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Importo non valido.' } })
    end

end)

RegisterServerEvent("esx_rich_staff:GiveMoneyServer")
AddEventHandler("esx_rich_staff:GiveMoneyServer", function(id, amount)

    local target = id
    local _source = source
    local importo = tonumber(amount)

    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        xPlayer.addAccountMoney(money, importo)
    else
        TriggerClientEvent('chat:addMessage', source, { args = {'^1[MENU STAFF] ', 'Giocatore non online.' } })
    end

end)

--esx_rich_staff:GiveMoneyServerBank

RegisterServerEvent("esx_rich_staff:GiveMoneyServerBank")
AddEventHandler("esx_rich_staff:GiveMoneyServerBank", function(id, amount)

    local target = id
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        xPlayer.addAccountMoney('bank', amount)
        TriggerClientEvent('chat:addMessage', _source, {args = {'^1[MENU STAFF] ', 'Hai dato $' .. amount .. ' soldi in banca a ' .. xPlayer.name } })
    else
        TriggerClientEvent('chat:addMessage', source, { args = {'^1[MENU STAFF] ', 'Giocatore non online.' } })
    end

end)

RegisterServerEvent("esx_rich_staff:GiveMoneyServerBlackMoney")
AddEventHandler("esx_rich_staff:GiveMoneyServerBlackMoney", function(id, amount)

    local target = id
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        xPlayer.addAccountMoney('black_money', amount)
        TriggerClientEvent('chat:addMessage', _source, {args = {'^1[MENU STAFF] ', 'Hai dato $' .. amount .. ' soldi sporchi a ' .. xPlayer.name } })
    else
        TriggerClientEvent('chat:addMessage', source, { args = {'^1[MENU STAFF] ', 'Giocatore non online.' } })
    end

end)

RegisterServerEvent("esx_rich_staff:SetJob")
AddEventHandler("esx_rich_staff:SetJob", function(id, job, grade)

    local target = id
    
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        if ESX.DoesJobExist(job, grade) then
            xPlayer.setJob(job, grade)
            TriggerClientEvent('chat:addMessage', source, { args = { '^1[MENU STAFF] ', 'Hai impostato il lavoro da ' .. job .. ' con il grado ' .. grade .. ' a ' .. xPlayer.name } })
        else
            TriggerClientEvent('chat:addMessage', source, { args = {'^1[MENU STAFF] ', 'Questo lavoro non esiste.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = {'^1[MENU STAFF] ', 'Giocatore non online.' } })
    end

end)

RegisterServerEvent("esx_rich_staff:GiveMoney")
AddEventHandler("esx_rich_staff:GiveMoney", function(id, qtty)

    local target = id
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)

    local amount = qtty

    if amount ~= nil then
        if xPlayer.getAccount('money') ~= nil then
            xPlayer.addAccountMoney('money', amount)
            TriggerClientEvent('chat:addMessage', _source, {args = {'^1[MENU STAFF] ', 'Hai dato ' .. amount .. ' soldi contanti a ' .. xPlayer.name } })
        end
    else
        TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Importo non valido.' } })
    end
end)

RegisterServerEvent("esx_rich_staff:GiveObjectServer")
AddEventHandler("esx_rich_staff:GiveObjectServer", function(id, item, qtty)

    local target = id
    --local item = object
    --local number = qtty
    
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)

    if qtty ~= nil then
        if xPlayer.getInventoryItem(item) ~= nil then
            xPlayer.addInventoryItem(item, qtty)
            TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Hai dato x' .. qtty .. ' ' .. item .. ' a ' .. xPlayer.name } })
        else
            TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Item non valido.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', _source, { args = { '^1[MENU STAFF] ', 'Quantità non valida.' } })
    end

end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

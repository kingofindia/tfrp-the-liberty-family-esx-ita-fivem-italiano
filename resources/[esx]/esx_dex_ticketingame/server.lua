ESX = nil
local bancache = {} -- id,sender,sender_name,receiver,reason,length
local open_assists,active_assists = {},{}

Citizen.CreateThread(function() -- startup
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end
end)

AddEventHandler("playerDropped",function(reason)
    if open_assists[source] then open_assists[source]=nil end
    for k,v in ipairs(active_assists) do
        if v==source then
            active_assists[k]=nil
            TriggerClientEvent("chat:addMessage",k,{color={255,0,0},multiline=false,args={"DexSistem"," L'admin che ti stava aiutando è crashato dal server"}})
            return
        elseif k==source then
            TriggerClientEvent("esx_dex_ticketingame:assistDone",v)
            TriggerClientEvent("chat:addMessage",v,{color={255,0,0},multiline=false,args={"DexSistem"," Il player che stavi aiutando è crashato dal server, teleport indietro..."}})
            active_assists[k]=nil
            return
        end
    end
end)

function isAdmin(xPlayer)
    local admin = false
    for k,v in ipairs(Config.admin_groups) do
        if xPlayer.getGroup()==v then return true end
    end
    return xPlayer.getPermissions()>=Config.admin_level
end

function execOnAdmins(func)
    local ac = 0
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            ac = ac + 1
            func(v)
        end
    end
    return ac
end

TriggerEvent('es:addCommand', 'assist', function(source, args, user)
    local reason = table.concat(args," ")
    if reason=="" or not reason then TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Specifica una ragione"}}); return end
    if not open_assists[source] and not active_assists[source] then
        local ac = execOnAdmins(function(admin) TriggerClientEvent("esx_dex_ticketingame:requestedAssist",admin,source); TriggerClientEvent("chat:addMessage",admin,{color={0,255,255},multiline=Config.chatassistformat:find("\n")~=nil,args={"DexSistem",Config.chatassistformat:format(GetPlayerName(source),source,reason)}}) end)
        if ac>0 then
            open_assists[source]=true
            Citizen.SetTimeout(120000,function()
                if open_assists[source] then open_assists[source]=nil end
            end)
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"DexSistem"," Richiesta di assistenza inviata (scade tra 120sec), scrivi ^1/cassist^7 per cancellare la tua richiesta"}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Nessun admin disponibile al momento"}})
        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Qualcuno ti sta già aiutando o hai già una richiesta di assistenza in sospeso"}})
    end
end)

TriggerEvent('es:addCommand', 'cassist', function(source, args, user)
    if open_assists[source] then
        open_assists[source]=nil
        TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"DexSistem"," Richiesta assistenza cancellata"}})
        execOnAdmins(function(admin) TriggerClientEvent("esx_dex_ticketingame:hideAssistPopup",admin) end)
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Non hai nessuna richiesta di assistenza in sospeso"}})
    end
end)

TriggerEvent('es:addCommand', 'finassist', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        local found = false
        for k,v in pairs(active_assists) do
            if v==source then
                found = true
                active_assists[k]=nil
                TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"DexSistem"," Assistenza chiusa, teleport indietro"}})
                TriggerClientEvent("esx_dex_ticketingame:assistDone",source)
            end
        end
        if not found then TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Non stai aiutando nessuno"}}) end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Non hai il permesso per usare questo comando!"}})
    end
end)

function acceptAssist(xPlayer,target)
    if isAdmin(xPlayer) then
        local source = xPlayer.source
        for k,v in pairs(active_assists) do
            if v==source then
                TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Stai già aiutando qualcuno"}})
                return
            end
        end
        if open_assists[target] and not active_assists[target] then
            open_assists[target]=nil
            active_assists[target]=source
            TriggerClientEvent("esx_dex_ticketingame:acceptedAssist",source,target)
            TriggerClientEvent("esx_dex_ticketingame:hideAssistPopup",source)
            TriggerClientEvent("chat:addMessage",source,{color={0,255,0},multiline=false,args={"DexSistem"," Teleport al player..."}})
        elseif not open_assists[target] and active_assists[target] and active_assists[target]~=source then
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Qualcuno sta già aiutando questo player"}})
        else
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Il player con questo id non ha richiesto assistenza"}})
        end
    else
        TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"DexSistem"," Non hai il permesso per usare questo comando!"}})
    end
end

TriggerEvent('es:addCommand', 'accassist', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
    acceptAssist(xPlayer,target)
end)

RegisterServerEvent("esx_dex_ticketingame:acceptAssistKey")
AddEventHandler("esx_dex_ticketingame:acceptAssistKey",function(target)
    if not target then return end
    local _source = source
    acceptAssist(ESX.GetPlayerFromId(_source),target)
end)
function sendToDiscord (name,message,WebHook)
    local DiscordWebHook = WebHook
  
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = Config.Colore,
            ["footer"]=  {
                ["text"]= Config.Nome,
            },
        }
    }
  
    if message == nil or message == '' then 
        return FALSE 
    end

    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('explosionEvent', function(sender, ev)
    print(GetPlayerName(sender), json.encode(ev))
    sendToDiscord('📝 Log Esplosioni', GetPlayerName(sender) .. " ha creato un esplosione: " .. json.encode(ev), 'https://discordapp.com/api/webhooks/613870554423754902/Qcdfw0vkQC49Ls0YYG3_KFX38wc5gSa_RKno_m2HvHF83z300gbSjudPQOzyEdQmwMrm')
end)

RegisterServerEvent('esx:playerconnected')
AddEventHandler('esx:playerconnected', function()
    sendToDiscord('📝 Log Sistema', GetPlayerName(source) .." ".. "si sta connettendo al server.", Config.WebHookConnessione)
end)

AddEventHandler('playerDropped', function(motivo)
    sendToDiscord('📝 Log Sistema', GetPlayerName(source) .." ".. 'si è disconnesso dal server' .. "("..motivo..")", Config.WebHookDisconnessione)
end)

RegisterServerEvent("esx:giveitemalert")
AddEventHandler("esx:giveitemalert", function(name,nametarget,itemname,amount)
    sendToDiscord('📝 Log Generali', name.. ' ha dato un oggetto a ' ..nametarget.." "..amount .." "..itemname, Config.WebHookGiveItem)
end)

RegisterServerEvent("esx:givemoneyalert")
AddEventHandler("esx:givemoneyalert", function(name,nametarget,amount)
    sendToDiscord('📝 Log Generali', name.." ".. ' ha dato dei contanti a '..' '..nametarget..' '..amount..'$', Config.WebHookContanti)
end)

RegisterServerEvent("esx:givemoneybankalert")
AddEventHandler("esx:givemoneybankalert", function(name,nametarget,amount)
    sendToDiscord('📝 Log Generali', name.." ".. ' ha dato dei soldi in banca a '..' '..nametarget..' '..amount..'$', Config.WebHookBanca)
end)

RegisterServerEvent("esx:giveweaponalert")
AddEventHandler("esx:giveweaponalert", function(name,nametarget,weaponlabel)
    sendToDiscord('📝 Log Generali', name.." ".. ' ha dato un arma a '..' '..nametarget..' '..weaponlabel, Config.WebHookWeaponGive)
end)

RegisterServerEvent("esx:washingmoneyalert")
AddEventHandler("esx:washingmoneyalert", function(name,amount)
    sendToDiscord('📝 Log Generali', name..' ha lavato dei soldi: '.. amount .."$", Config.WebHookMoneyWash)
end)

RegisterServerEvent("esx:prendisoldisociety")
AddEventHandler("esx:prendisoldisociety", function(name,amount,account)
    sendToDiscord('📝 Log Generali', GetPlayerName(name)..' ha prelevato dei soldi: '.. amount .."$ Dalla società: "..account, Config.WebHookTakeSociety)
end)

RegisterServerEvent("esx:depositsociey")
AddEventHandler("esx:depositsociey", function(name,amount,job)
    sendToDiscord('📝 Log Generali', GetPlayerName(name).. ' ha depositato ' ..amount.. ' nella società: ' ..job, Config.WebHookDepositSociety)
end)

RegisterServerEvent('esx:openbossed')
AddEventHandler('esx:openbossed', function()
    sendToDiscord('📝 Log Generali', 'NIL ha aperto il menu boss del lavoro NIL', Config.WebHookDepositSociety)
end)

RegisterServerEvent('esx_rich_discord:spectatePersona')
AddEventHandler('esx_rich_discord:spectatePersona', function(target)
    sendToDiscord('📝 Log Spectate', GetPlayerName(source).. ' ha iniziato a spectare ' ..GetPlayerName(target), Config.WebHookSpectate)
end)

RegisterServerEvent('esx:paycheck')
AddEventHandler('esx:paycheck', function(ricevutore,lavoro,grado,salario)

    if grado == nil then
        sendToDiscord('📝 Log Salario', GetPlayerName(ricevutore).. ' ha ricevuto lo stipendio di ' ..salario.. '. Lavoro: ' ..lavoro, Config.WebHookPayceck)
    elseif lavoro == nil then
        sendToDiscord('📝 Log Salario', GetPlayerName(ricevutore).. ' ha ricevuto lo stipendio di ' ..salario.. '. Lavoro: Sconosciuto' ..grado, Config.WebHookPayceck)
    elseif salario == nil then
        sendToDiscord('📝 Log Salario', GetPlayerName(ricevutore).. ' ha ricevuto lo stipendio di Sconosciuto - Lavoro: ' ..lavoro.. ' ' ..grado, Config.WebHookPayceck)
    elseif ricevutore == nil then
        sendToDiscord('📝 Log Salario', 'Sconosciuto ha ricevuto lo stipendio di ' ..salario.. '. Lavoro: ' ..lavoro.. ' ' ..grado, Config.WebHookPayceck)
    else
        sendToDiscord('📝 Log Salario', GetPlayerName(ricevutore).. ' ha ricevuto lo stipendio di ' ..salario.. '. Lavoro: ' ..lavoro.. ' ' ..grado, Config.WebHookPayceck)
    end
end)

RegisterServerEvent('esx:takepolicevehicle')
AddEventHandler('esx:takepolicevehicle', function(name,label)
    sendToDiscord('📝 Log Salario', name.. ' ha preso un veicolo della polizia. Nome veicolo: ' ..label, Config.WebHookPoliceV)
end)

--[[ RegisterServerEvent('esx:killerlog')
AddEventHandler('esx:killerlog', function(t,killer, kilerT)
    if(t == 1) then
        local xPlayer = ESX.GetPlayerFromId(source)
        local xPlayerKiller = ESX.GetPlayerFromId(killer)
        if(xPlayerKiller.name ~= nil and xPlayer.name ~= nil)then
            if(kilerT.killerinveh) then
                local model = kilerT.killervehname
                sendToDiscord('📝 Log Kill', xPlayer.name .." ha ucciso "..xPlayerKiller.name.." con "..model, Config.WebHookKill)
            else
                sendToDiscord('📝 Log Kill', xPlayer.name .." ha ucciso "..xPlayerKiller.name, Config.WebHookKill)
            end
        end
    else
        local xPlayero = ESX.GetPlayerFromId(source)
        sendToDiscord('📝 Log Kill', xPlayero.name .." è morto. Causa: Suicidio o ucciso da NPC", Config.WebHookKill)
    end
end) ]]

AddEventHandler('chatMessage', function(source, name, msg)
    args = stringsplit(msg, " ")
    CancelEvent()
	if args[1] ~= nil then
		if string.find(args[1], "/") then
			local cmd = args[1]
			table.remove(args, 1)	
		else
			-- Sets variable 'player' to the players SteamId
			player = GetPlayerIdentifiers(source)[1]
			-- Fetches all rows from the database table 'users' where the column 'identifier' equals the players SteamId
			local result = MySQL.Sync.fetchAll(
			  'SELECT * FROM users WHERE identifier = @identifier',
			  {
				['@identifier'] = player
			  }
			)

			for i=1, #result, 1 do
			
				if result[i].group == 'superadmin' then
                    TriggerClientEvent('chatMessage', -1, "SuperAdmin | " .. name .. ":", {255, 0, 0}, "  " .. msg)
                    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. name .. '**__ ha inviato un messaggio __**IN CHAT**__ con il seguente testo: **' .. msg .. '**', Config.WebHookChat)
					CancelEvent()
				elseif result[i].group == 'admin' then
                    TriggerClientEvent('chatMessage', -1, "Admin |" .. name .. ":", {0, 255, 0}, "  " .. msg)
                    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. name .. '**__ ha inviato un messaggio __**IN CHAT**__ con il seguente testo: **' .. msg .. '**', Config.WebHookChat)
					CancelEvent()
				elseif result[i].group == 'mod' then
                    TriggerClientEvent('chatMessage', -1, "Mod | " .. name .. ":", {0, 0, 255}, "  " .. msg)
                    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. name .. '**__ ha inviato un messaggio __**IN CHAT**__ con il seguente testo: **' .. msg .. '**', Config.WebHookChat)
					CancelEvent()
				elseif result[i].group == 'helper' then
					TriggerClientEvent('chatMessage', -1, "Helper | " .. name .. ":", {0, 255, 0}, "  " .. msg)
                    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. name .. '**__ ha inviato un messaggio __**IN CHAT**__ con il seguente testo: **' .. msg .. '**', Config.WebHookChat)
                    CancelEvent()
				else
                    --TriggerClientEvent('chatMessage', -1, "Civile | " .. name .. ":", {0, 255, 0}, "  " .. msg)
                    
                    TriggerClientEvent('chatMessage', source, "CHAT: ", {255, 0, 0}, "NON PUOI INVIARE MESSAGGI OOC")
                    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. name .. '**__ ha inviato un messaggio __**IN CHAT**__ con il seguente testo: **' .. msg .. '**', Config.WebHookChat)
                    CancelEvent()
                end
                
			end
		end
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


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

function sendToDiscord (name,message)
    local DiscordWebHook = "https://discordapp.com/api/webhooks/570768380374810625/V_ItJ2PCEqS4L0zDddxAfCenr3FEjaXBgC_HR-DZERYRBNStRC67YygB2tAZTyurHkbj" -- Chat #Log-Chat
  
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

TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)

RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        --template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(28, 160, 242, 0.6); color: white; border-radius: 3px;"><i class="fab fa-twitter "style="font-size:15px;color:white"> <font color="#FFFFFF">@{0} Tweet:</font> &ensp; <font color="white">{1}</font></div>',
        template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"style="font-size:15px;color:white"></i> <b><font color="white">@{0} Tweet:</font></b> <font color="white">{1}</font></div>',
		args = { fal, msg }
    })
    print('Il giocatore ' .. playerName .. ' ha inviato un messaggio TWEET con il seguente testo: ' .. msg)
    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. playerName .. '**__ ha inviato un messaggio __**TWEET**__ con il seguente testo: **' .. msg .. '**')
    local file = LoadResourceFile(GetCurrentResourceName(), "chat.log")
    SaveResourceFile(GetCurrentResourceName(), "chat.log", tostring(file) .. "Il giocatore: " .. tostring(GetPlayerName(source)) .. " ha inviato un messaggio TWEET con il seguente testo: " .. msg .. "\n", -1)
end, false)

RegisterCommand('anontweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        --template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(28, 160, 242, 0.6); color: white; border-radius: 3px;"><i class="fab fa-twitter "style="font-size:15px;color:white"> <font color="#FFFFFF">@Anonymous Tweet:</font> &ensp; <font color="white">{1}</font></div>',
        template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"style="font-size:15px;color:white"></i> <b><font color="white">@Tweet Anonimo:</font></b> <font color="white">{1}</font></div>',
		args = { fal, msg }
    })
    print('Il giocatore ' .. playerName .. ' ha inviato un messaggio ANONTWEET con il seguente testo: ' .. msg)
    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. playerName .. '**__ ha inviato un messaggio __**ANONTWEET**__ con il seguente testo: **' .. msg .. '**')
    local file = LoadResourceFile(GetCurrentResourceName(), "chat.log")
    SaveResourceFile(GetCurrentResourceName(), "chat.log", tostring(file) .. "Il giocatore: " .. tostring(GetPlayerName(source)) .. " ha inviato un messaggio ANONTWEET con il seguente testo: " .. msg .. "\n", -1)
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(247, 164, 0); border-radius: 3px;"><i class="fas fa-ad"style="font-size:20px;color:black"></i> <b><font color="white">Annuncio pubblicitario:</font></b> <b><font color="white">{1}</font></b></div>',
        args = { fal, msg }
    })
    local file = LoadResourceFile(GetCurrentResourceName(), "chat.log")
    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. playerName .. '**__ ha inviato un messaggio __**AD**__ con il seguente testo: **' .. msg .. '**')
    SaveResourceFile(GetCurrentResourceName(), "chat.log", tostring(file) .. "Il giocatore: " .. tostring(GetPlayerName(source)) .. " ha inviato un messaggio AD con il seguente testo: " .. msg .. "\n", -1)
end, false)

RegisterCommand('me', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(3)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(127, 0, 225, 0.6); border-radius: 3px;"><i class="fas fa-comment-dots"style="font-size:15px;color:lime"></i>&ensp;<i><b><font size="3" color="#FFFF00">{0}:</font></b></i>&ensp;<b><i><font color="lime">{1}</font></i></b></div>',
        args = { fal, msg }
    })
    print('Il giocatore ' .. playerName .. ' ha inviato un messaggio ME con il seguente testo: ' .. msg)
    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. playerName .. '**__ ha inviato un messaggio __**ME**__ con il seguente testo: **' .. msg .. '**')
    local file = LoadResourceFile(GetCurrentResourceName(), "chat.log")
    SaveResourceFile(GetCurrentResourceName(), "chat.log", tostring(file) .. "Il giocatore: " .. tostring(GetPlayerName(source)) .. " ha inviato un messaggio ME con il seguente testo: " .. msg .. "\n", -1)
end, false)

--[[ RegisterCommand('0112', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname

    TriggerClientEvent('chat:addMessage', -1, {
        --template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-helicopter"></i> Polizia di Los Santos:<br> {1}</div>',
		template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-helicopter"style="font-size:20px;color:black"></i> <b><font color="white">Polizia di Los Santos:</font></b> <b><i><font color="white">{1}</font></i></b></div>',
        args = { fal, msg } 
    })
    print('Il giocatore ' .. playerName .. ' ha inviato un messaggio 0112 con il seguente testo: ' .. msg)
    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. playerName .. '**__ ha inviato un messaggio __**0112**__ con il seguente testo: **' .. msg .. '**')
    local file = LoadResourceFile(GetCurrentResourceName(), "chat.log")
    SaveResourceFile(GetCurrentResourceName(), "chat.log", tostring(file) .. "Il giocatore: " .. tostring(GetPlayerName(source)) .. " ha inviato un messaggio 0112 con il seguente testo: " .. msg .. "\n", -1)
end, false)

RegisterCommand('news', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.3vw; margin: 0.0vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-newspaper"style="font-size:20px;color:black"></i> <b><font color="white">Weazel News:</font></b> <b><i><font color="white">{1}</font></i></b></div>',
        args = { fal, msg } 
    })
    print('Il giocatore ' .. playerName .. ' ha inviato un messaggio NEWS con il seguente testo: ' .. msg)
    sendToDiscord('📝 Log Chat', 'Il giocatore __**' .. playerName .. '**__ ha inviato un messaggio __**NEWS**__ con il seguente testo: **' .. msg .. '**')
    local file = LoadResourceFile(GetCurrentResourceName(), "chat.log")
    SaveResourceFile(GetCurrentResourceName(), "chat.log", tostring(file) .. "Il giocatore: " .. tostring(GetPlayerName(source)) .. " ha inviato un messaggio NEWS con il seguente testo: " .. msg .. "\n", -1)
end, false) ]]

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

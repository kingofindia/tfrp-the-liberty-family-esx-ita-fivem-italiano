ESX = nil
local pos_before_assist,assisting,assist_target,last_assist = nil, false, nil, nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	SetNuiFocus(false, false)
end)

RegisterNetEvent("esx_dex_ticketingame:requestedAssist")
AddEventHandler("esx_dex_ticketingame:requestedAssist",function(t)
	SendNUIMessage({show=true,window="assistreq",data=Config.popassistformat:format(GetPlayerName(GetPlayerFromServerId(t)),t)})
	last_assist=t
end)

RegisterNetEvent("esx_dex_ticketingame:acceptedAssist")
AddEventHandler("esx_dex_ticketingame:acceptedAssist",function(t)
	if assisting then return end
	local target = GetPlayerFromServerId(t)
	if target then
		local ped = GetPlayerPed(-1)
		pos_before_assist = GetEntityCoords(ped)
		assisting = true
		assist_target = t
		ESX.Game.Teleport(ped,GetEntityCoords(GetPlayerPed(target))+vector3(0,0.5,0))
	end
end)

RegisterNetEvent("esx_dex_ticketingame:assistDone")
AddEventHandler("esx_dex_ticketingame:assistDone",function()
	if assisting then
		assisting = false
		if pos_before_assist~=nil then ESX.Game.Teleport(GetPlayerPed(-1),pos_before_assist+vector3(0,0.5,0)); pos_before_assist = nil end
		assist_target = nil
	end
end)

RegisterNetEvent("esx_dex_ticketingame:hideAssistPopup")
AddEventHandler("esx_dex_ticketingame:hideAssistPopup",function(t)
	SendNUIMessage({hide=true})
	last_assist=nil
end)

RegisterCommand("decassist",function(a,b,c)
	TriggerEvent("esx_dex_ticketingame:hideAssistPopup")
end, false)

if Config.assist_keys then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsControlJustPressed(0, Config.assist_keys.accept) then
				if not last_assist then
					ESX.ShowNotification("~r~ Nessuno ha ancora richiesto assistenza")
				elseif not NetworkIsPlayerActive(GetPlayerFromServerId(last_assist)) then
					ESX.ShowNotification("~r~ Il giocatore che ha richiesto assistenza non è più online")
					last_assist=nil
				else
					TriggerServerEvent("esx_dex_ticketingame:acceptAssistKey",last_assist)
				end
			end
			if IsControlJustPressed(0, Config.assist_keys.decline) then
				TriggerEvent("esx_dex_ticketingame:hideAssistPopup")
			end
		end
	end)
end

TriggerEvent('chat:addSuggestion', '/decassist', 'Nascondi popup richiesta assistenza',{})
TriggerEvent('chat:addSuggestion', '/assist', 'Richiedi assistenza agli admin',{{name="Ragione", help="Perchè hai bisogno di aiuto?"}})
TriggerEvent('chat:addSuggestion', '/cassist', 'Annulla la tua richiesta di assistenza',{})
TriggerEvent('chat:addSuggestion', '/finassist', 'Chiudi ticket assistenza',{})
TriggerEvent('chat:addSuggestion', '/accassist', 'Accetta richiesta assistenza', {{name="ID player", help="ID del player che vuoi aiutare"}})
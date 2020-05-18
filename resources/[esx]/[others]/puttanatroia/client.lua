local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

troia = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(text)
        DrawSubtitleTimed(time, 1)
end)

function puttana()
    troia = true
    RequestModel( GetHashKey( "s_f_y_stripper_01" ) )
    while ( not HasModelLoaded( GetHashKey( "s_f_y_stripper_01" ) ) ) do
    Citizen.Wait( 1 )
    end
    local ped = CreatePed(4, 0x52580019, 100.649, -1294.102, 29.268, 295.405, true)
    SetEntityAsMissionEntity(ped)
    Wait(1500)
    RequestAnimDict("mini@strip_club@lap_dance@ld_girl_a_song_a_p1")
	while (not HasAnimDictLoaded("mini@strip_club@lap_dance@ld_girl_a_song_a_p1")) do Citizen.Wait(0) end
	Wait(1500)
	RequestAnimDict("mini@strip_club@private_dance@part2")
	while (not HasAnimDictLoaded("mini@strip_club@private_dance@part2")) do Citizen.Wait(0) end
	RequestAnimDict("mini@strip_club@private_dance@part3")
    while (not HasAnimDictLoaded("mini@strip_club@private_dance@part3")) do Citizen.Wait(0) end

	Wait(1000)
	TaskGoStraightToCoord(ped, 111.401, -1287.878, 28.561, 1.0, -1, 300.651, 0.0)
	Wait(14000)
	SetPedDesiredHeading(ped, 215.966)
	Wait(1000)
	TaskPlayAnim(ped, "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(30000)
	TaskPlayAnim(ped, "mini@strip_club@private_dance@part2", "priv_dance_p2", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(30000)
	TaskPlayAnim(ped, "mini@strip_club@private_dance@part3", "priv_dance_p3", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(30000)
	TaskGoStraightToCoord(ped, 100.649, -1294.102, 29.268, 1.0, -1, 116.493, 0.0)
	Wait(14000)
    DeletePed(ped)
        troia = false

end

function puttana2()
    troia = true
    RequestModel( GetHashKey( "s_f_y_stripper_01" ) )
    while ( not HasModelLoaded( GetHashKey( "s_f_y_stripper_01" ) ) ) do
    Citizen.Wait( 1 )
    end
    local ped = CreatePed(4, 0x52580019, 113.144, -1297.26, 29.269, 303.959, true)
    SetEntityAsMissionEntity(ped)
    Wait(1500)
    RequestAnimDict("mini@strip_club@lap_dance@ld_girl_a_song_a_p1")
	while (not HasAnimDictLoaded("mini@strip_club@lap_dance@ld_girl_a_song_a_p1")) do Citizen.Wait(0) end
	Wait(1500)
	RequestAnimDict("mini@strip_club@private_dance@part2")
	while (not HasAnimDictLoaded("mini@strip_club@private_dance@part2")) do Citizen.Wait(0) end
	RequestAnimDict("mini@strip_club@private_dance@part3")
	while (not HasAnimDictLoaded("mini@strip_club@private_dance@part3")) do Citizen.Wait(0) end
	RequestAnimDict("mini@strip_club@lap_dance_2g@ld_2g_reach")
    while (not HasAnimDictLoaded("mini@strip_club@lap_dance_2g@ld_2g_reach")) do Citizen.Wait(0) end

	Wait(1000)
	TaskGoStraightToCoord(ped, 117.782, -1294.343, 29.279, 1.0, -1, 238.812, 0.0)
	Wait(9000)
	--SetPedDesiredHeading(ped, 215.966)
	TriggerEvent("mt:missiontext", 'Seguimi', 3000)
	Wait(3000)
	SetPedDesiredHeading(ped, 120.59)
	Wait(2000)
	TaskGoStraightToCoord(ped, 115.276, -1295.779, 29.269, 1.0, -1, 117.241, 0.0)
	Wait(3000)
	TaskGoStraightToCoord(ped, 118.467, -1300.603, 29.019, 1.0, -1, 198.037, 0.0)
	Wait(7000)
	TriggerEvent("mt:missiontext", 'Mettiti seduto', 3000)
	Wait(5000)
	TaskGoStraightToCoord(ped, 118.625, -1301.632, 29.269, 1.0, -1, 120.59, 0.0)
	Wait(3000)
	SetEntityCoords(GetPlayerPed(-1), 118.92, -1302.55, 27.87)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetEntityHeading(GetPlayerPed(-1), 39.0)
	TaskPlayAnim(GetPlayerPed(-1), "mini@strip_club@lap_dance_2g@ld_2g_reach", "ld_2g_sit_idle", 8.0, -8.0, -1, 0, 0, false, false, false)
	SetFollowPedCamViewMode(4)
	TaskPlayAnim(ped, "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(30000)
	TaskPlayAnim(ped, "mini@strip_club@private_dance@part2", "priv_dance_p2", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(30000)
	TaskPlayAnim(ped, "mini@strip_club@private_dance@part3", "priv_dance_p3", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(30000)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetFollowPedCamViewMode(1)
	TaskGoStraightToCoord(ped, 115.272, -1296.144, 29.269, 1.0, -1, 115.824, 0.0)
	TaskGoStraightToCoord(ped, 111.578, -1298.126, 29.269, 1.0, -1, 119.131, 0.0)
	Wait(8000)
        DeletePed(ped)
        troia = false

end

function inizio()
	ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spo',
        {
            title    = 'Spogliarellista',
            align    = 'center',
            elements = {
				{label = 'Balletto spogliarellista <span style="color:green;">500 $</span>',		value = 'spo1'},
            }
    }, function(data, menu)

        if data.current.value == 'spo1' then
        menu.close()
            ESX.TriggerServerCallback("puttanatroia:checkMoney", function(hasMoney)
                if hasMoney then
                    puttana()
                    TriggerServerEvent("puttanatroia:removeMoney")
                else
                    ESX.ShowNotification("Non hai abbastanza soldi")
                end
			end)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function inizio2()
	ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spo',
        {
            title    = 'Spogliarellista',
            align    = 'center',
            elements = {
				{label = 'Privè <span style="color:green;">1500 $</span>',		value = 'prv1'},
            }
    }, function(data, menu)

        if data.current.value == 'prv1' then
        menu.close()
            ESX.TriggerServerCallback("puttanatroia:checkMoney2", function(hasMoney)
                if hasMoney then
                    TriggerEvent("mt:missiontext", 'Non ti muovere! La spogliarellista sta arrivando...', 3000)
                    puttana2()
                    TriggerServerEvent("puttanatroia:removeMoney2")
                else
                    ESX.ShowNotification("Non hai abbastanza soldi")
                end
			end)
        end
    end, function(data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
	while true do

	Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
			
		if GetDistanceBetweenCoords(coords, 114.753, -1285.85, 28.263, true) < 10.0 and (troia == false) then
			DrawMarker(-0, 114.753, -1285.85, 28.263, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 114.753, -1285.85, 28.263, true) < 1.0 then
				DisplayHelpText('Premi ~INPUT_PICKUP~ per pagare una spogliarellista')
                if IsControlJustReleased(1, 51) then
                    inizio()
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do

	Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
			
		if GetDistanceBetweenCoords(coords, 119.231, -1294.991, 29.274, true) < 10.0 and (troia == false) then
			DrawMarker(-0, 119.231, -1294.991, 29.274, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, 119.231, -1294.991, 29.274, true) < 1.0 then
				DisplayHelpText('Premi ~INPUT_PICKUP~ per pagare un privè')
                if IsControlJustReleased(1, 51) then
                    inizio2()
				end
			end
		end
	end
end)
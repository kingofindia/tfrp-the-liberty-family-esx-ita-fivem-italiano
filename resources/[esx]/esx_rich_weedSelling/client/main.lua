Keys = {
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

local PlayerData 				= {}
ESX = nil
local menuOpen = false
local wasOpen = false
local invendita = false
local vendere = false
local hainviatomsg = false
local controlli = false

-- Local Blip2
local VenditaBlips1 = {}
local VenditaBlips2 = {}
local VenditaBlips3 = {}
local VenditaBlips4 = {}
local VenditaBlips5 = {}
local VenditaBlips6 = {}
local VenditaBlips7 = {}
local VenditaBlips8 = {}
local VenditaBlips9 = {}
local VenditaBlips10 = {}
local VenditaBlips11 = {}
local VenditaBlips12 = {}
local VenditaBlips13 = {}
local VenditaBlips14 = {}
local VenditaBlips15 = {}
local VenditaBlips16 = {}
local VenditaBlips17 = {}

-- Local Vendere
local havenduto1 = false
local havenduto2 = false
local havenduto3 = false
local havenduto4 = false
local havenduto5 = false
local havenduto6 = false
local havenduto7 = false
local havenduto8 = false
local havenduto9 = false
local havenduto10 = false
local havenduto11 = false
local havenduto12 = false
local havenduto13 = false
local havenduto14 = false
local havenduto15 = false
local havenduto16 = false
local havenduto17 = false

policeOnline = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(76.519, -1948.138, 21.174)
        
    SetBlipSprite (blip, 140)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 2)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Spaccio')
    EndTextCommandSetBlipName(blip)

    while true do

        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local lavoro = PlayerData.job
        if lavoro ~= nil and lavoro.name ~= "police" and lavoro.name ~= "sheriff" and lavoro.name ~= "ambulance" and lavoro.name ~= "state" then
            if GetDistanceBetweenCoords(coords, 76.519, -1948.138, 21.174, true) < 1.5 then
                if not menuOpen then
                    ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per aprire il menu')

                    if IsControlJustReleased(0, Keys['E']) then
                        wasOpen = true
                        OpenDrugShop()
                    end
                else
                    Citizen.Wait(500)
                end
            else
                if wasOpen then
                    wasOpen = false
                    ESX.UI.Menu.CloseAll()
                end

                Citizen.Wait(500)
            end

            if menuOpen then
                Citizen.Wait(600000)
                menuOpen = false
            end
        end
    end
end)

function animazioneplayer()
	local ped = PlayerPedId()

	RequestAnimDict("amb@world_human_drug_dealer_hard@male@idle_b")
	while (not HasAnimDictLoaded("amb@world_human_drug_dealer_hard@male@idle_b")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "amb@world_human_drug_dealer_hard@male@idle_b", "idle_d", 8.0, -8.0, -1, 0, 0, false, false, false) 
end

function animazioneplayer2()
	local ped = PlayerPedId()

	RequestAnimDict("mp_common")
	while (not HasAnimDictLoaded("mp_common")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false) 
end

function animazioneplayer3()
	local ped = PlayerPedId()

	RequestAnimDict("gestures@m@standing@casual")
	while (not HasAnimDictLoaded("gestures@m@standing@casual")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "gestures@m@standing@casual", "gesture_hello", 8.0, -8.0, -1, 0, 0, false, false, false) 
end

function OpenDrugShop()
    ESX.UI.Menu.CloseAll()
    menuOpen = true
    TriggerEvent("pNotify:SendNotification",{
        text = 'Potrai accedere nuovamente a questo menu tra 10 minuti.',
        type = "warning",
        timeout = (10000),
        layout = "bottomCenter",
        queue = "global"
    })

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_weed', 
        {
            title = 'Vendita Marijuana',
            align = 'top-left',
            elements = {
                {label = 'Inizia a vendere marijuana in zona', value = 'startsellingweed'}
            }
        }, function(data, menu)
                menu.close()
                if IsPedSittingInAnyVehicle(PlayerPedId(), false) then
                    TriggerEvent("pNotify:SendNotification",{
                        text = 'Non puoi vendere l\'erba se sei dentro un veicolo!',
                        type = "error",
                        timeout = (7000),
                        layout = "bottomCenter",
                        queue = "global"
                      })
                    invendita = false
                else
                    ESX.TriggerServerCallback('esx_rich:GetPoliceOnline', function(police)
                        policeOnline = police
                        if policeOnline == 2 or policeOnline == 1 then
                            TriggerEvent("pNotify:SendNotification",{
                                text = 'Non puoi vendere marijuana se non ci sono almeno 2 poliziotti online!',
                                type = "error",
                                timeout = (7000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            invendita = false
                        elseif policeOnline >= 0 then
                            ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                                if quantity ~= 0 then
                                    invendita = true
                                    refreshBlips()
                                    TriggerEvent("pNotify:SendNotification",{
                                        text = 'Vai nei punti di vendita',
                                        type = "success",
                                        timeout = (7000),
                                        layout = "bottomCenter",
                                        queue = "global"
                                    })
                                else
                                    TriggerEvent("pNotify:SendNotification",{
                                        text = 'Non hai nessun grammo di marijuana!',
                                        type = "error",
                                        timeout = (7000),
                                        layout = "bottomCenter",
                                        queue = "global"
                                    })
                                    invendita = false
                                end
                            end, 'marijuana')
                        end
                    end)
                end
            end, function(data, menu)
                menu.close()
            end
    )
end

function refreshBlips()
    
    if invendita then
        
        if not havenduto1 then
            for k,v in pairs(Config.Zones) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips1, blip)
                end
            end
        end

        if not havenduto2 then
            for k,v in pairs(Config.Zones2) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                    
                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips2, blip)
                end
            end
        end

        if not havenduto3 then
            for k,v in pairs(Config.Zones3) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips3, blip)
                end
            end
        end

        if not havenduto4 then
            for k,v in pairs(Config.Zones4) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips4, blip)
                end
            end
        end

        if not havenduto5 then
            for k,v in pairs(Config.Zones5) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips5, blip)
                end
            end
        end

        if not havenduto6 then
            for k,v in pairs(Config.Zones6) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips6, blip)
                end
            end
        end

        if not havenduto7 then
            for k,v in pairs(Config.Zones7) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips7, blip)
                end
            end
        end

        if not havenduto8 then
            for k,v in pairs(Config.Zones8) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips8, blip)
                end
            end
        end

        if not havenduto9 then
            for k,v in pairs(Config.Zones9) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips9, blip)
                end
            end
        end

        if not havenduto10 then
            for k,v in pairs(Config.Zones10) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips10, blip)
                end
            end
        end

        if not havenduto11 then
            for k,v in pairs(Config.Zones11) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips11, blip)
                end
            end
        end

        if not havenduto12 then
            for k,v in pairs(Config.Zones12) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips12, blip)
                end
            end
        end

        if not havenduto13 then
            for k,v in pairs(Config.Zones13) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips13, blip)
                end
            end
        end

        if not havenduto14 then
            for k,v in pairs(Config.Zones14) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips14, blip)
                end
            end
        end

        if not havenduto15 then
            for k,v in pairs(Config.Zones15) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips15, blip)
                end
            end
        end

        if not havenduto16 then
            for k,v in pairs(Config.Zones16) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips16, blip)
                end
            end
        end

        if not havenduto17 then
            for k,v in pairs(Config.Zones17) do
                for i = 1, #v.Pos, 1 do
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

                    SetBlipSprite (blip, 140)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 2)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips17, blip)
                end
            end
        end
    end
end

function deleteBlips()
	if VenditaBlips1[1] ~= nil then
		for i=1, #VenditaBlips1, 1 do
			RemoveBlip(VenditaBlips1[i])
			VenditaBlips1[i] = nil
		end
    end
    if VenditaBlips2[1] ~= nil then
        for i=1, #VenditaBlips2, 1 do
            RemoveBlip(VenditaBlips2[i])
            VenditaBlips2[i] = nil
        end
    end
    if VenditaBlips3[1] ~= nil then
        for i=1, #VenditaBlips3, 1 do
            RemoveBlip(VenditaBlips3[i])
            VenditaBlips3[i] = nil
        end
    end
    if VenditaBlips4[1] ~= nil then
        for i=1, #VenditaBlips4, 1 do
            RemoveBlip(VenditaBlips4[i])
            VenditaBlips4[i] = nil
        end
    end
    if VenditaBlips5[1] ~= nil then
        for i=1, #VenditaBlips5, 1 do
            RemoveBlip(VenditaBlips5[i])
            VenditaBlips5[i] = nil
        end
    end
    if VenditaBlips6[1] ~= nil then
        for i=1, #VenditaBlips6, 1 do
            RemoveBlip(VenditaBlips6[i])
            VenditaBlips6[i] = nil
        end
    end
    if VenditaBlips7[1] ~= nil then
        for i=1, #VenditaBlips7, 1 do
            RemoveBlip(VenditaBlips7[i])
            VenditaBlips7[i] = nil
        end
    end
    if VenditaBlips8[1] ~= nil then
        for i=1, #VenditaBlips8, 1 do
            RemoveBlip(VenditaBlips8[i])
            VenditaBlips8[i] = nil
        end
    end
    if VenditaBlips9[1] ~= nil then
        for i=1, #VenditaBlips9, 1 do
            RemoveBlip(VenditaBlips9[i])
            VenditaBlips9[i] = nil
        end
    end
    if VenditaBlips10[1] ~= nil then
        for i=1, #VenditaBlips10, 1 do
            RemoveBlip(VenditaBlips10[i])
            VenditaBlips10[i] = nil
        end
    end
    if VenditaBlips11[1] ~= nil then
        for i=1, #VenditaBlips11, 1 do
            RemoveBlip(VenditaBlips11[i])
            VenditaBlips11[i] = nil
        end
    end
    if VenditaBlips12[1] ~= nil then
        for i=1, #VenditaBlips12, 1 do
            RemoveBlip(VenditaBlips12[i])
            VenditaBlips12[i] = nil
        end
    end
    if VenditaBlips13[1] ~= nil then
        for i=1, #VenditaBlips13, 1 do
            RemoveBlip(VenditaBlips13[i])
            VenditaBlips13[i] = nil
        end
    end
    if VenditaBlips14[1] ~= nil then
        for i=1, #VenditaBlips14, 1 do
            RemoveBlip(VenditaBlips14[i])
            VenditaBlips14[i] = nil
        end
    end
    if VenditaBlips15[1] ~= nil then
        for i=1, #VenditaBlips15, 1 do
            RemoveBlip(VenditaBlips15[i])
            VenditaBlips15[i] = nil
        end
    end
    if VenditaBlips16[1] ~= nil then
        for i=1, #VenditaBlips16, 1 do
            RemoveBlip(VenditaBlips16[i])
            VenditaBlips16[i] = nil
        end
    end
    if VenditaBlips17[1] ~= nil then
        for i=1, #VenditaBlips17, 1 do
            RemoveBlip(VenditaBlips17[i])
            VenditaBlips17[i] = nil
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if invendita then
            Citizen.Wait(1200000)
            invendita = false
            TriggerEvent("pNotify:SendNotification",{
                text = 'Hai passato troppo tempo nella zona, non puoi più vendere marijuana!',
                type = "error",
                timeout = (7000),
                layout = "bottomCenter",
                queue = "global"
            })
        end
    end
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(1)
        
        if controlli then
            DisableControlAction(0, Keys['X'], true)
        else
            EnableControlAction(0, Keys['X'], false)
        end
        
        DrawMarker(1, 76.519, -1948.138, 20.174, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 200, 0, 100, false, false, 2, false, false, false , false)

        if invendita then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local player = PlayerPedId()

            ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                if quantity == 0 then
                    if not hainviatomsg then
                        invendita = false
                        hainviatomsg = true
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Hai finito la marijuana, non puoi continuare a vendere!',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                    end
                end
            end, 'marijuana')

            if not havenduto1 then
                DrawMarker(0, 56.364, -1922.498, 21.911, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto2 then                    
                DrawMarker(0, 72.618, -1938.981, 21.369, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto3 then
                DrawMarker(0, 100.165, -1913.126, 21.029, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto4 then
                DrawMarker(0, 95.203, -1895.838, 24.311, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto5 then
                DrawMarker(0, 129.463, -1853.413, 25.231, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto6 then
                DrawMarker(0, 150.008, -1864.682, 24.591, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto7 then
                DrawMarker(0, 171.783, -1871.062, 24.4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto8 then
                DrawMarker(0, 192.711, -1883.636, 25.057, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto9 then
                DrawMarker(0, 178.988, -1924.165, 21.371, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto10 then
                DrawMarker(0, 165.365, -1944.562, 20.235, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto11 then
                DrawMarker(0, 148.777, -1960.712, 19.459, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto12 then
                DrawMarker(0, 144.368, -1969.049, 18.858, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto13 then
                DrawMarker(0, 250.353, -1934.973, 24.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto14 then
                DrawMarker(0, 140.499, -1983.25, 18.32, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto15 then
                DrawMarker(0, 258.37, -1927.251, 25.445, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto16 then
                DrawMarker(0, 269.844, -1916.64, 26.183, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto17 then
                DrawMarker(0, 282.67, -1899.256, 27.268, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if havenduto1 and havenduto2 and havenduto3 and havenduto4 and havenduto5 and havenduto6 and havenduto7 and havenduto8 and havenduto9 and havenduto10 and havenduto11 and havenduto12 and havenduto13 and havenduto14 and havenduto15 and havenduto16 and havenduto17 then
                invendita = false
                TriggerEvent("pNotify:SendNotification",{
                    text = 'Non ci sono più case dove poter vendere la marijuana!',
                    type = "error",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end

            if(GetDistanceBetweenCoords(coords, 56.364, -1922.498, 21.911, true) < 1.5) and not havenduto1 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto1 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 72.618, -1938.981, 21.369, true) < 1.5) and not havenduto2 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto2 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 100.165, -1913.126, 21.029, true) < 1.5) and not havenduto3 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto3 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 95.203, -1895.838, 24.311, true) < 1.5) and not havenduto4 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto4 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 129.463, -1853.413, 25.231, true) < 1.5) and not havenduto5 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto5 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 150.008, -1864.682, 24.591, true) < 1.5) and not havenduto6 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto6 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 171.783, -1871.062, 24.4, true) < 1.5) and not havenduto7 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto7 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 192.711, -1883.636, 25.057, true) < 1.5) and not havenduto8 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto8 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 178.988, -1924.165, 21.371, true) < 1.5) and not havenduto9 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto9 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 165.365, -1944.562, 20.235, true) < 1.5) and not havenduto10 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto10 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 148.777, -1960.712, 19.459, true) < 1.5) and not havenduto11 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto11 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 144.368, -1969.049, 18.858, true) < 1.5) and not havenduto12 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto12 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 250.353, -1934.973, 24.7, true) < 1.5) and not havenduto13 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto13 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 140.499, -1983.25, 18.32, true) < 1.5) and not havenduto14 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto14 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 258.37, -1927.251, 25.445, true) < 1.5) and not havenduto15 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto15 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 269.844, -1916.64, 26.183, true) < 1.5) and not havenduto16 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto16 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 282.67, -1899.256, 27.268, true) < 1.5) and not havenduto17 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per vendere marijuana')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = math.random(0, 4)
                    havenduto17 = true

                    deleteBlips()
                    refreshBlips()

                    if number ~= 0 then
                        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                            marijuanaQTY = quantity
                            if marijuanaQTY >= number then
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer()
                                Wait(12000)
                                animazioneplayer2()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_sellingweed:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza marijuana. Marijuana richiesta: ' .. number .. ' marijuana nel tuo inventario ' .. marijuanaQTY,
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'marijuana')
                    else
                        FreezeEntityPosition(player, true)
                        controlli = true
                        animazioneplayer3()
                        Wait(2000)
                        controlli = false
                        FreezeEntityPosition(player, false)
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Nessuno vuole comprare la marijuana',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                          })
                    end
                end
            end
        end
    end
end)
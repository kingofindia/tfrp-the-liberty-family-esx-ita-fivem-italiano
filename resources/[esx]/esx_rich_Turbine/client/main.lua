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

function creaBlip()
    local blip = AddBlipForCoord(2514.495, 1974.708, 19.96)
        
    SetBlipSprite (blip, 564)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 5)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Riparazione turbine')
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    creaBlip()
    while true do

        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local lavoro = PlayerData.job
        if lavoro ~= nil and lavoro.name == "mecano" then
            if GetDistanceBetweenCoords(coords, 2514.495, 1974.708, 19.96, true) < 2.0 then
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
        --else
            --ESX.ShowHelpNotification('Devi essere un meccanico!')
        end
    end
end)
 --WORLD_HUMAN_WELDING

function animazioneplayer()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, false)
end

function animazioneplayer3()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_STANDING", 0, false)
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
            title = 'Riparazione Turbine',
            align = 'top-left',
            elements = {
                {label = 'Inizia a riparare le turibe', value = 'startsellingweed'}
            }
        }, function(data, menu)
                menu.close()
                if IsPedSittingInAnyVehicle(PlayerPedId(), false) then
                    TriggerEvent("pNotify:SendNotification",{
                        text = 'Non puoi riparare le turbine se sei dentro un veicolo!',
                        type = "error",
                        timeout = (7000),
                        layout = "bottomCenter",
                        queue = "global"
                      })
                    invendita = false
                else
                    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                        if quantity ~= 0 then
                            invendita = true
                            refreshBlips()
                            TriggerEvent("pNotify:SendNotification",{
                                text = 'Vai nei punti di riparazione',
                                type = "success",
                                timeout = (7000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                        else
                            TriggerEvent("pNotify:SendNotification",{
                                text = 'Non hai neanche un saldatore!',
                                type = "error",
                                timeout = (7000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                            invendita = false
                        end
                    end, 'blowpipe')
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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
                    
                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
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

                    SetBlipSprite (blip, 564)
                    SetBlipDisplay(blip, 2)
                    SetBlipScale  (blip, 0.6)
                    SetBlipColour (blip, 5)
                    SetBlipAsShortRange(blip, true)
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Pos[i].nome)
                    EndTextCommandSetBlipName(blip)
                    table.insert(VenditaBlips11, blip)
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
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if invendita then
            Citizen.Wait(1200000)
            invendita = false
            TriggerEvent("pNotify:SendNotification",{
                text = 'Hai passato troppo tempo nella zona, non puoi più riparare le turbine!',
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
        
        DrawMarker(0, 2514.495, 1974.708, 19.96, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 200, 0, 100, false, false, 2, false, false, false , false)

        if invendita then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local player = PlayerPedId()

            ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                if quantity == 0 then
                    if not hainviatomsg then
                        invendita = false
                        hainviatomsg = true
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Hai finito i saldatori, non puoi continuare a riparare le turbine!',
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                    end
                end
            end, 'blowpipe')

            if not havenduto1 then
                DrawMarker(0, 2202.013, 2490.196, 87.387, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto2 then                    
                DrawMarker(0, 1984.871, 2201.755, 104.077, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto3 then
                DrawMarker(0, 2044.293, 2121.600, 92.498, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto4 then
                DrawMarker(0, 1998.100, 1931.331, 91.441, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto5 then
                DrawMarker(0, 2123.001, 1752.178, 102.293, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto6 then
                DrawMarker(0, 2199.375, 1495.238, 81.671, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto7 then
                DrawMarker(0, 2277.742, 1411.886, 73.985, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto8 then
                DrawMarker(0, 2281.808, 1569.976, 65.648, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto9 then
                DrawMarker(0, 2318.153, 1608.140, 56.94, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto10 then
                DrawMarker(0, 2303.596, 1853.392, 106.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto11 then
                DrawMarker(0, 2398.752, 2031.661, 90.339, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if not havenduto12 then
                DrawMarker(0, 2367.886, 2187.717, 101.976, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, true, false, false , false)
            end

            if havenduto1 and havenduto2 and havenduto3 and havenduto4 and havenduto5 and havenduto6 and havenduto7 and havenduto8 and havenduto9 and havenduto10 and havenduto11 and havenduto12 then
                invendita = false
                TriggerEvent("pNotify:SendNotification",{
                    text = 'Non ci sono più turbine da riparare!',
                    type = "error",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end

            if(GetDistanceBetweenCoords(coords, 2202.013, 2490.196, 88.387, true) < 1.5) and not havenduto1 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 1984.871, 2201.755, 105.077, true) < 1.5) and not havenduto2 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2044.293, 2121.600, 93.498, true) < 1.5) and not havenduto3 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 1998.100, 1931.331, 92.441, true) < 1.5) and not havenduto4 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2123.001, 1752.178, 103.293, true) < 1.5) and not havenduto5 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2199.375, 1495.238, 82.671, true) < 1.5) and not havenduto6 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2277.742, 1411.886, 74.985, true) < 1.5) and not havenduto7 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2281.808, 1569.976, 66.648, true) < 1.5) and not havenduto8 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2318.153, 1608.140, 57.94, true) < 1.5) and not havenduto9 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2303.596, 1853.392, 107.0, true) < 1.5) and not havenduto10 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2398.752, 2031.661, 91.339, true) < 1.5) and not havenduto11 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end

            if(GetDistanceBetweenCoords(coords, 2367.886, 2187.717, 102.976, true) < 1.5) and not havenduto12 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per riparare la turbina')
                if IsControlJustReleased(0, Keys['E']) then
                    local number = 1
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
                                Wait(7000)
                                ClearPedTasksImmediately(player)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerServerEvent('esx_rich_Turbine:vendi', number)
                            else
                                FreezeEntityPosition(player, true)
                                controlli = true
                                animazioneplayer3()
                                Wait(2000)
                                controlli = false
                                FreezeEntityPosition(player, false)
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai più saldatori nel tuo inventario',
                                    type = "error",
                                    timeout = (7000),
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end, 'blowpipe')
                    end
                end
            end
        end
    end
end)
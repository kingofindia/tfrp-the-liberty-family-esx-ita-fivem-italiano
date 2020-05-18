local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil

local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

local TestDriveDueMinuti      = false
local TestDriveCinqueMinuti   = false
local rientrato               = false

local PlayerData              = {}
local GUI                     = {}
ESX                           = nil
GUI.Time                      = 0

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
  
    ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function (categories)
        Categories = categories
    end)
  
    ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function (vehicles)
        Vehicles = vehicles
    end)
end)

function DeleteKatalogVehicles ()
    while #LastVehicles > 0 do
        local vehicle = LastVehicles[1]
        ESX.Game.DeleteVehicle(vehicle)
        table.remove(LastVehicles, 1)
    end
end

AddEventHandler('esx_qalle_bilpriser:hasEnteredMarker', function (zone)
    if zone == 'Katalog' then
        CurrentAction     = 'cars_menu'
        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per aprire il listino'
        CurrentActionData = {}
    end
  
    if zone == 'GoDownFrom' then
        CurrentAction     = 'go_down_from'
        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per visitare l\'auto salone'
        CurrentActionData = {}
    end
  
    if zone == 'GoUpFrom' then
        CurrentAction     = 'go_up_from'
        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per tornare in concessionario'
        CurrentActionData = {}
    end  
end)

AddEventHandler('esx_qalle_bilpriser:hasExitedMarker', function (zone)
    if not IsInShopMenu then
        ESX.UI.Menu.CloseAll()
    end
    CurrentAction = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if TestDriveDueMinuti then
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)


            Citizen.Wait(60000)

            if IsPedInAnyVehicle(playerPed, true) then
                vehicle = GetVehiclePedIsIn(playerPed, false)
            elseif IsPedInAnyVehicle(playerPed, false) then
                vehicle = GetVehiclePedIsIn(playerPed, false)
            end

            if TestDriveDueMinuti and not rientrato then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Attenzione: Ti manca 1 minuto prima della fine del test drive, riporta il tuo veicolo in concessionario sennò verrai segnalato alla polizia.",
                    type = "warning",
                    timeout = 7000,
                    layout = "bottomCenter",
                    queue = "global"
                })
            end

            Citizen.Wait(60000)
            if not rientrato then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Hai finito il test drive ma non sei ancora rientrato in concessionario, è stata inviata una segnalazione alla polizia.",
                    type = "error",
                    timeout = 7000,
                    layout = "bottomCenter",
                    queue = "global"
                })
                PolMex()
                rientrato = true
            end
            TestDriveDueMinuti = false
        end
        if TestDriveCinqueMinuti then
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            Citizen.Wait(120000)

            if IsPedInAnyVehicle(playerPed, true) then
                vehicle = GetVehiclePedIsIn(playerPed, false)
            elseif IsPedInAnyVehicle(playerPed, false) then
                vehicle = GetVehiclePedIsIn(playerPed, false)
            end

            if TestDriveCinqueMinuti and not rientrato then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Attenzione: Ti mancano 2 minuti prima della fine del test drive, riporta il tuo veicolo in concessionario sennò verrai segnalato alla polizia.",
                    type = "warning",
                    timeout = 7000,
                    layout = "bottomCenter",
                    queue = "global"
                })
            end

            Citizen.Wait(120000)
            if not rientrato then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Hai finito il test drive ma non sei ancora rientrato in concessionario, è stata inviata una segnalazione alla polizia.",
                    type = "error",
                    timeout = 7000,
                    layout = "bottomCenter",
                    queue = "global"
                })
                PolMex()
                rientrato = true
            end
            TestDriveCinqueMinuti = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle = nil

        DrawMarker(27, -51.855, -1078.865, 25.992, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
        if GetDistanceBetweenCoords(coords, -51.855, -1078.865, 25.892, true) < 1.5 then
            ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per restituire il veicolo')

            if IsControlJustReleased(0, Keys['E']) then
                if IsPedInAnyVehicle(playerPed, true) then
                    vehicle = GetVehiclePedIsIn(playerPed, false)
                elseif IsPedInAnyVehicle(playerPed, false) then
                    vehicle = GetVehiclePedIsIn(playerPed, false)
                end

                if vehicle then
                    
                    if TestDriveDueMinuti or TestDriveCinqueMinuti then
                        rientrato = true
                        TestDriveCinqueMinuti = false
                        TestDriveDueMinuti = false
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Hai restituito il veicolo",
                            type = "success",
                            timeout = 7000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        SetEntityAsMissionEntity(vehicle, true, true)
                        DeleteVehicle(vehicle)
                    else
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Non stai facendo un test drive!",
                            type = "error",
                            timeout = 7000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                    end
                else
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Devi essere in un veicolo",
                        type = "error",
                        timeout = 7000,
                        layout = "bottomCenter",
                        queue = "global"
                    })
                end
            end
        end
    end
end)

function PolMex()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)

	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    
    ESX.TriggerServerCallback('esx_rich_testDrive:ChiamataPolizia', function(nome)
        if nome then
            TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'Avviso mancata restituzione del veicolo alla fine di un TestDrive, nominativi: ' .. nome, PlayerCoords, {
                PlayerCoords2 = {
                    x = PedPosition.x, 
                    y = PedPosition.y, 
                    z = PedPosition.z 
                }
            })
        else
            TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'Avviso mancata restituzione del veicolo alla fine di un TestDrive, nominativi: NON TROVATI', PlayerCoords, {
                PlayerCoords2 = {
                    x = PedPosition.x, 
                    y = PedPosition.y, 
                    z = PedPosition.z 
                }
            })
        end
    end)
end

function TornaInConcessionario()
    local playerPed = PlayerPedId()
    --[[ local veicolo = vehicle

    if DoesEntityExist(veicolo) then
        SetEntityAsMissionEntity(veicolo, true, true)
        DeleteVehicle(veicolo)
    end ]]

    SetEntityCoords(playerPed, Config.Zones.Katalog.Pos.x, Config.Zones.Katalog.Pos.y, Config.Zones.Katalog.Pos.z)
end

function OpenShopMenu()
    IsInShopMenu = true

    ESX.UI.Menu.CloseAll()

    local playerPed = GetPlayerPed(-1)

    FreezeEntityPosition(playerPed, true)
    SetEntityVisible(playerPed, false)
    SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)

    local vehiclesByCategory = {}
    local elements           = {}
    local firstVehicleData   = nil

    for i=1, #Categories, 1 do
        vehiclesByCategory[Categories[i].name] = {}
    end

    for i=1, #Vehicles, 1 do
        table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
    end

    for i=1, #Categories, 1 do
        local category         = Categories[i]
        local categoryVehicles = vehiclesByCategory[category.name]
        local options          = {}
    
        for j=1, #categoryVehicles, 1 do
            local vehicle = categoryVehicles[j]
    
            if i == 1 and j == 1 then
                firstVehicleData = vehicle
            end
    
            table.insert(options, vehicle.name .. ' ')
        end
    
        table.insert(elements, {
            name    = category.name,
            label   = category.label,
            value   = 0,
            type    = 'slider',
            max     = #Categories[i],
            options = options
        })
    end

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_shop',
        {
            title    = 'Veicoli',
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'shop_confirm',
                {
                    title = vehicleData.name,
                    align = 'top-left',
                    elements = {
                        {label = '' .. vehicleData.name .. ' Prezzo: ' .. vehicleData.price * Config.Price .. ' $', value = 'yes'},
                        {label = 'Test Drive: 2500$, 2 minuti', value = 'DueMinuti'},
                        {label = 'Test Drive: 5000$, 4 minuti', value = 'CinqueMinuti'},
                        {label = 'Torna indietro', value = 'no'},
                    },
                },
                function(data2, menu2)
                    local opzione = data2.current.value

                    if opzione == 'yes' then
                        TriggerEvent("pNotify:SendNotification",{
                            text = 'Contatta il concessionario per il prezzo finale.',
                            type = "warning",
                            timeout = 7000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                    elseif opzione == 'DueMinuti' then
                        ESX.TriggerServerCallback('esx_rich_carshowroom:CheckMoney', function(money)
                            if money >= 2500 then
                                local playerPed = GetPlayerPed(-1)
                                local vehicle2 = GetVehiclePedIsIn(playerPed, false)

                                TestDriveDueMinuti = true
                                
                                TriggerServerEvent('esx_rich_take:DuemilaCinque')
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Hai iniziato il Test Drive di 2 Minuti',
                                    type = "success",
                                    timeout = 7000,
                                    layout = "bottomCenter",
                                    queue = "global"
                                })

                                ESX.Game.SpawnVehicle(vehicleData.model, {
                                    x = -58.917,
                                    y = -1059.816,
                                    z = 26.523
                                }, 180.00, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                    FreezeEntityPosition(vehicle, false)
                                end)

                                FreezeEntityPosition(playerPed, false)
                                IsInShopMenu = false
                                menu.close()

                                if DoesEntityExist(vehicle2) then
                                    SetEntityAsMissionEntity(vehicle2, true, true)
                                    DeleteVehicle(vehicle2)
                                else
                                    DeleteVehicle(vehicle2)
                                end
                            else
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza soldi contanti',
                                    type = "error",
                                    timeout = 7000,
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end)

                    elseif opzione == 'CinqueMinuti' then
                        ESX.TriggerServerCallback('esx_rich_carshowroom:CheckMoney', function(money)
                            if money >= 5000 then
                                local playerPed = GetPlayerPed(-1)
                                local vehicle2 = GetVehiclePedIsIn(playerPed, false)

                                TestDriveCinqueMinuti = true
                                
                                TriggerServerEvent('esx_rich_take:CinqueKappa')
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Hai iniziato il Test Drive di 4 Minuti',
                                    type = "success",
                                    timeout = 7000,
                                    layout = "bottomCenter",
                                    queue = "global"
                                })

                                ESX.Game.SpawnVehicle(vehicleData.model, {
                                    x = -58.917,
                                    y = -1059.816,
                                    z = 26.523
                                }, 180.00, function(vehicle)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                    FreezeEntityPosition(vehicle, false)
                                end)

                                FreezeEntityPosition(playerPed, false)
                                IsInShopMenu = false
                                menu2.close()
                                menu.close()

                                if DoesEntityExist(vehicle2) then
                                    SetEntityAsMissionEntity(vehicle2, true, true)
                                    DeleteVehicle(vehicle2)
                                else
                                    DeleteVehicle(vehicle2)
                                end
                            else
                                TriggerEvent("pNotify:SendNotification",{
                                    text = 'Non hai abbastanza soldi contanti',
                                    type = "error",
                                    timeout = 7000,
                                    layout = "bottomCenter",
                                    queue = "global"
                                })
                            end
                        end)
                    
                    elseif opzione == 'no' then
                        menu2.close()
                    end
                end,
                function(data2, menu2)
                    menu2.close()
                end
            )
        end,
        function(data, menu)

            menu.close()

            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)

            DeleteKatalogVehicles()

            local playerPed = GetPlayerPed(-1)

            CurrentAction     = 'shop_menu'
            CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per aprire il listino veicoli'
            CurrentActionData = {}

            FreezeEntityPosition(playerPed, false)

            SetEntityCoords(playerPed, Config.Zones.Katalog.Pos.x, Config.Zones.Katalog.Pos.y, Config.Zones.Katalog.Pos.z)
            SetEntityVisible(playerPed, true)

            IsInShopMenu = false
        end,
        function(data, menu)
            local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
            local playerPed   = GetPlayerPed(-1)

            DeleteKatalogVehicles()

            ESX.Game.SpawnLocalVehicle(vehicleData.model, {
                x = Config.Zones.ShopInside.Pos.x,
                y = Config.Zones.ShopInside.Pos.y,
                z = Config.Zones.ShopInside.Pos.z
            }, Config.Zones.ShopInside.Heading, function(vehicle)
                table.insert(LastVehicles, vehicle)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                FreezeEntityPosition(vehicle, true)
            end)
        end
    )

    DeleteKatalogVehicles()

    ESX.Game.SpawnLocalVehicle(firstVehicleData.model, {
        x = Config.Zones.ShopInside.Pos.x,
        y = Config.Zones.ShopInside.Pos.y,
        z = Config.Zones.ShopInside.Pos.z
    }, Config.Zones.ShopInside.Heading, function (vehicle)
        table.insert(LastVehicles, vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
                if CurrentAction == 'cars_menu' then
                    OpenShopMenu()
                end

                if CurrentAction == 'go_down_from' then
                    local playerPed = GetPlayerPed(-1)
                    DoScreenFadeOut(3000)
                    Wait(3000)
                    DoScreenFadeIn(3000)
                    SetEntityCoords(playerPed, Config.Zones.GoUpFrom.Pos.x, Config.Zones.GoUpFrom.Pos.y, Config.Zones.GoUpFrom.Pos.z)
                end

                if CurrentAction == 'go_up_from' then
                    local playerPed = GetPlayerPed(-1)
                    DoScreenFadeOut(3000)
                    Wait(3000)
                    DoScreenFadeIn(3000)
                    SetEntityCoords(playerPed, Config.Zones.GoDownFrom.Pos.x, Config.Zones.GoDownFrom.Pos.y, Config.Zones.GoDownFrom.Pos.z)
                end
                
                CurrentAction = nil
                GUI.Time      = GetGameTimer()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(Config.Zones) do
            if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local coords      = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker  = false
        local currentZone = nil

        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
                isInMarker  = true
                currentZone = k
            end
        end
      
        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            HasAlreadyEnteredMarker = true
            LastZone                = currentZone
            TriggerEvent('esx_qalle_bilpriser:hasEnteredMarker', currentZone)
        end
      
        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_qalle_bilpriser:hasExitedMarker', LastZone)
        end
    end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
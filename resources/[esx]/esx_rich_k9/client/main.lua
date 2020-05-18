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

local PlayerData            = {}
local spawned_ped           = nil
local k9_name               = "Default"
local following             = false
local attacking             = false
local attacked_player       = 0
local searching             = false
local playing_animation     = false
local model                 = -1788665315

local isRestricted          = false

--local inveicolo             = false
--local status                = 100
--local model                 = "a_c_rottweiler"

local animations = {
    ['Normal'] = {
        sit = {
            dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
            anim = "idle_b"
        },
        laydown = {
            dict = "creatures@rottweiler@amb@sleep_in_kennel@",
            anim = "sleep_in_kennel"
        },
        searchhit = {
            dict = "creatures@rottweiler@indication@",
            anim = "indicate_high"
        }
    }
}

ESX                         = nil

-- ESX base

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()

    Citizen.Wait(5000)
    DoRequestModel(-1788665315)
    DoRequestModel(1318032802)
    DoRequestModel(1126154828)
    DoRequestModel(882848737)
end)

RegisterNetEvent("esx_rich_k9:TiSegue")
AddEventHandler("esx_rich_k9:TiSegue", function()
    if spawned_ped ~= nil then
        if not following then
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
                SetPedKeepTask(spawned_ped, true)
                following = true
                attacking = false
                TriggerEvent("pNotify:SendNotification",{
                    text = k9_name .. " ti sta seguendo",
                    type = "success",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        end
    end
end)

RegisterNetEvent("esx_rich_k9:NonTiSegue")
AddEventHandler("esx_rich_k9:NonTiSegue", function()
    if spawned_ped ~= nil then
        if following then
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                SetPedKeepTask(spawned_ped, false)
                ClearPedTasks(spawned_ped)
                following = false
                attacking = false
                TriggerEvent("pNotify:SendNotification",{
                    text = k9_name .. " ha smesso di seguirti",
                    type = "success",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        end
    end
end)

-- Attack / UnAttack

RegisterNetEvent("esx_rich_k9:ToggleAttack")
AddEventHandler("esx_rich_k9:ToggleAttack", function(target)
    if not attacking and not searching then
        if IsPedAPlayer(target) then
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                local player = GetPlayerFromServerId(GetPlayerId(target))
                SetCanAttackFriendly(spawned_ped, true, true)
                TaskPutPedDirectlyIntoMelee(spawned_ped, GetPlayerPed(player), 0.0, -1.0, 0.0, 0)
                attacked_player = player
            end
        else
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                SetCanAttackFriendly(spawned_ped, true, true)
                TaskPutPedDirectlyIntoMelee(spawned_ped, target, 0.0, -1.0, 0.0, 0)
                attacked_player = 0
            end
        end
        attacking = true
        following = false
        --Notification(tostring(k9_name .. " " .. language.attack))
        TriggerEvent("pNotify:SendNotification",{
            text = k9_name .. " sta attaccando",
            type = "success",
            timeout = (7000),
            layout = "bottomCenter",
            queue = "global"
        })
    else
        TriggerEvent("pNotify:SendNotification",{
            text = k9_name .. " non riesce ad attaccare",
            type = "success",
            timeout = (7000),
            layout = "bottomCenter",
            queue = "global"
        })
    end
end)


-- [[Functions]] --
function OpenDog()

    if spawned_ped == nil then
        local playerPed = GetPlayerPed(-1)
        local LastPosition = GetEntityCoords(GetPlayerPed(-1))
        local GroupHandle = GetPlayerGroup(PlayerId())

        DoRequestAnimSet('rcmnigel1c')

        TaskPlayAnim(GetPlayerPed(-1), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
        Citizen.SetTimeout(5000, function()
            ped = CreatePed(28, model, LastPosition.x +1, LastPosition.y +1, LastPosition.z -1, 1, 1)
            spawned_ped = ped

            local blip = AddBlipForEntity(spawned_ped)
            SetBlipAsFriendly(blip, true)
            SetBlipSprite(blip, 442)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring("K9: ".. k9_name))
            EndTextCommandSetBlipName(blip)
            NetworkRegisterEntityAsNetworked(spawned_ped)
            TriggerEvent("esx_rich_k9:TiSegue")
            while not NetworkGetEntityIsNetworked(spawned_ped) do
                NetworkRegisterEntityAsNetworked(spawned_ped)
                Citizen.Wait(1)
            end
        --    Citizen.Wait(5)
        --    attached()
        --    Citizen.Wait(5)
        --    detached()
        end)
    else
        local has_control = false
        RequestNetworkControl(function(cb)
            has_control = cb
        end)
        if has_control then
            SetEntityAsMissionEntity(spawned_ped, true, true)
            DeleteEntity(spawned_ped)
               spawned_ped = nil
            if attacking then
                SetPedRelationshipGroupDefaultHash(target_ped, GetHashKey("CIVMALE"))
                target_ped = nil
                attacking = false
            end

            following = false
            searching = false
            playing_animation = false
        end
    end
end

function GetLocalPed()
    return GetPlayerPed(PlayerId())
end

function RequestNetworkControl(callback)
    local netId = NetworkGetNetworkIdFromEntity(spawned_ped)
    local timer = 0
    NetworkRequestControlOfNetworkId(netId)
    while not NetworkHasControlOfNetworkId(netId) do
        Citizen.Wait(1)
        NetworkRequestControlOfNetworkId(netId)
        timer = timer + 1
        if timer == 5000 then
            Citizen.Trace("Controllo fallito")
            callback(false)
            break
        end
    end
    callback(true)
end

function PlayAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(spawned_ped, dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end

function GetPlayerId(target_ped)
    local players = GetPlayers()
    for a = 1, #players do
        local ped = GetPlayerPed(players[a])
        local server_id = GetPlayerServerId(players[a])
        if target_ped == ped then
            return server_id
        end
    end
    return 0
end

function GetVehicleAheadOfPlayer()
    local lPed = GetLocalPed()
    local lPedCoords = GetEntityCoords(lPed, alive)
    local lPedOffset = GetOffsetFromEntityInWorldCoords(lPed, 0.0, 3.0, 0.0)
    local rayHandle = StartShapeTestCapsule(lPedCoords.x, lPedCoords.y, lPedCoords.z, lPedOffset.x, lPedOffset.y, lPedOffset.z, 1.2, 10, lPed, 7)
    local returnValue, hit, endcoords, surface, vehicle = GetShapeTestResult(rayHandle)

    if hit then
        return vehicle
    else
        return false
    end
end

function GetClosestVehicleDoor(vehicle)
    local plyCoords = GetEntityCoords(GetLocalPed(), false)
	local backleft = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_r"))
	local backright = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_r"))
	local bldistance = GetDistanceBetweenCoords(backleft['x'], backleft['y'], backleft['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)
    local brdistance = GetDistanceBetweenCoords(backright['x'], backright['y'], backright['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)

    local found_door = false

    if (bldistance < brdistance) then
        found_door = 1
    elseif(brdistance < bldistance) then
        found_door = 2
    end

    return found_door
end

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

-- Create Menu

function OpenK9Menu()

    local playerPed = PlayerPedId()
    
    local elements = {
        {label = "Opzioni",     value = "opzioni"},
        {label = "Animazioni",  value = "animazioni"},
        {label = "Azioni",      value = "azioni"},
        {label = "- - - -",  value = nil},
        {label = "Chiudi Menu", value = "close"}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'k9_menu',
    {
        title = "Menù K9",
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        if data.current.value == "opzioni" then
            OpenOptionsMenu()
        elseif data.current.value == "animazioni" then
            OpenAnimazioniMenu()
        elseif data.current.value == "azioni" then
            OpenAzioniMenu()
        elseif data.current.value == "close" then
            ESX.UI.Menu.CloseAll()
        end
    end)
end

function OpenOptionsMenu()

    local playerPed = PlayerPedId()

    local elements = {
        {label = "Cambia nome",         value = "changeName"},
        {label = "Cambia modello",      value = "changeModel"},
        {label = "Chiama Unità K9",     value = "toggleK9"},
        {label = "- - - -",          value = nil},
        {label = "Indietro",            value = "indietro"},
        {label = "Chiudi",               value = "chiudi"},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'k9_menu_options',
    {
        title = "Opzioni K9",
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        if data.current.value == "changeName" then
            local result = requestInput("", 60)
            
            if result == nil then
                TriggerEvent("pNotify:SendNotification",{
                    text = "Devi inserire un nome valido!",
                    type = "error",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            else
                k9_name = result
            end

        elseif data.current.value == "changeModel" then
            OpenModelMenu()
        elseif data.current.value == "toggleK9" then
            OpenDog()
        elseif data.current.value == "indietro" then
            OpenK9Menu()
        elseif data.current.value == "chiudi" then
            ESX.UI.Menu.CloseAll()
        end

    end)
end

function OpenModelMenu()
    
    local playerPed = PlayerPedId()

    local elements = {
        {label = "Rottweiler",          value = "a_c_rottweiler"},
        {label = "Husky",               value = "a_c_husky"},
        {label = "Shephard",            value = "a_c_shepherd"},
        {label = "Retriver",            value = "a_c_retriever"},
        {label = "- - - -",           value = nil},
        {label = "Indietro",            value = "indietro"},
        {label = "Chiudi",               value = "chiudi"},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'k9_menu_model',
    {
        title = "Modello K9",
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        modello = data.current.value

        if modello == "a_c_rottweiler" then
            TriggerEvent("pNotify:SendNotification",{
                text = "Hai cambiato modello: " .. modello,
                type = "success",
                timeout = (7000),
                layout = "bottomCenter",
                queue = "global"
            })
            model = -1788665315
            OpenDog()
            menu.close()
        elseif modello == "a_c_husky" then
            TriggerEvent("pNotify:SendNotification",{
                text = "Hai cambiato modello: " .. modello,
                type = "success",
                timeout = (7000),
                layout = "bottomCenter",
                queue = "global"
            })
            model = 1318032802
            OpenDog()
            menu.close()
        elseif modello == "a_c_shepherd" then
            TriggerEvent("pNotify:SendNotification",{
                text = "Hai cambiato modello: " .. modello,
                type = "success",
                timeout = (7000),
                layout = "bottomCenter",
                queue = "global"
            })
            model = 1126154828
            OpenDog()
            menu.close()
        elseif modello == "a_c_retriever" then
            TriggerEvent("pNotify:SendNotification",{
                text = "Hai cambiato modello: " .. modello,
                type = "success",
                timeout = (7000),
                layout = "bottomCenter",
                queue = "global"
            })
            model = 882848737
            OpenDog()
            menu.close()
        elseif modello == "indietro" then
            OpenOptionsMenu()
        elseif modello == "chiudi" then
            ESX.UI.Menu.CloseAll()
        end
    end)
end

function OpenAnimazioniMenu()

    local playerPed = PlayerPedId()

    local elements = {
        {label = "Siediti",         value = "siediti"},
        {label = "Stenditi",        value = "stenditi"},
        --{label = "Cerca",           value = "cerca"},
        {label = "- - - -",           value = nil},
        {label = "Indietro",         value = "indietro"},
        {label = "Chiudi",           value = "chiudi"},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'k9_menu_animations',
    {
        title = "Menù K9",
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        if data.current.value == "siediti" then
            if spawned_ped ~= nil then
                PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
            else
                TriggerEvent("pNotify:SendNotification",{
                    text = "Non hai un unità K9!",
                    type = "error",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        elseif data.current.value == "stenditi" then
            if spawned_ped ~= nil then
                PlayAnimation(animations['Normal'].laydown.dict, animations['Normal'].laydown.anim)
            else
                TriggerEvent("pNotify:SendNotification",{
                    text = "Non hai un unità K9!",
                    type = "error",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        elseif data.current.value == "cerca" then
            if spawned_ped ~= nil then
                PlayAnimation(animations['Normal'].searchhit.dict, animations['Normal'].searchhit.anim)
                --Citizen.Wait(3000)
                --PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
            else
                TriggerEvent("pNotify:SendNotification",{
                    text = "Non hai un unità K9!",
                    type = "error",
                    timeout = (7000),
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        elseif data.current.value == "indietro" then
            OpenK9Menu()
        elseif data.current.value == "chiudi" then
            ESX.UI.Menu.CloseAll()
        end

    end)
end

function OpenAzioniMenu()

    local playerPed = PlayerPedId()

    local elements = {}

    if isInVehicle then
        table.insert(elements, {label = "Fai uscire dal veicolo", value = "togglecar"})
    else
        table.insert(elements, {label = "Fai entrare nel veicolo", value = "togglecar"})
    end

    table.insert(elements, {label = "- - - -", value = nil})
    table.insert(elements, {label = "Indietro", value = "indietro"})
    table.insert(elements, {label = "Chiudi", value = "chiudi"})

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'k9_menu_azioni',
    {
        title = "Menù K9",
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        if data.current.value == "togglecar" then
            if spawned_ped ~= nil then
                local coords   = GetEntityCoords(GetPlayerPed(-1))
                local vehicle  = GetVehiclePedIsUsing(GetPlayerPed(-1))
                local coords2  = GetEntityCoords(spawned_ped)
                local distance = GetDistanceBetweenCoords(coords.x,coords.y,coords.z,coords2.x,coords2.y,coords2.z,true)
                if not isInVehicle then
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        if distance < 8 then
                            Citizen.Wait(200)
                            if IsVehicleSeatFree(vehicle, 1) then
                                SetPedIntoVehicle(spawned_ped, vehicle, 1)
                                PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
                                isInVehicle = true
                            elseif IsVehicleSeatFree(vehicle, 2) then
                                isInVehicle = true
                                SetPedIntoVehicle(spawned_ped, vehicle, 2)
                                PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
                            elseif IsVehicleSeatFree(vehicle, 0) then
                                isInVehicle = true
                                SetPedIntoVehicle(spawned_ped, vehicle, 0)
                                PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
                            end

                            menu.close()
                            
                        else
                            TriggerEvent("pNotify:SendNotification",{
                                text = "L'unità K9 è troppo lontanta dal veicolo!",
                                type = "error",
                                timeout = (7000),
                                layout = "bottomCenter",
                                queue = "global"
                            })
                        end
                    else
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi essere in un veicolo!",
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                    end
                else
                    if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        SetEntityCoords(ped,coords.x, coords.y, coords.z,1,0,0,1)
                        Citizen.Wait(100)
                        isInVehicle = false
                        menu.close()
                        TriggerEvent("esx_rich_k9:NonTiSegue")
                    else
                        TriggerEvent("pNotify:SendNotification",{
                            text = "Devi essere fuori da un veicolo!",
                            type = "error",
                            timeout = (7000),
                            layout = "bottomCenter",
                            queue = "global"
                        })
                    end
                end
            end
        elseif data.current.value == "indietro" then
            OpenK9Menu()
        elseif data.current.value == "chiudi" then
            ESX.UI.Menu.CloseAll()
        end

    end)
end

function DoRequestModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
end

function DoRequestAnimSet(anim)
	RequestAnimDict(anim)
	while not HasAnimDictLoaded(anim) do
		Citizen.Wait(1)
	end
end

function attached()
	local playerPed = GetPlayerPed(-1)
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 1.9)
	SetPedNeverLeavesGroup(ped, false)
	FreezeEntityPosition(ped, true)
end

function detached()
	local playerPed = GetPlayerPed(-1)
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 999999.9)
	SetPedNeverLeavesGroup(ped, true)
	SetPedAsGroupMember(ped, GroupHandle)
	FreezeEntityPosition(ped, false)
end

function requestInput(exampleText, maxLength)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", exampleText, "", "", "", maxLength + 1)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait( 0 )
    end

    local result = GetOnscreenKeyboardResult()

    UnblockMenuInput()

    if result ~= "" and result ~= exampleText then
        return result
    else
        return false
    end
end

function UnblockMenuInput()
    Citizen.CreateThread( function()
        Citizen.Wait( 150 )
        blockinput = false 
    end )
end

function UnitK9Dead()
    
    SetEntityAsMissionEntity(spawned_ped, true, true)
    DeleteEntity(spawned_ped)
    spawned_ped = nil
    
    if attacking then
        SetPedRelationshipGroupDefaultHash(target_ped, GetHashKey("CIVMALE"))
        target_ped = nil
        attacking = false
    end

    following = false
    searching = false
    playing_animation = false

    TriggerEvent("pNotify:SendNotification",{
        text = "L'unità cinofila è morta",
        type = "error",
        timeout = (7000),
        layout = "bottomCenter",
        queue = "global"
    })
end

-- Key Events

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        --[[ if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'state') then
            if IsControlJustPressed(1, Keys["7"]) then
                OpenK9Menu()
            end
        end ]]

        if IsControlJustPressed(1, 19) and IsControlJustPressed(1, Keys["G"]) and IsPlayerFreeAiming(PlayerId()) then
            local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerPedId())

            if bool then
                if IsEntityAPed(target) then
                    TriggerEvent("esx_rich_k9:ToggleAttack", target)
                end
            end
        end

        if IsControlJustPressed(1, Keys["G"]) and not IsPlayerFreeAiming(PlayerId()) then
            if following then
                TriggerEvent("esx_rich_k9:NonTiSegue")
            else
                TriggerEvent("esx_rich_k9:TiSegue")
            end
        end

    end
end)

RegisterNetEvent('esx_rich_k9:ForceOpenMenu')
AddEventHandler('esx_rich_k9:ForceOpenMenu', function()
    OpenK9Menu()
end)
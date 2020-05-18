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

local inbraccio         = false
local haOstaggio        = false
local haOstaggio2       = false
local hainviatomsg2     = false
local hainviatomsg      = false
ESX                     = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_rich_emote:carry')
AddEventHandler('esx_rich_emote:carry', function()
    loadAnim('missfinale_c2mcs_1')
    loadAnim('nm')
    local t, distanza = GetClosestPlayer()
    if (distanza ~= -1 and distanza < 3) then
        if inbraccio then
            ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
            inbraccio = false
        else
            if DecorGetBool(GetPlayerPed(t), "Handsup") or IsEntityDead(GetPlayerPed(t)) then
                inbraccio = true
                ClearPedTasksImmediately(GetPlayerPed(t))
                TaskPlayAnim(GetPlayerPed(t), 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
                AttachEntityToEntity(GetPlayerPed(t), GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
                TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
            end
        end
    end
end)

RegisterNetEvent('esx_rich_emote:scudoUmanoPlayer')
AddEventHandler('esx_rich_emote:scudoUmanoPlayer', function()
    loadAnim('misssagrab_inoffice')
    local t, distanza = GetClosestPlayer()
    local target = GetPlayerPed(t)

    if not haOstaggio2 then
        if (distanza ~= -1 and distanza < 3) then
            if not IsEntityAttachedToEntity(target, GetPlayerPed(PlayerId())) then
                haOstaggio2 = true
                TriggerEvent("pNotify:SendNotification",{
                    text = 'Premi "E" per uccidere l\'ostaggio. Premi "G" per lasciare l\'ostaggio.',
                    type = "success",
                    timeout = 4000,
                    layout = "bottomCenter",
                    queue = "global"
                })
                SetEntityAsMissionEntity(target, true)
                ClearPedTasksImmediately(target)
                TaskPlayAnim(target, 'misssagrab_inoffice', 'hostage_loop_mrk', 8.0, -4, -1, 9, 0, 0, 0, 0)
                AttachEntityToEntity(target, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 9816), 0.025, 0.3, 0.0, 0.9, 0.30, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(GetPlayerPed(PlayerId()), 'misssagrab_inoffice', 'hostage_loop', 8.0, -4, -1, 9, 0, 0, 0, 0)
                TriggerEvent("pNotify:SendNotification",{
                    text = 'Hai preso l\'ostaggio come scudo!',
                    type = "success",
                    timeout = 4000,
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        else
            TriggerEvent("pNotify:SendNotification",{
                text = 'Nessun Giocatore nelle vicinanze',
                type = "error",
                timeout = 4000,
                layout = "bottomCenter",
                queue = "global"
            })
        end
    end
end)

RegisterNetEvent('esx_rich_emote:scudoUmanoPlayerLascia')
AddEventHandler('esx_rich_emote:scudoUmanoPlayerLascia', function()
    loadAnim('reaction@shove')
    loadAnim('missmic2ig_11')
    local t, distanza = GetClosestPlayer()
    local target = GetPlayerPed(t)

    if haOstaggio2 and IsEntityAttachedToEntity(target, GetPlayerPed(PlayerId())) then
        haOstaggio2 = false
        TaskPlayAnim(GetPlayerPed(PlayerId()), 'reaction@shove', 'shove_var_a', 8.0, -4, 3000, 0, 0, false, false, false)
        DetachEntity(target, GetPlayerPed(PlayerId()), true)
        Citizen.Wait(250)
        TaskPlayAnim(target, 'missmic2ig_11', 'mic_2_ig_11_intro_goon', 8.0, -4.0, 3000, 0, 0, true, true, false)
        SetEntityAsNoLongerNeeded(target)
        --PlayPain(target, 7,  0)
        Citizen.Wait(500)
        ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
        TriggerEvent("pNotify:SendNotification",{
            text = 'Hai lasciato l\'ostaggio',
            type = "success",
            timeout = 4000,
            layout = "bottomCenter",
            queue = "global"
        })
    end
end)

RegisterNetEvent('esx_rich_emote:PlayerUccidi')
AddEventHandler('esx_rich_emote:PlayerUccidi', function()
    local t, distanza = GetClosestPlayer()
    local target = GetPlayerPed(t)

    if haOstaggio2 and IsEntityAttachedToEntity(target, GetPlayerPed(PlayerId())) then
        --local arma = GetCurrentPedWeapon(GetPlayerPed(PlayerId()), true)
        haOstaggio2 = false
        RequestNamedPtfxAsset('scr_solomon3')
        --[[ if not HasNamedPtfxAssetLoaded("scr_solomon3") then
			RequestNamedPtfxAsset("scr_solomon3")
		end]]
        while not HasNamedPtfxAssetLoaded("scr_solomon3") do
	    	Citizen.Wait(1)
        end
        --ExplodeProjectiles(GetPlayerPed(PlayerId()), arma, true)
        SetPtfxAssetNextCall('scr_solomon3')
        StartParticleFxLoopedOnEntityBone('scr_trev4_747_blood_impact', target, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(GetPlayerPed(PlayerId()), 31086), 0.35, 0.0, 0.0, 0.0)
        ClearPedTasksImmediately(target)
        SetEntityHealth(target, 0)
        DetachEntity(target, GetPlayerPed(PlayerId()), true)
        SetEntityAsNoLongerNeeded(target)
        ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
    end
end)

RegisterNetEvent('esx_rich_emote:carryPed')
AddEventHandler('esx_rich_emote:carryPed', function()
    loadAnim('nm')
    loadAnim('missfinale_c2mcs_1')
    local closestPed = getNPC()
    if closestPed then
        if IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
            DetachEntity(closestPed, GetPlayerPed(PlayerId()), false)
            ClearPedTasksImmediately(closestPed)
            ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
        else
            local closestPed = getNPC()
            ClearPedTasksImmediately(closestPed)
            TaskPlayAnim(closestPed, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
            AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
            TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
        end
    end
end)

RegisterNetEvent('esx_rich_emote:scudoUmanoNPC')
AddEventHandler('esx_rich_emote:scudoUmanoNPC', function()
    loadAnim('misssagrab_inoffice')
    local closestPed = getNPC()

    if not haOstaggio then
        if closestPed then
            if not IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
                haOstaggio = true
                TriggerEvent("pNotify:SendNotification",{
                    text = 'Premi "E" per uccidere l\'ostaggio. Premi "G" per lasciare l\'ostaggio.',
                    type = "success",
                    timeout = 4000,
                    layout = "bottomCenter",
                    queue = "global"
                })
                SetEntityAsMissionEntity(closestPed, true)
                ClearPedTasksImmediately(closestPed)
                TaskPlayAnim(closestPed, 'misssagrab_inoffice', 'hostage_loop_mrk', 8.0, -4, -1, 9, 0, 0, 0, 0)
                AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 9816), 0.025, 0.3, 0.0, 0.9, 0.30, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(GetPlayerPed(PlayerId()), 'misssagrab_inoffice', 'hostage_loop', 8.0, -4, -1, 9, 0, 0, 0, 0)
                TriggerEvent("pNotify:SendNotification",{
                    text = 'Hai preso l\'ostaggio come scudo!',
                    type = "success",
                    timeout = 4000,
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        else
            TriggerEvent("pNotify:SendNotification",{
                text = 'Nessun NPC nelle vicinanze',
                type = "error",
                timeout = 4000,
                layout = "bottomCenter",
                queue = "global"
            })
        end
    end
end)

RegisterNetEvent('esx_rich_emote:scudoUmanoNPCLascia')
AddEventHandler('esx_rich_emote:scudoUmanoNPCLascia', function()
    loadAnim('reaction@shove')
    loadAnim('missmic2ig_11')
    local closestPed = getNPC()

    if haOstaggio and IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
        haOstaggio = false
        TaskPlayAnim(GetPlayerPed(PlayerId()), 'reaction@shove', 'shove_var_a', 8.0, -4, 3000, 0, 0, false, false, false)
        DetachEntity(closestPed, GetPlayerPed(PlayerId()), true)
        Citizen.Wait(250)
        TaskPlayAnim(closestPed, 'missmic2ig_11', 'mic_2_ig_11_intro_goon', 8.0, -4.0, 3000, 0, 0, true, true, false)
        SetEntityAsNoLongerNeeded(closestPed)
        PlayPain(closestPed, 7,  0)
        Citizen.Wait(500)
        ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
        TriggerEvent("pNotify:SendNotification",{
            text = 'Hai lasciato l\'ostaggio',
            type = "success",
            timeout = 4000,
            layout = "bottomCenter",
            queue = "global"
        })
    end
end)

RegisterNetEvent('esx_rich_emote:Uccidi')
AddEventHandler('esx_rich_emote:Uccidi', function()
    local closestPed = getNPC()
    if haOstaggio and IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then
        --local arma = GetCurrentPedWeapon(GetPlayerPed(PlayerId()), true)
        haOstaggio = false
        RequestNamedPtfxAsset('scr_solomon3')
        --[[ if not HasNamedPtfxAssetLoaded("scr_solomon3") then
			RequestNamedPtfxAsset("scr_solomon3")
		end]]
        while not HasNamedPtfxAssetLoaded("scr_solomon3") do
	    	Citizen.Wait(1)
        end
        --ExplodeProjectiles(GetPlayerPed(PlayerId()), arma, true)
        SetPtfxAssetNextCall('scr_solomon3')
        StartParticleFxLoopedOnEntityBone('scr_trev4_747_blood_impact', closestPed, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(GetPlayerPed(PlayerId()), 31086), 0.35, 0.0, 0.0, 0.0)
        ClearPedTasksImmediately(closestPed)
        SetEntityHealth(closestPed, 0)
        DetachEntity(closestPed, GetPlayerPed(PlayerId()), true)
        SetEntityAsNoLongerNeeded(closestPed)
        ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if haOstaggio then
            if IsControlJustReleased(0, Keys['E']) then
                hainviatomsg = false
                TriggerEvent('esx_rich_emote:Uccidi')
            elseif IsControlJustReleased(0, Keys['G']) then
                hainviatomsg = false
                TriggerEvent('esx_rich_emote:scudoUmanoNPCLascia')
            end
        end
        if haOstaggio2 then
            if IsControlJustReleased(0, Keys['E']) then
                hainviatomsg2 = false
                TriggerEvent('esx_rich_emote:PlayerUccidi')
            elseif IsControlJustReleased(0, Keys['G']) then
                hainviatomsg2 = false
                TriggerEvent('esx_rich_emote:scudoUmanoPlayerLascia')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if inbraccio then
            DisableControlAction(0, 23)
            DisableControlAction(0, 75)
        end
    end
end)

function loadAnim(anim)
    RequestAnimDict(anim) 
    while not HasAnimDictLoaded(anim) do 
        Citizen.Wait(1) 
    end
end

function getNPC()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    
    repeat
    
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
    
    if canPedBeUsed(ped) and distance < 5.0 and (distanceFrom == nil or distance < distanceFrom) then
        distanceFrom = distance
        rped = ped
        SetEntityAsMissionEntity(rped, true, true)
    end

    success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then return false end
    if ped == GetPlayerPed(-1) then return false end
    if not DoesEntityExist(ped) then return false end
    if not IsPedOnFoot(ped) then return false end
    if IsEntityDead(ped) then return false end
    if not IsPedHuman(ped) then return false end
    return true
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

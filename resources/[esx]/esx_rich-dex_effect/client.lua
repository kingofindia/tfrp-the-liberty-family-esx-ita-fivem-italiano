ESX              = nil
local PlayerData = {}

local Position1 = {
    {x = 181.942, y = 1163.798, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 182.949, y = 1166.604, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 182.799, y = 1169.438, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 182.398, y = 1171.020, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 183.346, y = 1158.879, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 185.085, y = 1156.688, z = 225.590, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 186.024, y = 1154.573, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 186.805, y = 1152.634, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 198.095, y = 1154.301, z = 226.246, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 193.342, y = 1175.573, z = 226.251, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 185.289, y = 1162.414, z = 226.253, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
}

local Position2 = {
    {x = 158.067, y = 1149.774, z = 227.012, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 166.456, y = 1151.984, z = 227.017, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 163.753, y = 1162.88, z = 226.979, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 155.551, y = 1161.169, z = 226.969, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 156.401, y = 1156.0, z = 227.051, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
}

local Position3 = {
    {x = 181.942, y = 1163.798, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 182.949, y = 1166.604, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 182.799, y = 1169.438, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 182.398, y = 1171.020, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 183.346, y = 1158.879, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 185.085, y = 1156.688, z = 225.590, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 186.024, y = 1154.573, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 186.805, y = 1152.634, z = 225.594, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 198.095, y = 1154.301, z = 226.246, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 193.342, y = 1175.573, z = 226.251, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 185.289, y = 1162.414, z = 226.253, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
}

local Position4 = {
    {x = 158.067, y = 1149.774, z = 227.012, rootX = 0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 166.456, y = 1151.984, z = 227.017, rootX = 0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 163.753, y = 1162.88, z = 226.979, rootX = 0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 155.551, y = 1161.169, z = 226.969, rootX = 0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
    {x = 156.401, y = 1156.0, z = 227.051, rootX = 0, rootY = 0.0, rootZ = 0.0, scale = 1.0},
}

local Position5 = {
    {x = 158.067, y = 1149.774, z = 227.012, rootX = 0, rootY = 1.0, rootZ = 0.0, scale = 20.0},
    {x = 166.456, y = 1151.984, z = 227.017, rootX = 0, rootY = 1.0, rootZ = 0.0, scale = 20.0},
    {x = 163.753, y = 1162.88, z = 226.979, rootX = 0, rootY = 1.0, rootZ = 0.0, scale = 20.0},
    {x = 155.551, y = 1161.169, z = 226.969, rootX = 0, rootY = 1.0, rootZ = 0.0, scale = 20.0},
    {x = 156.401, y = 1156.0, z = 227.051, rootX = 0, rootY = 1.0, rootZ = 0.0, scale = 20.0},
}

local Position6 = {
    {x = 181.942, y = 1163.798, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 182.949, y = 1166.604, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 182.799, y = 1169.438, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 182.398, y = 1171.020, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 183.346, y = 1158.879, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 185.085, y = 1156.688, z = 225.590, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 186.024, y = 1154.573, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 186.805, y = 1152.634, z = 225.594, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 198.095, y = 1154.301, z = 226.246, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 193.342, y = 1175.573, z = 226.251, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
    {x = 185.289, y = 1162.414, z = 226.253, rootX = 0.0, rootY = 0.0, rootZ = 0.0, scale = 20.0},
}

local Position7 = {
    {x = 160.813, y = 1156.295, z = 226.933, rootX = 90.0, rootY = 0.0, rootZ = 0.0, scale = 4.0},
}

local EffectListOne = {
    {label = 'Effetto Menu Uno 1', dict = 'scr_indep_fireworks', name = 'scr_indep_firework_shotburst', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 2', dict = 'scr_indep_fireworks', name = 'scr_indep_firework_starburst', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 3', dict = 'proj_indep_firework_v2', name = 'scr_firework_indep_spiral_burst_rwb', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 4', dict = 'scr_rcbarry2', name = 'scr_exp_clown', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 5', dict = 'scr_reconstructionaccident', name = 'scr_reconstruct_pipe_impact', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 6', dict = 'scr_recartheft', name = 'scr_wheel_burnout', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 7', dict = 'scr_josh3', name = 'scr_josh3_light_explosion', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 8', dict = 'scr_agencyheistb', name = 'scr_agency3b_heli_exp_trail', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 9', dict = 'weap_xs_vehicle_weapons', name = 'muz_xs_turret_flamethrower_looping', pos = 'Position3', duration = 5000},
    {label = 'Effetto Menu Uno 10', dict = 'cut_family5', name = 'cs_alien_light_bed', pos = 'Position6', duration = 5000},
    {label = 'Effetto Menu Uno 11', dict = 'scr_josh3', name = 'scr_josh3_light_explosion', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 12', dict = 'scr_indep_fireworks', name = 'scr_indep_firework_burst_spawn', pos = 'Position1', duration = 5000},
    {label = 'Effetto Menu Uno 13', dict = 'weap_xs_vehicle_weapons', name = 'muz_xs_turret_flamethrower_looping_sf', pos = 'Position3', duration = 5000},
    {label = 'Effetto Menu Uno 14', dict = 'core', name = 'ent_sht_flame', pos = 'Position1', duration = 5000},
    {label = 'Effetto NUOVO1', dict = 'proj_indep_firework', name = 'scr_indep_firework_grd_burst', pos = 'Position3', duration = 10000},
    {label = 'Effetto NUOVO2', dict = 'proj_indep_firework', name = 'proj_indep_flare_trail', pos = 'Position3', duration = 10000},
    {label = 'Effetto NUOVO3', dict = 'proj_indep_firework_v2', name = 'scr_xmas_firework_burst_fizzle', pos = 'Position3', duration = 10000},
    {label = 'Effetto NUOVO4', dict = 'proj_indep_firework_v2', name = 'scr_firework_indep_repeat_burst_rwb', pos = 'Position3', duration = 10000},
    {label = 'Effetto NUOVO5', dict = 'scr_stunts', name = 'scr_stunts_shotburst', pos = 'Position1', duration = 10000},
}

local EffectListTwo = {
    {label = 'Effetto Menu Due 1', dict = 'scr_indep_fireworks', name = 'scr_indep_firework_shotburst', pos = 'Position4', duration = 5000},
    {label = 'Effetto Menu Due 2', dict = 'scr_indep_fireworks', name = 'scr_indep_firework_starburst', pos = 'Position4', duration = 5000},
    {label = 'Effetto Menu Due 3', dict = 'proj_indep_firework_v2', name = 'scr_firework_indep_spiral_burst_rwb', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 4', dict = 'scr_rcbarry2', name = 'scr_exp_clown', pos = 'Position4', duration = 5000},
    {label = 'Effetto Menu Due 5', dict = 'scr_reconstructionaccident', name = 'scr_reconstruct_pipe_impact', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 6', dict = 'scr_recartheft', name = 'scr_wheel_burnout', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 7', dict = 'scr_josh3', name = 'scr_josh3_light_explosion', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 8', dict = 'scr_agencyheistb', name = 'scr_agency3b_heli_exp_trail', pos = 'Position4', duration = 5000},
    {label = 'Effetto Menu Due 9', dict = 'weap_xs_vehicle_weapons', name = 'muz_xs_turret_flamethrower_looping', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 10', dict = 'cut_family5', name = 'cs_alien_light_bed', pos = 'Position5', duration = 5000},
    {label = 'Effetto Menu Due 11', dict = 'scr_josh3', name = 'scr_josh3_light_explosion', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 12', dict = 'scr_indep_fireworks', name = 'scr_indep_firework_burst_spawn', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Due 13', dict = 'weap_xs_vehicle_weapons', name = 'muz_xs_turret_flamethrower_looping_sf', pos = 'Position2', duration = 5000},
    {label = 'Effetto Menu Uno 14', dict = 'core', name = 'ent_sht_flame', pos = 'Position4', duration = 5000},
    {label = 'Effetto HP1', dict = 'core', name = 'proj_laser_player', pos = 'Position7', duration = 10000},
    {label = 'Effetto NUOVO1', dict = 'proj_indep_firework', name = 'scr_indep_firework_grd_burst', pos = 'Position2', duration = 10000},
    {label = 'Effetto NUOVO2', dict = 'proj_indep_firework', name = 'proj_indep_flare_trail', pos = 'Position2', duration = 10000},
    {label = 'Effetto NUOVO3', dict = 'proj_indep_firework_v2', name = 'scr_xmas_firework_burst_fizzle', pos = 'Position2', duration = 10000},
    {label = 'Effetto NUOVO4', dict = 'proj_indep_firework_v2', name = 'scr_firework_indep_repeat_burst_rwb', pos = 'Position2', duration = 10000},
    {label = 'Effetto NUOVO5', dict = 'scr_stunts', name = 'scr_stunts_shotburst', pos = 'Position4', duration = 10000},
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function MenuMixerOne()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mixer_menu', {
        title = 'Mixer 1',
        align = 'top-left',
        elements = EffectListOne
    }, function(data, menu)

        TriggerServerEvent('esx_rich-dext_effect:syncServer', data.current.dict, data.current.name, data.current.pos, data.current.duration)

    end, function(data, menu)
        menu.close()
    end)
end

function MenuMixerTwo()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mixer_menu', {
        title = 'Mixer 2',
        align = 'top-left',
        elements = EffectListTwo
    }, function(data, menu)

        TriggerServerEvent('esx_rich-dext_effect:syncServer', data.current.dict, data.current.name, data.current.pos, data.current.duration)

    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('esx_rich-dext_effect:syncClient')
AddEventHandler('esx_rich-dext_effect:syncClient', function(effectDict, effectName, position, duration)
    doEffect(effectDict, effectName, position, duration)
end)

doEffect = function(effectDict, effectName, position, duration)
    local fuocoDict = effectDict
    local particleName = effectName
    local effectList = {}

    if position == 'Position1' then
        effectPos = Position1
    elseif position == 'Position2' then
        effectPos = Position2
    elseif position == 'Position3' then
        effectPos = Position3
    elseif position == 'Position4' then
        effectPos = Position4
    elseif position == 'Position5' then
        effectPos = Position5
    elseif position == 'Position6' then
        effectPos = Position6
    elseif position == 'Position7' then
        effectPos = Position7
    end

    if not HasNamedPtfxAssetLoaded(fuocoDict) then
        RequestNamedPtfxAsset(fuocoDict)
    end

    while not HasNamedPtfxAssetLoaded(fuocoDict) do
        Citizen.Wait(0)
    end

    for _, search in pairs(effectPos) do
        UseParticleFxAssetNextCall(fuocoDict)

        local particle = StartParticleFxLoopedAtCoord(particleName, search.x, search.y, search.z, search.rootX, search.rootY, search.rootZ, search.scale, false, false, false, false)

        table.insert(effectList, 1, particle)

        Citizen.Wait(0)
    end

    Citizen.Wait(duration)

    for _, particle in pairs(effectList) do
        StopParticleFxLooped(particle, true)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        
        if PlayerData.job ~= nil and PlayerData.job.name == 'maluma' then
            local playerPed = GetPlayerPed(-1)
            local coords = GetEntityCoords(playerPed)

            if GetDistanceBetweenCoords(coords, 147.008, 1156.853, 228.394, true) < 20.0 then
                DrawMarker(23, 147.008, 1156.853, 227.394, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(coords, 147.008, 1156.853, 228.394, true) < 1.5 then
                    ESX.ShowHelpNotification('Premi ~INPUT_PICKUP~ per ~g~aprire ~w~il menu mixer')
                    if IsControlJustPressed(0, 51) then
                        MenuMixerOne()
                    end
                end
            end

            if GetDistanceBetweenCoords(coords, 148.869, 1150.738, 228.394, true) < 20.0 then
                DrawMarker(23, 148.869, 1150.738, 227.394, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(coords, 148.869, 1150.738, 228.394, true) < 1.5 then
                    ESX.ShowHelpNotification('Premi ~INPUT_PICKUP~ per ~g~aprire ~w~il menu mixer')
                    if IsControlJustPressed(0, 51) then
                        MenuMixerTwo()
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)
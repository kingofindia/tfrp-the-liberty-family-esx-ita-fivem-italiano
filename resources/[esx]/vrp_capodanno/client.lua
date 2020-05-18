RegisterNetEvent('firework:place_firework')
AddEventHandler('firework:place_firework', function()
    local model = GetHashKey(Config.Prop)
    local dict = loadDict('anim@mp_fireworks')
    TaskPlayAnim(PlayerPedId(), dict, 'place_firework_1_rocket', 8.0, -8.0, -1, 0, 0, false, false, false)

    while not IsEntityPlayingAnim(PlayerPedId(), dict, 'place_firework_1_rocket', 3) do Wait(0) end
    Wait(500)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local firework = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false)
    AttachEntityToEntity(firework, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

    local timer = GetGameTimer() + 2250
    while timer >= GetGameTimer() do Wait(0) end
    DetachEntity(firework)
    FreezeEntityPosition(firework, true)
    Wait(7500)
    timer = GetGameTimer() + 1500
    loadPtfx('scr_indep_fireworks')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_indep_firework_starburst', GetEntityCoords(PlayerPedId()), 0.0, 180.0, 0.0, 20.0, false, false, false, false)
    while timer >= GetGameTimer() do Wait(0) SetEntityCoords(firework, GetOffsetFromEntityInWorldCoords(firework, 0.0, 0.0, 0.25)) end

    local coords = GetEntityCoords(firework)
    DeleteEntity(firework)
    TriggerServerEvent('firework:explosion', coords.x, coords.y, coords.z+500)
end)

RegisterNetEvent('firework:startExplosion')
AddEventHandler('firework:startExplosion', function(x, y, z)
    loadPtfx('scr_indep_fireworks')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_indep_firework_trailburst_spawn', x, y, z, 0.0, 180.0, 0.0, 20.0, false, false, false, false)
    loadPtfx('proj_xmas_firework')
    StartNetworkedParticleFxNonLoopedAtCoord('scr_firework_xmas_repeat_burst_rgw', x, y, z, 0.0, 180.0, 0.0, 20.0, false, false, false, false)
end)

loadPtfx = function(dict)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do Wait(0) end
    UseParticleFxAssetNextCall(dict)
    return dict
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end
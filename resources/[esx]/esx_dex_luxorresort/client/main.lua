local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function ApriMenuArsenale(station)

    local elements = {
        {label = "Prendi Oggetto", value = 'prendi_oggetto'},
        {label = "Deposita Oggetto", value = 'deposita_oggetto'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'arsenale',
    {
        title = "Arsenale",
        align = 'top-left',
        elements = elements
    }, function(data, menu)

        local opzione = data.current.value

        if opzione == 'prendi_arma' then
            ApriPrendiArmaMenu()
        elseif opzione == 'deposita_arma' then
            ApriDepositaArmaMenu()
        elseif opzione == 'prendi_oggetto' then
            ApriPrendiOggettoMenu()
        elseif opzione == 'deposita_oggetto' then
            ApriDepositaOggettoMenu()
        end

    end, function(data, menu)
        menu.close()

        CurrentAction       = 'menu_armeria'
        CurrentActionMsg    = 'Premi ~INPUT_CONTEXT~ per aprire l\'arsenale'
        CurrentActionData = {station = station}
    end)
end

function ApriMenuVeicolo(station, partNum)
    
    local veicoli = Config.StazioniNibba[station].Veicoli

    ESX.UI.Menu.CloseAll()

    local elements = {}

    for i=1, #Config.StazioniNibba[station].VeicoliAutorizzati, 1 do
        local veicolo = Config.StazioniNibba[station].VeicoliAutorizzati[i]
        table.insert(elements, {label = veicolo.nome, value = veicolo.modello})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawner_veicoli',
    {
        title = 'Menu Veicoli',
        align = 'top-left',
        elements = elements,
    }, function(data, menu)
        
        menu.close()
    
        local modello = data.current.value
    
        local veicolo = GetClosestVehicle(veicoli[partNum].SpawnPoint.x, veicoli[partNum].SpawnPoint.y, veicoli[partNum].SpawnPoint.z, 3.0, 0, 71)

        if not DoesEntityExist(veicolo) then
            
            local playerPed = GetPlayerPed(-1)

            ESX.Game.SpawnVehicle(modello, {
                x = veicoli[partNum].SpawnPoint.x,
                y = veicoli[partNum].SpawnPoint.y,
                z = veicoli[partNum].SpawnPoint.z
            }, veicoli[partNum].Heading, function(veicolo)
                TaskWarpPedIntoVehicle(playerPed, veicolo, -1)
            end)

        else
            ESX.ShowNotification('Il punto di Spawn è occupato')
        end
    end, function(data, menu)
        menu.close()

        CurrentAction       = 'menu_spawn_veicoli'
        CurrentActionMsg    = 'Premi ~INPUT_CONTEXT~ per prendere un veicolo'
        CurrentActionData = {station = station, partNum = partNum}
    end)
end

function ApriPrendiArmaMenu()

    ESX.TriggerServerCallback('esx_dex_luxorresort:getArmoryWeapons', function(weapons)

        local elements = {}

        for i=1, #weapons, 1 do
            if weapons[i].count > 0 then
                table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armeria_prendi_arma',
        {
            title = 'Arsenale - Prendi Arma',
            align = 'top-left',
            elements = elements,
        }, function(data, menu)
            menu.close()

            ESX.TriggerServerCallback('esx_dex_luxorresort:removeArmoryWeapon', function()
                ApriPrendiArmaMenu()
            end, data.current.value)

        end, function(data, menu)
            menu.close()
        end)
    end)
end

function ApriDepositaArmaMenu()

    local elements   = {}
    local playerPed  = GetPlayerPed(-1)
    local weaponList = ESX.GetWeaponList()

    for i=1, #weaponList, 1 do
        local weaponHash = GetHashKey(weaponList[i].name)
        if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
            local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
            table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armeria_deposita_arma',
    {
        title = 'Arsenale - Deposita Arma',
        align = 'top-left',
        elements = elements,
    }, function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_dex_luxorresort:addArmoryWeapon', function()
            ApriDepositaArmaMenu()
        end, data.current.value)

    end, function(data, menu)
        menu.close()
    end)
end

function ApriPrendiOggettoMenu()

    ESX.TriggerServerCallback('esx_dex_luxorresort:getStockItems', function(items)

        print(json.encode(items))

        local elements = {}

        for i=1, #items, 1 do
            table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_stock',
        {
            title = 'Stock',
            elements = elements
        }, function(data, menu)

            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_stock_prendi_numero_item',
            {
                title = 'Quantità'
            }, function(data2, menu2)

                local count = tonumber(data2.value)

                if count == nil then
                    ESX.ShowNotification('Quantità non valida')
                else
                    TriggerServerEvent('esx_dex_luxorresort:getStockItem', itemName, count)
                    
                    menu2.close()
                    menu.close()
                    ApriPrendiOggettoMenu()
                end

            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function ApriDepositaOggettoMenu()

    ESX.TriggerServerCallback('esx_dex_luxorresort:getPlayerInventory', function(inventory)

        local elements = {}

        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]
            if item.count > 0 then
                table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_stock',
        {
            title = 'Inventario',
            elements = elements
        }, function(data, menu)

            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'menu_stock_deposita_numero_item',
            {
                title = 'Quantità'
            }, function(data2, menu2)

                local count = tonumber(data2.value)

                if count == nil then
                    ESX.ShowNotification('Quantità non valida')
                else
                    TriggerServerEvent('esx_dex_luxorresort:putStockItems', itemName, count)
                
                    menu2.close()
                    menu.close()
                    ApriDepositaOggettoMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('esx_dex_luxorresort:hasEnteredMarker', function(station, part, partNum)

    if part == 'Arsenale' then
        CurrentAction     = 'menu_armeria'
        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per accedere all\'arsenale'
        CurrentActionData = {station = station}
    end

    if part == 'SpawnerVeicoli' then
        CurrentAction     = 'menu_spawn_veicoli'
        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per prendere un veicolo'
        CurrentActionData = {station = station, partNum = partNum}
    end

    if part == 'EliminaVeicolo' then
        
        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)

        if IsPedInAnyVehicle(playerPed, false) then
            
            local veicolo = GetVehiclePedIsIn(playerPed, false)

            if DoesEntityExist(veicolo) then
                CurrentAction     = 'elimina_veicolo'
                CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per depositare il veicolo'
                CurrentActionData = {vehicle = vehicle}

                if IsControlPressed(0, 38) then
                    DeleteEntity(veicolo)
                end
            end
        end
    end

    if part == 'MenuBoss' then
        CurrentAction     = 'menu_azioni_boss'
        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per accedere al menu Boss'
        CurrentActionData = {}
    end
end)

AddEventHandler('esx_dex_luxorresort:hasExitedMarker', function(station, part, partNum)
    ESX.UI.Menu.CloseAll()
    CurrentAction = nil
end)

--[[ Citizen.CreateThread(function()
    for k,v in pairs(Config.StazioniGrigi) do
        local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
  
        SetBlipSprite (blip, v.Blip.Sprite)
        SetBlipDisplay(blip, v.Blip.Display)
        SetBlipScale  (blip, v.Blip.Scale)
        SetBlipColour (blip, v.Blip.Colour)
        SetBlipAsShortRange(blip, true)
  
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.NomeBlip)
        EndTextCommandSetBlipName(blip)
    end  
end) ]]

Citizen.CreateThread(function()
    while true do
        Wait(0) 
      
        if PlayerData.job ~= nil and PlayerData.job.name == 'nibba' then
  
        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)
  
            for k,v in pairs(Config.StazioniNibba) do
    
                for i=1, #v.Arsenale, 1 do
                    if GetDistanceBetweenCoords(coords,  v.Arsenale[i].x,  v.Arsenale[i].y,  v.Arsenale[i].z,  true) < Config.DrawDistance then
                        DrawMarker(Config.MarkerType, v.Arsenale[i].x, v.Arsenale[i].y, v.Arsenale[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                    end
                end
    
                for i=1, #v.Veicoli, 1 do
                    if GetDistanceBetweenCoords(coords,  v.Veicoli[i].Spawner.x,  v.Veicoli[i].Spawner.y,  v.Veicoli[i].Spawner.z,  true) < Config.DrawDistance then
                        DrawMarker(Config.MarkerType, v.Veicoli[i].Spawner.x, v.Veicoli[i].Spawner.y, v.Veicoli[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                    end
                end
            
                for i=1, #v.EliminaVeicoli, 1 do
                    if GetDistanceBetweenCoords(coords,  v.EliminaVeicoli[i].x,  v.EliminaVeicoli[i].y,  v.EliminaVeicoli[i].z,  true) < Config.DrawDistance then
                        DrawMarker(Config.MarkerType, v.EliminaVeicoli[i].x, v.EliminaVeicoli[i].y, v.EliminaVeicoli[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                    end
                end
    
                if PlayerData.job ~= nil and PlayerData.job.name == 'nibba' and PlayerData.job.grade_name == 'boss' then
                    for i=1, #v.AzioniBoss, 1 do
                        if not v.AzioniBoss[i].disabled and GetDistanceBetweenCoords(coords,  v.AzioniBoss[i].x,  v.AzioniBoss[i].y,  v.AzioniBoss[i].z,  true) < Config.DrawDistance then
                            DrawMarker(Config.MarkerType, v.AzioniBoss[i].x, v.AzioniBoss[i].y, v.AzioniBoss[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
                        end
                    end
                end
    
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
  
        if PlayerData.job ~= nil and PlayerData.job.name == 'nibba' then
  
            local playerPed      = GetPlayerPed(-1)
            local coords         = GetEntityCoords(playerPed)
            local isInMarker     = false
            local currentStation = nil
            local currentPart    = nil
            local currentPartNum = nil
  
            for k,v in pairs(Config.StazioniNibba) do
    
                for i=1, #v.Arsenale, 1 do
                    if GetDistanceBetweenCoords(coords,  v.Arsenale[i].x,  v.Arsenale[i].y,  v.Arsenale[i].z,  true) < Config.MarkerSize.x then
                        isInMarker     = true
                        currentStation = k
                        currentPart    = 'Arsenale'
                        currentPartNum = i
                    end
                end
    
                for i=1, #v.Veicoli, 1 do
                    if GetDistanceBetweenCoords(coords,  v.Veicoli[i].Spawner.x,  v.Veicoli[i].Spawner.y,  v.Veicoli[i].Spawner.z,  true) < Config.MarkerSize.x then
                        isInMarker     = true
                        currentStation = k
                        currentPart    = 'SpawnerVeicoli'
                        currentPartNum = i
                    end
    
                    if GetDistanceBetweenCoords(coords,  v.Veicoli[i].SpawnPoint.x,  v.Veicoli[i].SpawnPoint.y,  v.Veicoli[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
                        isInMarker     = true
                        currentStation = k
                        currentPart    = 'SpawnerVeicoliPuntoPreciso'
                        currentPartNum = i
                    end
                end
    
                for i=1, #v.EliminaVeicoli, 1 do
                    if GetDistanceBetweenCoords(coords,  v.EliminaVeicoli[i].x,  v.EliminaVeicoli[i].y,  v.EliminaVeicoli[i].z,  true) < Config.MarkerSize.x then
                        isInMarker     = true
                        currentStation = k
                        currentPart    = 'EliminaVeicolo'
                        currentPartNum = i
                    end
                end
    
                if PlayerData.job ~= nil and PlayerData.job.name == 'nibba' and PlayerData.job.grade_name == 'boss' then
                    for i=1, #v.AzioniBoss, 1 do
                        if GetDistanceBetweenCoords(coords,  v.AzioniBoss[i].x,  v.AzioniBoss[i].y,  v.AzioniBoss[i].z,  true) < Config.MarkerSize.x then
                            isInMarker     = true
                            currentStation = k
                            currentPart    = 'MenuBoss'
                            currentPartNum = i
                        end
                    end
                end

            end
  
            local hasExited = false
    
            if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
    
                if (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) then
                    TriggerEvent('esx_dex_luxorresort:hasExitedMarker', LastStation, LastPart, LastPartNum)
                    hasExited = true
                end
    
                HasAlreadyEnteredMarker = true
                LastStation             = currentStation
                LastPart                = currentPart
                LastPartNum             = currentPartNum
    
                TriggerEvent('esx_dex_luxorresort:hasEnteredMarker', currentStation, currentPart, currentPartNum)
            end
    
            if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
    
                HasAlreadyEnteredMarker = false
    
                TriggerEvent('esx_dex_luxorresort:hasExitedMarker', LastStation, LastPart, LastPartNum)
            end

        end
    end
end)

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions',
	{
		title    = 'Police',
		align    = 'top-left',
		elements = {
            {label = "Fattura", value = 'fine'}
        }
	}, function(data, menu)

		if data.current.value == 'fine' then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fine', {
                title = 'Fattura',
            }, function(data2, menu2)
            local amount = tonumber(data2.value)

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    if amount == nil then
                        ESX.ShowNotification('Importo non valido')
                    else
                        menu2.close()

                        FreezeEntityPosition(GetPlayerPed(-1), true)
                        TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)
                        Citizen.Wait(6250)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        FreezeEntityPosition(GetPlayerPed(-1), false)

                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_nibba', 'Luxor Resort', amount)
                        ESX.ShowNotification('Fattura inviata')
                    end
                else
                    ESX.ShowNotification('Nessun giocatore nelle vicinanze')
                end

            end, function(data2, menu2)
                menu2.close()
            end)
        end

	end, function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
  
        if CurrentAction ~= nil then
  
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
            if IsControlPressed(0, 38) and PlayerData.job ~= nil and PlayerData.job.name == 'nibba' and (GetGameTimer() - GUI.Time) > 150 then
  
                if CurrentAction == 'menu_armeria' then
                    ApriMenuArsenale(CurrentActionData.station)
                end
    
                if CurrentAction == 'menu_spawn_veicoli' then
                    ApriMenuVeicolo(CurrentActionData.station, CurrentActionData.partNum)
                end
    
                if CurrentAction == 'elimina_veicolo' then
                    
                    local playerPed = GetPlayerPed(-1)
                    local coords    = GetEntityCoords(playerPed)
            
                    if IsPedInAnyVehicle(playerPed, false) then
                        
                        local veicolo = GetVehiclePedIsIn(playerPed, false)
            
                        if DoesEntityExist(veicolo) then
                            DeleteEntity(veicolo)
                        end
                    end
                
                end
  
                if CurrentAction == 'menu_azioni_boss' then
    
                    ESX.UI.Menu.CloseAll()
    
                    TriggerEvent('esx_society:openBossMenu', 'nibba', function(data, menu)
                        menu.close()
        
                        CurrentAction     = 'menu_azioni_boss'
                        CurrentActionMsg  = 'Premi ~INPUT_CONTEXT~ per aprire il menu'
                        CurrentActionData = {}
                    end, {wash = Config.LavareSoldi})
                end
                
                CurrentAction = nil
                GUI.Time      = GetGameTimer()

            end
        end

        if PlayerData.job ~= nil and PlayerData.job.name == 'nibba' then
            if IsControlPressed(0, 167) then
                OpenMenu()
            end
        end
    end
end)
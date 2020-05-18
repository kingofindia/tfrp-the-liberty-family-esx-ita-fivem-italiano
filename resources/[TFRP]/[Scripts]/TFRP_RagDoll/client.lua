local key = 22

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if (IsControlJustReleased(0, key)) then
            local pressedAgain = false
            local timer = GetGameTimer()
            while true do
                Citizen.Wait(0)
                if (IsControlJustPressed(0, key)) then
                    pressedAgain = true
                    break
                end
                if (GetGameTimer() - timer >= 100) then
                    break
                end
            end
            if (pressedAgain) then
				SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
            end
        end
    end
end)

local random = false

RegisterNetEvent('esx_rich_emote:RagDoll')
AddEventHandler('esx_rich_emote:RagDoll', function()
    random = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if random then
            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
            alert("Premi ~INPUT_PICKUP~ o ~INPUT_VEH_DUCK~ per alzarti")

            if IsControlJustPressed(0, 38) or IsControlJustPressed(0, 73) then
                random = false
            end
        end
    end
end)

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end
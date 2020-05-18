local canHandsUp = true
local GUI							= {}
GUI.Time							= 0

AddEventHandler("handsup:toggle", function(param)
	canHandsUp = param
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local lPed = GetPlayerPed(-1)
        RequestAnimDict("random@arrests")
        RequestAnimDict("random@arrests@busted")
       
        if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
            if IsControlJustReleased(0, 246) then
                if DoesEntityExist(lPed) and not IsHandcuffed then
                    SetCurrentPedWeapon(lPed, 0xA2719263, true)
                    Citizen.CreateThread(function()
                        RequestAnimDict("random@arrests")
                        while not HasAnimDictLoaded("random@arrests") do
                            Citizen.Wait(100)
                        end
                       
                        RequestAnimDict("random@arrests@busted")
                        while not HasAnimDictLoaded("random@arrests@busted") do
                            Citizen.Wait(100)
                        end
 
                        if not handsup then
                            handsup = true
                            TaskPlayAnim( lPed, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                            Wait (4000)
                            TaskPlayAnim( lPed, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                            Wait (500)
                            TaskPlayAnim( lPed, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                            Wait (1000)
                            TaskPlayAnim( lPed, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
                            Wait (1000)
                            DisableControlAction(1, 140, true)
                            DisableControlAction(1, 141, true)
                            DisableControlAction(1, 142, true)
                            DisableControlAction(0, 21, true)
                            DisableControlAction(0, 23, true)
                            DisableControlAction(1, 23, true)
                            exports.pNotify:SendNotification({
                            text = "Ti sei arreso! Quando ti verrà chiesto di alzarti, premi ',' (virgola)" ,
                            type = "error",
                            timeout = 5000,
                            layout = "centerLeft",
                            queue = "left"
							})
							FreezeEntityPosition(lPed, true)
							TriggerServerEvent("esx_thief:update", handsup)
                        end  
                    end)
                end
            end
        end
        if IsControlJustReleased(0, 82) then
            if DoesEntityExist(lPed) and not IsHandcuffed then
                Citizen.CreateThread(function()
                    RequestAnimDict("random@mugging3")
                    while not HasAnimDictLoaded("random@mugging3") do
                        Citizen.Wait(0)
                    end
 
                    if handsup then
                        handsup = false
                        TaskPlayAnim( lPed, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                        Wait (3000)
						TaskPlayAnim( lPed, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
						Citizen.Wait(3000)
                        ClearPedSecondaryTask(lPed)
                        DisableControlAction(1, 140, false)
                        DisableControlAction(1, 141, false)
                        DisableControlAction(1, 142, false)
                        DisableControlAction(0,21,false)
                        DisableControlAction(0, 23, false)
                        DisableControlAction(1, 23, false)
						FreezeEntityPosition(lPed, false)
						TriggerServerEvent("esx_thief:update", handsup)
                    end
                end)
            end
        end
    end
end)


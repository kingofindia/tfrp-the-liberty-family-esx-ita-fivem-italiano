ESX                  = nil
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function Drunk(level, start)
  
  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)

    if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end

    if level == 0 then

      RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)

    elseif level == 1 then

      RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)

    elseif level == 2 then

      RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)

    end

    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)

    if start then
      DoScreenFadeIn(800)
    end

  end)

end

function Reality()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)

    DoScreenFadeOut(800)
    Wait(1000)

    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)

    DoScreenFadeIn(800)

  end)

end

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				
				if status.val > 0 then
					
          local start = true

          if IsAlreadyDrunk then
            start = false
          end

          local level = 0

          if status.val <= 250000 then
            level = 0
          elseif status.val <= 500000 then
            level = 1
          else
            level = 2
          end

          if level ~= DrunkLevel then
            Drunk(level, start)
          end

          IsAlreadyDrunk = true
          DrunkLevel     = level
				end

				if status.val == 0 then
          
          if IsAlreadyDrunk then
            Reality()
          end

          IsAlreadyDrunk = false
          DrunkLevel     = -1

				end

			end)

		end

	end)

end)

function drunk2()
  DoScreenFadeOut(1000)
  Citizen.Wait(500)
  TriggerEvent("esx:statusdrunkaf") -- Funktionen som gör dig dragen
  TriggerEvent("esx:statusdrunkaf")
  Citizen.Wait(500)
  DoScreenFadeIn(1000)
end

RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
  
local pP = GetPlayerPed(-1)
  
  TaskPlayAnim(pP, "amb@world_human_partying@female@partying_beer@base", "enter", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
  TaskStartScenarioInPlace(pP, "world_human_DRINKING", 0, true)
  Wait(3000)
  ESX.ShowNotification("Sei ubriaco")
  Wait(3000)
  drunk2()

end)

RegisterNetEvent('esx_optionalneeds:onWeed')
AddEventHandler('esx_optionalneeds:onWeed', function()
  
local pP = GetPlayerPed(-1)
  
  RequestAnimSet("move_m@hipster@a") 
  while not HasAnimSetLoaded("move_m@hipster@a") do
  Citizen.Wait(0)
  end    

  TaskStartScenarioInPlace(pP, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Wait(3000)
  ClearPedTasksImmediately(pP)
  ESX.ShowNotification("Stai fatto fracigo!")
  Wait(3000)
  drunk2()

end)

RegisterNetEvent('esx_optionalneeds:onCoke')
AddEventHandler('esx_optionalneeds:onCoke', function()
  
local pP = GetPlayerPed(-1)
  
  RequestAnimSet("move_m@hipster@a") 
  while not HasAnimSetLoaded("move_m@hipster@a") do
  Citizen.Wait(0)
  end    

  TaskStartScenarioInPlace(pP, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Wait(3000)
  ClearPedTasksImmediately(pP)
  ESX.ShowNotification("Stai intrippato fracigo!")
  Wait(3000)
    
    --Efects
    local player = PlayerId()
    --AddArmourToPed(playerPed, 100)
    --local health = GetEntityHealth(playerPed)
    --local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    --SetEntityHealth(playerPed, newHealth)
    SetSwimMultiplierForPlayer(player, 1.5)
    SetRunSprintMultiplierForPlayer(player, 1.5)		
    Wait(300000)
    SetSwimMultiplierForPlayer(player, 1.0)
    SetRunSprintMultiplierForPlayer(player, 1.0)			

end)
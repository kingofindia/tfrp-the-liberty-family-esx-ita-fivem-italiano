current_health = 0
previous_health = 0

Citizen.CreateThread(function()

  Citizen.Wait(40000)

  while true do Citizen.Wait(0)
    
	pPed = PlayerPedId()
	current_health = GetEntityHealth(pPed)
	maxHealth = GetEntityMaxHealth(pPed)

	if maxHealth < 200 then

		Citizen.Trace("character changed: health max was below standard, been set to 100") -- #Equality lul

		SetEntityMaxHealth(pPed, 200)
		SetEntityHealth(pPed, 200)

		ResetPedMovementClipset(pPed, 0.0) -- this shouldnt be needed, but fuck it extra assurance m8.

	end

	if current_health ~= previous_health then

		Citizen.Trace("\nHealth changed\n")
		Citizen.Trace("\nLatest: " .. current_health .. " | Older: " .. previous_health .. "\n")

		if current_health > 189 then

			Citizen.Trace("Resetting movement due to hp being above 90 or above.")
			ResetPedMovementClipset(pPed, 0.0)

		end

		previous_health = current_health

	end

  end

end)

Citizen.CreateThread(function()

  while true do Citizen.Wait(100)

	pPed = PlayerPedId()
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.00) -- (Yes, im aware this does not need to be looped however I just have it looped because there is no notice-able difference and it ensures that it shouldn't get messed with by another script)
	previous_health = current_health

  end

end)

Citizen.CreateThread(function()

	Citizen.Wait(60000)

	while true do Citizen.Wait(50)
		pPed = PlayerPedId()
		health = GetEntityHealth(pPed)
		if health <= 189 and health >= 176 then
			RequestAnimSet("move_injured_generic")

      		while not HasAnimSetLoaded("move_injured_generic") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(pPed, "move_injured_generic", true)
		elseif health <= 175 and health >= 151 then
			RequestAnimSet("move_heist_lester")

      		while not HasAnimSetLoaded("move_heist_lester") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(pPed, "move_heist_lester", true)
		elseif health <= 150 and health >= 126 then
			RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")

      		while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(pPed, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
		elseif health <= 125 and health >= 100 then
			RequestAnimSet("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP")

      		while not HasAnimSetLoaded("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(pPed,"MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true)
		end
	end
end)
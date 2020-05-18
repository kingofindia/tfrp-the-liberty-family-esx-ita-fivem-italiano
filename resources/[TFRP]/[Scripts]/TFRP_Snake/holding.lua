DecorRegister('crouched', 2)
prone = false
OnBack = false
onKnees = false

Citizen.CreateThread(function()
	local facing
	local movedict = 'move_crawl'
	local moveOBbwd = 'onback_bwd'
	local moveOBfwd = 'onback_fwd'
	local moveOFbwd = 'onfront_bwd'
	local moveOFfwd = 'onfront_fwd'
	local goPronedict = 'get_up@directional@transition@prone_to_knees@crawl'
	local goProneanim = 'front'
	local getUpdict = 'get_up@directional@movement@from_knees@standard'
	local getUpanim = 'getup_l_0'
	local runDivedict = 'move_jump'
	local runDiveamin = 'dive_start_run'

	--Prone/Crawling around
	RequestAnimDict(movedict)
	while not HasAnimDictLoaded(movedict) do
		Citizen.Wait(100)
	end

	RequestAnimDict(goPronedict)
	while not HasAnimDictLoaded(goPronedict) do
		Citizen.Wait(100)
	end

	RequestAnimDict(getUpdict)
	while not HasAnimDictLoaded(getUpdict) do
		Citizen.Wait(100)
	end

	RequestAnimDict(runDivedict)
	while not HasAnimDictLoaded(runDivedict) do
		Citizen.Wait(100)
	end

	while true do
		Citizen.Wait(10)
		local ped = PlayerPedId()

		if IsControlJustPressed(0,20) then
			if IsPauseMenuActive() then
				Citizen.Wait(500)
			elseif not IsInputDisabled(0) then
				Citizen.Wait(500)
			elseif not IsPedOnFoot(ped) then
				Citizen.Wait(500)
			elseif IsEntityDead(ped) then
				Citizen.Wait(500)
			elseif IsPedCuffed(ped) then
				Citizen.Wait(500)
			elseif handsup then
				Citizen.Wait(500)
			else
				if not onKnees then
					if not prone then
						if IsPedRunning(ped) or IsPedSprinting(ped) then
							TaskPlayAnim(ped, runDivedict, runDiveamin, 4.0, 0, -1, 15, 1.0, 0, 1, 0)
							Wait(1250)
						end

						DisableControlAction(0,73,true)     --Disable Hands Up
						DisableControlAction(0,10,true)     --Disable Animation Menu
						DisableControlAction(0,213,true)    --Disable Phone

						facing = GetEntityHeading(ped)
						prone = true
						ClearPedTasks(ped)
						TaskPlayAnim(ped, movedict, moveOFfwd, 8.0, 0, -1, 0, 1.0, 0, 1, 0)
					elseif prone then
						DisableControlAction(0,73,false)
						DisableControlAction(0,10,false)
						DisableControlAction(0,213,false)

						prone = false
						OnBack = false
						TaskPlayAnim(ped, getUpdict,getUpanim, 8.0, 0, -1, 2, 0.0, 0, 0, 0)
						Wait(1875)
						ClearPedTasksImmediately(ped)
					end
				end
			end
		end

		DisableControlAction(0, 36, true) -- INPUT_DUCK

		-- crouch
		if IsDisabledControlJustPressed(0, 36) then
			if IsPauseMenuActive() then
				Citizen.Wait(500)
			elseif not IsInputDisabled(0) then
				Citizen.Wait(500)
			elseif not IsPedOnFoot(ped) then
				Citizen.Wait(500)
			elseif IsEntityDead(ped) then
				Citizen.Wait(500)
			elseif IsPedCuffed(ped) then
				Citizen.Wait(500)
			elseif handsup then
				Citizen.Wait(500)
			else
				RequestAnimSet('move_ped_crouched')
				while not HasAnimSetLoaded('move_ped_crouched') do
					Citizen.Wait( 100 )
				end
	
				if crouched then
					ResetPedMovementClipset(ped, 0)
					crouched = false 
					DecorSetBool(ped, 'crouched', 0)
				elseif not crouched then
					SetPedMovementClipset(ped, 'move_ped_crouched', 0.25)
					crouched = true
					DecorSetBool(ped, 'crouched', 1)
				end
			end
		end

		if prone then
			if IsControlPressed(0,34) then
				facing = facing + 2.0
				if facing >= 360 then
					facing = 0
				end
				SetEntityHeading(ped,facing)
			end

			if IsControlPressed(0,9) then
				facing = facing - 2.0
				if facing <= 0 then
					facing = 360
				end
				SetEntityHeading(ped,facing)
			end

			if IsControlJustPressed(0,21) then -- SHIFT
				if OnBack then
					OnBack = false
				TaskPlayAnim(ped, movedict, moveOFfwd, 8.0, 1, -1, 2, 1.0, 0, 1, 0)
				else
					OnBack = true
				TaskPlayAnim(ped, movedict, moveOBbwd, 8.0, 1, -1, 2, 1.0, 0, 1, 0)
				end
			end

			if OnBack then
				if IsControlPressed(0,32) then
					TaskPlayAnim(ped, movedict, moveOBfwd, 8.0, 1, -1, 2, 0.0, 0, 0, 0) --32 for forward
					Wait(1100)
				end
				if IsControlPressed(0,8) then
					TaskPlayAnim(ped, movedict, moveOBbwd, 8.0, 1, -1, 2, 0.0, 0, 0, 0) --8 for backward
					Wait(1100)
				end
			end

			if not OnBack then
				if IsControlPressed(0,32) then
					TaskPlayAnim(ped, movedict, moveOFfwd, 8.0, 1, -1, 2, 0.0, 0, 0, 0) --32 for forward
					Wait(750)
				end
				if IsControlPressed(0,8) then
					TaskPlayAnim(ped, movedict, moveOFbwd, 8.0, 1, -1, 2, 0.0, 0, 0, 0) --8 for backward
					Wait(950)
				end
			end
		end
	end
end)


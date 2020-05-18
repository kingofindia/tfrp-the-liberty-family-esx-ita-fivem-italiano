local sirene = 1
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerped = GetPlayerPed(-1)		
		if IsPedInAnyVehicle(playerped, false) then
			local veh = GetVehiclePedIsUsing(playerped)	
			if GetPedInVehicleSeat(veh, -1) == playerped then
				if GetVehicleClass(veh) == 18 then
					if IsControlJustPressed(0, 47) then
						if sirene == 0 then
							-- on
							DisableVehicleImpactExplosionActivation(veh, 0)
							sirene = 1
						else
							-- off
							DisableVehicleImpactExplosionActivation(veh, 1)
							sirene = 0
						end
					end
				end
			end
		end
	end
end)
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Wait(0)
	end
end)

function DrawTxt(text, x, y)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

RegisterNetEvent('esx_showcoords:on')
AddEventHandler('esx_showcoords:on', function()
	Citizen.Wait(0)
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		
    	roundx = tonumber(string.format("%.2f", x))
    	roundy = tonumber(string.format("%.2f", y))
		roundz = tonumber(string.format("%.2f", z))
		
		DrawTxt("~r~X:~s~ "..roundx, 0.32, 0.00)
		DrawTxt("~r~Y:~s~ "..roundy, 0.38, 0.00)
		DrawTxt("~r~Z:~s~ "..roundz, 0.445, 0.00)

		heading = GetEntityHeading(GetPlayerPed(-1))
		roundh = tonumber(string.format("%.2f", heading))
		DrawTxt("~r~H:~s~ "..roundh, 0.50, 0.00)

        local rx,ry,rz = table.unpack(GetEntityRotation(PlayerPedId(), 1))
		DrawTxt("~r~RX:~s~ "..tonumber(string.format("%.2f", rx)), 0.38, 0.03)
		DrawTxt("~r~RY:~s~ "..tonumber(string.format("%.2f", ry)), 0.44, 0.03)
		DrawTxt("~r~RZ:~s~ "..tonumber(string.format("%.2f", rz)), 0.495, 0.03)
	
		speed = GetEntitySpeed(PlayerPedId())
		rounds = tonumber(string.format("%.2f", speed))
		DrawTxt("~r~Velocità giocatore: ~s~"..rounds, 0.40, 0.92)

		health = GetEntityHealth(PlayerPedId())
		DrawTxt("~r~Vita Giocatore: ~s~"..health, 0.40, 0.95)

		veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
		vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
		if IsPedInAnyVehicle(PlayerPedId(), 1) then
			vehenground = tonumber(string.format("%.2f", veheng))
			vehbodround = tonumber(string.format("%.2f", vehbody))

			DrawTxt("~r~Motore: ~s~"..vehenground, 0.015, 0.76)

			DrawTxt("~r~Carrozzeria: ~s~"..vehbodround, 0.015, 0.73)

			DrawTxt("~r~Benzina: ~s~"..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.70)
		end
	end)

--[[ Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		
    	roundx = tonumber(string.format("%.2f", x))
    	roundy = tonumber(string.format("%.2f", y))
		roundz = tonumber(string.format("%.2f", z))
		
		DrawTxt("~r~X:~s~ "..roundx, 0.32, 0.00)
		DrawTxt("~r~Y:~s~ "..roundy, 0.38, 0.00)
		DrawTxt("~r~Z:~s~ "..roundz, 0.445, 0.00)

		heading = GetEntityHeading(GetPlayerPed(-1))
		roundh = tonumber(string.format("%.2f", heading))
		DrawTxt("~r~H:~s~ "..roundh, 0.50, 0.00)

        local rx,ry,rz = table.unpack(GetEntityRotation(PlayerPedId(), 1))
		DrawTxt("~r~RX:~s~ "..tonumber(string.format("%.2f", rx)), 0.38, 0.03)
		DrawTxt("~r~RY:~s~ "..tonumber(string.format("%.2f", ry)), 0.44, 0.03)
		DrawTxt("~r~RZ:~s~ "..tonumber(string.format("%.2f", rz)), 0.495, 0.03)
	
		speed = GetEntitySpeed(PlayerPedId())
		rounds = tonumber(string.format("%.2f", speed))
		DrawTxt("~r~Velocità giocatore: ~s~"..rounds, 0.40, 0.92)

		health = GetEntityHealth(PlayerPedId())
		DrawTxt("~r~Vita Giocatore: ~s~"..health, 0.40, 0.95)

		veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
		vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
		if IsPedInAnyVehicle(PlayerPedId(), 1) then
			vehenground = tonumber(string.format("%.2f", veheng))
			vehbodround = tonumber(string.format("%.2f", vehbody))

			DrawTxt("~r~Motore: ~s~"..vehenground, 0.015, 0.76)

			DrawTxt("~r~Carrozzeria: ~s~"..vehbodround, 0.015, 0.73)

			DrawTxt("~r~Benzina: ~s~"..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.70)
		end
    end
end) ]]

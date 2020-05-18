local holdingup = false
local store = ""
local blipRobbery = nil
local PlayerData              = {}
ESX = nil

primostep = false
secondostep = false
terzostep = false
quartostep = false

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
  end)

function mycbpolice(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Hai scoperto i server principali! Hackera i server D1, D7 e D41!',
			type = "success",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = true
    else
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Non sei riuscito ad hackerare il computer, la polizia sta arrivando!',
			type = "warning",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerServerEvent('esx_hackersdr:toofar', store)
		holdingup = false
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	end
end

function mycbpolice2(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Hai hackerato il server D1! Rimangono i server D7 e D41!',
			type = "success",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = true
		secondostep = true
    else
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Non sei riuscito ad hackerare il server D1, la polizia sta arrivando!',
			type = "warning",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = false
		TriggerServerEvent('esx_hackersdr:toofar', store)
		holdingup = false
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	end
end

function mycbpolice3(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Hai hackerato il server D7! Rimane il server D41!',
			type = "success",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = true
		secondostep = true
		terzostep = true
    else
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Non sei riuscito ad hackerare il server D7, la polizia sta arrivando!',
			type = "warning",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = false
		secondostep = false
		TriggerServerEvent('esx_hackersdr:toofar', store)
		holdingup = false
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	end
end

function mycbpolice4(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Hai hackerato il server D41! ORA SCAPPA!',
			type = "success",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = false
		secondostep = false
		terzostep = false
		quartostep = false
		holdingup = false
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 50, "blackout", 1.0)
		TriggerServerEvent('esx_hackersdr:endrob', store)
		TriggerEvent('esx_hackersdr:buio')
    else
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Non sei riuscito ad hackerare il server D41, la polizia sta arrivando!',
			type = "warning",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		primostep = false
		secondostep = false
		terzostep = false
		TriggerServerEvent('esx_hackersdr:toofar', store)
		holdingup = false
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	end
end

function mycbpolice5(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Virus rimosso!',
			type = "success",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerServerEvent('esx_hackersdr:elucefu')
		TriggerEvent('esx_hackersdr:luce')
    else
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
			text = 'Non sei riuscito a rimuovere il virus, riprova!',
			type = "warning",
			timeout = (10000),
			layout = "bottomCenter",
			queue = "global"
		})
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_hackersdr:buio')
AddEventHandler('esx_hackersdr:buio', function()
    SetBlackout(true)
end)

RegisterNetEvent('esx_hackersdr:luce')
AddEventHandler('esx_hackersdr:luce', function()
    SetBlackout(false)
end)

RegisterNetEvent('esx_hackersdr:killblip')
AddEventHandler('esx_hackersdr:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_hackersdr:currentlyrobbing')
AddEventHandler('esx_hackersdr:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_hackersdr:killblip')
AddEventHandler('esx_hackersdr:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_hackersdr:setblip')
AddEventHandler('esx_hackersdr:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 0.8)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_hackersdr:toofarlocal')
AddEventHandler('esx_hackersdr:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('esx_hackersdr:robberycomplete')
AddEventHandler('esx_hackersdr:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 521)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
						TriggerServerEvent('esx_hackersdr:rob', k)
						
						local player = GetPlayerPed( -1 )
						loadAnimDict( "amb@prop_human_seat_computer@male@base" ) 
						TaskPlayAnim( player, "amb@prop_human_seat_computer@male@base", "base", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						Citizen.Wait(5000)
						ClearPedTasksImmediately(GetPlayerPed(-1))
					
						
						if holdingup then
						TriggerEvent("mhacking:show")
	                    TriggerEvent("mhacking:start",7,35,mycbpolice)
						end

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
							
							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2163.367, 2934.069, -84.724, true) < 10.5 ) then
			                if (primostep == true) and (secondostep == false) and (terzostep == false) and (quartostep == false) then
							DrawMarker(27, 2163.367, 2934.069, -85.500, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2163.367, 2934.069, -84.724, true) < 1.0 ) then
							DisplayHelpText('Premi ~INPUT_PICKUP~ per hackerare il server D1')
							if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
								loadAnimDict( "random@atmrobberygen" ) 
						        TaskPlayAnim( player, "random@atmrobberygen", "a_atm_mugging", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								TriggerEvent("mhacking:show")
								TriggerEvent("mhacking:start",7,35,mycbpolice2)		
							end
							end
							end
							end
							
							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2139.696, 2938.245, -84.719, true) < 10.5 ) then
								if (primostep == true) and (secondostep == true) and (terzostep == false) and (quartostep == false) then
								DrawMarker(27, 2139.696, 2938.245, -85.500, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
								if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2139.696, 2938.245, -84.719, true) < 1.0 ) then
								DisplayHelpText('Premi ~INPUT_PICKUP~ per hackerare il server D7')
								if IsControlJustReleased(1, 51) then
									local player = GetPlayerPed( -1 )
									loadAnimDict( "random@atmrobberygen" ) 
									TaskPlayAnim( player, "random@atmrobberygen", "a_atm_mugging", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
									Citizen.Wait(5000)
									ClearPedTasksImmediately(GetPlayerPed(-1))
									TriggerEvent("mhacking:show")
									TriggerEvent("mhacking:start",7,35,mycbpolice3)
								end		
								end
								end
								end

								if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1991.393, 2945.59, -84.724, true) < 10.5 ) then
									if (primostep == true) and (secondostep == true) and (terzostep == true) and (quartostep == false) then
									DrawMarker(27, 1991.393, 2945.59, -85.500, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
									if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1991.393, 2945.59, -84.724, true) < 1.0 ) then
										DisplayHelpText('Premi ~INPUT_PICKUP~ per hackerare il server D41')
									if IsControlJustReleased(1, 51) then
										local player = GetPlayerPed( -1 )
										loadAnimDict( "random@atmrobberygen" ) 
										TaskPlayAnim( player, "random@atmrobberygen", "a_atm_mugging", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
										Citizen.Wait(5000)
										ClearPedTasksImmediately(GetPlayerPed(-1))
										TriggerEvent("mhacking:show")
										TriggerEvent("mhacking:start",7,35,mycbpolice4)	
									end	
									end
									end
									end

			local pos2 = Stores[store].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 200.5)then
				TriggerServerEvent('esx_hackersdr:toofar', store)
				holdingup = false
			end
		end

		Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 2154.262, 2920.879, 47.65, true) < 10.0 then
			    DrawMarker(1, 2154.262, 2920.879, 46.65, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 2154.262, 2920.879, 47.65, true) < 1.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per entrare')
					if IsControlJustReleased(1, 51) then
						SetEntityCoords(playerPed, 2154.628, 2920.952, -81.076)
					end
			    end
		    end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 2154.628, 2920.952, -81.076, true) < 10.0 then
			    DrawMarker(1, 2154.628, 2920.952, -82.076, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 2154.628, 2920.952, -81.076, true) < 1.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per uscire')
					if IsControlJustReleased(1, 51) then
						SetEntityCoords(playerPed, 2154.262, 2920.879, 47.65)
					end
			    end
		    end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 2168.161, 2916.789, -81.075, true) < 10.0 and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			    DrawMarker(1, 2168.161, 2916.789, -82.075, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 2168.161, 2916.789, -81.075, true) < 1.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per togliere il virus')
					if IsControlJustReleased(1, 51) then
						local player = GetPlayerPed( -1 )
						loadAnimDict( "random@atmrobberygen" ) 
						TaskPlayAnim( player, "random@atmrobberygen", "a_atm_mugging", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						Citizen.Wait(5000)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:start",7,35,mycbpolice5)	
					end
			    end
		    end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
end)



local holdingup = false
local store = ""
local blipRobbery = nil
local locked = true

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

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

function ruba()
	local ped = PlayerPedId()
	SetEntityCoords(GetPlayerPed(-1), -2959.363, 387.197, 14.043-0.95)
    SetEntityHeading(GetPlayerPed(-1), 167.242)

    RequestAnimDict("mini@safe_cracking")
	while (not HasAnimDictLoaded("mini@safe_cracking")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "mini@safe_cracking", "dial_turn_anti_normal", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(17000)
	TaskPlayAnim(ped, "mini@safe_cracking", "idle_look_around", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(3000)
	TaskPlayAnim(ped, "mini@safe_cracking", "dial_turn_anti_normal", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(17000)
	TaskPlayAnim(ped, "mini@safe_cracking", "idle_look_around", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(3000)
	TaskPlayAnim(ped, "mini@safe_cracking", "dial_turn_anti_normal", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(17000)
	TaskPlayAnim(ped, "mini@safe_cracking", "idle_look_around", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(3000)
	TaskPlayAnim(ped, "mini@safe_cracking", "dial_turn_anti_normal", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(17000)
	TaskPlayAnim(ped, "mini@safe_cracking", "idle_look_around", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(3000)
	TaskPlayAnim(ped, "mini@safe_cracking", "dial_turn_anti_normal", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(17000)
	TaskPlayAnim(ped, "mini@safe_cracking", "idle_look_around", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(3000)
	TaskPlayAnim(ped, "mini@safe_cracking", "dial_turn_anti_normal", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(17000)
	PlaySoundFrontend(-1, "Drill_Pin_Break", 'DLC_HEIST_FLEECA_SOUNDSET', 1);
	TaskPlayAnim(ped, "mini@safe_cracking", "idle_look_around", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(3000)
	TaskPlayAnim(ped, "mini@safe_cracking", "door_open_succeed_stand", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(2100)

end

function cassa()
    local ped = PlayerPedId()
    RequestAnimDict("mp_take_money_mg")
	while (not HasAnimDictLoaded("mp_take_money_mg")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "mp_take_money_mg", "stand_cash_in_bag_loop", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(2000)

end

function finale()
    local ped = PlayerPedId()
    RequestAnimDict("mp_take_money_mg")
	while (not HasAnimDictLoaded("mp_take_money_mg")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "mp_take_money_mg", "stand_cash_in_bag_loop", 8.0, -8.0, -1, 0, 0, false, false, false) 
	Wait(2000)

end

RegisterNetEvent('esx_rapinanegozietto:currentlyrobbing')
AddEventHandler('esx_rapinanegozietto:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_rapinanegozietto:killblip')
AddEventHandler('esx_rapinanegozietto:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_rapinanegozietto:setblip')
AddEventHandler('esx_rapinanegozietto:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 0.8)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_rapinanegozietto:toofarlocal')
AddEventHandler('esx_rapinanegozietto:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('esx_rapinanegozietto:robberycomplete')
AddEventHandler('esx_rapinanegozietto:robberycomplete', function(robb)
	holdingup = false

	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)


incircle = false
hasrobbed = false
hasrobbed2 = false
hasrobbed3 = false

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local closeDoor    = GetClosestObjectOfType(-2967.027, 390.9038, 15.14779, 1.0, GetHashKey('prop_till_01'), false, false, false)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(29, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if HasEntityBeenDamagedByAnyPed(closeDoor) then
							TriggerServerEvent('esx_rapinanegozietto:rob', k)
							ClearEntityLastDamageEntity(closeDoor)
							local prop_name = prop_name or 'prop_anim_cash_pile_02'
							prop = CreateObject(GetHashKey(prop_name), -2966.83, 390.93, 15.06579,  true, true, true)
							prop2 = CreateObject(GetHashKey(prop_name), -2966.83, 391.01, 15.06579,  true, true, true)
							prop3 = CreateObject(GetHashKey(prop_name), -2966.83, 390.85, 15.06579,  true, true, true)
							prop4 = CreateObject(GetHashKey(prop_name), -2966.83, 390.77, 15.06579,  true, true, true)
							SetEntityRotation(prop, 0.0, -0, 85.0, false, true)
							SetEntityRotation(prop2, 0.0, -0, 85.0, false, true)
							SetEntityRotation(prop3, 0.0, -0, 85.0, false, true)
							SetEntityRotation(prop4, 0.0, -0, 85.0, false, true)
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
		local closeDoor2 = GetClosestObjectOfType(-2959.99, 386.7959, 13.81389, 1.0, GetHashKey('v_ilev_gangsafedoor'), false, false, false)

		if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2966.16, 390.785, 15.043, true) < 0.5 ) then
			if (hasrobbed == false) and (hasrobbed2 == false) and (hasrobbed3 == false) then
				DisplayHelpText(_U('field'))
					if IsControlJustReleased(1, 51) then
						local ped = GetPlayerPed( -1 )
						SetEntityCoords(GetPlayerPed(-1), -2966.217, 390.869, 15.043-0.95)
                        SetEntityHeading(GetPlayerPed(-1), 82.296)
						cassa()
						PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						TriggerServerEvent('esx_rapinanegozietto:gioielli1')
						hasrobbed2 = true
						DeleteObject(prop)
						DeleteObject(prop2)
						DeleteObject(prop3)
						DeleteObject(prop4)
					end
			end
		end
		
							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2959.652, 387.138, 14.043, true) < 0.5 ) then
								if (hasrobbed == false) and (hasrobbed2 == true) and (hasrobbed3 == false) then
							DisplayHelpText(_U('field2'))
							if IsControlJustReleased(1, 51) then
								local ped = GetPlayerPed( -1 )
								local prop_name2 = prop_name2 or 'prop_cash_case_01'
								prop5 = CreateObject(GetHashKey(prop_name2), -2959.69, 386.3459, 13.90,  true, true, true)
								SetEntityRotation(prop5, 0.0, -0, 180.0, false, true)
								ruba()
								FreezeEntityPosition(closeDoor2, false)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 177.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 178.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 179.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 180.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 181.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 182.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 183.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 184.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 185.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 186.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 187.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 188.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 189.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 190.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 191.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 192.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 193.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 194.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 195.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 196.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 197.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 198.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 199.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 200.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 201.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 202.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 203.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 204.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 205.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 206.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 207.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 208.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 209.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 210.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 211.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 212.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 213.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 214.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 215.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 216.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 217.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 218.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 219.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 220.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 221.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 222.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 223.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 224.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 225.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 226.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 227.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 228.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 229.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 230.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 231.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 232.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 233.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 234.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 235.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 236.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 237.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 238.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 239.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 240.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 241.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 242.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 243.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 244.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 245.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 246.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 247.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 248.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 249.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 250.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 251.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 252.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 253.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 254.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 255.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 256.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 257.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 258.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 259.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 260.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 261.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 262.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 263.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 264.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 265.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 266.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 267.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 268.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 269.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 270.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 271.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 272.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 273.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 274.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 275.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 276.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 277.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 278.3909, false, true)
							    SetEntityRotation(closeDoor2, 0.0, -0.01, 279.3909, false, true)
								SetEntityRotation(closeDoor2, 0.0, -0.01, 280.3909, false, true)
								hasrobbed = true
							end
							end
							end

							if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2959.652, 387.138, 14.043, true) < 0.5 ) then
								if (hasrobbed == true) and (hasrobbed2 == true) and (hasrobbed3 == false) then
							DisplayHelpText(_U('field3'))
							if IsControlJustReleased(1, 51) then
								SetEntityCoords(GetPlayerPed(-1), -2959.541, 387.431, 14.043-0.95)
								SetEntityHeading(GetPlayerPed(-1), 177.835)
							finale()
							DeleteObject(prop5)
							TriggerServerEvent('esx_rapinanegozietto:gioielli2')
							PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							hasrobbed3 = true
						end
					end
				end

							if (hasrobbed == true) and (hasrobbed2 == true) and (hasrobbed3 == true) then
							holdingup = false
							
							hasrobbed = false
							hasrobbed2 = false
							hasrobbed3 = false

							TriggerServerEvent('esx_rapinanegozietto:endrob', store)
							ESX.ShowNotification(_U('lester'))
							Wait(5000)
							SetEntityRotation(closeDoor2, 0.0, -0.01, 176.3909, false, true)
							FreezeEntityPosition(closeDoor2, true)
							end	

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2959.99, 386.7959, 13.81389, true) > 15.0 ) or IsControlJustReleased(1, 73) then
				TriggerServerEvent('esx_rapinanegozietto:toofar', store)
				holdingup = false
				
				hasrobbed = false

				ClearEntityLastDamageEntity(closeDoor)

				ESX.ShowNotification(_U('rapinaannullata'))

			end
		end

		Citizen.Wait(1)
	end
end)


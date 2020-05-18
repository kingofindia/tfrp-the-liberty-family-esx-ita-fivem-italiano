local holdingup = false
local store = ""
local blipRobbery = nil
local brokenOpen = 0 
local hostageLocations = {
 {x = 242.851, y = 223.885, z = 106.287, heading = 340.081, model = 'a_m_y_business_03'}, 
 {x = 247.193, y = 218.027, z = 106.287, heading = 264.487, model = 'a_f_m_business_02'}, 
 {x = 251.518, y = 221.341, z = 106.287, heading = 335.102, model = 'a_m_y_vinewood_02'}, 
 {x = 251.021, y = 219.823, z = 106.287, heading = 337.044, model = 'a_f_y_indian_01'}, 
 {x = 252.319, y = 223.404, z = 106.287, heading = 161.139, model = 'a_f_y_business_04'}, 
 {x = 243.648, y = 226.282, z = 106.288, heading = 159.647, model = 'a_f_y_business_04'}, 
 {x = 243.280, y = 229.495, z = 106.287, heading = 249.880, model = 'ig_bankman'}, 
}

local guardLocations = {
 {x = 234.979, y = 212.646, z = 110.283, heading = 341.230}, 
 {x = 236.364, y = 229.621, z = 110.278, heading = 272.020}, 
 {x = 258.183, y = 206.046, z = 110.283, heading = 345.461}, 
 {x = 266.883, y = 222.378, z = 110.283, heading = 351.867}, 
}

local securityBoxes = {
{x = 263.561, y = 216.314, z = 101.683, heading = 342.185, isOpen = false},
{x = 264.648, y = 215.954, z = 101.683, heading = 342.185, isOpen = false},
{x = 265.706, y = 215.503, z = 101.683, heading = 342.185, isOpen = false},
{x = 266.174, y = 214.760, z = 101.683, heading = 247.370, isOpen = false},
{x = 265.923, y = 214.008, z = 101.683, heading = 247.370, isOpen = false},
{x = 265.539, y = 212.938, z = 101.683, heading = 247.370, isOpen = false},
{x = 264.440, y = 212.203, z = 101.683, heading = 162.370, isOpen = false},
{x = 263.342, y = 212.536, z = 101.683, heading = 162.370, isOpen = false},
{x = 262.194, y = 212.883, z = 101.683, heading = 162.370, isOpen = false},
}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function mycbpolice(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
							text = 'Ora supera le due porte e scassina 9 cassette di sicurezza!',
							type = "success",
							timeout = (10000),
							layout = "bottomCenter",
							queue = "global"
						})
	SetEntityCoords(GetPlayerPed(-1), 253.113, 222.708, 101.683)

	else
		TriggerEvent('mhacking:hide')
		TriggerEvent("pNotify:SendNotification",{
							text = 'Non sei riuscito ad hackerare la porta del caveau, la polizia sta arrivando!',
							type = "warning",
							timeout = (7000),
							layout = "bottomCenter",
							queue = "global"
						})
		TriggerServerEvent('esx_holdup2:toofar', store)
		holdingup = false
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

RegisterNetEvent('esx_holdup2:currentlyrobbing')
AddEventHandler('esx_holdup2:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_holdup2:killblip')
AddEventHandler('esx_holdup2:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdup2:setblip')
AddEventHandler('esx_holdup2:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 0.8)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdup2:toofarlocal')
AddEventHandler('esx_holdup2:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('esx_holdup2:robberycomplete')
AddEventHandler('esx_holdup2:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete') .. Stores[store].reward)
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
quartostep = false
quintostep = false
sestostep = false
settimostep = false
ottavostep = false
nonostep = false

function loadAnimDict( dict ) 
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('esx_holdup2:radio')
AddEventHandler('esx_holdup2:radio', function()
	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 25, "banca", 0.3)
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
						
						TriggerServerEvent('esx_holdup2:rob', k)
						
						local player = GetPlayerPed( -1 )
						loadAnimDict( "random@atmrobberygen" ) 
						TaskPlayAnim( player, "random@atmrobberygen", "a_atm_mugging", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						Citizen.Wait(5000)
						ClearPedTasksImmediately(GetPlayerPed(-1))
					
						
						if holdingup then
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:start",7,35,mycbpolice)
						spawnGuards()
						spawnHostages()
						end

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		while holdingup do
            local coords = GetEntityCoords(GetPlayerPed(-1))
            Citizen.Wait(5)
            for i,v in pairs(securityBoxes) do 
                if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0) and not v.isOpen then 
                    DrawMarker(25, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 0.4,0.4,0.5, 255, 15, 15, 150, 0, true, 2, 0, 0, 0, 0)
                    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.75) then
                        drawTxt('~b~Premi ~g~E~b~ per scassinare la cassetta di sicurezza')
						if IsControlJustPressed(0, 38) then

                            SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-0.95)
                            SetEntityHeading(GetPlayerPed(-1), v.heading)
 	                        v.isOpen = true 
							local drillObject = CreateObject(GetHashKey('hei_prop_heist_drill'), 0.0, 0.0, 0.0, true, true, true)
 	
                            loadModel('hei_prop_heist_drill')
                            loadAnimation("anim@heists@fleeca_bank@drilling")
                            TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "intro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                            AttachEntityToEntity(drillObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                            Wait(6200)
							TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "drill_straight_start", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
							TriggerEvent('hud:progressbar', 'STAI SCASSINANDO...', 450)
                            Wait(45000)
                            TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "outro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
                            PlaySoundFrontend(-1, "Drill_Pin_Break", 'DLC_HEIST_FLEECA_SOUNDSET', 1);
                            Wait(5000)
                            ClearPedTasks(GetPlayerPed(-1))
                            DeleteObject(drillObject)
                            brokenOpen = brokenOpen+1
                            TriggerServerEvent('esx_holdup2:soldi1', store)
	                            if brokenOpen == 9 then 
		                            holdingup = false
		                            TriggerServerEvent('esx_holdup2:endrob', store)
		                            ESX.ShowNotification('Hai scassinato tutte le cassaforti! Ora scappa!')
		                            SetEntityCoords(GetPlayerPed(-1), 253.809, 225.196, 101.876)
		                            TriggerEvent('skinchanger:getSkin', function(skin)
	                                    if skin.sex == 0 then
                                            local clothesSkin = {
											['bags_1'] = 41, ['bags_2'] = 0
										    }
		                                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                                        else
                                            local clothesSkin = {
											['bags_1'] = 41, ['bags_2'] = 0
										    }
		                                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                                        end
	                                end)
								end
						end
					end
				end
			end
			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 253.328, 228.461, 101.683, true) > 27.5 ) then
				TriggerServerEvent('esx_holdup2:toofar', store)
				ESX.ShowNotification('HAI ANNULLATO LA RAPINA')
				holdingup = false
			end
			--if IsControlJustPressed(1, 73) then
				--TriggerServerEvent('esx_holdup2:toofar', store)
				--ESX.ShowNotification('HAI ANNULLATO LA RAPINA')
				--holdingup = false
			--end
		end
        Citizen.Wait(0)
    end
end)

   function spawnHostages()
	for i,v in pairs(hostageLocations) do 
	 loadModel(v.model)
	 loadAnimation('random@mugging3')
	 local hostage = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.heading, true, true)
	 SetBlockingOfNonTemporaryEvents(hostage, false)
	 SetPedFleeAttributes(hostage, 0, 0)
	 TaskPlayAnim(hostage, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 14, 0, 0, 0, 0)
	 SetPedKeepTask(hostage, true)
	 SetModelAsNoLongerNeeded(GetHashKey(v.model)) 
	end
   end
   
   function loadModel(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
	 Wait(0)
	end
   end
   
   function loadAnimation(animation)
	RequestAnimDict(animation)
	while not HasAnimDictLoaded(animation) do
	 Citizen.Wait(10)
	end
   end

   function spawnGuards()
	for i,v in pairs(guardLocations) do 
	 loadModel('s_m_m_highsec_01')
	 local ped = CreatePed(4, GetHashKey('s_m_m_highsec_01'), v.x, v.y, v.z, v.heading, true, true)
	 SetPedShootRate(ped, 950)
	 SetPedAlertness(ped, 3)
	 SetPedAccuracy(ped, 100)
	 SetEntityMaxHealth(ped, 450)
	 SetEntityHealth(ped, 450)
	 SetPedArmour(ped, 250)
	 SetPedFleeAttributes(ped, 0, 0)
	 SetPedCombatAttributes(ped, 46, true)
	 SetPedCombatAbility(ped, 2)
	 SetPedCombatRange(ped, 2)
	 SetPedPathAvoidFire(ped, 1)
	 SetPedGeneratesDeadBodyEvents(ped, 1)
	 if math.random(1,10) > 7 then
	  GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPDW"), 5000, true, true)
	 else
	  GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
	 end
	 SetPedRelationshipGroupHash(ped, GetHashKey("security_guard"))
	 SetModelAsNoLongerNeeded(GetHashKey(v.model)) 
	end
   end
   
   function round(num, numDecimalPlaces)
	   local mult = 10^(numDecimalPlaces or 0)
	   return math.floor(num * mult + 0.5) / mult
   end
   
   function drawTxt(text)
	 SetTextFont(0)
	 SetTextProportional(0)
	 SetTextScale(0.32, 0.32)
	 SetTextColour(0, 255, 255, 255)
	 SetTextDropShadow(0, 0, 0, 0, 255)
	 SetTextEdge(1, 0, 0, 0, 255)
	 SetTextDropShadow()
	 SetTextOutline()
	 SetTextCentre(1)
	 SetTextEntry("STRING")
	 AddTextComponentString(text)
	 DrawText(0.5, 0.93)
   end



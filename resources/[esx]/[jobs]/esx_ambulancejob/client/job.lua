local HasAlreadyEnteredMarker, LastZone, CurrentAction, CurrentActionMsg, CurrentActionData = nil, nil, nil, '', {}
local IsBusy = false
--regustrato = false

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	--if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		--table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	--end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions',
	{
		title		= _U('ambulance'),
		align		= 'top-left',
		elements	= elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		--elseif data.current.value == 'boss_actions' then
			--TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				--menu.close()
			--end, {wash = false})
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end)
end

--[[ function OpenBossMensu()
	local elements = {
		{label = 'Menù direttore', 'boss_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Open('default', GetCurrentResourceName(), 'boss_ambulance_actions',
	{
		title		= 'Menù direttore',
		align		= 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'boss_menu_actions'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end)
end ]]

----------------------------------------------------------------------------------------------------------------------------------------------------

local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }
local Car = { 133987706, -1553120962 }

function checkArray (array, val)
	for name, value in ipairs(array) do
		if value == val then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	  while true do
		local sleep = 3000

		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then

			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance < 10.0 then

				if distance ~= -1 and distance <= 2.0 then	
					if IsPedDeadOrDying(GetPlayerPed(player)) then
						Start(GetPlayerPed(player))
					end
				end

			else
				sleep = sleep / 100 * distance 
			end

		end

		Citizen.Wait(sleep)

	end
end)

function Start(ped)
	checking = true

	while checking do
		Citizen.Wait(5)

		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))

		local x,y,z = table.unpack(GetEntityCoords(ped))

		if distance < 2.0 and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sceriffo') then
			DrawText3D(x,y,z, 'Premi [~g~E~s~] per verificare', 0.4)
			
			if IsControlPressed(0, 38) and ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sceriffo') then
				OpenDeathMenu(ped)
			end
		end

		if distance > 7.5 or not IsPedDeadOrDying(ped) then
			checking = false
		end

  end

end

function Notification(x,y,z)
	local timestamp = GetGameTimer()

	while (timestamp + 4500) > GetGameTimer() do
		Citizen.Wait(1)
		DrawText3D(x, y, z, 'La ferita sembra essere qui', 0.4)
		checking = false
	end
end
  
  function OpenDeathMenu(player)
  
	  loadAnimDict('amb@medic@standing@kneel@base')
	  loadAnimDict('anim@gangops@facility@servers@bodysearch@')
  
	  local elements   = {}
  
	  table.insert(elements, {label = 'Cerca la causa di morte', value = 'deathcause'})
	  table.insert(elements, {label = 'Cerca la causa della ferita', value = 'damage'})
  
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'dead_citizen',
		  {
			  title    = 'Choose Option',
			  align    = 'top-left',
			  elements = elements,
		  },
	  function(data, menu)
		  local ac = data.current.value
  
		  if ac == 'damage' then
  
			  local bone
			  local success = GetPedLastDamageBone(player,bone)
  
			  local success,bone = GetPedLastDamageBone(player)
			  if success then
				  --print(bone)
				  local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
					Notification(x,y,z)
				
			  else
				  Notify('Causa ignota')
			  end
		  end
  
		  if ac == 'deathcause' then
			  --gets deathcause
			  local d = GetPedCauseOfDeath(player)		
			  local playerPed = GetPlayerPed(-1)
  
			  --starts animation
  
			  TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			  TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
  
			  Citizen.Wait(5000)
  
			  --exits animation			
  
			  ClearPedTasksImmediately(playerPed)
  
			  if checkArray(Melee, d) then
				  Notify('Corpo a corpo')
			  elseif checkArray(Bullet, d) then
				  Notify('Colpo d\'arma da fuoco')
			  elseif checkArray(Knife, d) then
				  Notify('Coltellata')
			  elseif checkArray(Animal, d) then
				  Notify('Morso')
			  elseif checkArray(FallDamage, d) then
				  Notify('Frattura')
			  elseif checkArray(Explosion, d) then
				  Notify('Esplosione')
			  elseif checkArray(Gas, d) then
				  Notify('Soffocamento da gas')
			  elseif checkArray(Burn, d) then
				  Notify('Ustione')
			  elseif checkArray(Drown, d) then
				  Notify('Annegamento')
			  elseif checkArray(Car, d) then
				  Notify('Incidente stradale')
			  else
				  Notify('Sconosciuto')
			  end
		  end
  
  
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  end
  
  function loadAnimDict(dict)
	  while (not HasAnimDictLoaded(dict)) do
		  RequestAnimDict(dict)
		  
		  Citizen.Wait(1)
	  end
  end
  
  function Notify(message)
	  ESX.ShowNotification(message)
  end
  
  function DrawText3D(x, y, z, text, scale)
	  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
   
	  SetTextScale(scale, scale)
	  SetTextFont(4)
	  SetTextProportional(1)
	  SetTextEntry("STRING")
	  SetTextCentre(1)
	  SetTextColour(255, 255, 255, 215)
   
	  AddTextComponentString(text)
	  DrawText(_x, _y)
   
  end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions',
	{
		title		= _U('ambulance'),
		align		= 'top-left',
		elements	= {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title		= _U('ems_menu_title'),
				align		= 'top-left',
				elements	= {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
          			{label = 'Fattura',			value = 'fine'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = 'Rilascia certificato porto d\'armi', value = 'certificatopda'},
					{label = 'Rilascia certificato uso Marijuana', value = 'certificatom'},
					{label = 'Rilascia assicurazione medica', value = 'assicurazione'},
					{label = 'Sedia a rotelle', value = 'wheelchair'},
					--{label = 'Elimina sedia a rotelle', value = 'delwheelchair'},
					--{label = 'YES', value = 'yes'},
					--{label = 'Controllo assicurazioni/certificati/oggetti', value = 'bodysearch'},
				}
			}, function(data, menu)
				if IsBusy then return end

--				if data.current.value == 'yes' then
	--				TriggerEvent("hud:enabledebug")
		--		end
				if data.current.value == 'wheelchair' then
					local playerPed = PlayerPedId()
					local coords    = GetEntityCoords(playerPed)
					local forward   = GetEntityForwardVector(playerPed)
					local x, y, z   = table.unpack(coords + forward * 1.0)

					model = 'prop_wheelchair_01'

					ESX.Game.SpawnObject(model, {
						x = x,
						y = y,
						z = z
					}, function(obj)
						SetEntityHeading(obj, GetEntityHeading(playerPed))
						PlaceObjectOnGroundProperly(obj)
					end)
				elseif data.current.value == 'delwheelchair' then
					DeleteEntity('prop_wheelchair_01')
				end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else

					if data.current.value == 'revive' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('revive_inprogress'))

									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
									IsBusy = false

									-- Show revive award?
									if Config.ReviveReward > 0 then
										ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									else
										ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'fine' then
					--OpenFineMenu(closestPlayer)
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fine', {
						title = 'Fattura'
					}, function(data, menu)
		
						local amount = tonumber(data.value)
						if amount == nil then
							ESX.ShowNotification(_U('amount_invalid'))
						else
							menu.close()
							--local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							--if closestPlayer == -1 or closestDistance > 3.0 then
								--ESX.ShowNotification('Nessuno nelle vicinanza')
							--else
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'Ambulance', amount)
								ESX.ShowNotification('Fattura inviata')
							--end
		
						end
		
					end, function(data, menu)
						menu.close()
					end)									

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif data.current.value == 'bodysearch' then
						if xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == 'primario' then
							TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), 'Sei stato ~y~perquisito~s~ dal ~b~Medico~s~')
							OpenBodySearchMenu(closestPlayer)
						else
							ESX.ShowNotification('Devi essere direttore/primario per farlo!')
						end
					elseif data.current.value == 'assicurazione' then
						TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'assicurazionemedica')
						ESX.ShowNotification('Hai rilasciato l\'assicurazione medica')
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), 'Ti è stata rilasciata l\'assicurazione medica')
					elseif data.current.value == 'certificatopda' then
						TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'certificatopda')
						ESX.ShowNotification('Hai rilasciato il certificato per richiedere il porto d\'armi')
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), 'Ti è stato rilasciato il certificato per richiedere il porto d\'armi')
						--ESX.ShowNotification('Ti è stato rilasciato il certificato per richiedere il porto d\'armi', GetPlayerName(closestPlayer))
					elseif data.current.value == 'certificatom' then
					    TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'certificatom')
						ESX.ShowNotification('Hai rilasciato il certificato per l\'utilizzo di Marijuana a scopo terapeutico')
						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), 'Ti è stato rilasciato il certificato per l\'utilizzo di Marijuana a scopo terapeutico')
						--ESX.ShowNotification('Ti è stato rilasciato il certificato per l\'utilizzo di Marijuana a scopo terapeutico', GetPlayerName(closestPlayer))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenBodySearchMenu(player)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements = {}

		for i=1, #data.accounts, 1 do

			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then

				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end

		end

		table.insert(elements, {label = _U('guns_label'), value = nil})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label'), value = nil})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end


		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		{
			title    = _U('search'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			local itemType = data.current.itemType
			local itemName = data.current.value
			local amount   = data.current.amount

			if data.current.value ~= nil then
				TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
				OpenBodySearchMenu(player)
			end

		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))

end

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(zone)
	if zone == 'HospitalInteriorEntering1' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorInside1.Pos)
	elseif zone == 'HospitalInteriorExit1' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorOutside1.Pos)
	elseif zone == 'HospitalInteriorEntering2' then
		local heli = Config.HelicopterSpawner

		if not IsAnyVehicleNearPoint(heli.SpawnPoint.x, heli.SpawnPoint.y, heli.SpawnPoint.z, 3.0) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
			ESX.Game.SpawnVehicle('swift', {
				x = heli.SpawnPoint.x,
				y = heli.SpawnPoint.y,
				z = heli.SpawnPoint.z
			}, heli.Heading, function(vehicle)
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, 1)
			end)
		end
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorInside2.Pos)
	elseif zone == 'HospitalInteriorExit2' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorOutside2.Pos)
	--elseif zone == 'ParkingDoorGoOutInside' then
		--TeleportFadeEffect(PlayerPedId(), Config.Zones.ParkingDoorGoOutOutside.Pos)
	--elseif zone == 'ParkingDoorGoInOutside' then
		--TeleportFadeEffect(PlayerPedId(), Config.Zones.ParkingDoorGoInInside.Pos)
	--elseif zone == 'StairsGoTopBottom' then
	--	CurrentAction		= 'fast_travel_goto_top'
	--	CurrentActionMsg	= _U('fast_travel')
	--	CurrentActionData	= {pos = Config.Zones.StairsGoTopTop.Pos}
	--elseif zone == 'StairsGoBottomTop' then
	--	CurrentAction		= 'fast_travel_goto_bottom'
	--	CurrentActionMsg	= _U('fast_travel')
	--	CurrentActionData	= {pos = Config.Zones.StairsGoBottomBottom.Pos}
	elseif zone == 'AmbulanceActions' then
		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	elseif zone == 'boss_menu_coords' then
		CurrentAction			= 'boss_menu_actions'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	elseif zone == 'VehicleSpawner' then
		CurrentAction		= 'vehicle_spawner_menu'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
	elseif zone == 'VehicleSpawner2' then
		CurrentAction		= 'vehicle_spawner_menu_2'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
	elseif zone == 'VehicleSpawner3' then
		CurrentAction		= 'vehicle_spawner_menu_3'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
	elseif zone == 'Pharmacy' then
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords	= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then
				CurrentAction		= 'delete_vehicle'
				CurrentActionMsg	= _U('store_veh')
				CurrentActionData	= {vehicle = vehicle}
			end
		end
	end
end)

function FastTravel(pos)
	TeleportFadeEffect(PlayerPedId(), pos)
end

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)

	SetBlipSprite(blip, Config.Blip.Sprite)
	SetBlipDisplay(blip, Config.Blip.Display)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, Config.Blip.Colour)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('hospital'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				elseif k ~= 'AmbulanceActions' and k ~= 'VehicleSpawner' and k ~= 'VehicleSpawner2' and k ~= 'VehicleSpawner3' and k ~= 'VehicleDeleter' and k ~= 'Pharmacy' and k ~= 'boss_menu_coords' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
					DrawMarker(27, 268.482, -1362.5, 24.538, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local coords		= GetEntityCoords(PlayerPedId())
		local isInMarker	= false
		local currentZone	= nil

		for k,v in pairs(Config.Zones) do
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			elseif k ~= 'AmbulanceActions' and k ~= 'VehicleSpawner' and k ~= 'VehicleSpawner2' and k ~= 'VehicleSpawner3' and k ~= 'VehicleDeleter' and k ~= 'Pharmacy' and k ~= 'boss_menu_coords' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', lastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then

				if CurrentAction == 'ambulance_actions_menu' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'vehicle_spawner_menu' then
					OpenVehicleSpawnerMenu()
				elseif CurrentAction == 'vehicle_spawner_menu_2' then
					OpenVehicleSpawnerMenu2()
				elseif CurrentAction == 'vehicle_spawner_menu_3' then
					OpenVehicleSpawnerMenu3()
				elseif CurrentAction == 'pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'boss_menu_actions' then
					TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
						menu.close()
					end, {wash = false})
				elseif CurrentAction == 'fast_travel_goto_top' or CurrentAction == 'fast_travel_goto_bottom' then
					FastTravel(CurrentActionData.pos)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'ambulance', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil

			end

		end

		if IsControlJustReleased(0, Keys['F6']) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			OpenMobileAmbulanceActionsMenu()
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)


function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title		= _U('cloakroom'),
		align		= 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title		= _U('veh_menu'),
				align		= 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 30.0, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)
			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('veh_menu'),
			align		= 'top-left',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()

			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, 30.0, function(vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end)

	end
end

function OpenVehicleSpawnerMenu2()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title		= _U('veh_menu'),
				align		= 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint2.Pos, 130.0, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)
			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu_2'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('veh_menu'),
			align		= 'top-left',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()

			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint2.Pos, 190.0, function(vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu_2'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end)

	end
end

function OpenVehicleSpawnerMenu3()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title		= _U('veh_menu'),
				align		= 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint3.Pos, 30.0, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)
			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu_3'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('veh_menu'),
			align		= 'top-left',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()

			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint3.Pos, 30.0, function(vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu_3'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end)

	end
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy',
	{
		title		= _U('pharmacy_menu_title'),
		align		= 'top-left',
		elements = {
			--{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			--{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},
      --{label = _U('pharmacy_take', _U('sciroppo')), value = 'sciroppo'},
			--{label = _U('pharmacy_take', _U('antibiotico')), value = 'antibiotico'}
			{label = _U('pharmacy_take', _U('provetta')), value = 'provetta'}
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle({
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
		local freeSeat = nil

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat ~= nil then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)
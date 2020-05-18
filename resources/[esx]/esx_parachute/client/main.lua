ESX				= nil

local allzones	= {}
local alljumps	= {}

local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

local destinationblip

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_parachute:hasEnteredMarker', function(zone)
  	if LastZone == 'menujump' then
	    CurrentAction     = 'jump_menu'
	    CurrentActionMsg  = _U('jump')
	    CurrentActionData = {zone = zone}
  	elseif LastZone == 'arrived' then
	    CurrentAction     = 'arrive_menu'
	    CurrentActionMsg  = _U('arrive')
	    CurrentActionData = {zone = zone}
  	end
end)

AddEventHandler('esx_parachute:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	--Add all zones
	local zoneids = 1
	for k,v in pairs(Config.Zones) do
		table.insert(allzones, {
			id = zoneids,
			pos = v.Pos,
			size = v.Size,
			markercolor = v.MarkerColour,
			markertype = v.MarkerType,
			blipcolour = v.BlipColour,
			blipsprite = v.BlipSprite,
			title = v.Title,
		})
		zoneids = zoneids + 1  
	end
	--Add all jumps
	local jumpids = 1
	for k,v in pairs(Config.Zones) do
		table.insert(alljumps, {
			id = jumpids,
			departpos = v.DepartPos,
			destinationpos = v.DestinationPos,
			destinationsize = v.DestinationSize,
			destinationMarkertype = v.DestinationMarkerType,
			destinationblipcolour = v.DestinationBlipColour,
			destinationblipsprite = v.DestinationBlipSprite,
		})
		jumpids = jumpids + 1  
	end
end)

function Jump()
	--Get a random jump point
	randomjump = math.random(1,#alljumps)
				
	--Teleport player to depart position
	ESX.Game.Teleport(PlayerPedId(), alljumps[randomjump].departpos, function()
		ESX.ShowNotification(_U('in_jump'))
	end)

	--Set destination blip
	local dest = alljumps[randomjump].destinationpos
	destinationblip = AddBlipForCoord(dest.x, dest.y, dest.z)
	SetBlipSprite(destinationblip, Config.DestinationBlipSprite)
	SetBlipDisplay(destinationblip, 4)
	SetBlipScale(destinationblip, 0.6)
	SetBlipColour(destinationblip, Config.DestinationBlipColour)
	SetBlipAsShortRange(destinationblip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U("destination_point"))
	EndTextCommandSetBlipName(destinationblip)
	SetBlipRoute(destinationblip, true)
			
	--For destination blip
	isJumping = 1
	isArrived = 0
end

function FinishJump()
  	if(GetVehiclePedIsIn(GetPlayerPed(-1), false) == car) and GetEntitySpeed(car) < 3 then

	    --Remove destination zone
	    RemoveBlip(destinationblip)

	    --Pay the poor fella
		--TriggerServerEvent('esx_carthief:pay', allvehicles[randomvehicle].payment)

	    --For destination blip
	    isJumping = 0
	    isArrived = 1
	else
		ESX.ShowNotification(_U('cant_finish_jump'))
  	end
end

-- Enter / Exit marker events
Citizen.CreateThread(function()
  	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(allzones) do
			if(GetDistanceBetweenCoords(coords, allzones[k].Pos.x, allzones[k].Pos.y, allzones[k].Pos.z, true) < 3) then
				isInMarker  = true
				currentZone = 'menujump'
				LastZone    = 'menujump'
			end
		end
      
		if isJumping == 1 and (GetDistanceBetweenCoords(coords, alljumps[randomjump].destinationpos.x, alljumps[randomjump].destinationpos.y, alljumps[randomjump].destinationpos.z, true) < 3) then
			isInMarker  = true
			currentZone = 'arrived'
			LastZone    = 'arrived'
		end
      
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_parachute:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_parachute:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
  	while true do
	    Citizen.Wait(0)
	    if CurrentAction ~= nil then
	      	SetTextComponentFormat('STRING')
	      	AddTextComponentString(CurrentActionMsg)
	      	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

	      	if IsControlJustReleased(0, 38) then
		        if CurrentAction == 'jump_menu' then
		          	Jump()
	        	elseif CurrentAction == 'arrive_menu' then
	          		FinishJump()
	        	end
	        	CurrentAction = nil
	      	end
	    end
  	end
end)

-- Display markers for Zones
Citizen.CreateThread(function()
  	while true do
	    Wait(0)
	    for k,v in pairs(Config.Zones) do
			if (v.MarkerType ~= -1) then
				DrawMarker(v.MarkerType, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.MarkerColour.r, v.MarkerColour.g, v.MarkerColour.b, 100, false, true, 2, false, false, false, false)
			end
		end
  	end
end)

-- Display markers for destination place
Citizen.CreateThread(function()
  	while true do
    	Wait(0)
	    if isJumping == 1 and isArrived == 0 then
	      	v = alljumps[randomjump].destinationpos
			if (Config.DestinationMarkerType ~= -1) then
				DrawMarker(Config.DeliveryMarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 1.0, Config.DestinationMarkerColour.r, Config.DestinationMarkerColour.g, Config.DestinationMarkerColour.b, 100, false, false, 2, false, false, false, false)
			end
	    end
  	end
end)

-- Create Blips for Start Jump Zones
Citizen.CreateThread(function()
	for k,v in pairs(allzones) do
	    info = allzones[k]
	    info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
	    SetBlipSprite(info.blip, Config.ZoneBlipSprite)
	    SetBlipDisplay(info.blip, 4)
	    SetBlipScale(info.blip, 1.0)
	    SetBlipColour(info.blip, Config.ZoneBlipColour)
	    SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString(info.title)
	    EndTextCommandSetBlipName(info.blip)
	end
end)






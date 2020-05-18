local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

function Chat(t)
	TriggerEvent("chatMessage", 'TRUCKER', { 0, 255, 255}, "" .. tostring(t))
end

RegisterNetEvent("caccia:createBlip")
AddEventHandler("caccia:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	if(type == 500)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Caccia allo Squalo")
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent("caccia:createBlip2")
AddEventHandler("caccia:createBlip2", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	if(type == 500)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Mercato nero")
		EndTextCommandSetBlipName(blip)
	end
end)
------------------------------------------------------
ESX                             = nil
------------------------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
----------------------------------------------------------------------
local entitySkin
local entityType
local entityQuantity = 1
local missionX = -1643.059
local missionY = -1683.376
local missionZ = -28.702
local entityBlip = {}
local avantspawn
local entityAlive = false
local entityHealth = {}
local entity = {}
local entitySpawned = true
local remover = false

local missionCoords = {
  {x=-1643.059, y=-1683.376, z=-28.702},
  {x=-1678.69, y=-1667.24, z=-23.49},
  {x=-1673.847, y=-1786.159, z=-57.415},
  {x=-1677.601, y=-1890.96, z=-81.773},
  {x=-1764.494, y=-1696.542, z=-47.477},
  {x=-1832.924, y=-1643.751, z=-70.073},
  {x=-1799.996, y=-1580.095, z=-33.294},
  {x=-1754.284, y=-1510.281, z=-20.236},
  {x=-1728.107, y=-1451.439, z=-23.095},
  {x=-1636.829, y=-1462.239, z=-5.477}
}

local entityRemoved = {}
local vending = false
local count = 5
local blipid = 0
local missionRunning = false
local entityType = {28}		--Player,1|Male,4|Female,5|Cop,6|Human,26|SWAT,27|Animal,28|Army,29
local entitySkin = {GetHashKey("a_c_sharktiger")}
local reset = false
local proie = 1
local isinjob = false
local spawned_car = nil
local a = math.random(1, 10)


function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end


Citizen.CreateThread(function()
		TriggerEvent('caccia:createBlip', 500, -768.78, -1492.27, 2.76)
		TriggerEvent('caccia:createBlip2', 500, 113.06, -1959.43, 19.93)
                AddRelationshipGroup("a_c_sharktiger")
	  SetRelationshipBetweenGroups(5, GetHashKey("a_c_sharktiger"), GetHashKey("PLAYER"))
	  SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("a_c_sharktiger"))

	local entityCoords = {
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0},
	{x=0, y=0, z=0}
}
    while true do
       Citizen.Wait(1)
       playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		
		if pos then
				
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 113.06, -1959.43, 19.93, true) <= 5 then
					TriggerServerEvent('caccia:startVente')
					Citizen.Wait(4000)
				end
				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -768.78, -1492.27, 2.76, true) <= 8 ) then
					DrawMarker(27,-768.78, -1492.27, 2.76, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					drawTxt("Premi 'E' per iniziare o terminare la caccia allo squalo",0,1,0.5,0.8,0.6,255,255,255,255)
					if (IsControlPressed(1, 51)) then
						Wait(500)
						if isinjob==false then
							local vehiculeDetected = GetClosestVehicle(-791.95, -1500.41, -0.47, 6.0, 0, 70)
							if not DoesEntityExist(vehiculeDetected) then
								missionRunning = true
								entityType = {28,28,28,28,28}		
								entitySkin = 	{GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),
												GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),
												GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger"),GetHashKey("a_c_sharktiger")}
								entitySpawned = false
								remover = true
								GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNIFE"),250, true, true)
								avantspawn = AddBlipForCoord(missionCoords[a].x,missionCoords[a].y,missionCoords[a].z)
								SetBlipColour(avantspawn,1)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("Squalo")
								EndTextCommandSetBlipName(avantspawn)

								if(spawned_car ~= nil) then
									SetEntityAsMissionEntity(spawned_car, true, true)
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawned_car))
									spawned_car = nil
								else
									local vehicle = GetHashKey('jetmax')
									RequestModel(vehicle)
									while not HasModelLoaded(vehicle) do
										Wait(1)
									end
									local plate = math.random(100, 900)
									spawned_car = CreateVehicle(vehicle,-791.95, -1500.41, -0.47, 110.0, true, false)
									SetVehicleHasBeenOwnedByPlayer(spawned_car,true)
									local id = NetworkGetNetworkIdFromEntity(spawned_car)
									SetNetworkIdCanMigrate(id, true)
									SetEntityInvincible(spawned_car, false)
									SetVehicleOnGroundProperly(spawned_car)
									SetVehicleNumberPlateText(spawned_car,"Hunt "..plate.." ")
									SetEntityAsMissionEntity(spawned_car, true, true)
									SetModelAsNoLongerNeeded(vehicle)
									Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
								end
								isinjob = true
							else
								Citizen.CreateThread(function()
									Wait(10)
									SetNotificationTextEntry("STRING")
									AddTextComponentString("Zona di spawn occupata.")
									DrawNotification(false, false)
								end)
							end
						else
							isinjob = false
							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

								TriggerEvent('skinchanger:loadSkin', skin)
    
							end)
							RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNIFE"), true, true)
							missionRunning = false
							RemoveBlip(entityBlip[proie])
							Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity[proie]))
							if(spawned_car ~= nil) then
								SetEntityAsMissionEntity(spawned_car, true, true)
								Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawned_car))
								spawned_car = nil
							end
							RemoveBlip(avantspawn)
							
						end
					end
				end
					
					if isinjob==true then
						
						if GetDistanceBetweenCoords( GetEntityCoords(GetPlayerPed(-1)),missionCoords[a].x , missionCoords[a].y , missionCoords[a].z, true ) < 80 then
						if (entitySpawned==false) then
								local spawnproie = math.random(1, 12)
								RequestModel(entitySkin[proie]) 
								while not HasModelLoaded(entitySkin[proie]) do
									Wait(1)
								end

								if (avantspawn~= nil) then
									RemoveBlip(avantspawn)
								end
								entity[proie] = CreatePed(entityType[spawnproie], entitySkin[proie], missionCoords[a].x, missionCoords[a].y, missionCoords[a].z, 0, true, true)
								missionX = missionCoords[a].x
								missionY = missionCoords[a].y
								missionZ = missionCoords[a].z
								SetEntityAsMissionEntity(entity[proie], true, true)
                                                                SetPedRelationshipGroupHash(entity[proie], GetHashKey("a_c_sharktiger"))
								TaskWanderStandard(entity[proie], 0, 0)
								entityBlip[proie] = AddBlipForEntity(entity[proie])
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("Squalo")
								EndTextCommandSetBlipName(entityBlip[proie])
								entityAlive = true
								entitySpawned = true
								remover = false
								
						end
						
						if (missionRunning == true and entitySpawned == true) then	
							entityHealth[proie] = GetEntityHealth(entity[proie])
							blipid = entityBlip[proie]
							local vX , vY , vZ = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blipid, Citizen.ResultAsVector()))
							entityCoords[proie].x = vX
							entityCoords[proie].y = vY
							entityCoords[proie].z = vZ
							if (entityHealth[proie] == 0 and entityAlive == true) then
								SetBlipColour(entityBlip[proie],3)
								entityAlive = false
								entityRemoved[proie] = false
							end
							
							--Chat(entity[proie])
							if (GetDistanceBetweenCoords( GetEntityCoords(GetPlayerPed(-1)),entityCoords[proie].x , entityCoords[proie].y , entityCoords[proie].z, true ) < 3 and entityAlive == false) then
								if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
									TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_KNEEL", 0, 1)
									ClearPrints()
									SetTextEntry_2("STRING")
									AddTextComponentString("~g~Stai raccogliendo carne di squalo")
									DrawSubtitleTimed(8000, 1)
									Citizen.Wait(8000)
									ClearPedTasksImmediately(GetPlayerPed(-1))
									RemoveBlip(entityBlip[proie])
									Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity[proie]))
									TriggerServerEvent('caccia:startRecup')
									entityRemoved[proie] = true
									entitySpawned = false
									proie = math.random(1,12)
									a = math.random(1, 10)
									avantspawn = AddBlipForCoord(missionCoords[a].x,missionCoords[a].y,missionCoords[a].z)
									SetBlipColour(avantspawn,1)
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString("Squalo")
									EndTextCommandSetBlipName(avantspawn)
								else
									drawTxt("Scendi dalla barca per raccogliere la carne di squalo",0,1,0.5,0.8,0.6,255,255,255,255)
								end
								
								
							end		
						end
					end
				end
				
		end
    end
end)


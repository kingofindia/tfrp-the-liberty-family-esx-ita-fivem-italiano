ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[ local disPlayerNames = 5

playerDistances = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for id = 0, 256 do
			if NetworkIsPlayerActive(id) then
				if GetPlayerPed(id) ~= GetPlayerPed(-1) then
					if (playerDistances[id] < disPlayerNames) then
                        x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                        ESX.TriggerServerCallback('esx_rich_id:getNearID', function(resultID)
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(x2, y2, z2+1, resultID, 247,124,24)
                            else
                                DrawText3D(x2, y2, z2+1, resultID, 255,255,255)
                            end
                        end, GetPlayerServerId(id))
					end  
				end
			end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        for id = 0, 256 do
            if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				playerDistances[id] = distance
            end
        end
        Citizen.Wait(1000)
    end
end) ]]

function drawTxt4(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.32, 0.32)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(x, y)
end

local myID = 0

Citizen.CreateThread(function()
    local idAttuale = GetPlayerServerId(PlayerId())
    
    Citizen.Wait(5000)

    ESX.TriggerServerCallback('esx_rich_id:getNearID', function(result)
        myID = result
    end, idAttuale)

    while true do
		Citizen.Wait(0)
        drawTxt4(0.015, 0.768, 0.45, '~s~ID DINAMICO: ~y~ ' .. idAttuale, 185, 185, 185, 255)
        drawTxt4(0.015, 0.785, 0.45, '~s~ID PERMANENTE: ~r~' .. myID, 185, 185, 185, 255)
	end
end)

--[[ function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end ]]

local players = {}

RegisterNetEvent('esx_rich_permanentID:addUser')
AddEventHandler('esx_rich_permanentID:addUser', function(user_id, target)
    players[user_id] = GetPlayerFromServerId(target)
end)

RegisterNetEvent('esx_rich_permanentID:removeUser')
AddEventHandler('esx_rich_permanentID:removeUser', function(user_id)
    players[user_id] = nil
end)

function DrawText3D(x, y, z, text, r, g, b, a)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, a)
        SetTextDropshadow(0, 0, 0, 0, 100)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        for i=0,99 do 
            N_0x31698aa80e0223f8(i)
        end

        for k, v in pairs(players) do
            local ped = GetPlayerPed(v)
            local ply = GetPlayerPed(-1)

			if (ped ~= ply) then
				local x1, y1, z1 = table.unpack(GetEntityCoords(ply, true))
				local x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
				local distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true))

				if distance < 5 then
                    local text = ""
                    local r, g, b, a = 255, 255, 255, 225

					if NetworkIsPlayerTalking(v) then
                        z2 = z2 + 0.25
                        r, g, b, a = 0, 150, 230, 225
                        text = text
                    end

                    text = text .. k

                    DrawText3D(x2, y2, z2 + 1, text, r,g,b,a)
				end  
			end
        end

        Citizen.Wait(0)
    end
end)
--===============================================--===============================================
--= stationary radars based on  https://github.com/DreanorGTA5Mods/StationaryRadar           =
--===============================================--===============================================



ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local radares = {
    {x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554},
    {x = -253.10794067383, y = -630.20385742188, z = 33.002685546875},
    {x = 402.51351928711, y = -988.56060791016, z = 29.384887695313},
    {x = 396.40643310547, y = -998.04174804688, z = 29.384420394897},
    {x = 289.00451660156, y = -1038.8428955078, z = 29.15217590332},
    {x = 288.92974853516, y = -1044.7854003906, z = 29.216745376587},
    {x = 288.92974853516, y = -1044.7854003906, z = 29.216745376587},
    {x = 289.53424072266, y = -1050.1109619141, z = 29.217525482178},
    {x = 289.70599365234, y = -1054.7818603516, z = 29.207733154297},
    {x = 289.73013305664, y = -1060.6052246094, z = 29.222185134888},
                                                                                                                             

	
}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for k,v in pairs(radares) do
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(player, true)
            if Vdist2(radares[k].x, radares[k].y, radares[k].z, coords["x"], coords["y"], coords["z"]) < 20 then
                if PlayerData.job ~= nil and not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'sceriffo') then
                    checkSpeed()
                end
            end
        end
    end
end)

function checkSpeed()
    local pP = GetPlayerPed(-1)
    local speed = GetEntitySpeed(pP)
    local vehicle = GetVehiclePedIsIn(pP, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local plate = GetVehicleNumberPlateText(vehicle)
    local maxspeed = 45
    local mphspeed = math.ceil(speed*2.236936)
	local fineamount = nil
	local finelevel = nil
	local truespeed = mphspeed
    if mphspeed > maxspeed and driver == pP then
        Citizen.Wait(250)
        TriggerServerEvent('fineAmount', mphspeed)
	if truespeed >= 50 and truespeed <= 60 then
	fineamount = Config.Fine
	finelevel = '10mph Over Limit'
	end
	if truespeed >= 60 and truespeed <= 70 then
	fineamount = Config.Fine2
	finelevel = '20mph Over Limit'
	end
	if truespeed >= 70 and truespeed <= 80 then
	fineamount = Config.Fine3
	finelevel = '30mph Over Limit'
	end
	if truespeed >= 80 and truespeed <= 500 then
	fineamount = Config.Fine4
	finelevel = '40mph Over Limit'
	end
        exports.pNotify:SetQueueMax("left", 1)
        exports.pNotify:SendNotification({
            text = "<h2><center>Speed Camera</center></h2>" .. "</br>Sei stato multato per eccesso di velocità!</br>Numero targa: " .. plate .. "</br>Importo: $" .. fineamount .. "</br>Violazione: " .. finelevel .. "</br>Limite velocità: " .. maxspeed .. "</br>Tua velocità: " ..mphspeed,
            type = "error",
            timeout = 9500,
            layout = "centerLeft",
            queue = "left"
        })
	
	local player = GetPlayerPed( -1 )
	if not HasNamedPtfxAssetLoaded("core") then
	    RequestNamedPtfxAsset("core")
    end
        while not HasNamedPtfxAssetLoaded("core") do
	    Citizen.Wait(0)
        end
		local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped, true))

        SetPtfxAssetNextCall("core")
		StartParticleFxLoopedAtCoord("ent_anim_paparazzi_flash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		Citizen.Wait(200)
		-- aspetta
	if not HasNamedPtfxAssetLoaded("core") then
	    RequestNamedPtfxAsset("core")
    end
        while not HasNamedPtfxAssetLoaded("core") do
	    Citizen.Wait(0)
        end
		local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped, true))

        SetPtfxAssetNextCall("core")
		StartParticleFxLoopedAtCoord("ent_anim_paparazzi_flash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		Citizen.Wait(200)
		-- aspetta
	if not HasNamedPtfxAssetLoaded("core") then
	    RequestNamedPtfxAsset("core")
    end
        while not HasNamedPtfxAssetLoaded("core") do
	    Citizen.Wait(0)
        end
		local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped, true))

        SetPtfxAssetNextCall("core")
		StartParticleFxLoopedAtCoord("ent_anim_paparazzi_flash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    end
end


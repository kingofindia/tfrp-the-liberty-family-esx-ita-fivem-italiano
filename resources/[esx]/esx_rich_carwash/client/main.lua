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

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

vehicleWashStation = {
	{26.5906,   -1392.0261, 27.3634},
	{167.1034,  -1719.4704, 27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325, -932.7043,  17.0139}
}

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	  SetTextCentre(center)
    --SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local function drawRect(x, y, width, height, color)
    DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end

-- Add blips
Citizen.CreateThread(function()
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100)
		SetBlipAsShortRange(stationBlip, true)
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(2)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then 
			for i = 1, #vehicleWashStation do
				garageCoords = vehicleWashStation[i]
				DrawMarker(27, garageCoords[1], garageCoords[2], garageCoords[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), garageCoords[1], garageCoords[2], garageCoords[3], true) < 5 then
					if Config.EnablePrice then
						ESX.ShowHelpNotification(_U('press_wash_paid', Config.Price))
					else
						ESX.ShowHelpNotification(_U('press_wash'))
					end
					if IsControlJustPressed(1, Keys['NENTER']) then
						WashVehicle()
					end
				end
			end
		else
			-- enter 'sleep mode'
			Citizen.Wait(500)
		end
	end
end)

function WashVehicle()
	local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
	ESX.TriggerServerCallback('esx_carwash:canAfford', function(canAfford)
		if canAfford then
			SetVehicleDirtLevel(veh, 0.0000000001)
			SetVehicleEngineOn(veh, false, false, false)
			SetVehicleUndriveable(veh, true)
			
			local player = GetPlayerPed( -1 )
		if not HasNamedPtfxAssetLoaded("scr_carwash") then
			RequestNamedPtfxAsset("scr_carwash")
		end
        while not HasNamedPtfxAssetLoaded("scr_carwash") do
	    	Citizen.Wait(0)
        end
		local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped, true))

        SetPtfxAssetNextCall("scr_carwash")
		local splash = StartParticleFxLoopedAtCoord("ent_amb_car_wash", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		Citizen.Wait(200)
		if not HasNamedPtfxAssetLoaded("scr_carwash") then
			RequestNamedPtfxAsset("scr_carwash")
		end
			while not HasNamedPtfxAssetLoaded("scr_carwash") do
			Citizen.Wait(0)
			end
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped, true))
	
			SetPtfxAssetNextCall("scr_carwash")
			local getto = StartParticleFxLoopedAtCoord("ent_amb_car_wash_jet", x, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
			Citizen.Wait(200)
			if not HasNamedPtfxAssetLoaded("scr_carwash") then
				RequestNamedPtfxAsset("scr_carwash")
			end
				while not HasNamedPtfxAssetLoaded("scr_carwash") do
				Citizen.Wait(0)
				end
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped, true))
		
				SetPtfxAssetNextCall("scr_carwash")
				local gettodue = StartParticleFxLoopedAtCoord("ent_amb_car_wash_jet", x+1.0, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
				Citizen.Wait(200)
				if not HasNamedPtfxAssetLoaded("scr_carwash") then
					RequestNamedPtfxAsset("scr_carwash")
				end
					while not HasNamedPtfxAssetLoaded("scr_carwash") do
					Citizen.Wait(0)
					end
					local ped = PlayerPedId()
					local x,y,z = table.unpack(GetEntityCoords(ped, true))
			
					SetPtfxAssetNextCall("scr_carwash")
					local gettotre = StartParticleFxLoopedAtCoord("ent_amb_car_wash_jet", x-1.0, y, z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
					ProgressBar('LAVAGGIO VEICOLO IN CORSO', 135)
		Citizen.Wait(15000)
		StopParticleFxLooped(splash, 0)
		StopParticleFxLooped(getto, 0)
		StopParticleFxLooped(gettodue, 0)
		StopParticleFxLooped(gettotre, 0)
		
		SetVehicleEngineOn(veh, true, false, false)
		SetVehicleUndriveable(veh, false)

			if Config.EnablePrice then
				ESX.ShowNotification(_U('wash_successful_paid', Config.Price))
			else
				ESX.ShowNotification(_U('wash_successful'))
			end
			Citizen.Wait(5000)
		else
			ESX.ShowNotification(_U('wash_failed'))
			Citizen.Wait(5000)
		end
	end)
end

local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if progress_bar then 
   DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
   drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text, 255, 255, 255, 255, false)
   if progress_time > 0 then
   	DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 75, 156, 237, 225)
   elseif progress_time < 1 and progress_bar then 
    progress_bar = false
   end
  end
 end
end)

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
end

RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(text, time)
 ProgressBar(text, time)
end)


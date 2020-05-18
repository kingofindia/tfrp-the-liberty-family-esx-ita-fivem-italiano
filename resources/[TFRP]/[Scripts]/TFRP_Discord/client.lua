local WaitTime = 2500 -- How often do you want to update the status (In MS)

local DiscordAppId = tonumber(GetConvar("RichAppId", "581445999080243201"))
local DiscordAppAsset = GetConvar("RichAssetId", "fivem_large")
	
Citizen.CreateThread(function()
	SetDiscordAppId(DiscordAppId)
	SetDiscordRichPresenceAsset(DiscordAppAsset)
	while true do
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		Citizen.Wait(WaitTime)
		SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #players .. "/128") then
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("Corre a "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("Corre a "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("Cammina a "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("Cammina a "..StreetName)
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if MPH > 50 then
					SetRichPresence("Accellerando a "..StreetName.." in un "..VehName)
				elseif MPH <= 50 and MPH > 0 then
					SetRichPresence("Accellerando a "..StreetName.." in un "..VehName)
				elseif MPH == 0 then
					SetRichPresence("Parcheggiato a "..StreetName.." in un "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("Volando a "..StreetName.." in un "..VehName)
				else
					SetRichPresence("Atterrato a "..StreetName.." in un "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("Nuotando")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence("Navigando in un "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("In un sottomarino")
			end
		end
	end
end)

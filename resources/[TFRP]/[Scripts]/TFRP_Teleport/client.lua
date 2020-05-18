local TeleportFromTo = {
	["Maze Bank Building"] = {
		positionFrom = { ['x'] = -68.7212, ['y'] = -801.0262, ['z'] = 44.2273, nom = "Maze Bank Building"},
		positionTo = { ['x'] = -67.6794, ['y'] = -821.6484, ['z'] = 321.2873, nom = "Maze Bank Building"},
	},
	
	["Humane Labs"] = {
		positionFrom = { ['x'] = 3541.7028, ['y'] = 3674.2761, ['z'] = 28.1211, nom = "Humane labs"},
		positionTo = { ['x'] = 3541.7314, ['y'] = 3674.2619, ['z'] = 20.9917, nom = "Humane labs"},
	},
	
	["Arcadius Buisiness"] = {
		positionFrom = { ['x'] = -117.2135, ['y'] = -604.5497, ['z'] = 36.2807, nom = "Arcadius Buisiness"},
		positionTo = { ['x'] = -134.0843, ['y'] = -584.5471, ['z'] = 201.7355, nom = "Arcadius Buisiness"},
	},	
	
	["Bureau du FIB"] = {
		positionFrom = { ['x'] = 136.0994, ['y'] = -761.8452, ['z'] = 45.7520, nom = "Uffici FIB"},
		positionTo = { ['x'] = 136.7892, ['y'] = -761.4996, ['z'] = 242.1518, nom = "Uffici FIB"},
	},

	["Zancudo FBI Entrata"] = {
		positionFrom = { ['x'] = -1594.03, ['y'] = 2805.347, ['z'] = 17.01, nom = "Entra"},
		positionTo = { ['x'] = -1602.975, ['y'] = 2814.314, ['z'] = 17.45, nom = "Esci"},
	},

	["Zancudo FBI Uscita"] = {
		positionFrom = { ['x'] = -1607.578, ['y'] = 2810.177, ['z'] = 17.437, nom = "Entra"},
		positionTo = { ['x'] = -1597.326, ['y'] = 2796.984, ['z'] = 16.909, nom = "Esci"},
	},
	["Los Pollos Hermanos2"] = {
		positionFrom = { ['x'] = -570.453, ['y'] = -394.603, ['z'] = 35.057, nom = "Entrata"},
		positionTo = { ['x'] = -570.142, ['y'] = -396.987, ['z'] = 34.915, nom = "Uscita"}, 
	},

	["FBI GARAGE"] = {
		positionFrom = { ['x'] = 141.946, ['y'] = -769.048, ['z'] = 45.752, nom = "Garage"},
		positionTo = { ['x'] = 161.341, ['y'] = -698.486, ['z'] = 33.128, nom = "Garage"},
	},

	["FBI ELIPORTO"] = {
		positionFrom = { ['x'] = -70.733, ['y'] = -800.262, ['z'] = 44.227, nom = "Eliporto"},
		positionTo = { ['x'] = -66.666, ['y'] = -821.987, ['z'] = 321.285, nom = "Eliporto"},
	},
	["Market"] = {
		positionFrom = { ['x'] = 65.07, ['y'] = -1742.009, ['z'] = 0.854, nom = "Uscita - Market"},
		positionTo = { ['x'] = 63.838, ['y'] = -1729.006, ['z'] = 29.644, nom = "Entrata- Market"},
	},
	["Palco"] = {
		positionFrom = { ['x'] = 193.602, ['y'] = 1164.527, ['z'] = 227.179, nom = "Palco"},
		positionTo = { ['x'] = 215.791, ['y'] = 1161.16, ['z'] = 226.98, nom = "Palco"},
	},
	["Palco2"] = {
		positionFrom = { ['x'] = 214.747, ['y'] = 1164.05, ['z'] = 226.981, nom = "Palco2"},
		positionTo = { ['x'] = 160.408, ['y'] = 1156.538, ['z'] = 227.933, nom = "Palco2"},
	},
	["Elicottero"] = {
		positionFrom = { ['x'] = 340.406, ['y'] = -595.609, ['z'] = 28.791, nom = "Uscita - Ascensore Elicottero"},
		positionTo = { ['x'] = 338.591, ['y'] = -583.87, ['z'] = 74.166, nom = "Entrata - Ascensore Elicottero"},
	},
	["Mafia"] = {
		positionFrom = { ['x'] = 1395.451, ['y'] = 1141.874, ['z'] = 114.64, nom = "Entrata - Casa Mafia"},
		positionTo = { ['x'] = 1396.561, ['y'] = 1141.812, ['z'] = 114.334, nom = "Uscita - Casa Mafia"},
	},
	["Willy"] = {
		positionFrom = { ['x'] = 125.95, ['y'] = 609.745, ['z'] = 205.26, nom = "Entrata"},
		positionTo = { ['x'] = 126.592, ['y'] = 607.579, ['z'] = 205.261, nom = "Uscita"},
	},
	["Arma"] = {
		positionFrom = { ['x'] = 818.18, ['y'] = -2154.011, ['z'] = 29.619, nom = "Armeria - Ufficio"},
		positionTo = { ['x'] = 818.032, ['y'] = -2155.626, ['z'] = 29.619, nom = "Armeria - Ufficio"}
	},
	["PRESIDENTE"] = {
		positionFrom = { ['x'] = -429.027, ['y'] = 1110.103, ['z'] = 327.682, nom = "Casa Presidenziale"},
		positionTo = { ['x'] = 933.106, ['y'] = 1243.022, ['z'] = 366.209, nom = "Casa Presidenziale"}
	},
	["Narcos"] = {
		positionFrom = { ['x'] = -1586.521, ['y'] = 2097.472, ['z'] = 69.79, nom = "Entrata"},
		positionTo = { ['x'] = -1587.555, ['y'] = 2096.641, ['z'] = 69.99, nom = "Uscita"}
	}
}

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing


function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function Drawing.drawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

function msginf(msg, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(duree, 1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		
		for k, j in pairs(TeleportFromTo) do
		
			--msginf(k .. " " .. tostring(j.positionFrom.x), 15000)
			if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 5.0)then
				DrawMarker(25, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 5.0)then
					Drawing.draw3DText(j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1.100, j.positionFrom.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 1.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("Premi ~r~E~w~ per aprire la porta ".. j.positionFrom.nom)
						DrawSubtitleTimed(500, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2000)
							SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
							DoScreenFadeIn(1000)
						end
					end
				end
			end
			
			if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 20.0)then
				DrawMarker(25, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, .801, 255, 255, 255,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 5.0)then
					Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 1.0)then
						ClearPrints()
						SetTextEntry_2("STRING")
						AddTextComponentString("Premi ~r~E~w~ per aprire la porta ".. j.positionTo.nom)
						DrawSubtitleTimed(500, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2000)
							SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
							DoScreenFadeIn(1000)
						end
					end
				end
			end
		end
	end
end)
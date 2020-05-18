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

local PlayerData              = {}
local iniziato = false
local JobBlips = {}
local invendita = false
local invendita2 = false
local inservizio = false
ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	refreshBlips()
	
	Citizen.Wait(5000)
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function animazioneplayer()
	local ped = PlayerPedId()

	RequestAnimDict("melee@hatchet@streamed_core")
	while (not HasAnimDictLoaded("melee@hatchet@streamed_core")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "melee@hatchet@streamed_core", "plyr_front_takedown", 8.0, -8.0, -1, 0, 0, false, false, false) 
end

function animazionemaiale()
	local ped = PlayerPedId()

	RequestAnimDict("melee@hatchet@streamed_core")
	while (not HasAnimDictLoaded("melee@hatchet@streamed_core")) do Citizen.Wait(0) end
	Wait(1500)

	TaskPlayAnim(ped, "melee@hatchet@streamed_core", "plyr_front_takedown_b", 8.0, -8.0, -1, 0, 0, false, false, false) 
end

function armadietto()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = 'Armadietto',
		elements = {
			{label = 'Abiti da lavoro',     value = 'job_wear'},
			{label = 'Abiti quotidiani', value = 'citizen_wear'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			inservizio = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'job_wear' then
			inservizio = true
			--if PlayerData.job.name == 'slaughterer' or PlayerData.job2.name == 'slaughterer' then
				TriggerEvent('skinchanger:getSkin', function(skin)
  
					if skin.sex == 0 then
			
					  local clothesSkin = {
						['tshirt_1'] = 15, ['tshirt_2'] = 0, 
						['torso_1'] = 56, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 67,
						['pants_1'] = 36, ['pants_2'] = 0,
						['shoes_1'] = 12, ['shoes_2'] = 1,
						['ears_1'] = 8, ['ears_2'] = 2
					  }
					  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			--end
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, -1071.13, -2003.78, 14.78, true) < 15.0 then
			    DrawMarker(20, -1071.13, -2003.78, 15.78, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, -1071.13, -2003.78, 14.78, true) < 1.75 then
					drawTxt('~b~Premi ~g~E~b~ per interagire con l\'armadietto')
					if IsControlJustReleased(1, 51) then
						armadietto()
					end
			    end
		    end
		
		end
	end
end)

hailpollovivo = false
hailpollomorto = false
maiale = false

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local pos = GetEntityCoords(playerPed, true)

		if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then
			if (GetDistanceBetweenCoords(pos, -75.813, 6271.131, 31.374) < 15.0) then
				if not iniziato and inservizio and IsPedSittingInAnyVehicle(playerPed) then
					local cVeh = GetVehiclePedIsUsing(playerPed, false)
					local vehicle = GetHashKey('BENSON')
					if GetEntityModel(cVeh) == vehicle then
					    DrawMarker(11, -75.813, 6271.131, 31.374, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
					    if (GetDistanceBetweenCoords(pos, -75.813, 6271.131, 31.374) < 1.75) then
						    drawTxt('~b~Premi ~g~E~b~ per iniziare l\'attività')
							if IsControlJustReleased(1, 51) then
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
									if quantity <= 1000 then
										iniziato = true
										TriggerEvent('mt:missiontext', 'VAI AL PUNTO ~g~ 2', 5000)
									else
										TriggerEvent('mt:missiontext', '~r~ INVENTARIO PIENO', 10000)
									end
								end, 'packaged_chicken')
					        end
					    end
				    end
				end
			end
		end

		while iniziato do
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local player = PlayerPedId()

			Citizen.Wait(5)
				if(GetDistanceBetweenCoords(coords, -62.72, 6241.525, 31.09, true) < 15.0) and not hailpollovivo and not hailpollomorto then  
					DrawMarker(12, -62.72, 6241.525, 31.09, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(coords, -62.72, 6241.525, 31.09, true) < 1.0) then
                        drawTxt('~b~Premi ~g~E~b~ per prendere il pollo vivo')
						if IsControlJustPressed(0, 38) then
							hailpollovivo = true
							SetEntityCoords(GetPlayerPed(-1), -62.908, 6241.369, 31.09-0.95) 
							SetEntityHeading(GetPlayerPed(-1), 302.173)
							FreezeEntityPosition(player, true)
							RequestModel( GetHashKey( "a_c_hen" ) )
                            while ( not HasModelLoaded( GetHashKey( "a_c_hen" ) ) ) do
                            Citizen.Wait( 1 )
                            end
                            pollovivo = CreatePed(5, 0x6AF51FAF, -62.246, 6241.893, 31.09, 304.335, true)
							TaskStartScenarioInPlace(player, "PROP_HUMAN_BUM_BIN", 0, true)
							Wait(5000)
							AttachEntityToEntity(pollovivo, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(player, false)
							TriggerEvent('mt:missiontext', 'VAI AL PUNTO ~g~ 3', 5000)
						end
					end
				end
				
				if(GetDistanceBetweenCoords(coords, -78.054, 6229.428, 31.092, true) < 15.0) and hailpollovivo and not hailpollomorto then  
					DrawMarker(13, -78.054, 6229.428, 31.092, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(coords, -78.054, 6229.428, 31.092, true) < 1.0) then
						drawTxt('~b~Premi ~g~E~b~ per macellare il pollo vivo')
						if IsControlJustPressed(0, 38) then
							hailpollomorto = true
							SetEntityCoords(GetPlayerPed(-1), -78.002, 6229.203, 31.092-0.95) 
							SetEntityHeading(GetPlayerPed(-1), 127.636)
						    FreezeEntityPosition(player, true)
							TaskStartScenarioInPlace(player, "PROP_HUMAN_BUM_BIN", 0, true)
							hailpollovivo = false
	                        DeleteEntity(pollovivo)
							RequestModel( GetHashKey( "a_c_hen" ) )
                            while ( not HasModelLoaded( GetHashKey( "a_c_hen" ) ) ) do
                            Citizen.Wait( 1 )
                            end
                            pollomorto = CreatePed(5, 0x6AF51FAF, -78.789, 6228.725, 30.441, 304.335, true)
							SetEntityAsMissionEntity(pollomorto)
							Wait(1500)
							SetEntityHealth(pollomorto, 0)
							Wait(10000)
										
							AttachEntityToEntity(pollomorto, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1) 
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(player, false)
							TriggerEvent('mt:missiontext', 'VAI AL PUNTO ~g~ 4', 5000)
						end
					end
				end
										
				if(GetDistanceBetweenCoords(coords, -101.673, 6208.75, 31.025, true) < 15.0) and hailpollomorto and not hailpollovivo then  
					DrawMarker(14, -101.673, 6208.75, 31.025, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(coords, -101.673, 6208.75, 31.025, true) < 1.0) then
						drawTxt('~b~Premi ~g~E~b~ per lavorare il pollo')
						if IsControlJustPressed(0, 38) then
							SetEntityCoords(GetPlayerPed(-1), -101.676, 6208.732, 31.025-0.95) 
							SetEntityHeading(GetPlayerPed(-1), 45.796)
							FreezeEntityPosition(player, true)
							DetachEntity(pollomorto, false, false)
							hailpollomorto = false
							SetEntityCoords(pollomorto, -102.497, 6209.558, 31.759-0.95) 
							ClearPedTasksImmediately(PlayerPedId())
							TaskStartScenarioInPlace(player, "PROP_HUMAN_BUM_BIN", 0, true)
							Wait(10000)
							DeleteEntity(pollomorto)
							ClearPedTasksImmediately(PlayerPedId())
							TriggerServerEvent('esx_macellaiosdr:pollovassoio')
							FreezeEntityPosition(player, false)
						end
					end
				end

				if(GetDistanceBetweenCoords(coords, 1421.124, 1080.864, 114.345, true) < 15.0) and not maiale then  
					DrawMarker(20, 1421.124, 1080.864, 114.345, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(coords, 1421.124, 1080.864, 114.345, true) < 1.0) then
						drawTxt('~b~Premi ~g~E~b~ per chiamare il maiale')
						if IsControlJustPressed(0, 38) then
							maiale = true
							FreezeEntityPosition(player, true)
							RequestModel( GetHashKey( "a_c_pig" ) )
                            while ( not HasModelLoaded( GetHashKey( "a_c_pig" ) ) ) do
                            Citizen.Wait( 1 )
                            end
                            maiale = CreatePed(5, 0xB11BAB56, coords.x, coords.y, coords.z-0.7, 304.335, true)
							SetEntityAsMissionEntity(maiale)
							Wait(1500)
							TaskStartScenarioInPlace(player, 'world_human_gardener_plant', 0, false)
							SetEntityHealth(maiale, 50)
							Wait(5000)
							SetEntityHealth(maiale, 25)
							Wait(5000)
							SetEntityHealth(maiale, 0)
							Wait(5000)
							DeleteEntity(maiale)
							FreezeEntityPosition(player, false)
							TriggerServerEvent('esx_macellaiosdr:carnemaiale')
							ClearPedTasksImmediately(PlayerPedId())
							Wait(1200000)
						    maiale = false
						end
					end
				end

				if(GetDistanceBetweenCoords(coords, -66.69, 6270.376, 31.32, true) < 15.0) then  
					DrawMarker(20, -66.69, 6270.376, 31.32, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 15, 15, 150, 0, true, 2, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(coords, -66.69, 6270.376, 31.32, true) < 1.0) then
						drawTxt('~b~Premi ~g~E~b~ per terminare')
						if IsControlJustPressed(0, 38) then
							iniziato = false
							DeleteEntity(pollomorto)
							DeleteEntity(pollovivo)
						end
					end
				end
        end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local pos = GetEntityCoords(playerPed, true)
		if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then
			if (GetDistanceBetweenCoords(pos, -596.15, -889.32, 24.50) < 15.0) and not iniziato and not invendita and inservizio then
				DrawMarker(29, -596.15, -889.32, 25.50, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
				if (GetDistanceBetweenCoords(pos, -596.15, -889.32, 24.50) < 0.75) then
					drawTxt('~b~Premi ~g~E~b~ per vendere il pollo')
					if IsControlJustReleased(1, 51) then
						local cVeh = GetVehiclePedIsUsing(playerPed, false)
					local vehicle = GetHashKey('BENSON')
					if GetEntityModel(cVeh) == vehicle then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
							title = 'Quantità Pollo',
						}, function (data2, menu)
							Testo3 = tonumber(data2.value)
							if Testo3 == nil then
								ESX.ShowNotification('Valore non valido')
							else
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
									if Testo3 <= quantity then
										menu.close()
										invendita = true
										--FreezeEntityPosition(playerPed, true)
										Citizen.Wait(10000)
										TriggerServerEvent('esx_macellaiosdr:consegna', Testo3)
										invendita = false
										--FreezeEntityPosition(playerPed, false)
									else
										menu.close()
										TriggerEvent('mt:missiontext', '~r~ AZIONE IMPOSSIBILE', 10000)
									end
								end, 'packaged_chicken')
							end
							
						end, function (data2, menu)
							menu.close()
						end)
					else
						TriggerEvent('mt:missiontext', '~r~ DEVI STARE NEL CAMION AZIENDALE', 10000)
					end
					end
				end
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local pos = GetEntityCoords(playerPed, true)
		if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then
			if (GetDistanceBetweenCoords(pos, 981.546, -2120.82, 30.475) < 15.0) and not invendita2 and inservizio then
				DrawMarker(29, 981.546, -2120.82, 30.475, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 255, 0, 150, 0, true, 2, 0, 0, 0, 0)
				if (GetDistanceBetweenCoords(pos, 981.546, -2120.82, 30.475) < 0.75) then
					drawTxt('~b~Premi ~g~E~b~ per vendere il maiale')
					if IsControlJustReleased(1, 51) then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
							title = 'Quantità Maiale',
						}, function (data2, menu)
							Testo4 = tonumber(data2.value)
							if Testo4 == nil then
								ESX.ShowNotification('Valore non valido')
							else
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
									if Testo4 <= quantity then
										menu.close()
										invendita2 = true
										FreezeEntityPosition(playerPed, true)
										Citizen.Wait(10000)
										TriggerServerEvent('esx_macellaiosdr:consegnamaiale', Testo4)
										invendita2 = false
										FreezeEntityPosition(playerPed, false)
									else
										menu.close()
										TriggerEvent('mt:missiontext', '~r~ AZIONE IMPOSSIBILE', 10000)
									end
								end, 'maiale')
							end
							
						end, function (data2, menu)
							menu.close()
						end)
					end
				end
			end
		end
		Citizen.Wait(0)
	end
end)

function piastacazzodemacchina()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'prendi_veicolo',
	  {
		  title    = 'Veicolo Aziendale',
		  elements = {
			  {label = 'Camion Aziendale', value = 'uno'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
			if val == 'uno' then
			menu.close()
			local vehicle = GetHashKey('BENSON')
			RequestModel(vehicle)
			while not HasModelLoaded(vehicle) do
			Wait(1)
			end
			spawned_car = CreateVehicle(vehicle,-1051.749, -2028.212, 13.162,131.783, true, false)
			SetVehicleNumberPlateText(spawned_car,"CARNE")
			TriggerEvent('mt:missiontext', 'Ora raggiungi il punto in mappa chiamato ~g~Pollo vivo ~w~ con il camion aziendale.', 10000)
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
  end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, -1045.489, -2022.002, 13.162, true) < 15.0 and inservizio then
			    DrawMarker(39, -1045.489, -2022.002, 13.162, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, -1045.489, -2022.002, 13.162, true) < 1.75 then
					drawTxt('~b~Premi ~g~E~b~ per prendere il camion')
					if IsControlJustReleased(1, 51) then
						piastacazzodemacchina()
					end
			    end
		    end
		
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, -1061.51, -2008.35, 12.16, true) < 15.0 and inservizio then
			    DrawMarker(39, -1061.51, -2008.35, 13.16, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, -1061.51, -2008.35, 12.16, true) < 1.75 then
					drawTxt('~b~Premi ~g~E~b~ per parcheggiare il camion')
					if IsControlJustReleased(1, 51) then
						TriggerEvent('esx:deleteVehicle', "benson")
					end
			    end
		    end
		
		end
	end
end)



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

function refreshBlips()

	if PlayerData.job ~= nil and PlayerData.job.name == 'slaughterer' then

        for k,v in pairs(Config.Zones) do
		  
		    for i = 1, #v.Pos, 1 do
		
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
		
			SetBlipSprite (blip, 256)
			SetBlipDisplay(blip, 4)
		    SetBlipScale  (blip, 1.0)
		    SetBlipColour (blip, 5)
		    SetBlipAsShortRange(blip, true)
		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v.Pos[i].nome)
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		    end
		end
	end
end


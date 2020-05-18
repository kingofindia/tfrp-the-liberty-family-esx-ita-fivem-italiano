ESX = nil

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


function Radar()
  local player = GetPlayerPed(-1)
  local vitesse = GetEntitySpeed(player)
  local vehicule = GetVehiclePedIsIn(player)
  local conducteur = GetPedInVehicleSeat(vehicule, -1)
  local plaque = GetVehicleNumberPlateText(vehicule)
  local kmhspeed = math.ceil(vitesse*3.6)

  if ServicePublique == true then
      if kmhspeed >= vitessemax and conducteur == player and PlayerData.job ~= nil and PlayerData.job == 'mecano' and not (PlayerData.job.name == 'state' or PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
        TriggerServerEvent('paiement:radar')
        Wait(1000)
        TriggerEvent("InteractSound_CL:PlayOnOne", "Sonradar", 0.2)
        TriggerEvent("pNotify:SendNotification",{
          text = 'Velocità salvata:' ..kmhspeed.. 'km/h. Targa:' ..plaque,
          type = "warning",
          timeout = (7000),
          layout = "bottomCenter",
          queue = "global"
        })
        TriggerEvent("pNotify:SendNotification",{
          text = 'Multa di:' ..prixcontravention.. '$.',
          type = "warning",
          timeout = (7000),
          layout = "bottomCenter",
          queue = "global"
        })
      end
      if kmhspeed >= vitessemax and PlayerData.job ~= and (PlayerData.job.name == 'state' or PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
          Wait(1000)
        TriggerEvent("InteractSound_CL:PlayOnOne", "Sonradar", 0.2)
        --TriggerEvent("citizenv:notify", "CHAR_LS_TOURIST_BOARD", 1, "RADAR", false, "Velocità salvata : ~r~" .. kmhspeed.. "~s~ km/h \nTarga : ~r~"..plaque)
        --TriggerEvent("citizenv:notify", "CHAR_LS_TOURIST_BOARD", 1, "RADAR", false, "Questo è un veicolo d'emergenza \nsei esonerato da una ~r~contravvenzione~s~")
        TriggerEvent("pNotify:SendNotification",{
          text = 'Velocità salvata:' ..kmhspeed.. 'km/h. Targa:' ..plaque,
          type = "warning",
          timeout = (7000),
          layout = "bottomCenter",
          queue = "global"
        })
        TriggerEvent("pNotify:SendNotification",{
          text = 'Questo è un veicolo d\'emergenza sei esonerato da una contravvenzione',
          type = "warning",
          timeout = (7000),
          layout = "bottomCenter",
          queue = "global"
        })
        end
    else  
      if kmhspeed >= vitessemax and conducteur == player then
        TriggerServerEvent('paiement:radar')
        Wait(1000)
        TriggerEvent("InteractSound_CL:PlayOnOne", "Sonradar", 0.2)
        TriggerEvent("pNotify:SendNotification",{
          text = 'Velocità salvata:' ..kmhspeed.. 'km/h. Targa:' ..plaque,
          type = "warning",
          timeout = (7000),
          layout = "bottomCenter",
          queue = "global"
        })
        TriggerEvent("pNotify:SendNotification",{
          text = 'Multa di:' ..prixcontravention.. '$.',
          type = "warning",
          timeout = (7000),
          layout = "bottomCenter",
          queue = "global"
        })
      end
    end
end
 
Citizen.CreateThread(function()
	for _, item in pairs(radar) do
		local choixblip = item.blipshow
		if DrawBlipShow then
			if choixblip == true then
    			local blip = AddBlipForCoord(item.x, item.y, item.z)
        		SetBlipSprite(blip, item.idblip)
        		SetBlipColour(blip, item.couleurblip)
        		SetBlipScale(blip, item.tailleblip)
        		SetBlipFlashes(blip, item.clignotementblip)
        		SetBlipAsShortRange(blip, true)
        		BeginTextCommandSetBlipName("STRING")
        		AddTextComponentString(item.nom)
        		EndTextCommandSetBlipName(blip)
        	end
    	end
    end
end)
 
Citizen.CreateThread(function()
  while true do
    Wait(0)
    for _, item in pairs(radar) do
      local player = GetPlayerPed(-1)
      local coords = GetEntityCoords(player, true)
      local choixmarker = item.markershow
      if (Vdist(item.x, item.y, item.z, coords["x"], coords["y"], coords["z"]) <= item.distanceactivation) then
    	  vitessemax = item.vitessemax
    	  prixcontravention = item.prixamende
        Radar()
        Wait(2500)
      end
    	  if DrawMarkerShow then
    		  if choixmarker == true then
      		  DrawMarker(item.idmarqueur, item.x, item.y, item.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, item.taille1, item.taille2, item.taille3, item.couleurR, item.couleurG, item.couleurB, item.transparence, 2, 0, 0, 0, 0, 0, 0)
      	  end
    	  end
    end
 end
end)

AddEventHandler('onClientMapStart', function()

RequestModel(1581098148)
while not HasModelLoaded(1581098148) do
    Wait(1)
end

RequestModel(2046537925)
while not HasModelLoaded(2046537925) do
  	Wait(1)
end

RequestModel("prop_cctv_pole_01a")
while not HasModelLoaded("prop_cctv_pole_01a") do
    Wait(1)
end

  if FlicEnVille then
  	for _, item in pairs(positionsflics) do
    	flic = CreatePed(item.type, item.hash, item.x, item.y, item.z, item.h, false, false)
    	PlaceObjectOnGroundProperly(flic)
    	SetEntityInvincible(flic, true)
    	SetBlockingOfNonTemporaryEvents(flic, true)
    	TaskStartScenarioInPlace(flic, "WORLD_HUMAN_BINOCULARS", 0, true)
    	SetPedCanRagdoll(flic, false)
    	FreezeEntityPosition(flic, true)
  	end
  end

  if VoitureFlicEnville then
  	for _, item in pairs(positionsvoitureflics) do
    	voiture = CreateVehicle(item.hash, item.x, item.y, item.z, item.h, false, false)
    	SetVehicleOnGroundProperly(voiture)
    	SetEntityInvincible(voiture, true)
    	SetBlockingOfNonTemporaryEvents(voiture, true)
    	FreezeEntityPosition(voiture, false)
    	SetVehicleDoorsLocked(voiture, 2)
    	SetVehicleSiren(voiture, true)
  	end
  end

  if CameraRadar then
  	for _, item in pairs(positionsCamera) do
    	camera = CreateObject(GetHashKey(item.nom), item.x, item.y, item.z, false, true, false)
        SetObjectTargettable(camera, true)
    	SetEntityInvincible(camera, true)
    	SetBlockingOfNonTemporaryEvents(camera, false)
    	FreezeEntityPosition(camera, true)
    	SetEntityHeading(camera, item.h)
  	end
  end

end)

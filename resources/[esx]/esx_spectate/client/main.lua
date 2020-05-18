ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Wait(0)
	end
end)

local InSpectatorMode	= false
local TargetSpectate	= nil
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			= -3.5;
local cam 				= nil
local PlayerDate		= {}
local ShowInfos			= false
local group

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
	-- convert degrees to radians
	local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}

	return pos
end

function spectate(target)
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Wait(0)
	end
	NetworkSetInSpectatorMode(false, 0)
	NetworkSetInSpectatorMode(true, GetPlayerPed(GetPlayerFromServerId(target)))
	DoScreenFadeIn(500)
	InSpectatorMode = true
	TargetSpectate = target
end

function resetNormalCamera()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Wait(0)
	end
	NetworkSetInSpectatorMode(false, 0)
	DoScreenFadeIn(500)
	InSpectatorMode = false
	TargetSpectate = nil
end

function getPlayersList()

	local players = ESX.Game.GetPlayers()
	local data = {}

	for i=1, #players, 1 do

		local _data = {
			id = GetPlayerServerId(players[i]),
			name = GetPlayerName(players[i])
		}
		table.insert(data, _data)
	end

	return data
end

function OpenAdminActionMenu(player)

    ESX.TriggerServerCallback('esx_spectate:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil
	  local Money		= 0
	  local Bank		= 0
	  local blackMoney	= 0
	  local Inventory	= nil
	  
    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

	  if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Lavoro : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Lavoro : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Uomo'
        else
          sex = 'Donna'
        end
        sexLabel = 'Sesso : ' .. sex
      else
        sexLabel = 'Sesso : Sconosciuto'
      end
	  
	  if data.money ~= nil then
		Money = data.money
		else
		Money = 'No Data'
	  end

 	  if data.bank ~= nil then
		Bank = data.bank
		else
		Bank = 'No Data'
	  end
	  
      if data.dob ~= nil then
        dobLabel = 'DDN : ' .. data.dob
      else
        dobLabel = 'DDN : Sconosciuto'
      end

      if data.height ~= nil then
        heightLabel = 'Altezza : ' .. data.height
      else
        heightLabel = 'Altezza : Sconosciuto'
      end

      if data.name ~= nil then
        idLabel = 'Steam ID : ' .. data.name
      else
        idLabel = 'Steam ID : Sconosciuto'
      end
	  
      local elements = {
        {label = 'Nome: ' .. data.firstname .. " " .. data.lastname, value = nil},
        {label = 'Soldi: '.. data.money, value = nil},
        {label = 'Banca: '.. data.bank, value = nil},
        {label = 'Soldi Sporchi: '.. blackMoney, value = nil, itemType = 'item_account', amount = blackMoney},
		{label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
    }
	
    table.insert(elements, {label = '--- Inventario ---', value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = data.inventory[i].label .. ' x ' .. data.inventory[i].count,
          value          = nil,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end
	
    table.insert(elements, {label = '--- Armi ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = ESX.GetWeaponLabel(data.weapons[i].name),
        value          = nil,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end
      if data.licenses ~= nil then

        table.insert(elements, {label = '--- License ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = 'Controllo Player',
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		
		if IsControlJustReleased(1, 163) then
			print('triggered')
			if group ~= "user" then
				TriggerEvent('esx_spectate:spectate')
			end
		end
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	print('group setted ' .. g)
	group = g
end)

RegisterNetEvent('esx_spectate:spectate')
AddEventHandler('esx_spectate:spectate', function()

	SetNuiFocus(true, true)

	SendNUIMessage({
		type = 'show',
		data = getPlayersList(),
		player = GetPlayerServerId(PlayerId())
	})

end)

RegisterNUICallback('select', function(data, cb)
	print("select UI " .. json.encode(data))
	TriggerServerEvent('esx_rich_discord:spectatePersona', data.id)
	spectate(data.id)
	SetNuiFocus(false)
end)

RegisterNUICallback('close', function(data, cb)
	print("closing UI")
	SetNuiFocus(false)
end)

RegisterNUICallback('quit', function(data, cb)
	SetNuiFocus(false)
	resetNormalCamera()
end)

RegisterNUICallback('kick', function(data, cb)
	SetNuiFocus(false)
	TriggerServerEvent('esx_spectate:kick', data.id, data.reason)
	TriggerEvent('esx_spectate:spectate')
end)

Citizen.CreateThread(function()
  	while true do

		Citizen.Wait(1)

		if InSpectatorMode then

			local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
			local playerPed	  = GetPlayerPed(-1)
			local targetPed	  = GetPlayerPed(targetPlayerId)

			if IsControlPressed(2, 47) then
				OpenAdminActionMenu(targetPlayerId)
			end

			local text = {}
			local targetGod = GetPlayerInvincible(targetPlayerId)
			if targetGod then
				table.insert(text,"Godmode: ~r~Trovata~w~")
			else
				table.insert(text,"Godmode: ~g~Non trovata~w~")
			end
			if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
				table.insert(text,"~r~Anti-Ragdoll~w~")
			end

			table.insert(text,"Vita"..": "..GetEntityHealth(targetPed).."/"..GetEntityMaxHealth(targetPed))
			table.insert(text,"Armatura"..": "..GetPedArmour(targetPed))

			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end 
		end

  	end
end)
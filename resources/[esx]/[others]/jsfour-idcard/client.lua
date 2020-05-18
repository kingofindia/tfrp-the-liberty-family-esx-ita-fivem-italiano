local open = false
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

local Vehicle = GetVehiclePedIsIn(ped, false)
local inVehicle = IsPedSittingInAnyVehicle(ped)
local lastCar = nil
local lastCar = 0
local IsHandcuffed            = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--RegisterNetEvent('ciao:macchina')
--AddEventHandler('ciao:macchina', function()
    --doToggleEngine()
--end)

local weaponStealeableList = {453432689}
	for i=1, #weaponStealeableList do
		if GetCurrentPedWeapon(GetPlayerPed(-1), weaponStealeableList[i], false) then
				haveWeapon = true
		end
	end

	if(haveWeapon)then
	TriggerServerEvent('esx_holdup:rob', k)
	end

-----------------------------------------------------------------------------------------------

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
          sex = 'Male'
        else
          sex = 'Female'
        end
        sexLabel = 'Sex : ' .. sex
      else
        sexLabel = 'Sex : Unknown'
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
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : Unknown'
      end

      if data.height ~= nil then
        heightLabel = 'Height : ' .. data.height
      else
        heightLabel = 'Height : Unknown'
      end

      if data.name ~= nil then
        idLabel = 'Steam ID : ' .. data.name
      else
        idLabel = 'Steam ID : Unknown'
      end
	  
      local elements = {
        {label = 'Nome: ' .. data.firstname .. " " .. data.lastname, value = nil},
        {label = 'Contanti: '.. data.money, value = nil},
        {label = 'Banca: '.. data.bank, value = nil},
        {label = 'Soldi sporchi: '.. blackMoney, value = nil, itemType = 'item_account', amount = blackMoney},
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

        table.insert(elements, {label = '--- Licenze ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = 'Player Control',
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

-------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('macchina:blocca')
AddEventHandler('macchina:blocca', function()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	lockStatus = GetVehicleDoorLockStatus(vehicle)
	lockStatusOutside = GetVehicleDoorLockStatus(lastCar)
	if vehicle ~= nil and vehicle ~= 0 then
		if GetPedInVehicleSeat(vehicle, 0) then
			if lockStatus == 0 or lockStatus == 1 then
				SetVehicleDoorsLocked(vehicle, 2)
				SetVehicleDoorsLockedForPlayer(lastCar, PlayerId(), false)
				ESX.ShowNotification('Veicolo chiuso.')
				lastCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			elseif lockStatus == 2 then
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ESX.ShowNotification('Veicolo aperto.')
				lastCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			end
		else
			ESX.ShowNotification('Devi essere alla guida del veicolo.')
		end
	elseif vehicle == 0 and lastCar ~= 0 then
		if lockStatusOutside == 0 or lockStatusOutside == 1 then
			SetVehicleDoorsLocked(lastCar, 2)
			SetVehicleDoorsLockedForPlayer(lastCar, PlayerId(), false)
			ESX.ShowNotification('Veicolo chiuso.')
		elseif lockStatusOutside == 2 then
			SetVehicleDoorsLocked(lastCar, 1)
			SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			ESX.ShowNotification('Veicolo aperto.')
		else
			ESX.ShowNotification('Nessun veicolo.')
		end
	else
		ESX.ShowNotification('Devi essere dentro il veicolo.')
	end
end)

RegisterNetEvent('macchina:portiere')
AddEventHandler('macchina:portiere', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then 
			SetVehicleDoorShut(vehicle, 0, false)
			SetVehicleDoorShut(vehicle, 1, false)
			SetVehicleDoorShut(vehicle, 2, false)	
			SetVehicleDoorShut(vehicle, 3, false)	
			SetVehicleDoorShut(vehicle, 4, false)	
			SetVehicleDoorShut(vehicle, 5, false)				
		else
			SetVehicleDoorOpen(vehicle, 0, false) 
			SetVehicleDoorOpen(vehicle, 1, false)   
			SetVehicleDoorOpen(vehicle, 2, false)   
			SetVehicleDoorOpen(vehicle, 3, false)   
			SetVehicleDoorOpen(vehicle, 4, false)   
			SetVehicleDoorOpen(vehicle, 5, false)               
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
    end
end)

RegisterNetEvent('macchina:spas')
AddEventHandler('macchina:spas', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		local frontLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'door_dside_f')
		if frontLeftDoor ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then 
				SetVehicleDoorShut(vehicle, 0, false)            
			else
				SetVehicleDoorOpen(vehicle, 0, false)             
			end
		else
			ESX.ShowNotification('Questo veicolo non ha lo sportello anteriore sinistro.')
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
    end
end)

RegisterNetEvent('macchina:spad')
AddEventHandler('macchina:spad', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		local frontRightDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'door_pside_f')
		if frontRightDoor ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 then 
				SetVehicleDoorShut(vehicle, 1, false)            
			else
				SetVehicleDoorOpen(vehicle, 1, false)             
			end
		else
			ESX.ShowNotification('Questo veicolo non ha lo sportello anteriore destro.')
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
    end
end)

RegisterNetEvent('macchina:spps')
AddEventHandler('macchina:spps', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		local rearLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'door_dside_r')
		if rearLeftDoor ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 then 
				SetVehicleDoorShut(vehicle, 2, false)            
			else
				SetVehicleDoorOpen(vehicle, 2, false)             
			end
		else
			ESX.ShowNotification('Questo veicolo non ha lo sportello posteriore sinistro.')
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
    end
end)

RegisterNetEvent('macchina:sppd')
AddEventHandler('macchina:sppd', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		local rearRightDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'door_pside_r')
		if rearRightDoor ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 then 
				SetVehicleDoorShut(vehicle, 3, false)            
			else
				SetVehicleDoorOpen(vehicle, 3, false)             
			end
		else
			ESX.ShowNotification('Questo veicolo non ha lo sportello posteriore destro.')
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
    end
end)

RegisterNetEvent('macchina:hood')
AddEventHandler('macchina:hood', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		local bonnet = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'bonnet')
		if bonnet ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 4) > 0.0 then 
				SetVehicleDoorShut(vehicle, 4, false)            
			else
				SetVehicleDoorOpen(vehicle, 4, false)             
			end
		else
			ESX.ShowNotification('Questo veicolo non ha il cofano.')
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
	end
end)

RegisterNetEvent('macchina:trunk')
AddEventHandler('macchina:trunk', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
		local boot = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'boot')
		if boot ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 5) > 0.0 then 
				SetVehicleDoorShut(vehicle, 5, false)            
			else
				SetVehicleDoorOpen(vehicle, 5, false)             
			end
		else
			ESX.ShowNotification('Questo veicolo non ha un cofano.')
		end
	else
		ESX.ShowNotification('Devi essere alla guida del veicolo.')
    end
end)

function doToggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 then
		if GetPedInVehicleSeat(vehicle, 0) then
			if IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
				SetVehicleEngineOn(vehicle, false, false, true)
				ESX.ShowNotification('Motore spento.')
			else
				SetVehicleEngineOn(vehicle, true, false, true)
				ESX.ShowNotification('Motore acceso.')
			end
		else
			ESX.ShowNotification('Devi essere alla guida di un veicolo.')
		end
	else
		ESX.ShowNotification('Devi essere in un veicolo.')
    end
end

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

function openMenu()
	ESX.UI.Menu.Open(
	  	'default', GetCurrentResourceName(), 'azioni_menu',
	  	{
		  --css = 'documenti',
			title    = 'Menu',
			align    = 'top-left',
		  	elements = {
				{label = '🛍️ Inventario', value = 'inventario'},
				{label = '👛 Portafoglio', value = 'pfoglio'},
			  	{label = '🌐 Azioni', value = 'azioni'},
			  	{label = '💶 Fatture', value = 'fatture'},
				{label = '🙂 Animazioni', value = 'animazioni'},
				{label = '🔋 Dispositivi Elettronici', value = 'dispele'},
			  	{label = '🐕‍ Animale', value = 'animale'},
				{label = '🏎️ Veicolo', value = 'veicolo'},
				{label = '🚘 Macchinetta Telecomandata', value = 'rcar'},
				{label = '💪 Palestra', value = 'gym'}
				--{label = '💼 Lavori online', value = 'lavorionline'}
				--{label = 'TEST TABLET', value = 'tablet'},
		  	}
	  	},
	  	function(data, menu)
			local val = data.current.value

			if val == 'inventario' then
				menu.close()
				TriggerEvent('ciao:porcamadonna')
		  	elseif val == 'pfoglio' then
		  		TriggerEvent("wallet:open")
		  	elseif val == 'fatture' then
				TriggerEvent('ciao:hello')
			elseif val == 'animazioni' then
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'animazioni_menu',
					{
						title = "🙂 Animazioni",
						align = 'top-left',
						elements = {
							{label = 'Menu 1', value = 'number1'},
							{label = 'Menu 2', value = 'number2'}
						}
					}, function(data2, menu)
						local opzione = data2.current.value

						if opzione == 'number1' then
							TriggerEvent('ciao:porcodio')
						elseif opzione == 'number2' then
							ESX.UI.Menu.CloseAll()
							TriggerEvent('animations:open')
						end
					end, function(data2, menu)
						menu.close()
					end
				)
		  	elseif val == 'animale' then
				TriggerEvent('ciao:animals')
	    	elseif val == 'azioni' then
				openSubMenu()
		  	elseif val == 'veicolo' then
				openVehMenu()
			elseif val == 'dispele' then
				openDispMenu()
			elseif val == 'gym' then
				TriggerEvent('esx_rich_skill:ForceOpen')
			elseif val == 'rcar' then
				TriggerEvent('esx_rich_rc:OpenMenu')
		  	end
	  	end,
	  	function(data, menu)
		 	menu.close()
	  	end
  	)
end

function openDispMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'disp_menu',
		{
			title 	 = 'Dispositivi Elettronici',
			align    = 'top-left',
			elements = {
				{label = '📱 Cellulare', value = 'telefono'},
				{label = '💻 Tablet', value = 'tablet'},
			}
		},
		function(data8, menu)

			if data8.current.value == 'telefono' then
				--menu.close()
				ESX.UI.Menu.CloseAll()
				TriggerEvent('esx_rich_gcphone:OpenForce')
			elseif data8.current.value == 'tablet' then
				--menu.close()
				ESX.UI.Menu.CloseAll()
				TriggerEvent('esx_rich_tablet:tretheri')
			end
		end,
		function (data, menu)
			menu.close()
		end
	)
	end

  function openVehMenu()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'veicoli_menu',
	  {
		  --css = 'documenti',
			title    = 'Veicolo',
			align    = 'top-left',
		  elements = {
			  --{label = 'Informazioni Veicolo Vicino', value = 'vehicleinfo'},
			  {label = 'Accendi/Spegni motore', value = 'onoff'},
			  {label = 'Cambia posto', value = 'changeseat'},
			  {label = 'Accendi/Spengi neon', value = 'onoffneon'},
			  {label = 'Blocca/sblocca veicolo', value = 'lock'},
			  {label = 'Apri/chiudi portiere', value = 'doors'},
			  {label = 'Apri/chiudi sportello anteriore sinistro', value = 'spas'},
			  {label = 'Apri/chiudi sportello anteriore destro', value = 'spad'},
			  {label = 'Apri/chiudi sportello posteriore sinistro', value = 'spps'},
			  {label = 'Apri/chiudi sportello posteriore destro', value = 'sppd'},
			  {label = 'Apri/chiudi cofano', value = 'hood'},
			  {label = 'Apri/chiudi portabagagli', value = 'trunk'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'onoff' then
			doToggleEngine()
		  elseif val == 'changeseat' then
			TriggerEvent("SeatShuffle")
		  elseif val == 'vehicleinfo' then
			TriggerEvent('esx_rich_info:informazioni')
		  elseif val == 'onoffneon' then
			onoffneonstart()
		  elseif val == 'lock' then
			TriggerEvent('macchina:blocca')
		  elseif val == 'doors' then
			TriggerEvent('macchina:portiere')
		  elseif val == 'spas' then
			TriggerEvent('macchina:spas')
		  elseif val == 'spad' then
			TriggerEvent('macchina:spad')
		  elseif val == 'spps' then
			TriggerEvent('macchina:spps')
		  elseif val == 'sppd' then
			TriggerEvent('macchina:sppd')
		  elseif val == 'trunk' then
			TriggerEvent('macchina:trunk')
		  elseif val == 'hood' then
			TriggerEvent('macchina:hood')
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
	end
	
	local weaponStealeableList = {453432689}
		for i=1, #weaponStealeableList do
			if GetCurrentPedWeapon(GetPlayerPed(-1), weaponStealeableList[i], false) then
					haveWeapon = true
			end
		end


local isOn	=	false

function onoffneonstart()
	local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--left
        if isOn then
            SetVehicleNeonLightEnabled(veh, 0, false)
            SetVehicleNeonLightEnabled(veh, 1, false)
            SetVehicleNeonLightEnabled(veh, 2, false)
            SetVehicleNeonLightEnabled(veh, 3, false)
			
			isOn = false
        else
            SetVehicleNeonLightEnabled(veh, 0, true)
            SetVehicleNeonLightEnabled(veh, 1, true)
            SetVehicleNeonLightEnabled(veh, 2, true)
            SetVehicleNeonLightEnabled(veh, 3, true)
			
			isOn = true
        end
    end
end

function openSubMenu()

	local elements = {
		{label = 'Ammanetta/togli manette', value = 'manette'},
		{label = 'Perquisisci', value = 'perquisizione'},
		{label = 'Saccheggia giocatore morto', value = 'loot'},
		{label = 'Accessori', value = 'accessori'},
		{label = 'Prendi in braccio', value = 'lift'},
		{label = 'Spogliati', value = 'spogliatis'},
	}

	haveWeapon = false
	haveWeapon2 = false
	haveWeapon3 = false
	haveWeapon4 = false
	haveWeapon5 = false
	haveWeapon6 = false
	haveWeapon7 = false
	--hasRope			= false
	--hasUsedRope = false

	local bannedWeapons = {

		"WEAPON_PISTOL"
		}
		for i = 1, #bannedWeapons do
			local weapon_t = bannedWeapons[i]
			local weapon = GetHashKey(weapon_t)
			if HasPedGotWeapon(PlayerPedId(), weapon, false) then
				table.insert(elements, {label = 'Smonta Pistola', value = 'immagazzinapistola'})
				table.insert(elements, {label = 'Smonta Munizioni Pistola', value = 'immagazzinamunizionipistola'})
			end
		end
		
		local bannedWeapons2 = {

			"WEAPON_ASSAULTRIFLE"
			}
			for i = 1, #bannedWeapons2 do
				local weapon_t2 = bannedWeapons2[i]
				local weapon2 = GetHashKey(weapon_t2)
				if HasPedGotWeapon(PlayerPedId(), weapon2, false) then
					table.insert(elements, {label = 'Smonta AK', value = 'immagazzinaak'})
				end
			end
			
			local bannedWeapons3 = {

				"WEAPON_KNIFE"
				}
				for i = 1, #bannedWeapons3 do
					local weapon_t3 = bannedWeapons3[i]
					local weapon3 = GetHashKey(weapon_t3)
					if HasPedGotWeapon(PlayerPedId(), weapon3, false) then
						table.insert(elements, {label = 'Smonta Coltello', value = 'immagazzinacoltello'})
					end
				end

				local bannedWeapons4 = {

					"WEAPON_BAT"
					}
					for i = 1, #bannedWeapons4 do
						local weapon_t4 = bannedWeapons4[i]
						local weapon4 = GetHashKey(weapon_t4)
						if HasPedGotWeapon(PlayerPedId(), weapon4, false) then
							table.insert(elements, {label = 'Smonta Mazza', value = 'immagazzinamazza'})
						end
					end

					local bannedWeapons5 = {

						"WEAPON_PUMPSHOTGUN"
						}
						for i = 1, #bannedWeapons5 do
							local weapon_t5 = bannedWeapons5[i]
							local weapon5 = GetHashKey(weapon_t5)
							if HasPedGotWeapon(PlayerPedId(), weapon5, false) then
								table.insert(elements, {label = 'Smonta Fucile a pompa', value = 'immagazzinapompa'})
								table.insert(elements, {label = 'Smonta munizioni Fucile a pompa', value = 'immagazzinamunizionipompa'})
							end
						end

						local bannedWeapons6 = {

							"WEAPON_SMOKEGRENADE"
							}
							for i = 1, #bannedWeapons6 do
								local weapon_t6 = bannedWeapons6[i]
								local weapon6 = GetHashKey(weapon_t6)
								if HasPedGotWeapon(PlayerPedId(), weapon6, false) then
									table.insert(elements, {label = 'Smonta granata a gas', value = 'immagazzinagas'})
								end
							end

							local bannedWeapons7 = {

								"WEAPON_MICROSMG"
								}
								for i = 1, #bannedWeapons7 do
									local weapon_t7 = bannedWeapons7[i]
									local weapon7 = GetHashKey(weapon_t7)
									if HasPedGotWeapon(PlayerPedId(), weapon7, false) then
										table.insert(elements, {label = 'Smonta Micro SMG', value = 'immagazzinauzi'})
									end
								end

								local bannedWeapons8 = {

									"WEAPON_FLASHLIGHT"
									}
									for i = 1, #bannedWeapons8 do
										local weapon_t8 = bannedWeapons8[i]
										local weapon8 = GetHashKey(weapon_t8)
										if HasPedGotWeapon(PlayerPedId(), weapon8, false) then
											table.insert(elements, {label = 'Smonta Torcia', value = 'immagazzinatorcia'})
										end
									end

									local bannedWeapons9 = {

										"WEAPON_PETROLCAN"
										}
										for i = 1, #bannedWeapons9 do
											local weapon_t9 = bannedWeapons9[i]
											local weapon9 = GetHashKey(weapon_t9)
											if HasPedGotWeapon(PlayerPedId(), weapon9, false) then
												table.insert(elements, {label = 'Smonta Tanica di benzina', value = 'immagazzinatanica'})
											end
										end

										local bannedWeapons10 = {

											"WEAPON_SMG"
											}
											for i = 1, #bannedWeapons10 do
												local weapon_t10 = bannedWeapons10[i]
												local weapon10 = GetHashKey(weapon_t10)
												if HasPedGotWeapon(PlayerPedId(), weapon10, false) then
													table.insert(elements, {label = 'Smonta SMG', value = 'immagazzinasmg'})
													table.insert(elements, {label = 'Smonta munizioni SMG', value = 'immagazzinamunizionismg'})
												end
											end

											local bannedWeapons11 = {

												"WEAPON_CARBINERIFLE"
												}
												for i = 1, #bannedWeapons11 do
													local weapon_t11 = bannedWeapons11[i]
													local weapon11 = GetHashKey(weapon_t11)
													if HasPedGotWeapon(PlayerPedId(), weapon11, false) then
														table.insert(elements, {label = 'Smonta Carabina', value = 'immagazzinacarabina'})
													end
												end

												local bannedWeapons12 = {

													"WEAPON_MARKSMANRIFLE"
													}
													for i = 1, #bannedWeapons12 do
														local weapon_t12 = bannedWeapons12[i]
														local weapon12 = GetHashKey(weapon_t12)
														if HasPedGotWeapon(PlayerPedId(), weapon12, false) then
															table.insert(elements, {label = 'Smonta Fucile da precisione', value = 'immagazzinacecchino'})
														end
													end

													local bannedWeapons13 = {

														"WEAPON_NIGHTSTICK"
														}
														for i = 1, #bannedWeapons13 do
															local weapon_t13 = bannedWeapons13[i]
															local weapon13 = GetHashKey(weapon_t13)
															if HasPedGotWeapon(PlayerPedId(), weapon13, false) then
																table.insert(elements, {label = 'Smonta manganello', value = 'immagazzinamanganello'})
															end
														end

														local bannedWeapons14 = {

															"WEAPON_COMBATPISTOL"
															}
															for i = 1, #bannedWeapons14 do
																local weapon_t14 = bannedWeapons14[i]
																local weapon14 = GetHashKey(weapon_t14)
																if HasPedGotWeapon(PlayerPedId(), weapon14, false) then
																	table.insert(elements, {label = 'Smonta pistola da combattimento', value = 'immagazzinacombattimento'})
																	table.insert(elements, {label = 'Smonta munizioni Pistola da combattimento', value = 'immagazzinamunizionicom'})
																end
															end

															local bannedWeapons15 = {

																"WEAPON_STUNGUN"
																}
																for i = 1, #bannedWeapons15 do
																	local weapon_t15 = bannedWeapons15[i]
																	local weapon15 = GetHashKey(weapon_t15)
																	if HasPedGotWeapon(PlayerPedId(), weapon15, false) then
																		table.insert(elements, {label = 'Smonta storditore', value = 'immagazzinastorditore'})
																	end
																end

																local bannedWeapons16 = {

																	"WEAPON_BZGAS"
																	}
																	for i = 1, #bannedWeapons16 do
																		local weapon_t16 = bannedWeapons16[i]
																		local weapon16 = GetHashKey(weapon_t16)
																		if HasPedGotWeapon(PlayerPedId(), weapon16, false) then
																			table.insert(elements, {label = 'Smonta granata a gas', value = 'immagazzinagasdue'})
																		end
																	end
	
	


	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		--css = 'documenti',
		align = 'top-left',
		title    = 'Azioni',
		elements = elements
	},
	function(data, menu)
		local val = data.current.value
		
	if val == 'accessori' then
		TriggerEvent('ciao:accessori')
	elseif val == 'loot' then
		TriggerEvent('esx_rich_loot:Check')
	elseif val == 'lift' then
		TriggerEvent('esx_barbie_lyftupp')
	elseif val == 'spogliatis' then
		TriggerEvent('ciao:spogliati')
		elseif val == 'immagazzinapistola' then
			menu.close()
			Citizen.Wait(500)
			local playerPed  = PlayerPedId()
      local weaponHash = GetHashKey("WEAPON_PISTOL")
      local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
			TriggerServerEvent('jsfour-idcard:pistola', pedAmmo)
		elseif val == 'immagazzinamunizionipistola' then
		menu.close()
		MunPis()
		elseif val == 'immagazzinaak' then
			menu.close()
			Citizen.Wait(500)
			local playerPed = PlayerPedId()
			local weaponHash91 = GetHashKey("WEAPON_ASSAULTRIFLE")
      		local pedAmmo91 = GetAmmoInPedWeapon(playerPed, weaponHash91)
			TriggerServerEvent('jsfour-idcard:ak', pedAmmo91)
		elseif val == 'immagazzinacoltello' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:coltello', source)
		elseif val == 'immagazzinamazza' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:mazza', source)
		elseif val == 'immagazzinapompa' then
		  menu.close()
		  Citizen.Wait(500)
		  local playerPed  = PlayerPedId()
		  local weaponHash2 = GetHashKey("WEAPON_PUMPSHOTGUN")
		  local pedAmmo2 = GetAmmoInPedWeapon(playerPed, weaponHash2)
		TriggerServerEvent('jsfour-idcard:pompa', pedAmmo2)
		elseif val == 'immagazzinamunizionipompa' then
		  menu.close()
		  MunPom()
		elseif val == 'immagazzinagas' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:gas', source)
		elseif val == 'immagazzinauzi' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:uzi', source)
		elseif val == 'immagazzinatorcia' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:torcia', source)
		elseif val == 'immagazzinatanica' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:tanica', source)
		elseif val == 'immagazzinasmg' then
			menu.close()
			Citizen.Wait(500)
			local playerPed  = PlayerPedId()
      local weaponHash3 = GetHashKey("WEAPON_SMG")
      local pedAmmo3 = GetAmmoInPedWeapon(playerPed, weaponHash3)
			TriggerServerEvent('jsfour-idcard:smg', pedAmmo3)
		elseif val == 'immagazzinamunizionismg' then
		  menu.close()
		  MunSmg()
		elseif val == 'immagazzinacarabina' then
			menu.close()
			Citizen.Wait(500)
			local PlayerPed16 = PlayerPedId()
			local weaponHash16 = GetHashKey('WEAPON_CARBINERIFLE')
			local pedAmmo16 = GetAmmoInPedWeapon(PlayerPed16, weaponHash16)
			TriggerServerEvent('jsfour-idcard:carabina', pedAmmo16)
		elseif val == 'immagazzinacecchino' then
			menu.close()
			Citizen.Wait(500)
			local playerPed = PlayerPedId()
			local weaponHash9 = GetHashKey("WEAPON_MARKSMANRIFLE") 
			local pedAmmo9 = GetAmmoInPedWeapon(playerPed, weaponHash9)
			TriggerServerEvent('jsfour-idcard:cecchino', pedAmmo9)
		elseif val == 'immagazzinamanganello' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:manganello', source)
		elseif val == 'immagazzinacombattimento' then
			menu.close()
			Citizen.Wait(500)
			local playerPed  = PlayerPedId()
      local weaponHash4 = GetHashKey("WEAPON_COMBATPISTOL")
      local pedAmmo4 = GetAmmoInPedWeapon(playerPed, weaponHash4)
			TriggerServerEvent('jsfour-idcard:combattimento', pedAmmo4)
		elseif val == 'immagazzinamunizionicom' then
		  menu.close()
		  MunCom()
		elseif val == 'immagazzinastorditore' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:storditore', source)
		elseif val == 'immagazzinagasdue' then
			menu.close()
			Citizen.Wait(500)
			TriggerServerEvent('jsfour-idcard:gasdue', source)
		else
			local player, distance = ESX.Game.GetClosestPlayer()
			

			if distance ~= -1 and distance <= 3.0 then
			  if val == 'perquisizione' then
					OpenAdminActionMenu(player)
					ESX.ShowNotification('Stai perquisendo una persona!')
					TriggerServerEvent('jsfour:message', GetPlayerServerId(player), ('Sei stato perquisito'))
				elseif val == 'manette' then
				  ESX.TriggerServerCallback('jsfour-idcard:getItemAmount', function(quantity)
				    if quantity > 0 then
					    TriggerServerEvent('jsfour-idcard:handcuff', GetPlayerServerId(player))
				    else
					    ESX.ShowNotification('Non hai le manette!')
				    end
			    end, 'manette')
				end
			else
			  ESX.ShowNotification('Nessuno nelle vicinanze')
			end
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end

local ped = PlayerPedId()
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")

RegisterNetEvent('jsfour-idcard:handcuff')
AddEventHandler('jsfour-idcard:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			if GetEntityModel(ped) == femaleHash then -- mp female
				prevFemaleVariation = GetPedDrawableVariation(ped, 7)
				SetPedComponentVariation(ped, 7, 25, 0, 0)
			  
			  elseif GetEntityModel(ped) == maleHash then -- mp male
				prevMaleVariation = GetPedDrawableVariation(ped, 7)
				SetPedComponentVariation(ped, 7, 41, 0, 0)
			  end

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)

		else

			if GetEntityModel(ped) == femaleHash then -- mp female
				SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
			  elseif GetEntityModel(ped) == maleHash then -- mp male
				SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
			  end
			
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			DisplayRadar(true)
		end
	end)

end)

RegisterNetEvent('jsfour-idcard:unrestrain')
AddEventHandler('jsfour-idcard:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		if GetEntityModel(ped) == femaleHash then -- mp female
			SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
		  elseif GetEntityModel(ped) == maleHash then -- mp male
			SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
		  end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DisplayRadar(true)

	end
end)

---------------------------------------------------------------------------------------------------------------------

function MunPis()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo = tonumber(data2.value)
		if Testo == nil then
			ESX.ShowNotification('Valore non valido')
		else
			TriggerEvent('jsfour-idcard:munizionipistola2', Testo)
			menu.close()
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('jsfour-idcard:munizionipistola2')
AddEventHandler('jsfour-idcard:munizionipistola2', function()
local playerPed  = PlayerPedId()
local weaponHash = GetHashKey("WEAPON_PISTOL")
local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
local finalAmmo = math.floor(pedAmmo - Testo)

  if pedAmmo >= Testo then
	SetPedAmmo(playerPed, weaponHash, finalAmmo)
	TriggerServerEvent('jsfour-idcard:munizionipistola', Testo)
else
	ESX.ShowNotification('Valore non valido')
end

end)

-----------------------------------------------------------------------------------------------------------------------------

function MunPom()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo2 = tonumber(data2.value)
		if Testo2 == nil then
			ESX.ShowNotification('Valore non valido')
		else
			TriggerEvent('jsfour-idcard:munizionipompa2', Testo2)
			menu.close()
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('jsfour-idcard:munizionipompa2')
AddEventHandler('jsfour-idcard:munizionipompa2', function()
local playerPed  = PlayerPedId()
local weaponHash2 = GetHashKey("WEAPON_PUMPSHOTGUN")
local pedAmmo2 = GetAmmoInPedWeapon(playerPed, weaponHash2)
local finalAmmo2 = math.floor(pedAmmo2 - Testo2)

  if pedAmmo2 >= Testo2 then
	SetPedAmmo(playerPed, weaponHash2, finalAmmo2)
	TriggerServerEvent('jsfour-idcard:munizionipompa', Testo2)
else
	ESX.ShowNotification('Valore non valido')
end

end)
----------------------------------------------------------------------------------------------------------------------------------------

function MunSmg()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo3 = tonumber(data2.value)
		if Testo3 == nil then
			ESX.ShowNotification('Valore non valido')
		else
			TriggerEvent('jsfour-idcard:munizionismg2', Testo3)
			menu.close()
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('jsfour-idcard:munizionismg2')
AddEventHandler('jsfour-idcard:munizionismg2', function()
local playerPed  = PlayerPedId()
local weaponHash3 = GetHashKey("WEAPON_SMG")
local pedAmmo3 = GetAmmoInPedWeapon(playerPed, weaponHash3)
local finalAmmo3 = math.floor(pedAmmo3 - Testo3)

  if pedAmmo3 >= Testo3 then
	SetPedAmmo(playerPed, weaponHash3, finalAmmo3)
	TriggerServerEvent('jsfour-idcard:munizionismg', Testo3)
else
	ESX.ShowNotification('Valore non valido')
end

end)

function MunCarabine()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo17 = tonumber(data2.value)
		if Testo17 == nil then
			ESX.ShowNotification('Valore non valido')
		else
			TriggerEvent('jsfour-idcard:munzinizdfsdsfcarab', Testo17)
			menu.close()
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('jsfour-idcard:munzinizdfsdsfcarab')
AddEventHandler('jsfour-idcard:munzinizdfsdsfcarab', function()
	local playerPed  = PlayerPedId()
	local weaponHash17 = GetHashKey("WEAPON_SMG")
	local pedAmmo17 = GetAmmoInPedWeapon(playerPed, weaponHash17)
	local finalAmmo17 = math.floor(pedAmmo17 - Testo17)

  	if pedAmmo17 >= Testo17 then
		SetPedAmmo(playerPed, weaponHash17, finalAmmo17)
		TriggerServerEvent('jsfour-idcard:munizionicarabinaspeciale', Testo17)
	else
		ESX.ShowNotification('Valore non valido')
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------

function MunCom()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'text_menu2', {
		title = 'Numero Munizioni',
	}, function (data2, menu)
		Testo4 = tonumber(data2.value)
		if Testo4 == nil then
			ESX.ShowNotification('Valore non valido')
		else
			TriggerEvent('jsfour-idcard:munizionicom2', Testo4)
			menu.close()
		end
		
	end, function (data2, menu)
		menu.close()
	end)
end

RegisterNetEvent('jsfour-idcard:munizionicom2')
AddEventHandler('jsfour-idcard:munizionicom2', function()
local playerPed  = PlayerPedId()
local weaponHash4 = GetHashKey("WEAPON_COMBATPISTOL")
local pedAmmo4 = GetAmmoInPedWeapon(playerPed, weaponHash4)
local finalAmmo4 = math.floor(pedAmmo4 - Testo4)

  if pedAmmo4 >= Testo4 then
	SetPedAmmo(playerPed, weaponHash4, finalAmmo4)
	TriggerServerEvent('jsfour-idcard:munizionicom', Testo4)
else
	ESX.ShowNotification('Valore non valido')
end

end)

-------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 166) then
          openMenu() 
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F5'], true) -- Menu
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0,21,true) -- disable sprint

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1730.414, 6416.267, 35.037, true) < 20.0 then
			    DrawMarker(32, 1730.414, 6416.267, 35.037, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1730.414, 6416.267, 35.037, true) < 1.0 then
					DisplayHelpText('Premi ~INPUT_PICKUP~ per acquistare le manette al prezzo di 20.000 dollari.')
					if IsControlJustReleased(1, 51) then
						ESX.TriggerServerCallback('jsfouridcard:haisoldi', function(celiha)
						  if celiha then
								TriggerServerEvent('jsfour-idcard:compramanette')
              				else
								ESX.ShowNotification('Non hai abbastanza soldi')
							end
						end)
					end
			  end
		  end
	end
end)
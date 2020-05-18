ESX                         = nil
inMenu                      = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function hasPhone2 (cb)
  cb(true)
end

function ShowNoPhoneWarning2 ()
end

function hasPhone2 (cb)
	if (ESX == nil) then return cb(0) end
	ESX.TriggerServerCallback('esx_rich_tablet:ForceOpenTablet', function(qtty)
		cb(qtty > 0)
	end, 'tablet')
end

function ShowNoPhoneWarning2 ()
	if (ESX == nil) then return end
	ESX.ShowNotification("Non hai il ~r~tablet~s~")
end

Tablet = function(boolean)
	if boolean then
		LoadModels({ GetHashKey("prop_cs_tablet") })

		TabletEntity = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(PlayerPedId()), true)

		AttachEntityToEntity(TabletEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	
		LoadModels({ "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a" })
	
		TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	
		Citizen.CreateThread(function()
			while DoesEntityExist(TabletEntity) do
				Citizen.Wait(5)
	
				if not IsEntityPlayingAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3) then
					TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
			end

			ClearPedTasks(PlayerPedId())
		end)
	else
		DeleteEntity(TabletEntity)
	end
end

LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		if not CachedModels then
			CachedModels = {}
		end

		table.insert(CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

UnloadModels = function()
	for modelIndex = 1, #CachedModels do
		local model = CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 322) then
			if inMenu then
				CloseTablet()
			end
		end
	end
end)

RegisterNetEvent('esx_rich_tablet:tretheri')
AddEventHandler('esx_rich_tablet:tretheri', function()
	hasPhone2(function (hasPhone2)
		if hasPhone2 == true then
			OpenTablet()
		else
			ShowNoPhoneWarning2()
		end
	end)
end)

function CloseTablet()
	inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'close'})
    Tablet(false)
	ClearPedTasks(PlayerPedId())
end

function OpenTablet()
	Tablet(true)
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
	TriggerServerEvent('bank:balance')
	local ped = GetPlayerPed
end

RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
end)

RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)

	SendNUIMessage({type = 'balanceReturn', bal = balance})

end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	
end)

RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false, false)
  SendNUIMessage({type = 'closeAll'})
  Tablet(false)
  ClearPedTasks(PlayerPedId())
end)

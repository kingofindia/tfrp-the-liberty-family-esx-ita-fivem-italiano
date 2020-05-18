local isTaking = false
local isProcessing = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('weed_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then
				ProcessWeed()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 1 then
			if not isTaking then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isTaking then
				ESX.TriggerServerCallback('esx_dex_vodka:canPickUp', function(canPickUp)
					if canPickUp then
						TakeWeed()
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end
				end, 'bottigliasp')
			end
		else
			Citizen.Wait(500)
		end

	end
end)

function ProcessWeed()
	isProcessing = true

	ESX.ShowNotification(_U('weed_processingstarted'))
	TriggerServerEvent('esx_dex_vodka:processCannabis')
	local timeLeft = Config.Delays.WeedProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('weed_processingtoofar'))
			TriggerServerEvent('esx_dex_vodka:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

function TakeWeed()
	isTaking = true
	
	ESX.ShowNotification('Stai raccogliendo delle bottiglie di spumante')
	TriggerServerEvent('esx_dex_vodka:pickedUpCannabis')
	local timeLeft = Config.Delays.WeedTaking / 1000
	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedField.coords, false) > 4 then
			ESX.ShowNotification(_U('weed_processingtoofar'))
			FreezeEntityPosition(playerPed, false)
			--TriggerServerEvent('esx_dex_vodka:cancelProcessing')
			break
		end
	end

	FreezeEntityPosition(playerPed, false)
	isTaking = false
end


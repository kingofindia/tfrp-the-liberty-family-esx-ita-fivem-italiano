Keys = {
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
local PlayerData              = {}
InMenu = false
local display = false
---
Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
  end)
---
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

function isWeapon(item)
	local weaponList = ESX.GetWeaponList()
	for i=1, #weaponList, 1 do
		if weaponList[i].label == item then
			return true
		end
	end
	return false
end

local function craftItem(ingredients)
	local ingredientsPrepped = {}
	for name, count in pairs(ingredients) do
		if count > 0 then
			table.insert(ingredientsPrepped, { item = name , quantity = count})
		end
	end
	TriggerServerEvent('salty_crafting:craftItem', ingredientsPrepped)
end

RegisterNetEvent('salty_crafting:craft')
AddEventHandler('salty_crafting:craft', function (craftableScenario)
	TaskStartScenarioInPlace(GetPlayerPed(-1), craftableScenario, 0, true)
	--ESX.ShowNotification('~g~Elaborazione ~w~' .. craftableName)
end)

RegisterNetEvent('salty_crafting:stopCraft')
AddEventHandler('salty_crafting:stopCraft', function ()
	ClearPedTasks(GetPlayerPed(-1))
	--ESX.ShowNotification('~g~Elaborazione completata')
end)

RegisterNetEvent('salty_crafting:openMenu')
AddEventHandler('salty_crafting:openMenu', function(playerInventory)
	SetNuiFocus(true,true)
	local preppedInventory = {}
	for i=1, #playerInventory, 1 do
		if playerInventory[i].count > 0 and not isWeapon(playerInventory[i].label) then
			table.insert(preppedInventory, playerInventory[i])
		end
	end
	SendNUIMessage({
		inventory = preppedInventory,
		display = true
	})
	display = true
end)

RegisterNUICallback('craftItemNUI', function(data, cb)
	craftItem(data)
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		display = false
	})
	display = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
			DrawMarker(27, -462.548, -355.729, -187.46, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 127, 255, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -462.548, -355.729, -186.46, true) < 1.5 then
				if not InMenu then
					ESX.ShowHelpNotification('Premi ~INPUT_PICKUP~ per aprire il menu crafting')
				end
				if IsControlJustReleased(1, Keys['E']) then
					InMenu = true
					if PlayerData.job.grade == 3 or PlayerData.job.grade == 4  or PlayerData.job.grade == 5 then
						TriggerServerEvent('salty_crafting:getPlayerInventory')
					else
						TriggerEvent("pNotify:SendNotification",{
							text = 'Non puoi farlo!',
							type = "error",
							timeout = (7000),
							layout = "centerLeft",
							queue = "global"
						})
						InMenu = false
					end
				end
			else
				InMenu = false
			end
		end
	end
end)
--[[ 
RegisterNetEvent('esx_rich_crafting:notificaNoFarmaci')
AddEventHandler('esx_rich_crafting:notificaNoFarmaci', function()
	TriggerEvent("pNotify:SendNotification",{
		text = 'Nessun farmaco trovato con questi ingredienti!',
		type = "error",
		timeout = (7000),
		layout = "centerLeft",
		queue = "global"
	})
end)

RegisterNetEvent('esx_rich_crafting:InizioCrafting')
AddEventHandler('esx_rich_crafting:InizioCrafting', function()
	TriggerEvent("pNotify:SendNotification",{
		text = 'Stai creando il farmaco',
		type = "success",
		timeout = (7000),
		layout = "centerLeft",
		queue = "global"
	})
end)

RegisterNetEvent('esx_rich_crafting:MedicinaleCreato')
AddEventHandler('esx_rich_crafting:MedicinaleCreato', function()
	TriggerEvent("pNotify:SendNotification",{
		text = '~g~Farmaco creato',
		type = "success",
		timeout = (7000),
		layout = "centerLeft",
		queue = "global"
	})
end)

RegisterNetEvent('esx_rich_crafting:NoIngredienti')
AddEventHandler('esx_rich_crafting:NoIngredienti', function()
	TriggerEvent("pNotify:SendNotification",{
		text = 'Non hai abbastanza ingredienti!',
		type = "error",
		timeout = (7000),
		layout = "centerLeft",
		queue = "global"
	})
end)
 ]]
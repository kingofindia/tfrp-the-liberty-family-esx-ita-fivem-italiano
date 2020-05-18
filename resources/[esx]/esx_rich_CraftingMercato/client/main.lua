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
----------------------------------------------------------------------
---Debug
local trace = false
function dbg(msg)
	if trace then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^1[esx_mercatocrafting]: " .. tostring(msg))
	end
end

RegisterNetEvent('esx_mercatocrafting:craft')
AddEventHandler('esx_mercatocrafting:craft', function (craftableName, craftableScenario)
	TaskStartScenarioInPlace(GetPlayerPed(-1), craftableScenario, 0, true)
	ESX.ShowNotification('~g~Elaborazione ~w~' .. craftableName)
end)

RegisterNetEvent('esx_mercatocrafting:stopCraft')
AddEventHandler('esx_mercatocrafting:stopCraft', function ()
	ClearPedTasks(GetPlayerPed(-1))
	ESX.ShowNotification('~g~Elaborazione completata')
end)

function Discover(inventory)
	craftables = {}
	
	for i, j in pairs(Config.Craftables) do
		local matchCount = 0
		local canCraft = true
		local matchRequired = #j.Require
		for x = 1, #j.Require, 1 do
			for y = 1, #inventory, 1 do
				if (inventory[y].name == j.Require[x].Name) and (inventory[y].count >= j.Require[x].Amount) then
					matchCount = matchCount + 1
				elseif (inventory[y].name == j.Require[x].Name) and (inventory[y].count >= 1) then
					matchCount = matchCount + 1
					canCraft = false
				end
			end
		end
		if matchCount >= matchRequired then
			table.insert(craftables,{label = j.Label, value = j, flag = canCraft})
		end
	end
	table.insert(craftables, {label = "Esci", value = 'gtfo'})
	return craftables
end

function OpenCraftMenu()
	
	local ped = GetPlayerPed(-1)
	
	if IsPedInAnyVehicle(ped, false) then
		ESX.ShowNofication('~r~Azione impossibile')
		return
	elseif IsEntityDead(ped) then
		ESX.ShowNofication('~r~Azione impossibile')
		return
	end
	
	dbg("opening menu")
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
		
		local options = Discover(inventory.items)

		ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'craft_menu',
		  {
			title    = "Menu Crafting",
			align    = "top-left",
			elements = options
		  },
		  function(data, menu)
			if data.current.value ~= 'gtfo' and data.current.flag then
				TriggerServerEvent('esx_mercatocrafting:craftItem', data.current.value)
			elseif data.current.value ~= 'gtfo' and not data.current.flag then
				ESX.ShowNotification('~r~Non hai abbastanza elementi')
			end
			menu.close()
		  end,
		  function(data, menu)
			menu.close()
		  end
		)

	end)
end

Citizen.CreateThread(function ()
	if Config.EnableHotkey then
		while true do
			Citizen.Wait(0)
			if IsControlPressed(0, 170) and PlayerData.job ~= nil and PlayerData.job.name == 'mercato' then 
				OpenCraftMenu()
			end
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
end)

function openCraftMenu()
	OpenCraftMenu()
end






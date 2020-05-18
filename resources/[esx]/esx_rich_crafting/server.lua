ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('salty_crafting:getPlayerInventory')
AddEventHandler('salty_crafting:getPlayerInventory', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		TriggerClientEvent('salty_crafting:openMenu', _source, xPlayer.inventory)
	end
end)

function findRecipe(list)
	for item, ingredients in pairs(Config.Recipes) do
		if #ingredients == #list then
			-- same length, let's compare
			local found = 0
			for i=1, #ingredients, 1 do
				for j=1, #list, 1 do
					if ingredients[i].item == list[j].item and ingredients[i].quantity == list[j].quantity then
						found = found + 1
					end
				end
			end
			if found == #list then
				return item
			end
		end
	end
	return false
end

function hasAllIngredients(inventory, ingredients)
	for i=1, #ingredients, 1 do
		for j=1, #inventory, 1 do
			if ingredients[i].name == inventory[j].name then
				if inventory[j].count < ingredients[i].quantity then
					return false
				end
			end
		end
	end
	return true
end

function itemLabel(name, inventory)
	if string.match(string.lower(name), "weapon_") then
		return ESX.GetWeaponLabel(name)
	else
		for i=1, #inventory, 1 do
			if inventory[i].name == name then
				return inventory[i].label
			end
		end
	end
	return "unknown item"
end

RegisterServerEvent('salty_crafting:craftItem')
AddEventHandler('salty_crafting:craftItem', function(ingredients)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = findRecipe(ingredients)
	if not item then
		--TriggerClientEvent('esx_rich_crafting:notificaNoFarmaci')
		TriggerClientEvent("pNotify:SendNotification",{
			text = 'Nessun farmaco trovato con questi ingredienti!',
			type = "error",
			timeout = 7000,
			layout = "centerLeft",
			queue = "global"
		})
	else
		if xPlayer ~= nil then
			if hasAllIngredients(xPlayer.inventory, Config.Recipes[item]) then
				TriggerClientEvent('salty_crafting:craft', _source, Config.Scenario)
				--TriggerClientEvent('esx_rich_crafting:InizioCrafting')
				TriggerClientEvent("pNotify:SendNotification",{
					text = 'Stai creando il farmaco',
					type = "success",
					timeout = 7000,
					layout = "centerLeft",
					queue = "global"
				})
				for _,ingredient in pairs(Config.Recipes[item]) do
					if (ingredient.remove ~= nil and ingredient.remove) or (ingredient.remove == nil) then
						xPlayer.removeInventoryItem(ingredient.item, ingredient.quantity)
					end
				end

--				ESX.SetTimeout(Config.Time, function()
				Citizen.Wait(10000)
				if string.match(string.lower(item), "weapon_") then
					xPlayer.addWeapon(item, Config.WeaponAmmo)
				elseif item == 'medikit' then
					xPlayer.addInventoryItem(item, Config.Number1)
				elseif item == 'bandage' then
					xPlayer.addInventoryItem(item, Config.Number2)
				else
					xPlayer.addInventoryItem(item, 1)
				end
				TriggerClientEvent("pNotify:SendNotification",{
					text = '~g~Farmaco creato',
					type = "success",
					timeout = 7000,
					layout = "centerLeft",
					queue = "global"
				})
				--TriggerClientEvent('esx_rich_crafting:MedicinaleCreato')
				--TriggerClientEvent('esx:showNotification', _source, '~y~Item creato: ~w~' .. itemLabel(item, xPlayer.inventory))
				TriggerClientEvent('salty_crafting:stopCraft', _source)
--				end)
			else
				--TriggerClientEvent('esx:showNotification', _source, 'Non hai abbastanza ingredienti')
				--TriggerClientEvent('esx_rich_crafting:NoIngredienti')
				TriggerClientEvent("pNotify:SendNotification",{
					text = 'Non hai abbastanza ingredienti!',
					type = "error",
					timeout = 7000,
					layout = "centerLeft",
					queue = "global"
				})
			end
		end
	end
end)

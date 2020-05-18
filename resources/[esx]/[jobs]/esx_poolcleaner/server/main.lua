ESX                			 = nil
local PlayersSale			 = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_poolcleaner:GiveItem')
AddEventHandler('esx_poolcleaner:GiveItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local Quantity = xPlayer.getInventoryItem(Config.Zones.Sale.ItemRequires).count



	if Quantity >= 15 then
		
		TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
	else
		local amount = Config.Zones.Sale.ItemAdd
		local item = Config.Zones.Sale.ItemDb_name
		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('esx:showNotification', _source, 'Hai pultio la piscina.')
	end
end
)

local function Sale(source)

	SetTimeout(Config.Zones.Sale.ItemTime, function()

		if PlayersSale[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(Config.Zones.Sale.ItemRequires).count

			if Quantity < Config.Zones.Sale.ItemRemove then
				TriggerClientEvent('esx:showNotification', _source, 'Non hai '..Config.Zones.Sale.ItemRequires_name..' da incassare.')
				PlayersSale[_source] = false
			else
				local amount = Config.Zones.Sale.ItemRemove
				local item = Config.Zones.Sale.ItemRequires
				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(Config.Zones.Sale.ItemPrice)
				TriggerClientEvent('esx:showNotification', _source, 'Hai ricevuto ~g~$' .. Config.Zones.Sale.ItemPrice)
				Sale(_source)
			end

		end
	end)
end

RegisterServerEvent('esx_poolcleaner:startSale')
AddEventHandler('esx_poolcleaner:startSale', function()

	local _source = source

	if PlayersSale[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Esci e torna nell\'area!')
		PlayersSale[_source] = false
	else
		PlayersSale[_source] = true
		TriggerClientEvent('esx:showNotification', _source, 'Grazie - Sei stato pagato per il tuo lavoro!')
		Sale(_source)
	end
end)

RegisterServerEvent('esx_poolcleaner:stopSale')
AddEventHandler('esx_poolcleaner:stopSale', function()

	local _source = source

	if PlayersSale[_source] == true then
		PlayersSale[_source] = false
	else
		PlayersSale[_source] = true
	end
end)

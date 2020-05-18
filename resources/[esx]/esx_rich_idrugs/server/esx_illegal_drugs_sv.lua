ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingCoke    = {}
local PlayersTransformingCoke  = {}
local PlayersSellingCoke       = {}
local PlayersHarvestingMeth    = {}
local PlayersTransformingMeth  = {}
local PlayersSellingMeth       = {}
local PlayersHarvestingWeed    = {}
local PlayersTransformingWeed  = {}
local PlayersSellingWeed       = {}
local PlayersHarvestingOpium   = {}
local PlayersTransformingOpium = {}
local PlayersSellingOpium      = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

-------------------------------------------------------
-----------------------WEED----------------------------
-------------------------------------------------------
local function HarvestWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToFarmWeed, function()

		if PlayersHarvestingWeed[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local weed = xPlayer.getInventoryItem('lsd')

			if weed.limit ~= -1 and weed.count >= weed.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_weed'))
			else
				xPlayer.addInventoryItem('lsd', 1)
				HarvestWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startHarvestWeed')
AddEventHandler('esx_illegal_drugs:startHarvestWeed', function()

	local _source = source

	PlayersHarvestingWeed[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestWeed(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopHarvestWeed')
AddEventHandler('esx_illegal_drugs:stopHarvestWeed', function()

	local _source = source

	PlayersHarvestingWeed[_source] = false

end)

local function TransformWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToProcessWeed, function()

		if PlayersTransformingWeed[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)
			local weedQuantity = xPlayer.getInventoryItem('lsd').count
			local poochQuantity = xPlayer.getInventoryItem('lsdprocessato').count

			if poochQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif weedQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_weed'))
			else
				xPlayer.removeInventoryItem('lsd', 5)
				xPlayer.addInventoryItem('lsdprocessato', 1)
				
				TransformWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startTransformWeed')
AddEventHandler('esx_illegal_drugs:startTransformWeed', function()

	local _source = source

	PlayersTransformingWeed[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformWeed(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopTransformWeed')
AddEventHandler('esx_illegal_drugs:stopTransformWeed', function()

	local _source = source

	PlayersTransformingWeed[_source] = false

end)

local function SellWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToSellWeed, function()

		if PlayersSellingWeed[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('lsdprocessato').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_weed_sale'))
			else
				xPlayer.removeInventoryItem('lsdprocessato', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 1100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 1200)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
				elseif CopsConnected >= 4 then
					xPlayer.addAccountMoney('black_money', 1300)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 1400)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
                elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 1500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
                elseif CopsConnected >= 7 then
					xPlayer.addAccountMoney('black_money', 1600)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
                elseif CopsConnected >= 8 then
					xPlayer.addAccountMoney('black_money', 1700)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
                elseif CopsConnected >= 9 then
					xPlayer.addAccountMoney('black_money', 1800)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
                elseif CopsConnected >= 10 then
					xPlayer.addAccountMoney('black_money', 1900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))					
				end
				
				SellWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startSellWeed')
AddEventHandler('esx_illegal_drugs:startSellWeed', function()

	local _source = source

	PlayersSellingWeed[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellWeed(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopSellWeed')
AddEventHandler('esx_illegal_drugs:stopSellWeed', function()

	local _source = source

	PlayersSellingWeed[_source] = false

end)
-------------------------------------------------------
-----------------------WEED----------------------------
-------------------------------------------------------







-------------------------------------------------------
-----------------------OPIUM---------------------------
-------------------------------------------------------
local function HarvestOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToFarmOpium, function()

		if PlayersHarvestingOpium[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local opium = xPlayer.getInventoryItem('papavero')

			if opium.limit ~= -1 and opium.count >= opium.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_opium'))
			else
				xPlayer.addInventoryItem('papavero', 1)
				HarvestOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startHarvestOpium')
AddEventHandler('esx_illegal_drugs:startHarvestOpium', function()

	local _source = source

	PlayersHarvestingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestOpium(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopHarvestOpium')
AddEventHandler('esx_illegal_drugs:stopHarvestOpium', function()

	local _source = source

	PlayersHarvestingOpium[_source] = false

end)

local function TransformOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToProcessOpium, function()

		if PlayersTransformingOpium[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local opiumQuantity = xPlayer.getInventoryItem('papavero').count
			local poochQuantity = xPlayer.getInventoryItem('oppio').count

			if poochQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif opiumQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_opium'))
			else
				xPlayer.removeInventoryItem('papavero', 5)
				xPlayer.addInventoryItem('oppio', 1)
			
				TransformOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startTransformOpium')
AddEventHandler('esx_illegal_drugs:startTransformOpium', function()

	local _source = source

	PlayersTransformingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformOpium(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopTransformOpium')
AddEventHandler('esx_illegal_drugs:stopTransformOpium', function()

	local _source = source

	PlayersTransformingOpium[_source] = false

end)

local function SellOpium(source)

	if CopsConnected < Config.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsOpium))
		return
	end

	SetTimeout(Config.TimeToSellOpium, function()

		if PlayersSellingOpium[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('oppio').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_opium_sale'))
			else
				xPlayer.removeInventoryItem('oppio', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 1100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 1200)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 1300)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 1400)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
                elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 1500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
                elseif CopsConnected >= 7 then
					xPlayer.addAccountMoney('black_money', 1600)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
                elseif CopsConnected >= 8 then
					xPlayer.addAccountMoney('black_money', 1700)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
                elseif CopsConnected >= 9 then
					xPlayer.addAccountMoney('black_money', 1800)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))
                elseif CopsConnected >= 10 then
					xPlayer.addAccountMoney('black_money', 1900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_opium'))		
				end
				
				SellOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startSellOpium')
AddEventHandler('esx_illegal_drugs:startSellOpium', function()

	local _source = source

	PlayersSellingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellOpium(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopSellOpium')
AddEventHandler('esx_illegal_drugs:stopSellOpium', function()

	local _source = source

	PlayersSellingOpium[_source] = false

end)
-------------------------------------------------------
-----------------------OPIUM---------------------------
-------------------------------------------------------










-------------------------------------------------------
-----------------------COKE----------------------------
-------------------------------------------------------
local function HarvestCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToFarmCoke, function()

		if PlayersHarvestingCoke[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local coke = xPlayer.getInventoryItem('cocaina')

			if coke.limit ~= -1 and coke.count >= coke.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_coke'))
			else
				xPlayer.addInventoryItem('cocaina', 1)
				HarvestCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startHarvestCoke')
AddEventHandler('esx_illegal_drugs:startHarvestCoke', function()

	local _source = source

	PlayersHarvestingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestCoke(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopHarvestCoke')
AddEventHandler('esx_illegal_drugs:stopHarvestCoke', function()

	local _source = source

	PlayersHarvestingCoke[_source] = false

end)

local function TransformCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToProcessCoke, function()

		if PlayersTransformingCoke[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local cokeQuantity = xPlayer.getInventoryItem('cocaina').count
			local poochQuantity = xPlayer.getInventoryItem('cocainag').count

			if poochQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif cokeQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_coke'))
			else
				xPlayer.removeInventoryItem('cocaina', 5)
				xPlayer.addInventoryItem('cocainag', 1)
			
				TransformCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startTransformCoke')
AddEventHandler('esx_illegal_drugs:startTransformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformCoke(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopTransformCoke')
AddEventHandler('esx_illegal_drugs:stopTransformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = false

end)

local function SellCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToSellCoke, function()

		if PlayersSellingCoke[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('cocainag').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_coke_sale'))
			else
				xPlayer.removeInventoryItem('cocainag', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 1100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 1200)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 1300)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 1400)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 1500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 7 then
					xPlayer.addAccountMoney('black_money', 1600)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 8 then
					xPlayer.addAccountMoney('black_money', 1700)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 9 then
					xPlayer.addAccountMoney('black_money', 1800)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 10 then
					xPlayer.addAccountMoney('black_money', 1900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))	
				end
				
				SellCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startSellCoke')
AddEventHandler('esx_illegal_drugs:startSellCoke', function()

	local _source = source

	PlayersSellingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellCoke(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopSellCoke')
AddEventHandler('esx_illegal_drugs:stopSellCoke', function()

	local _source = source

	PlayersSellingCoke[_source] = false

end)
-------------------------------------------------------
-----------------------COKE----------------------------
-------------------------------------------------------







-------------------------------------------------------
----------------------METH-----------------------------
-------------------------------------------------------
local function HarvestMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end
	
	SetTimeout(Config.TimeToFarmMeth, function()

		if PlayersHarvestingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local meth = xPlayer.getInventoryItem('pefedrina')

			if meth.limit ~= -1 and meth.count >= meth.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_meth'))
			else
				xPlayer.addInventoryItem('pefedrina', 1)
				HarvestMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startHarvestMeth')
AddEventHandler('esx_illegal_drugs:startHarvestMeth', function()

	local _source = source

	PlayersHarvestingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestMeth(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopHarvestMeth')
AddEventHandler('esx_illegal_drugs:stopHarvestMeth', function()

	local _source = source

	PlayersHarvestingMeth[_source] = false

end)

local function TransformMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToProcessMeth, function()

		if PlayersTransformingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local methQuantity = xPlayer.getInventoryItem('pefedrina').count
			local poochQuantity = xPlayer.getInventoryItem('metanfetamina').count

			if poochQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif methQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_meth'))
			else
				xPlayer.removeInventoryItem('pefedrina', 5)
				xPlayer.addInventoryItem('metanfetamina', 1)
				
				TransformMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startTransformMeth')
AddEventHandler('esx_illegal_drugs:startTransformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

	TransformMeth(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopTransformMeth')
AddEventHandler('esx_illegal_drugs:stopTransformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = false

end)

local function SellMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToSellMeth, function()

		if PlayersSellingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('metanfetamina').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_meth_sale'))
			else
				xPlayer.removeInventoryItem('metanfetamina', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 1100)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 1200)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 1300)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected == 5 then
					xPlayer.addAccountMoney('black_money', 1400)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
				elseif CopsConnected >= 6 then
					xPlayer.addAccountMoney('black_money', 1500)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))
                elseif CopsConnected >= 7 then
					xPlayer.addAccountMoney('black_money', 1600)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 8 then
					xPlayer.addAccountMoney('black_money', 1700)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 9 then
					xPlayer.addAccountMoney('black_money', 1800)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
                elseif CopsConnected >= 10 then
					xPlayer.addAccountMoney('black_money', 1900)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))	
				end
				
				SellMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_illegal_drugs:startSellMeth')
AddEventHandler('esx_illegal_drugs:startSellMeth', function()

	local _source = source

	PlayersSellingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

	SellMeth(_source)

end)

RegisterServerEvent('esx_illegal_drugs:stopSellMeth')
AddEventHandler('esx_illegal_drugs:stopSellMeth', function()

	local _source = source

	PlayersSellingMeth[_source] = false

end)
-------------------------------------------------------
----------------------METH-----------------------------
-------------------------------------------------------






RegisterServerEvent('esx_illegal_drugs:GetUserInventory')
AddEventHandler('esx_illegal_drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_illegal_drugs:ReturnInventory', 
		_source, 
		xPlayer.getInventoryItem('cocaina').count, 
		xPlayer.getInventoryItem('cocainag').count,
		xPlayer.getInventoryItem('pefedrina').count, 
		xPlayer.getInventoryItem('metanfetamina').count, 
		xPlayer.getInventoryItem('lsd').count, 
		xPlayer.getInventoryItem('lsdprocessato').count, 
		xPlayer.getInventoryItem('papavero').count, 
		xPlayer.getInventoryItem('oppio').count,
		xPlayer.job.name, 
		currentZone
	)
end)

ESX.RegisterUsableItem('lsd', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('lsd', 1)

	TriggerClientEvent('esx_illegal_drugs:onPot', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_weed'))
end)

ESX.RegisterUsableItem('pefedrina', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('pefedrina', 1)

	TriggerClientEvent('esx_illegal_drugs:onMeth', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_meth'))
end)

ESX.RegisterUsableItem('papavero', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('papavero', 1)

	TriggerClientEvent('esx_illegal_drugs:onOpium', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_opium'))
end)

ESX.RegisterUsableItem('cocaina', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('cocaina', 1)

	TriggerClientEvent('esx_illegal_drugs:onCoke', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('used_one_coke'))
end)

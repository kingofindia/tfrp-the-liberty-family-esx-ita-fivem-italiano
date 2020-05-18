ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('viande', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('viande', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat2', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai mangiato della carne fresca')
end)

ESX.RegisterUsableItem('champagne', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('champagne', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprite', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto una sprite')
	
end)

ESX.RegisterUsableItem('teqpaf', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('teqpaf', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto una bottiglia di Teq\'paf')
	
end)

ESX.RegisterUsableItem('jagerbomb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jagerbomb', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('golem', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('golem', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('whiskycoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whiskycoca', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('vodkaenergy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkaenergy', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('vodkafruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkafruit', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('rhumfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumfruit', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('rhumcoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumcoca', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('mojito', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mojito', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('mixapero', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mixapero', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('metreshooter', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('metreshooter', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('jagercerbere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jagercerbere', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('menthe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('menthe', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink4', source)
end)

ESX.RegisterUsableItem('masch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('masch', 1)

	TriggerClientEvent('esx_basicneeds:oxygen_mask', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai indossato una maschera subacquea')
end)

ESX.RegisterUsableItem('giub', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('giub', 1)

	TriggerClientEvent('esx_basicneeds:bulletproof', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai indossato un giubbotto antiproiettile')
end)

ESX.RegisterUsableItem('limonade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('limonade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto una bottiglia di limonata')
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto tè ghiacciato')
end)

ESX.RegisterUsableItem('jusfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jusfruit', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 280000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto un succo di frutta')
end)

ESX.RegisterUsableItem('grand_cru', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('grand_cru', 1)

	--TriggerClientEvent('esx_basicneeds:vinodrugs', source)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_status:add', source, 'thirst', 280000)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto del vino drogato.')
end)

ESX.RegisterUsableItem('hotdog', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hotdog', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat3', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai mangiato un hotdog')
end)

ESX.RegisterUsableItem('nugets', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('nugets', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 220000)
	TriggerClientEvent('esx_basicneeds:onEat4', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai mangiato una scatola di nugets')
end)

ESX.RegisterUsableItem('candy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('candy', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 220000)
	TriggerClientEvent('esx_basicneeds:onEat5', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai mangiato un pacchetto di caramelle')
end)

ESX.RegisterUsableItem('ciambella', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('ciambella', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 180000)
	TriggerClientEvent('esx_extraitems:donut', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai mangiato una ciambella')
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
	
end)

ESX.RegisterUsableItem('pastocompleto', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('pastocompleto', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, "Hai usufruito di un pasto completo")
end)

ESX.RegisterUsableItem('milk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('milk', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink2', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto mezzo litro di latte')
	
end)

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink3', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto una lattina di lemon soda')
	
end)

ESX.RegisterUsableItem('fish', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fish', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat6', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai mangiato del pesce fresco')
end)

--[[ ESX.RegisterUsableItem('purpledrunk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('purpledrunk', 1)

	TriggerClientEvent('esx_basicneeds:onDrink4', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto una bottiglia di Purple Drunk')

	TriggerClientEvent('esx_basicneeds:gotheal', source)
	

end)

ESX.RegisterUsableItem('redpurpledrunk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('redpurpledrunk', 1)

	TriggerClientEvent('esx_basicneeds:onDrink4', source)
	TriggerClientEvent('esx:showNotification', source, 'Hai bevuto una bottiglia di Red Purple Drunk')

	TriggerClientEvent('esx_basicneeds:gotheal2', source)
	

end) ]]

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = tonumber(args[1])
		
		-- is the argument a number?
		if target ~= nil then
			
			-- is the number a valid player?
			if GetPlayerName(target) then
				print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing a player!')
				TriggerClientEvent('esx_basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "You have been healed!")
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing!')
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Heal a player, or yourself - restores thirst, hunger and health."})
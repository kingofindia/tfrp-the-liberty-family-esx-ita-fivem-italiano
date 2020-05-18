local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_capodanno")

--[[
ESX.RegisterUsableItem('firework', function(source)
   -- local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = vRP.getUserId({source})
	local dinamico = GetPlayerServerId(PlayerId(-1))
	local thePlayer = source
    --xPlayer.removeInventoryItem('firework', 1)
	if vRP.tryGetInventoryItem({user_id,"firework",1}) then
    TriggerClientEvent('firework:place_firework', user_id)
	else 
	vRPclient.notify(thePlayer, {"~r~Numero non valido!"})
	end
end)--]]

vRP.defInventoryItem({"fuochiartificio", "Fuochi Artificio", "Festeggia il nuovo anno!", function(args)
	local choices = {}
	
	choices["Accendi"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
		if vRP.tryGetInventoryItem({user_id,"firework",1}) then
				TriggerClientEvent('firework:place_firework', user_id)
				vRPclient.notify(player,{"Stai posizionando i fuochi."})
				vRP.closeMenu({player})
			
			end
			end
		end}

	return choices
end, 0.5})



RegisterServerEvent('firework:explosion')
AddEventHandler('firework:explosion', function(x, y, z)
    TriggerClientEvent('firework:startExplosion', -1, x, y, z)
end)
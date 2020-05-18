# esx_distributor

[REQUIREMENT]

esx_basicneeds =>  ``https://github.com/ESX-Org/esx_basicneeds``

[INSTALLATION]

1) CD in your resources/[esx] folder
2) Clone the repository
``git clone https://github.com/Thananyx/esx_distributor.git``


3) Import ``esx_distributor.sql`` in your database


4) Add this in your server.cfg :

``start esx_distributor``


5) UPDATE .SQL
```
INSERT INTO `items` (name, label) VALUES 
	('pepsi', 'Pepsi');  -- example
```


6) UPDATE esx_basicneeds [server/main.lua]
```
ESX.RegisterUsableItem('pepsi', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pepsi', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkPepsi', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_pepsi'))

end)
```


7) UPDATE esx_basicneeds [client/main.lua]
```RegisterNetEvent('esx_basicneeds:onDrinkPepsi')
AddEventHandler('esx_basicneeds:onDrinkPepsi', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_ecola_can'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)			
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)```

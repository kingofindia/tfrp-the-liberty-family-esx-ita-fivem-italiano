ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterUsableItem('gloves', function(source)
	local _source = source
    TriggerClientEvent('dqp:EquipGloves', _source)
end)
ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

RegisterServerEvent('esx_rich_take:DuemilaCinque')
AddEventHandler('esx_rich_take:DuemilaCinque', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeMoney(2500)

    local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function(account)
		societyAccount = account
	end)

  societyAccount.addMoney(2500)
end)

RegisterServerEvent('esx_rich_take:CinqueKappa')
AddEventHandler('esx_rich_take:CinqueKappa', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeMoney(5000)

    local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cardealer', function(account)
		societyAccount = account
	end)

  societyAccount.addMoney(5000)
end)

ESX.RegisterServerCallback('esx_rich_carshowroom:CheckMoney', function(source, cb)
    local _source = source
    local identifier = ESX.GetPlayerFromId(_source).identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
    local userData = {}

    soldi = xPlayer.get('money')

    cb(soldi)
end)

ESX.RegisterServerCallback('esx_rich_testDrive:ChiamataPolizia', function(source, cb)
  local name = getIdentity(source)
  fal = name.firstname .. " " .. name.lastname

  cb(fal)
end)
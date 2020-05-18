ESX = nil

Wrapper.TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Wrapper.RegisterNetEvent('blargleambulance:finishLevel')
Wrapper.AddEventHandler('blargleambulance:finishLevel', function(levelFinished)
    ESX.GetPlayerFromId(source).addMoney(Config.Formulas.moneyPerLevel(levelFinished))

    local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		societyAccount = account
    end)
    
    societyAccount.addMoney(Config.Formulas.moneyPerLevel(levelFinished)/2)
end)
local Keys = {
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

ESX                 = nil
local PlayerData    = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--[[ polizia = 0
medici = 0
concessionario = 0
taxionline = 0
meccanico = 0
armaiolo = 0 ]]

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        ESX.TriggerServerCallback('esx_lavori:check', function(police, ems, cardealer, taxi, mecano, armeria)
            polizia = police
            medici = ems
            concessionario = cardealer
            taxionline = taxi
            meccanico = mecano
            armaiolo = armeria
            
        end)
    end
end) ]]

jobs = {}

RegisterNetEvent('esx_rich_jobsOnline:set')
AddEventHandler('esx_rich_jobsOnline:set', function(jobs_online)

    --jobs_online['police'] 

    polizia = jobs_online['police']
    medici = jobs_online['ambulance']
    concessionario = jobs_online['cardealer']
    taxionline = jobs_online['taxi']
    meccanico = jobs_online['mecano']
    armaiolo = jobs_online['armeria']

end)

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent('esx_jobCounter:get')

		Wait(10000)
	end
end)

function MenuLavori()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'menu_lavori',
        {
            title    = 'Lavori online',
            elements = {
                {label = polizia, value = 'polizia'},
                {label = medici, value = 'medici'},
                {label = concessionario, value = 'concess'},
                {label = taxionline, value = 'taxion'},
                {label = meccanico, value = 'mecano'},
                {label = armaiolo, value = 'armeria'}
            }
        }, function(data, menu)
            local val = data.current.value

            if val == 'polizia' then
                ESX.ShowNotification('Polizia: ' ..polizia)
            elseif val == 'medici' then
                ESX.ShowNotification('Medici: ' ..medici)
            elseif val == 'concess' then
                ESX.ShowNotification('Concessionario: ' ..concessionario)
            elseif val == 'taxion' then
                ESX.ShowNotification('Taxi: ' ..taxionline)
            elseif val == 'mecano' then
                ESX.ShowNotification('Meccanico: ' ..meccanico)
            elseif val == 'armeria' then
                ESX.ShowNotification('Armaiolo: ' ..armaiolo)
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

RegisterNetEvent('esx:hahhadiocane')
AddEventHandler('esx:hahhadiocane', function()
    MenuLavori()
end)
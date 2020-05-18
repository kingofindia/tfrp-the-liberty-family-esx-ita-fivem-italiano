ESX                             = nil

local PoliziaOnline             = 0
local MediciOnline              = 0
local ConcessionarioOnline      = 0
local TaxiOnline                = 0
local MeccanicoOnline           = 0
local ArmaioloOnline            = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountJobs()

    local xPlayers = ESX.GetPlayers()

    PoliziaOnline           = 0
    MediciOnline            = 0
    ConcessionarioOnline    = 0
    TaxiOnline              = 0
    MeccanicoOnline         = 0
    ArmaioloOnline          = 0

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == 'police' then
            PoliziaOnline = PoliziaOnline + 1
        elseif xPlayer.job.name == 'ambulance' then
            MediciOnline = MediciOnline + 1
        elseif xPlayer.job.name == 'cardealer' then
            ConcessionarioOnline = ConcessionarioOnline + 1
        elseif xPlayer.job.name == 'taxi' then
            TaxiOnline = TaxiOnline + 1
        elseif xPlayer.job.name == 'mecano' then
            MeccanicoOnline = MeccanicoOnline + 1
        elseif xPlayer.job.name == 'armeria' then
            ArmaioloOnline = ArmaioloOnline + 1
        end
    end

    --SetTimeout(10000, CountJobs)
end

CountJobs()

RegisterServerEvent('esx_rich_jobsOnline:get')
AddEventHandler('esx_rich_jobsOnline:get', function()
    local counted = {}

    counted['police'] = PoliziaOnline
    counted['ambulance'] = MediciOnline
    counted['cardealer'] = ConcessionarioOnline
    counted['taxi'] = TaxiOnline
    counted['mecano'] = MeccanicoOnline
    counted['armeria'] = ArmaioloOnline

    TriggerClientEvent('esx_rich_jobsOnline:set', source, counted)
end)

--[[ ESX.RegisterServerCallback('esx_lavori:check', function(source, db)

    --local xPlayer  = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    PoliziaOnline = 0
    MediciOnline = 0
    ConcessionarioOnline = 0
    TaxiOnline = 0
    MeccanicoOnline = 0
    ArmaioloOnline = 0

    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == 'police' then
            PoliziaOnline = PoliziaOnline + 1
        elseif xPlayer.job.name == 'ambulance' then
            MediciOnline = MediciOnline + 1
        elseif xPlayer.job.name == 'cardealer' then
            ConcessionarioOnline = ConcessionarioOnline + 1
        elseif xPlayer.job.name == 'taxi' then
            TaxiOnline = TaxiOnline + 1
        elseif xPlayer.job.name == 'mecano' then
            MeccanicoOnline = MeccanicoOnline + 1
        elseif xPlayer.job.name == 'armeria' then
            ArmaioloOnline = ArmaioloOnline + 1
        end
    end

    cb(PoliziaOnline, MediciOnline, ConcessionarioOnline, TaxiOnline, MeccanicoOnline, ArmaioloOnline)

end) ]]
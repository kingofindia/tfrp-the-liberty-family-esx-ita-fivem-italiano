----------------------------
--(Made By Qalle)--
----------------------------

ESX               = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

----- Kommando

RegisterCommand("tpm", function(source)
    tpTillMarker()
end, false)

RegisterCommand("BailaCheTiPassa", function(source)
  negraccio()
end, false)

----- Kod

function tpTillMarker()
  
  ESX.TriggerServerCallback('esx_marker:getUsergroup', function(group)
    playergroup = group
    
    if playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'mod' then
      local playerPed = GetPlayerPed(-1)
      local WaypointHandle = GetFirstBlipInfoId(8)
      if DoesBlipExist(WaypointHandle) then
        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
        --SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
        SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
        ESX.ShowNotification('Sei un cazzo di modder!')
      else
        ESX.ShowNotification('Nessuna meta selezionata')
      end
    end
    
  end)
end

function negraccio()
  
  ESX.TriggerServerCallback('esx_marker:getUsergroup', function(group)
    playergroup = group
    
    if playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'mod' or playergroup == 'helper' then
      local playerPed = GetPlayerPed(-1)
      SetPlayerWeaponDamageModifier(playerPed, 2000)
      SetEntityHealth(playerPed, 450)
      SetPedArmour(playerPed, 250)
      PedSkipNextReloading(playerPed)
      SetPedInfiniteAmmoClip(playerPed, true)
    end
    
  end)
end
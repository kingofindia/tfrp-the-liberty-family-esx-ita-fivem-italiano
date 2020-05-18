gloves = {}
local gloveModel = GetHashKey("prop_boxing_glove_01")
function toggleGloves()
	for k,v in pairs(gloves) do DeleteEntity(v) end
	if #gloves > 0 then gloves = {} return end

	if not HasModelLoaded(gloveModel) then
		RequestModel(gloveModel)
		while not HasModelLoaded(gloveModel) do Citizen.Wait(100) end
	end

	local Player = LocalPlayer()
	local ped, plyPos = Player.Ped, Player.Pos

	local firstGlove = CreateObject(gloveModel, plyPos, 1, 0, 0)
	local secondGlove = CreateObject(gloveModel, plyPos, 1, 0, 0)
	table.insert(gloves, firstGlove)
	table.insert(gloves, secondGlove)

	for k,v in pairs(gloves) do
		SetEntityAsMissionEntity(v, 1, 1)
	end

	AttachEntityToEntity(firstGlove, ped, GetPedBoneIndex(ped, 6286), vector3(-0.1, 0.01, -0.01), vector3(90.0, 0.0, 90.0), 0, 0, 0, 0, 0, 1)
	AttachEntityToEntity(secondGlove, ped, GetPedBoneIndex(ped, 36029), vector3(-0.1, 0.02, 0.02), vector3(-90.0, 0.0, -90.0), 0, 0, 0, 0, 0, 1)
end


RegisterNetEvent('dqp:EquipGloves')
AddEventHandler('dqp:EquipGloves', function()
    toggleGloves()
end)

local PLAYER = {}
PLAYER.Vehicle = 0
PLAYER.Ped = 0
PLAYER.Weapon = {}
PLAYER.DecorItem = {}
PLAYER.Struct = {}
PLAYER.Sex = 0
PLAYER.InstanceID = 0
PLAYER.InVehicle = false
PLAYER.InCombat = false
PLAYER.Ragdoll = false
PLAYER.Dead = false -- ped dead
PLAYER.IsDead = false -- player dead
PLAYER.Pos = vector3(0.0, 0.0, 0.0)
PLAYER.ZoneName = ""
PLAYER.InteriorID = 0
PLAYER.Armed = false
PLAYER.Shooting = false
PLAYER.Cuffed = false
PLAYER.Health = 0
PLAYER.Armor = 0

function PLAYER:Matrix() return GetEntityMatrix(self.Ped) end
function PLAYER:GetVehicle() local vehicle = self.InVehicle and GetVehiclePedIsUsing(self.Ped) return vehicle and vehicle > 0 and vehicle end
function PLAYER:Set(a, b) PLAYER[a] = b end

function LocalPlayer()
	return PLAYER
end

Citizen.CreateThread(function()
	while true do
		PLAYER.Pos = GetEntityCoords(PLAYER.Ped)
		PLAYER.Health = GetEntityHealth(PLAYER.Ped)
		PLAYER.Armor = GetPedArmour(PLAYER.Ped)
		PLAYER.Shooting = IsPedShooting(PLAYER.Ped)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		PLAYER.Ped = GetPlayerPed(-1)
		PLAYER.InVehicle = IsPedInAnyVehicle(PLAYER.Ped)
		PLAYER.ZoneName = GetNameOfZone(PLAYER.Pos)
		PLAYER.InteriorID = GetInteriorFromEntity(PLAYER.Ped)
		PLAYER.Armed = IsPedArmed(PLAYER.Ped, 6)
		PLAYER.Cuffed = IsPedCuffed(PLAYER.Ped)


		Citizen.Wait(1000)
	end
end)
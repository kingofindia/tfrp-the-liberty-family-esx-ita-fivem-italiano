local looped = 8
local looped2 = 16
local prop = nil
local hotkeysEnabled = false
 
Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('list', "Emote")
    WarMenu.CreateSubMenu('anims', 'list', 'Animazioni')
    WarMenu.CreateSubMenu('walkanims', 'list', 'Animazioni in cammino')
    WarMenu.CreateSubMenu('gesture', 'anims', 'Gesti')
    WarMenu.CreateSubMenu('misc2', 'anims', 'Misc')
    WarMenu.CreateSubMenu('scens', 'list', 'Scenari')
    WarMenu.CreateSubMenu('job', 'scens', 'Lavori')
    WarMenu.CreateSubMenu('hobby', 'scens', 'Hobby')
    WarMenu.CreateSubMenu('drink', 'scens', 'Bere e droghe')
    WarMenu.CreateSubMenu('ems', 'scens', 'Scenari EMS')
    WarMenu.CreateSubMenu('sat', 'scens', 'Scenari Siediti')
    WarMenu.CreateSubMenu('misc', 'scens', 'Misc')
	WarMenu.CreateSubMenu('walk', 'list', 'Stili di camminata')
	WarMenu.CreateSubMenu('new2', 'anims', 'Nuove')
    WarMenu.CreateSubMenu('new', 'scens', 'Nuove')
    WarMenu.CreateSubMenu('ostaggi', 'list', 'Ostaggi')

    for theId,theItems in pairs(anims) do
        RequestAnimDict(theItems.dic)
    end

    while true do
        local ped = PlayerPedId()
        if checkbox then
            looped = 1
        else
            looped = 32
        end

        if checkbox2 then
            looped2 = 1
        else
            looped2 = 0
        end
        if WarMenu.IsMenuOpened('list') then
            if WarMenu.MenuButton('Animazioni', 'anims') then
            elseif WarMenu.MenuButton('Scenari', 'scens') then
            elseif WarMenu.MenuButton('Animazioni in cammino', 'walkanims') then
            elseif WarMenu.MenuButton('Stili di camminata', 'walk') then
            elseif WarMenu.MenuButton('Azioni personali', 'actions') then
            elseif WarMenu.MenuButton('Espressioni facciali', 'expressions') then
            elseif WarMenu.MenuButton('Ostaggi', 'ostaggi') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('walkanims') then
            if WarMenu.Button('~r~~h~Ferma l\'animazione') then
                ClearPedTasks(ped)
            end
            
            if WarMenu.Button('Svieni') then
                TriggerEvent('esx_rich_emote:RagDoll')
                WarMenu.CloseMenu()
            end

            for theId,theItems in pairs(walkanims) do
				if WarMenu.Button(theItems.label) then
					RequestAnimDict(theItems.dic)
			  
					while not HasAnimDictLoaded(theItems.dic) do
						Citizen.Wait(0)
					end

					TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, 49, 1, 0, 0, 0)
				end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('ostaggi') then
            --[[ if WarMenu.Button('~r~~h~Ferma l\'animazione') then
                ClearPedTasks(ped)
            end ]]
            
            if WarMenu.Button('Scudo umano con ostaggio NPC fermo') then
                TriggerEvent('esx_rich_emote:scudoUmanoNPC')
            elseif WarMenu.Button('Prendi giocatore a cavallo') then
                TriggerEvent('esx_rich_emote:prendiacavallo')
            --elseif WarMenu.Button('Scudo umano con Giocatore fermo') then
              --  TriggerEvent('esx_rich_emote:scudoUmanoPlayer')
            --elseif WarMenu.Button('Prendi Giocatore in spalla') then
              --  TriggerEvent('esx_rich_emote:carry')
            elseif WarMenu.Button('Prendi NPC in spalla') then
                TriggerEvent('esx_rich_emote:carryPed')
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('anims') then
            if WarMenu.CheckBox('Loop Animazione', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Ferma l\'animazione') then
                ClearPedTasksImmediately(ped)
            elseif WarMenu.MenuButton('Gesti', 'gesture') then
            elseif WarMenu.MenuButton('Misc', 'misc2') then
			elseif WarMenu.MenuButton('Nuovi', 'new2') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('gesture') then
            if WarMenu.CheckBox('Loop Animazione', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Ferma l\'animazione') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(anims) do
                if theItems.category == "Gesture" then
                    if WarMenu.Button(theItems.label) then
                        TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, (looped + theItems.loop), 1, 0, 0, 0)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('misc2') then
            if WarMenu.CheckBox('Loop Animazione', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Ferma l\'animazione') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(anims) do
                if theItems.category == "Misc" then
                    if WarMenu.Button(theItems.label) then
                        TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, (looped + theItems.loop), 1, 0, 0, 0)
                    end
                end
            end
			
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('new2') then
            if WarMenu.CheckBox('Loop Animazione', checkbox, function(checked)
                    checkbox = checked
                end) then
            elseif WarMenu.Button('~r~~h~Ferma l\'animazione') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(anims) do
                if theItems.category == "new" then
                    if WarMenu.Button(theItems.label) then
                        TaskPlayAnim(ped, theItems.dic, theItems.anim, 8.0, -1, -1, (looped + theItems.loop), 1, 0, 0, 0)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('scens') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            elseif WarMenu.MenuButton('Lavori', 'job') then
            elseif WarMenu.MenuButton('Hobby', 'hobby') then
            elseif WarMenu.MenuButton('Bere e Droghe', 'drink') then
            elseif WarMenu.MenuButton('Animazioni EMS', 'ems') then
            elseif WarMenu.MenuButton('Scenari siediti', 'sat') then
            elseif WarMenu.MenuButton('Misc', 'misc') then
			elseif WarMenu.MenuButton('Nuovi', 'new') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('job') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Jobs" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

        WarMenu.Display()
        elseif WarMenu.IsMenuOpened('hobby') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Hobby" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('drink') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Drink" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('ems') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "EMS" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('sat') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Sat" then
                    if WarMenu.Button(theItems.label) then
						local ped = GetPlayerPed(-1)
						local pos = GetOffsetFromEntityInWorldCoords(ped, theItems.pos["mp_m_freemode_01"][1], theItems.pos["mp_m_freemode_01"][2], theItems.pos["mp_m_freemode_01"][3])
						local head = GetEntityHeading(ped)-theItems.pos["mp_m_freemode_01"][4]
						local femaleHash = GetHashKey("mp_f_freemode_01")
						if GetEntityModel(ped) == femaleHash then
							pos = GetOffsetFromEntityInWorldCoords(ped, theItems.pos["mp_f_freemode_01"][1], theItems.pos["mp_f_freemode_01"][2], theItems.pos["mp_f_freemode_01"][3])
							head = GetEntityHeading(ped)-theItems.pos["mp_f_freemode_01"][4]
						end
						TaskStartScenarioAtPosition(ped, theItems.scen, pos['x'], pos['y'], pos['z'], head, looped2, 0, false)
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('misc') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "Misc" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end
			
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('new') then
            if WarMenu.CheckBox2('Loop Scenari', checkbox2, function(checked2)
                    checkbox2 = checked2
                end) then
            elseif WarMenu.Button('~r~~h~Ferma Scenario') then
                ClearPedTasksImmediately(ped)
            end
            for theId,theItems in pairs(scens) do
                if theItems.category == "new" then
                    if WarMenu.Button(theItems.label) then
                    TaskStartScenarioInPlace(ped, theItems.scen, looped2, true)
                    end
                end
            end
	
           WarMenu.Display()
        elseif WarMenu.IsMenuOpened('walk') then
			if WarMenu.Button('~r~Ripristina stile di camminata') then
                ResetPedMovementClipset(GetPlayerPed(-1), 0)
            end
            for theId,theItems in pairs(walks) do
                if theItems.category == "Walking" then
                    if WarMenu.Button(theItems.label) then
					local anim = theItems.Walk
                    startAttitude(anim)
                    end
                end
            end


            WarMenu.Display()
        --[[ elseif IsControlJustPressed(0, 168) then --f6
            WarMenu.OpenMenu('list') ]]
        end

       	--[[ if IsControlJustPressed(0, 178) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then 
          ClearPedTasks(GetPlayerPed(-1))
        end ]]

        Citizen.Wait(0)
    end
end)

function startAttitude(anim)
 	Citizen.CreateThread(function()
	 
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)

end

function Drunk(anim)
 	Citizen.CreateThread(function()
	 
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)

end

RegisterNetEvent('animations:open')
AddEventHandler('animations:open', function()
 WarMenu.OpenMenu('list')
end)


-- New Emote Commands
local emotes = {
 ["cheer"] = "WORLD_HUMAN_CHEERING",
 ["sit"] = "WORLD_HUMAN_PICNIC",
 ["sitchair"] = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER",
 ["lean"] = "WORLD_HUMAN_LEANING",
 ["hangout"] = "WORLD_HUMAN_HANG_OUT_STREET",
 ["cop"] = "WORLD_HUMAN_COP_IDLES",
 ["bum"] = "WORLD_HUMAN_BUM_STANDING",
 ["kneel"] = "CODE_HUMAN_MEDIC_KNEEL",
 ["medic"] = "CODE_HUMAN_MEDIC_TEND_TO_DEAD",
 ["musician"] = "WORLD_HUMAN_MUSICIAN",
 ["film"] = "WORLD_HUMAN_MOBILE_FILM_SHOCKING",
 ["guard"] = "WORLD_HUMAN_GUARD_STAND",
 ["phone"] = "WORLD_HUMAN_STAND_MOBILE",
 ["traffic"] = "WORLD_HUMAN_CAR_PARK_ATTENDANT",
 ["bumsleep"] = "WORLD_HUMAN_BUM_SLUMPED",
 ["drink"] = "WORLD_HUMAN_DRINKING",
 ["dealer"] = "WORLD_HUMAN_DRUG_DEALER",
 ["dealerhard"] = "WORLD_HUMAN_DRUG_DEALER_HARD",
 ["patrol"] = "WORLD_HUMAN_GUARD_PATROL",
 ["hangout"] = "WORLD_HUMAN_HANG_OUT_STREET",
 ["hikingstand"] = "WORLD_HUMAN_HIKER_STANDING",
 ["statue"] = "WORLD_HUMAN_HUMAN_STATUE",
 ["jog"] = "WORLD_HUMAN_JOG_STANDING",
 ["maid"] = "WORLD_HUMAN_MAID_CLEAN",
 ["flex"] = "WORLD_HUMAN_MUSCLE_FLEX",
 ["weights"] = "WORLD_HUMAN_MUSCLE_FLEX",
 ["party"] = "WORLD_HUMAN_PARTYING",
 ["prosthigh"] = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS",
 ["prostlow"] = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS",
 ["pushup"] = "WORLD_HUMAN_PUSH_UPS",
 ["sitsteps"] = "WORLD_HUMAN_SEAT_STEPS",
 ["sitwall"] = "WORLD_HUMAN_SEAT_WALL",
 ["situp"] = "WORLD_HUMAN_SIT_UPS",
 ["fire"] = "WORLD_HUMAN_STAND_FIRE",
 ["impatient"] = "WORLD_HUMAN_STAND_IMPATIENT",
 ["impatientup"] = "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT",
 ["mobileup"] = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT",
 ["stripwatch"] = "WORLD_HUMAN_STRIP_WATCH_STAND",
 ["stupor"] = "WORLD_HUMAN_STUPOR",
 ["sunbathe"] = "WORLD_HUMAN_SUNBATHE",
 ["sunbatheback"] = "WORLD_HUMAN_SUNBATHE_BACK",
 ["map"] = "WORLD_HUMAN_TOURIST_MAP",
 ["tourist"] = "WORLD_HUMAN_TOURIST_MOBILE",
 ["mechanic"] = "WORLD_HUMAN_VEHICLE_MECHANIC",
 ["windowshop"] = "WORLD_HUMAN_WINDOW_SHOP_BROWSE",
 ["yoga"] = "WORLD_HUMAN_YOGA",
 ["atm"] = "PROP_HUMAN_ATM",
 ["bumbin"] = "PROP_HUMAN_BUM_BIN",
 ["cart"] = "PROP_HUMAN_BUM_SHOPPING_CART",
 ["chinup"] = "PROP_HUMAN_MUSCLE_CHIN_UPS",
 ["chinuparmy"] = "PROP_HUMAN_MUSCLE_CHIN_UPS_ARMY",
 ["chinupprison"] = "PROP_HUMAN_MUSCLE_CHIN_UPS_PRISON",
 ["parkingmeter"] = "PROP_HUMAN_PARKING_METER",
 ["armchair"] = "PROP_HUMAN_SEAT_ARMCHAIR",
 ["crossroad"] = "CODE_HUMAN_CROSS_ROAD_WAIT",
 ["crowdcontrol"] = "CODE_HUMAN_POLICE_CROWD_CONTROL",
 ["investigate"] = "CODE_HUMAN_POLICE_INVESTIGATE",
 ["mugshot"] = "WORLD_HUMAN_PAPARAZZI",

}

RegisterCommand("e", function(source, args, rawCommand)
	TaskStartScenarioInPlace(GetPlayerPed(-1), emotes[string.sub(rawCommand, 3)], 0, true)
end)

local dances = {
    [1] = {["dict"] = "misschinese2_crystalmazemcs1_cs", ["anim"] = "dance_loop_tao"},
    [2] = {["dict"] = "rcmnigel1bnmt_1b", ["anim"] = "dance_loop_tyler"},
    [3] = {["dict"] = "missfbi3_sniping", ["anim"] = "dance_m_default"},
    [4] = {["dict"] = "anim@amb@nightclub@dancers@black_madonna_entourage@", ["anim"] = "hi_dance_facedj_09_v2_male^5"},
    [5] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_single_props@hi_intensity", ["anim"] = "hi_dance_prop_09_v1_male^6"},
    [6] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity", ["anim"] = "trans_dance_crowd_mi_to_li_09_v2_male^3"},
    [7] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", ["anim"] = "mi_dance_crowd_15_v2_female^6"},
    [8] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", ["anim"] = "mi_dance_crowd_17_v1_female^2"},
    [9] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", ["anim"] = "mi_dance_crowd_17_v1_male^2"},
    [10] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", ["anim"] = "mi_dance_crowd_09_v2_male^1"},
    [11] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", ["anim"] = "mi_dance_crowd_10_v2_female^3"},
    [12] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_groups@med_intensity", ["anim"] = "mi_dance_crowd_17_v2_male^4"},
    [13] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", ["anim"] = "trans_dance_facedj_hi_to_li_09_v1_female^5"},
    [14] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", ["anim"] = "trans_dance_facedj_hi_to_li_09_v1_male^4"},
    [15] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", ["anim"] = "trans_dance_facedj_hi_to_li_07_v1_female^6"},
    [16] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@", ["anim"] = "trans_dance_facedj_hi_to_li_09_v1_female^1"},
    [17] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_low_intensity", ["anim"] = "trans_dance_facedj_li_to_mi_09_v1_male^2"},
    [18] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_low_intensity", ["anim"] = "trans_dance_facedj_li_to_mi_11_v1_female^5"},
    [19] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_low_intensity", ["anim"] = "trans_dance_facedj_li_to_mi_11_v1_male^5"},
    [20] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", ["anim"] = "trans_dance_facedj_hi_to_li_07_v1_female^1"},
    [21] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", ["anim"] = "trans_dance_facedj_hi_to_li_07_v1_male^6"},
    [22] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_hi_intensity", ["anim"] = "trans_dance_facedj_hi_to_li_09_v1_male^6"},
    [23] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", ["anim"] = "hi_dance_facedj_15_v2_female^5"},
    [24] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", ["anim"] = "hi_dance_facedj_17_v1_male^1"},
    [25] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", ["anim"] = "trans_dance_facedj_li_to_mi_11_v1_male^5"},
    [26] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", ["anim"] = "hi_dance_facedj_17_v2_female^1"},
    [27] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", ["anim"] = "hi_dance_facedj_17_v2_male^6"},
    [28] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", ["anim"] = "hi_dance_facedj_17_v2_male^3"},
    [29] = {["dict"] = "anim@amb@nightclub@dancers@club_ambientpeds@med-hi_intensity", ["anim"] = "mi-hi_amb_club_13_v1_male^2"},
    [30] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", ["anim"] = "high_center_down"},
    [31] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", ["anim"] = "li_dance_facedj_17_v1_female^3"},
    [32] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", ["anim"] = "li_dance_facedj_17_v1_male^5"},
    [33] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", ["anim"] = "li_dance_facedj_17_v2_female^4"},
    [34] = {["dict"] = "anim@amb@nightclub@dancers@crowddance_facedj@low_intesnsity", ["anim"] = "li_dance_facedj_17_v2_male^3"},
    [35] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", ["anim"] = "high_center_up"},
    [36] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", ["anim"] = "high_right_up"},
    [37] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", ["anim"] = "high_center_up"},
    [38] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", ["anim"] = "med_center_up"},
    [39] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", ["anim"] = "med_center_up"},
    [40] = {["dict"] = "anim@mp_player_intcelebrationfemale@banging_tunes_left", ["anim"] = "banging_tunes"},
    [41] = {["dict"] = "anim@mp_player_intcelebrationmale@heart_pumping", ["anim"] = "heart_pumping"},
    [42] = {["dict"] = "anim@mp_player_intcelebrationfemale@oh_snap", ["anim"] = "oh_snap"},
    [43] = {["dict"] = "anim@mp_player_intcelebrationfemale@cats_cradle", ["anim"] = "cats_cradle"},
    [44] = {["dict"] = "anim@mp_player_intcelebrationmale@banging_tunes_left", ["anim"] = "banging_tunes"},
    [45] = {["dict"] = "anim@mp_player_intcelebrationmale@salsa_roll", ["anim"] = "salsa_roll"},
    [46] = {["dict"] = "anim@mp_player_intcelebrationmale@find_the_fish", ["anim"] = "find_the_fish"},
    [47] = {["dict"] = "anim@mp_player_intcelebrationfemale@raise_the_roof", ["anim"] = "raise_the_roof"},
    [48] = {["dict"] = "anim@mp_player_intcelebrationmale@raise_the_roof", ["anim"] = "raise_the_roof"},
    [49] = {["dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", ["anim"] = "med_right_up"},
    [50] = {["dict"] = "anim@mp_player_intcelebrationfemale@salsa_roll", ["anim"] = "salsa_roll"},
}

RegisterCommand("dance", function(source, args, rawCommand)
	if args[1] ~= nil and type(tonumber(args[1])) == "number" then
		if dances[tonumber(args[1])] ~= nil then
			local ped = GetPlayerPed(-1)

			RequestAnimDict(dances[tonumber(args[1])]["dict"])
			  
			while not HasAnimDictLoaded(dances[tonumber(args[1])]["dict"]) do
				Citizen.Wait(0)
			end

			TaskPlayAnim(ped, dances[tonumber(args[1])]["dict"], dances[tonumber(args[1])]["anim"], -1, -1, -1, 47, 1, 0, 0, 0)
		end
	end
end)

RegisterCommand("smoke", function(source, args, rawCommand)
	RequestAnimDict('mp_player_int_uppersmoke') 
	while not HasAnimDictLoaded('mp_player_int_uppersmoke') do 
	Citizen.Wait(1) 
	end
	TaskPlayAnim(GetPlayerPed(-1), 'mp_player_int_uppersmoke', 'mp_player_int_smoke', 3.0, -1, -1, 63, 1, false, false, false)
end)

RegisterCommand("ep", function(source, args, rawCommand)
	local ped = GetPlayerPed(-1)
	local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.6, -0.5)
	local head = GetEntityHeading(ped)
	TaskStartScenarioAtPosition(ped, emotes[string.sub(rawCommand, 4)], pos['x'], pos['y'], pos['z'], head, 0, 0, false)
end)

RegisterCommand("emote", function(source, args, rawCommand)
	TaskStartScenarioInPlace(GetPlayerPed(-1), emotes[string.sub(rawCommand, 7)], 0, true)
end)

RegisterCommand("emotes", function(source, args, rawCommand)
 local strResult = 'Emote List: <div>'
 for ind, v in pairs(emotes) do
  strResult = strResult..ind.."<div>"
 end
 TriggerEvent("pNotify:SendNotification", {text = strResult, timeout= 25000})
end)

RegisterCommand("ce", function(source, args, rawCommand)
 ClearPedTasks(GetPlayerPed(-1))
end)
 
RegisterCommand("cancel", function(source, args, rawCommand)
 ClearPedTasksImmediately(GetPlayerPed(-1))
end)

-- Personal Actions!!!
local personalaction = {name = 'None', dic = 'None', anim = 'None'}


Citizen.CreateThread(function()
 WarMenu.CreateMenu('actions', 'Azioni')
 while true do
  Citizen.Wait(1)
  if WarMenu.IsMenuOpened('actions') then
   if WarMenu.Button('Azione attuale: '..personalaction.name) then
   elseif WarMenu.Button('L\'uccello') then
    personalaction = {name = 'L\'uccello', dic = 'mp_player_int_upperfinger', anim = 'mp_player_int_finger_02'}
   elseif WarMenu.Button('Jerk Off') then
    personalaction = {name = 'Jerk Off', dic = 'mp_player_int_upperwank', anim = 'mp_player_int_wank_01'}
   elseif WarMenu.Button('Salute') then
    personalaction = {name = 'Salute', dic = 'mp_player_int_uppersalute', anim = 'mp_player_int_salute'}
   elseif WarMenu.Button('Blow Kiss') then
    personalaction = {name = 'Blow Kiss', dic = 'anim@mp_player_intupperblow_kiss', anim = 'idle_a'}
   elseif WarMenu.Button('Air Thrusting') then
    personalaction = {name = 'Air Thrusting', dic = 'anim@mp_player_intcelebrationfemale@air_shagging', anim = 'air_shagging'}
   elseif WarMenu.Button('Knuckle Crunch') then
    personalaction = {name = 'Knuckle Crunch', dic = 'anim@mp_player_intupperknuckle_crunch', anim = 'idle_a'}
   elseif WarMenu.Button('Slow Clap') then
    personalaction = {name = 'Slow Clap', dic = 'anim@mp_player_intupperslow_clap', anim = 'idle_a'}
   elseif WarMenu.Button('Thumbs Up') then
    personalaction = {name = 'Thumbs Up', dic = 'anim@mp_player_intupperthumbs_up', anim = 'idle_a'}
   elseif WarMenu.Button('Jazz Hands') then
    personalaction = {name = 'Jazz Hands', dic = 'anim@mp_player_intupperjazz_hands', anim = 'idle_a'}
   elseif WarMenu.Button('Nose Pick') then
    personalaction = {name = 'Nose Pick', dic = 'anim@mp_player_intuppernose_pick', anim = 'idle_a'}
   elseif WarMenu.Button('Air Guitar') then
    personalaction = {name = 'Air Guitar', dic = 'anim@mp_player_intupperair_guitar', anim = 'idle_a'}
   elseif WarMenu.Button('Wave') then
    personalaction = {name = 'Wave', dic = 'anim@mp_player_intupperwave', anim = 'idle_a'}
   elseif WarMenu.Button('Peace') then
    personalaction = {name = 'Peace', dic = 'anim@mp_player_intupperpeace', anim = 'idle_a'}
   elseif WarMenu.Button('Freakout') then
    personalaction = {name = 'Freakout', dic = 'anim@mp_player_intupperfreakout', anim = 'idle_a'}
   elseif WarMenu.Button('Chin Brush') then
    personalaction = {name = 'Chin Brush', dic = 'anim@mp_player_intupperchin_brush', anim = 'idle_a'}
   elseif WarMenu.Button('Chicken Taunt') then
    personalaction = {name = 'Chicken Taunt', dic = 'anim@mp_player_intupperchicken_taunt', anim = 'idle_a'}
   elseif WarMenu.Button('No Way') then
    personalaction = {name = 'No Way', dic = 'anim@mp_player_intupperno_way', anim = 'idle_a'}
   elseif WarMenu.Button('Air Synth') then
    personalaction = {name = 'Air Synth', dic = 'anim@mp_player_intupperair_synth', anim = 'idle_a'}
   elseif WarMenu.Button('DJ') then
    personalaction = {name = 'DJ', dic = 'anim@mp_player_intupperdj', anim = 'idle_a'}
   elseif WarMenu.Button('Shush') then
    personalaction = {name = 'Shush', dic = 'anim@mp_player_intuppershush', anim = 'idle_a'}
   end
   WarMenu.Display()
  end 
  if IsControlJustPressed(0, 171) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and not IsPedCuffed(GetPlayerPed(-1)) and personalaction.dic ~= 'None' then
   if IsEntityPlayingAnim(GetPlayerPed(-1), personalaction.dic, personalaction.anim, 3) then
    ClearPedTasks(GetPlayerPed(-1))
   else
    RequestAnimDict(personalaction.dic) 
    while not HasAnimDictLoaded(personalaction.dic) do 
        Citizen.Wait(1) 
    end
    TaskPlayAnim(GetPlayerPed(-1), personalaction.dic, personalaction.anim, 3.0, -1, -1, 63, 1, false, false, false)
   end
  end
 end
end)

local expressions = 
{
    {name = 'Normale', mood = 'mood_normal_1'},
    {name = 'Puntando', mood = 'mood_aiming_1'},
    {name = 'Arrabbiato', mood = 'mood_angry_1'},
    {name = 'Ubriaco', mood = 'mood_drunk_1'},
    {name = 'Contento', mood = 'mood_happy_1'},
    {name = 'Ferito', mood = 'mood_injured_1'},
    {name = 'Stressato', mood = 'mood_stressed_1'},
    {name = 'Malumore', mood = 'mood_sulk_1'},
    {name = 'Addormentato', mood = 'mood_sleeping_1'},
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('expressions', 'Espressioni')
 while true do
  Citizen.Wait(1)
  if WarMenu.IsMenuOpened('expressions') then
   for _,v in pairs(expressions) do
    if WarMenu.Button(v.name) then
     SetFacialIdleAnimOverride(GetPlayerPed(-1), v.mood)
    end
   end
   WarMenu.Display()
  end 
 end
end)


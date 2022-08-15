-- @vars
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerData = ESX.GetPlayerData()
    Wait(5000)
    TriggerEvent('lb_deathalert:updateJob')
    
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
    TriggerEvent('lb_deathalert:updateJob')
end)

local isAmbulance = false

AddEventHandler('lb_deathalert:updateJob', function()
    if PlayerData.job.name == 'ambulance' then
        SendNUIMessage({
            ACTION = 'open',
            OPEN = true,
        })
        isAmbulance = true
    else
        SendNUIMessage({
            ACTION = 'close',
            OPEN = false,
        })
        isAmbulance = false
    end
    
end)





local GLOBAL = {
    USERTABLES = {},
    MENU_OPENED = false,
}
local onMenu = false
--[[Citizen.CreateThread(function()
    Wait(5000)
    
    if isAmbulance then
        while not onMenu do
            SendNUIMessage({
                ACTION = 'open',
                OPEN = true,
            })
            
            Wait(1000)
            if onMenu then
                print("pinguu")
                break
            end
        end
    
    end

end)]]--
-- @nui_callbacks
local beforepressed = false

RegisterNUICallback('escape', function()
    SetNuiFocus(false, false)
    GLOBAL.MENU_OPENED = false
end)

RegisterNUICallback('onmenu', function()
    onMenu = true
end)


RegisterNUICallback('coma', function()
    SetNuiFocus(false, false)
    beforepressed = false
end)




local BLIP_1

RegisterNUICallback('markubi', function(cb)

local x = cb.x
local y = cb.y
SetNewWaypoint(x, y)
TriggerServerEvent('lb_deathalert:sentAdvert', cb.id )


end)



RegisterNetEvent('lb_deathalert:data2ems')
AddEventHandler('lb_deathalert:data2ems', function(table)
    
    if isAmbulance then
        GLOBAL.USERTABLES = table
        SendNUIMessage({
            ACTION = 'open',
            USERTABLES = table
        })
    end
end)



Citizen.CreateThread(function()
    while true do
        if isAmbulance then
            
            if IsPauseMenuActive() then
                SendNUIMessage({
                    SHOW = false,
                })
            else
                SendNUIMessage({
                    SHOW = true,
                })
              
            end


            if IsControlJustReleased(1, 168) then --in js => 118
                if not beforepressed then
                    beforepressed = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        PRESSED = true
                    })
            end
            
        end
        end
        Citizen.Wait(0)

    end

end)



--System of blipss



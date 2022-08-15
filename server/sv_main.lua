local ESX = nil
--TriggerEvent('064d6d16-1781-435b-bfdb-8bc665a8fb6d', function(obj) ESX = obj end)
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local deathPeople = {}
local players = {}




RegisterNetEvent('lb_deathalert:sendTSignal')
AddEventHandler('lb_deathalert:sendTSignal', function(porcentaje, coords, type, color)

    
    local _src = source

    if players[_src] ~= true then
        
        local tableinfo = {
            id = _src,
            percent = porcentaje,
            ubi = coords,
            tipo = type,
            color = color
        }
        table.insert(deathPeople,tableinfo)
        players[_src] = true

    elseif  players[_src] == true then
        print("winidepuu")
        for i=1, #deathPeople do
            if deathPeople[i].id == _src then
                deathPeople[i].percent = porcentaje
                deathPeople[i].tipo = type
                deathPeople[i].color = color
            end
        end
    else
        players[_src] = false
    end

    print(json.encode(deathPeople))
    TriggerClientEvent('lb_deathalert:data2ems', -1, deathPeople)

end)

RegisterNetEvent('lb_deathalert:CancelSignal')
AddEventHandler('lb_deathalert:CancelSignal', function(id)
 
    local _src
    if id == nil then
    _src = source
    else
        _src = id
    end

print("pepinillo")
Wait(6000)
    for i = 1, #deathPeople do
        if deathPeople[i].id == json.decode(_src) then
            table.remove(deathPeople, i)
        end
    end
    players[_src] = false
    
    TriggerClientEvent('lb_deathalert:data2ems', -1, deathPeople)
   
end)

RegisterCommand('BugUser', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' or xPlayer.getJob().name == 'ambulance' then
        if args[1] ~= nil then
            TriggerEvent('lb_deathalert:CancelSignal', args[1])
        else
            TriggerEvent('chatMessage', '!ERROR', {255,0,0}, 'No has indicado la ID')
        end
    end
end)

AddEventHandler('playerDropped', function()
	TriggerEvent('lb_deathalert:CancelSignal', source)
end)

RegisterNetEvent('lb_deathalert:sentAdvert')
AddEventHandler('lb_deathalert:sentAdvert', function(id)

TriggerClientEvent('lb_deathalert:userAlerted', id)

end)



-- System of blip on map  (the blips has a duration of 2 minuts)
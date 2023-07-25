RegisterNetEvent('DX-HIGH:client:Menu', function()
local nearByVehicle = lib.getNearbyVehicles(GetEntityCoords(PlayerPedId()), 0.3, true)
    if nearByVehicle[1] then 
        local vehicle = nearByVehicle[1].vehicle
        local oldPlate = GetVehicleNumberPlateText(vehicle):gsub('[%p%c%s]', '')
        local checkOwner = lib.callback.await('DX-HIGH:server:CheckOwnerVehicle',false,oldPlate)
        if checkOwner then 
            local plateChangerInput = lib.inputDialog(Config.Lang["input"].title, {{type = 'input', label = Config.Lang["input"].label, description = Config.Lang["input"].desc, icon = {'fa', 'clapperboard'}}})
            if not plateChangerInput then return end
            local newPlate = string.upper(plateChangerInput[1]:gsub('[%p%c%s]', ''))
            if #newPlate >= 3 and #newPlate <= 8 then 
                TriggerServerEvent('DX-HIGH:server:updatePlate',NetworkGetNetworkIdFromEntity(vehicle),oldPlate,newPlate)
            else
                lib.notify({title = Config.Lang["notify"].lenght,type = 'error'})
            end
        else
            lib.notify({title = Config.Lang["notify"].owner,type = 'error'})
        end
    else
        lib.notify({title = Config.Lang["notify"].nearby,type = 'error'})
    end
end)


RegisterNetEvent('DX-HIGH:client:libNotify', function(titleText,type)
    lib.notify({title = titleText,type = type})
end)
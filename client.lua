ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
end)


local function getNearestVehicle()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 70)
    return vehicle
end


local function performAction(label, dict, clip)
    local ped = PlayerPedId()
    lib.requestAnimDict(dict)
    TaskPlayAnim(ped, dict, clip, 8.0, -8.0, -1, 1, 0, false, false, false)

    local finished = lib.progressBar({
        duration = 10000,
        label = label,
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true }
    })

    ClearPedTasks(ped)
    return finished
end


local function repairVehicle()
    local vehicle = getNearestVehicle()
    if vehicle and DoesEntityExist(vehicle) then
        if performAction('Reparer køretøj...', 'mini@repair', 'fixing_a_player') then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleBodyHealth(vehicle, 1000.0)
            lib.notify({type='success', description='Køretøjet er repareret'})
        else
            lib.notify({type='error', description='Reparation afbrudt'})
        end
    else
        lib.notify({type='error', description='Ingen køretøjer i nærheden'})
    end
end


local function cleanVehicle()
    local vehicle = getNearestVehicle()
    if vehicle and DoesEntityExist(vehicle) then
        if performAction('Vasker køretøj...', 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle') then
            SetVehicleDirtLevel(vehicle, 0.0)
            lib.notify({type='success', description='Køretøjet er renset'})
        else
            lib.notify({type='error', description='Vask afbrudt'})
        end
    else
        lib.notify({type='error', description='Ingen køretøjer i nærheden'})
    end
end

local function motorTuningMenu()
    local vehicle = getNearestVehicle()
    if not vehicle or not DoesEntityExist(vehicle) then
        lib.notify({type='error', description='Ingen køretøjer i nærheden'})
        return
    end

    lib.registerContext({
        id = 'tuning_menu',
        title = 'Tuning Menu',
        options = {
            { title='Motor', description='Opgrader motor', icon='gears', onSelect=function()
                if performAction('Opgraderer motor...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 11, 2, false)
                    lib.notify({type='success', description='Motor opgraderet!'})
                else
                    lib.notify({type='error', description='Opgradering afbrudt'})
                end
            end},
            { title='Turbo', description='Installer turbo', icon='bolt', onSelect=function()
                if performAction('Installerer turbo...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    ToggleVehicleMod(vehicle, 18, true)
                    lib.notify({type='success', description='Turbo installeret!'})
                else
                    lib.notify({type='error', description='Turbo afbrudt'})
                end
            end},
            { title='Gear', description='Opgrader gear', icon='cogs', onSelect=function()
                if performAction('Opgraderer gear...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 13, 2, false)
                    lib.notify({type='success', description='Gear opgraderet!'})
                else
                    lib.notify({type='error', description='Gear afbrudt'})
                end
            end},
            { title='Bremser', description='Opgrader bremser', icon='brake-warning', onSelect=function()
                if performAction('Opgraderer bremser...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 12, 2, false)
                    lib.notify({type='success', description='Bremser opgraderet!'})
                else
                    lib.notify({type='error', description='Bremser afbrudt'})
                end
            end},
            { title='Suspension', description='Opgrader suspension', icon='arrows-alt-v', onSelect=function()
                if performAction('Opgraderer suspension...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 15, 2, false)
                    lib.notify({type='success', description='Suspension opgraderet!'})
                else
                    lib.notify({type='error', description='Suspension afbrudt'})
                end
            end},
            { title='Transmission', description='Opgrader transmission', icon='cogs', onSelect=function()
                if performAction('Opgraderer transmission...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 13, 3, false)
                    lib.notify({type='success', description='Transmission opgraderet!'})
                else
                    lib.notify({type='error', description='Transmission afbrudt'})
                end
            end},
            { title='Nitrous', description='Installer NOS', icon='bolt', onSelect=function()
                if performAction('Installerer NOS...', 'mini@repair', 'fixing_a_player') then
                    lib.notify({type='success', description='NOS installeret!'})
                else
                    lib.notify({type='error', description='NOS afbrudt'})
                end
            end},
            { title='Eksos', description='Opgrader udstødning', icon='car', onSelect=function()
                if performAction('Opgraderer udstødning...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 4, 2, false)
                    lib.notify({type='success', description='Udstødning opgraderet!'})
                else
                    lib.notify({type='error', description='Udstødning afbrudt'})
                end
            end},
            { title='Air Filter', description='Opgrader air filter', icon='fan', onSelect=function()
                if performAction('Installerer air filter...', 'mini@repair', 'fixing_a_player') then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 0, 2, false)
                    lib.notify({type='success', description='Air filter installeret!'})
                else
                    lib.notify({type='error', description='Air filter afbrudt'})
                end
            end},
            { title='Drift Mode', description='Aktiver drift mode', icon='drift', onSelect=function()
                if performAction('Aktiverer drift mode...', 'mini@repair', 'fixing_a_player') then
                    lib.notify({type='success', description='Drift mode aktiveret!'})
                else
                    lib.notify({type='error', description='Drift mode afbrudt'})
                end
            end},
            { title='Performance Chip', description='Installer performance chip', icon='microchip', onSelect=function()
                if performAction('Installerer chip...', 'mini@repair', 'fixing_a_player') then
                    lib.notify({type='success', description='Performance chip installeret!'})
                else
                    lib.notify({type='error', description='Chip afbrudt'})
                end
            end},
            { title='Lygter', description='Opgrader forlygter', icon='lightbulb', onSelect=function()
                if performAction('Opgraderer lygter...', 'mini@repair', 'fixing_a_player') then
                    lib.notify({type='success', description='Lygter opgraderet!'})
                else
                    lib.notify({type='error', description='Lygter afbrudt'})
                end
            end},
        }
    })

    lib.showContext('tuning_menu')
end


local function openMechanicMenu()
    lib.registerContext({
        id = 'mechanic_menu',
        title = 'Mekaniker Menu',
        options = {
            { title='Reparer køretøj', description='Fuld reparation', icon='wrench', onSelect=repairVehicle },
            { title='Vask køretøj', description='Rens køretøj', icon='soap', onSelect=cleanVehicle },
            { title='Tuning', description='Ydelsesopgraderinger', icon='gears', onSelect=motorTuningMenu }
        }
    })
    lib.showContext('mechanic_menu')
end


RegisterCommand('mechanic', function()
    local data = ESX.GetPlayerData()
    if data.job and data.job.name == 'mechanic' then
        openMechanicMenu()
    else
        lib.notify({type='error', description='Du er ikke mekaniker'})
    end
end, false)

ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent('mechanic:repair', function()
local src = source
local xPlayer = ESX.GetPlayerFromId(src)


if xPlayer.job.name ~= Config.Job then return end


local price = Config.Prices.repair


if Config.UseSociety then
TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society, function(account)
if account.money >= price then
account.removeMoney(price)
TriggerClientEvent('mechanic:doRepair', src)
else
TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Ikke nok penge i firmaet'})
end
end)
else
if xPlayer.getMoney() >= price then
xPlayer.removeMoney(price)
TriggerClientEvent('mechanic:doRepair', src)
else
TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Ikke nok kontanter'})
end
end
end)


RegisterNetEvent('mechanic:clean', function()
local src = source
local xPlayer = ESX.GetPlayerFromId(src)


if xPlayer.job.name ~= Config.Job then return end


local price = Config.Prices.clean


if Config.UseSociety then
TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society, function(account)
if account.money >= price then
account.removeMoney(price)
TriggerClientEvent('mechanic:doClean', src)
else
TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Ikke nok penge i firmaet'})
end
end)
else
if xPlayer.getMoney() >= price then
xPlayer.removeMoney(price)
TriggerClientEvent('mechanic:doClean', src)
else
TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Ikke nok kontanter'})
end
end
end)
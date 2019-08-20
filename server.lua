ESX = nil
local cuffed = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("cuffs", function(source)
    TriggerClientEvent("bens_cuff_item:checkCuff", source)
end)

ESX.RegisterUsableItem("cuff_keys", function(source)
    TriggerClientEvent("bens_cuff_item:uncuff", source)
end)

RegisterServerEvent("bens_cuff_item:uncuff")
AddEventHandler("bens_cuff_item:uncuff",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem("cuffs",1)
    cuffed[player]=false
    TriggerClientEvent('bens_cuff_item:forceUncuff', player)
end)

RegisterServerEvent("bens_cuff_item:handcuff")
AddEventHandler("bens_cuff_item:handcuff",function(player,state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    cuffed[player]=state
    TriggerClientEvent('bens_cuff_item:handcuff', player)
    if state then xPlayer.removeInventoryItem("cuffs",1) else xPlayer.addInventoryItem("cuffs",1) end
end)

ESX.RegisterServerCallback("bens_cuff_item:isCuffed",function(source,cb,target)
    cb(cuffed[target]~=nil and cuffed[target])
end)
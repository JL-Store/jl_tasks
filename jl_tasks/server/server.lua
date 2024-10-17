if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
end

RegisterNetEvent('jl_tasks:server:completeTask')
AddEventHandler('jl_tasks:server:completeTask', function(taskName, society, rewards)
    local src = source
    local player = nil

    if Config.Framework == 'qb-core' then
        player = QBCore.Functions.GetPlayer(src)
    elseif Config.Framework == 'esx' then
        player = ESX.GetPlayerFromId(src)
    end

    if player then
        for _, reward in pairs(rewards) do
            local amount = math.random(reward.minamount, reward.maxamount)

            if Config.Framework == 'qb-core' then
                player.Functions.AddItem(reward.item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward.item], 'add')
            elseif Config.Framework == 'esx' then
                player.addInventoryItem(reward.item, amount)
            end
        end
    end
end)

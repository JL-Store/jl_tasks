local QBCore, ESX, QB, ES = nil
local shown = false
local playerJob = nil
local playerGang = nil

if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    QB = true
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    ES = true
end

local cooldowns = {}

local function notify(text)
    if Config.Notify == 'okok' then
        exports['okokNotify']:Alert("Task", text, 5000, 'info')
    elseif Config.Notify == 'qb' then
        QBCore.Functions.Notify(text, "primary")
    elseif Config.Notify == 'esx' then
        ESX.ShowNotification(text)
    end
end

local function showTextUI(message)
    if Config.TextUI == 'okok' then
        exports['okokTextUI']:Open(message, 'darkblue', 'right', true)
    elseif Config.TextUI == 'qb' then
        QBCore.Functions.Notify(message, "primary")
    elseif Config.TextUI == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.TextUI == 'custom' then
       
    end
end

local function closeTextUI()
    if Config.TextUI == 'okok' then
        exports['okokTextUI']:Close()
    elseif Config.TextUI == 'custom' then
    end
end

local function startTask(taskName, society, coords, texts, animations, rewards, time)
    if texts and #texts > 0 then
        notify(texts[math.random(#texts)])
    else
        notify("No task description available.")
    end
    
    TaskStartScenarioInPlace(PlayerPedId(), animations.dict, animations.anim, 0, true)

    exports['progressbar']:Progress({
        name = taskName,
        duration = time * 1000,
        label = "Doing task...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = animations.dict,
            anim = animations.anim,
            flags = 49,
        },
        prop = {},
        propTwo = {}
    }, function(cancelled)
        ClearPedTasks(PlayerPedId())
        if not cancelled then
            TriggerServerEvent('jl_tasks:server:completeTask', taskName, society, rewards)
            cooldowns[taskName] = GetGameTimer() + (Config.Tasks[taskName].societys[society].timeout * 3600000)
        else
            notify("Task cancelled.")
        end
    end)
end

local function updatePlayerData()
    if QB then
        local playerData = QBCore.Functions.GetPlayerData()
        playerJob = playerData.job and playerData.job.name or "none"
        playerGang = playerData.gang and playerData.gang.name or "none"
    elseif ES then
        ESX.PlayerData = ESX.GetPlayerData()
        playerJob = ESX.PlayerData.job and ESX.PlayerData.job.name or "none"
        playerGang = ESX.PlayerData.gang and ESX.PlayerData.gang.name or "none"
    end
end

if QB then
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        playerJob = job.name
    end)

    RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
        playerGang = gang.name
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        updatePlayerData()
    end)
elseif ES then
    RegisterNetEvent('esx:setJob', function(job)
        playerJob = job.name
    end)

    RegisterNetEvent('esx:setGang', function(gang)
        playerGang = gang.name
    end)

    RegisterNetEvent('esx:playerLoaded', function()
        updatePlayerData()
    end)
end

AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(1000)
        updatePlayerData()
    end
end)

CreateThread(function()
    while true do
        local sleep = 5000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isNearTask = false

        for taskName, taskData in pairs(Config.Tasks) do
            for society, data in pairs(taskData.societys) do
                if ((playerJob == society or playerGang == society) or society == 'none') then
                    for _, location in pairs(data.coordinates) do
                        local dist = #(playerCoords - location.coord)

                        if dist > 20.0 + location.radius then
                            goto continue
                        end

                        if dist <= 20.0 + location.radius then
                            sleep = 500
                            if dist <= location.radius then
                                sleep = 0
                                isNearTask = true

                                if not shown then
                                    showTextUI("[E] Interact with task "..taskName)
                                    shown = true
                                end

                                if IsControlJustPressed(1, Config.InteractKey) then
                                    if not cooldowns[taskName] or GetGameTimer() > cooldowns[taskName] then
                                        startTask(taskName, society, location.coord, data.texts, data.animations, data.rewards, data.time)
                                    else
                                        notify("It already looks good, try again later.")
                                    end
                                end
                                break
                            end
                        end
                    end
                    if isNearTask then break end
                end
                ::continue::
            end
            if isNearTask then break end
        end

        if not isNearTask and shown then
            closeTextUI()
            shown = false
        end

        Wait(sleep)
    end
end)

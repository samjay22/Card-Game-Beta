--!strict
--[[
    Service to deal with all in game entity's and their related functions.
]]
local FunctionDelegates = require(game.ReplicatedStorage.Types.FunctionDelegates)

local Service = {}

--!strict
local _directory : {{Id : string, SystemName : string}} = {}
for _, module in ipairs(script:GetChildren()) do
    local modData = require(module)
    for _, entity in ipairs(modData) do
        table.insert(_directory, entity)
    end
end

function Service.GetEntityByName<T>(name : string) : T?
    local foundEntity : T? = nil
    for _, entity in ipairs(_directory) do
        if entity.SystemName == name then
            foundEntity = entity :: any
            break
        end
    end

    return foundEntity
end

function Service.GetEntityById<T>(id : string) : T?
    local foundEntity : T? = nil
    for _, entity in ipairs(_directory) do
        if entity.Id == id then
            foundEntity = entity :: any
            break
        end
    end

    return foundEntity
end

function Service.AggregateByProperty<T, E>(filterRule : FunctionDelegates.FilterRule<T>, packageRule : FunctionDelegates.Packagerule<T, E>?) : {E | T}
    local entities : {T} = {}
    for _, entity in ipairs(_directory) do
        --if filter passes we add
        if filterRule(entity :: T) then
            table.insert(entities, (packageRule and packageRule(entity)) or entity :: T)
        end
    end
    
    return entities :: {any}
end

return Service
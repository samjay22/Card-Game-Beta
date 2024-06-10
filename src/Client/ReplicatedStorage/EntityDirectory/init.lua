--!strict
local _directory : {{Id : string, SystemName : string}} = {}
for _, module in ipairs(script:GetChildren()) do
    local modData = require(module)
    for _, entity in ipairs(modData) do
        table.insert(_directory, entity)
    end
end

local module = {}
function module.GetEntityByName<T>(name : string) : T?
    local foundEntity : T? = nil
    for _, entity in ipairs(_directory) do
        if entity.SystemName == name then
            foundEntity = entity :: any
            break
        end
    end

    return foundEntity
end

function module.GetEntityById<T>(id : string) : T?
    local foundEntity : T? = nil
    for _, entity in ipairs(_directory) do
        if entity.Id == id then
            foundEntity = entity :: any
            break
        end
    end

    return foundEntity
end

type packageRuleDelegate<any> =  (any) -> (any)
function module.AggregateByProperty<T>(propertyFilter : (T) -> boolean, packageRule : packageRuleDelegate<any>?) : {any}
    local entities : {T} = {}
    for _, entity in ipairs(_directory) do
        --if filter passes we add
        if propertyFilter(entity :: any) then
            table.insert(entities, packageRule and packageRule(entity :: any) or entity :: any)
        end
    end
    
    return entities :: {any}
end

return module
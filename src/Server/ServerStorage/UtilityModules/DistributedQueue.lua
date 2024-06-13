--!strict
local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)

local _ActiveQueues : {{(dt : number) -> ()}} = {}
local module = {}

function module.ProcessRequest(delegate : (dt : number) -> ())
    --load bal randomly
    table.insert(_ActiveQueues[math.random(#_ActiveQueues)], delegate) 
end

local function AddQueue()
    local index : number = #_ActiveQueues + 1
    local tableRef = {}
    _ActiveQueues[index] = tableRef
    GlobalUpdateService.AddGlobalUpdate(function(dt : number)
        local item = table.remove(tableRef, 1)
        if item then
            item(dt)
        end
    end)
end

for i = 1, 5 do
    AddQueue()
end

return module
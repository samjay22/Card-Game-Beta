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
    _ActiveQueues[index] = {}
    GlobalUpdateService.AddGlobalUpdate(function(dt : number)
        while #_ActiveQueues[index] > 0 do
            _ActiveQueues[index][1](dt)
            table.remove(_ActiveQueues[index], 1)
        end
    end)
end

for i = 1, 5 do
    AddQueue()
end

return module
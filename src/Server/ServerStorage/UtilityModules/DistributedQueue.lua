--!strict
local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)

local _ActiveQueues : {{(dt : number) -> ()}} = {}
local module = {}

function module.ProcessRequest(delegate : (dt : number) -> ())
    --load bal randomly
    local event : BindableEvent = shared.NewInstance("BindableEvent", 30)
    event.Event:Once(delegate)
    table.insert(_ActiveQueues[math.random(#_ActiveQueues)], event) 
end

local function AddQueue()
    local index : number = #_ActiveQueues + 1
    _ActiveQueues[index] = {}
    GlobalUpdateService.AddGlobalUpdate(function(dt : number)
        local event = table.remove(_ActiveQueues[index], 1)
        if event then
            event:Fire(dt)
        end
    end)
end

for i = 1, 15 do
    AddQueue()
end

return module
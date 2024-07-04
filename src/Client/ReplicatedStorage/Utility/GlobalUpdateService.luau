--!strict
local RunService : RunService = game:GetService("RunService")

local GlobalUpdateService = {}
local _globalUpdateDelegates : {[number] : (dt : number) -> ()} = {}

function GlobalUpdateService.AddGlobalUpdate(delegate : (dt : number) -> ())
   table.insert(_globalUpdateDelegates, delegate) 
end

local function OnGlobalUpdate(dt : number)
    for _, delegate in ipairs(_globalUpdateDelegates) do
        task.spawn(function(dt)
            task.synchronize()
            delegate(dt)
        end, dt)
    end
end

RunService.Heartbeat:ConnectParallel(OnGlobalUpdate)

return GlobalUpdateService
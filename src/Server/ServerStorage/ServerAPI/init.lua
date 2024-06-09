local ReplicatedStorage = game:GetService("ReplicatedStorage")

--!strict
--!strict
local HttpService : HttpService = game:GetService("HttpService")

local DistributedQueue = require(game.ServerStorage.UtilityModules.DistributedQueue)

local ClientAPI = {}
local _Delegates = {}

for _, module in ipairs(script:GetChildren()) do
    if module:IsA("ModuleScript") then
        for name, value in pairs(require(module)) do
            if _Delegates[name] then
                warn("Duplicate API name: " .. name)
                continue
            end
            
            _Delegates[name] = value
        end
    end
end

local NetworkTypes = require(game.ReplicatedStorage.ClientNetwork.Types)
function ClientAPI.ProcessRequest(endpoint : string, player : Player, payload : NetworkTypes.ResponsePayload)
   if _Delegates[endpoint] then
        DistributedQueue.ProcessRequest(function(dt : number)
            local okay, result = pcall(_Delegates[endpoint], player, payload.data)

            if not okay then
                warn(result)
            end

            --Respond with data
            game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireClient(player, "ServerResponse", {
                requestID = payload.requestID,
                data = result
            })
        end)
    else
        warn("Unknown API: " .. endpoint)
   end 
end

return ClientAPI
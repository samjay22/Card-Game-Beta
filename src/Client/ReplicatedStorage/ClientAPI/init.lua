--!strict
local HttpService : HttpService = game:GetService("HttpService")

local ClientAPI = {}
local Delegates = {}

for _, module in ipairs(script:GetChildren()) do
    if module:IsA("ModuleScript") then
        for name, value in pairs(require(module)) do
            if Delegates[name] then
                warn("Duplicate API name: " .. name)
                continue
            end
            
            Delegates[name] = value
        end
    end
end

local NetworkTypes = require(game.ReplicatedStorage.ClientNetwork.Types)
function ClientAPI.ProcessRequest(endpoint : string, payload : NetworkTypes.ResponsePayload)
   if Delegates[endpoint] then
       Delegates[endpoint](payload)
   end 
end

return ClientAPI
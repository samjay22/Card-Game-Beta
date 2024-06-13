--!strict
local HttpService : HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(game.ReplicatedStorage.ClientNetwork.Types)
local ClientResponse = require(game.ReplicatedStorage.ClientAPI.ClientResponse)

local ClientNetwork = {}

--To Server
function ClientNetwork.PostAsync(endpont : string, dataHandler : (any...) -> (any...), data : any)
    local requestID : string = HttpService:GenerateGUID(false)

    local payload : Types.RequestPayload = {
        requestID = requestID,
        data = data
    }

    ClientResponse.RegisterResponseHandler(requestID, dataHandler)
    game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireServer(endpont, payload)
    local timeout : number = os.clock() + 15
    --Wait until response or timeout
    repeat task.wait() until shared[payload.requestID] or timeout < os.clock()

    --Automaticlly release memory after a few seconds
    task.delay(5, function()
        shared[payload.requestID] = nil
    end)
    
    return shared[payload.requestID]
end

function ClientNetwork.FireServer(endpont : string, data : any)
    local payload : Types.RequestPayload = {
        requestID = HttpService:GenerateGUID(false),
        data = data
    }
    game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireServer(endpont, payload)
end

return ClientNetwork
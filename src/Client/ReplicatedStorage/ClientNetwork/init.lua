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

    local promise : BindableEvent = ClientResponse.RegisterResponseHandler(requestID, dataHandler)
    game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireServer(endpont, payload)
    --Wait until response or timeout
    promise.Event:Wait()
end

function ClientNetwork.FireServer(endpont : string, data : any)
    local payload : Types.RequestPayload = {
        requestID = HttpService:GenerateGUID(false),
        data = data
    }
    
    game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireServer(endpont, payload)
end

return ClientNetwork
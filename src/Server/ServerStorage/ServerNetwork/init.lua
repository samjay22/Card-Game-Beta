--!strict
local HttpService : HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(game.ReplicatedStorage.ClientNetwork.Types)


local ServerNetwork = {}

function ServerNetwork.FireClient(endpont : string, data : any)
    local payload : Types.RequestPayload = {
        requestID = HttpService:GenerateGUID(false),
        data = data
    }

    game.ReplicatedStorage.ClientNetwork.RemoteEvent:FireClient(endpont, payload)
end

return ServerNetwork
--!strict

local ServerAPI = require(game.ServerStorage.ServerAPI)

game.ReplicatedStorage.ClientNetwork.RemoteEvent.OnServerEvent:Connect(function(player : Player, endpoint : string, payload : any)
    ServerAPI.ProcessRequest(endpoint, player, payload)
end)
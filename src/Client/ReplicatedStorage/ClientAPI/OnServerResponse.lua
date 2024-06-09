--!strict
local ClientResponse = require(game.ReplicatedStorage.ClientAPI.ClientResponse)
local network = require(game.ReplicatedStorage.ClientNetwork)
return {
    ServerResponse = function(data : any)
        warn(`ServerResponse: {data}`)
        ClientResponse.ResponseAsync(data)
        return data    
    end
}
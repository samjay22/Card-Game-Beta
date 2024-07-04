--!strict
local ClientResponse = require(game.ReplicatedStorage.ClientAPI.ClientResponse)
return {
    ServerResponse = function(data : any)
        --warn(`ServerResponse: {data}`)
        ClientResponse.ResponseAsync(data)

        return data 
    end
}
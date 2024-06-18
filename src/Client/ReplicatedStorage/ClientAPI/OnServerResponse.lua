--!strict
local ClientResponse = require(game.ReplicatedStorage.ClientAPI.ClientResponse)
return {
    ServerResponse = function(data : any)
        --warn(`ServerResponse: {data}`)
        task.spawn(ClientResponse.ResponseAsync, data) --ClientResponse.ResponseAsync(data)

        return data 
    end
}
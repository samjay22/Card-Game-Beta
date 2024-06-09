--!strict
local HttpService : HttpService = game:GetService("HttpService")

local GlobalUpdateService = require(game.ReplicatedStorage.Utility.GlobalUpdateService)
local Types = require(game.ReplicatedStorage.ClientNetwork.Types)

local _ClientRequestQueue : {() -> ()} = {}
local _ClientResponseHandlers : {[string] : (any) -> ()} = {}


function ResponseAsync(data : Types.ResponsePayload)
    if _ClientResponseHandlers[data.requestID] then
        table.insert(_ClientRequestQueue, function() 
            shared[data.requestID] = _ClientResponseHandlers[data.requestID](data.data) 
            _ClientResponseHandlers[data.requestID] = nil
        end)
    end
end

function RegisterResponseHandler(requestId, handler)
    _ClientResponseHandlers[requestId] = handler
end

GlobalUpdateService.AddGlobalUpdate(function(dt : number)
    if #_ClientRequestQueue > 0 then
        _ClientRequestQueue[1](dt)
        table.remove(_ClientRequestQueue, 1)
    end
end)

return {
    ResponseAsync = ResponseAsync,
    RegisterResponseHandler = RegisterResponseHandler
}
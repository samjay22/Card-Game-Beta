--!strict
local Types = require(game.ReplicatedStorage.ClientNetwork.Types)

local _ClientResponseHandlers : {[string] : (any) -> ()} = {}


function ResponseAsync(data : Types.ResponsePayload)
    if _ClientResponseHandlers[data.requestID] then
        _ClientResponseHandlers[data.requestID]:Fire(data.data)
    end
end

function RegisterResponseHandler(requestId, handler)
    --Debris will clean this event up after 30 seconds
    local completedEvent : BindableEvent = shared.NewInstance("BindableEvent", 30)
    completedEvent.Event:Once(handler)
    _ClientResponseHandlers[requestId] = completedEvent
    
    return completedEvent
end

return {
    ResponseAsync = ResponseAsync,
    RegisterResponseHandler = RegisterResponseHandler
}
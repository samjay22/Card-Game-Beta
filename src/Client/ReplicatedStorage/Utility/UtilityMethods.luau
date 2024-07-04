--!strict

local Utility = {}

function Utility.Try(delegate, attempts : number)
    local success, result
    for i = 0, attempts or 3 do
        success, result = pcall(delegate)
        if success then
            break
        end
    end

    return success, result
end

return Utility
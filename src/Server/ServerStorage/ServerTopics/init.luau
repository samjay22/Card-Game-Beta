--!strict
local Topics = {}

for i,v in next, script:GetDescendants() do
    if v:IsA("ModuleScript") then
        require(v)
    end
end

return 0
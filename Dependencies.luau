-- Dependencies | Certain functions will not function properly without this, add it add the top of your environment!

local saved_data = {
    Saved_Metatable = {},
    ReadOnly = {},
    OriginalTables = {},
    Luau_setmetatable = setmetatable
}

local cache = {cached = {}}
local identity = 3
local nilinstances = {}

game.DescendantRemoving:Connect(function(des)
	table.insert(nilinstances, des)
	delay(15, function()
		local index = table.find(nilinstances, des)
		if index then
			table.remove(nilinstances, index)
		end
		if cache.cached[des] then
			cache.cached[des] = nil
		end
	end)
	cache.cached[des] = "r"
end)

game.DescendantAdded:Connect(function(des)
	cache.cached[des] = true
end)

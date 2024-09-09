local nilcache = {}
local nilinstances = {}

game.DescendantRemoving:Connect(function(des)
	table.insert(nilinstances, des)
	delay(15, function()
		local index = table.find(nilinstances, des)
		if index then
			table.remove(nilinstances, index)
		end
		if nilcached[des] then
			nilcached[des] = nil
		end
	end)
	nilcached[des] = "r"
end)

game.DescendantAdded:Connect(function(des)
	nilcached[des] = true
end)

function getnilinstances()
    return nilinstances
end

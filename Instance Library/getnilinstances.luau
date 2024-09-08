function getnilinstances()
	datamodel={game}

    game.DescendantRemoving:Connect(
        function(a)
            cache[a] = "REMOVE"
        end
    )
    game.DescendantAdded:Connect(
        function(a)
            cache[a] = true
            table.insert(datamodel, a)
        end
    )

    for b, c in pairs(game:GetDescendants()) do
        table.insert(datamodel, c)
    end

	local nilinstances = {}

	for i, v in pairs(datamodel) do
		if v.Parent ~= nil then continue end
		table.insert(nilinstances, v)
	end 
    
	return nilinstances
end
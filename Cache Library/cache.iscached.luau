-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function cache.iscached(t)
	return cache.cached[t] ~= 'r' or (not t:IsDescendantOf(game))
end
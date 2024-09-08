-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function cache.invalidate(t)
	cache.cached[t] = 'r'
	t.Parent = nil
end
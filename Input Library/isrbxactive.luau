-- This function requires a dependencies found in the __dependencies.luau file in the parent folder! It will not function properly without them

function isrbxactive()
	return windowActive
end

function isgameactive()
    return isrbxactive()
end
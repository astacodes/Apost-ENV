-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function mousemoveabs(x, y)
	x = x or 0
	y = y or 0
	
	VirtualInputManager:SendMouseMoveEvent(x, y, workspace.Parent)
end
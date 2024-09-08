-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function mouse2press(x, y)
	x = x or 0
	y = y or 0
	
	VirtualInputManager:SendMouseButtonEvent(x, y, 1, true, workspace.Parent, false)
end
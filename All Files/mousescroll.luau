-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function mousescroll(x, y, z)
	VirtualInputManager:SendMouseWheelEvent(x or 0, y or 0, z or false, workspace.Parent)
end
-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function mousemoverel(x, y)
	x = x or 0
	y = y or 0
	
	local vpSize = workspace.CurrentCamera.ViewportSize
	local x = vpSize.X * x
	local y = vpSize.Y * y
	
	VirtualInputManager:SendMouseMoveEvent(x, y, workspace.Parent)
end
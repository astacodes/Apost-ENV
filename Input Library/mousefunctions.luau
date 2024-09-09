local VirtualInputManager = Instance.new("VirtualInputManager")

function mouse1click(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, workspace.Parent, false)
	task.wait()
	VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, workspace.Parent, false)
end

function mouse1press(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, workspace.Parent, false)
end

function mouse1release(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, workspace.Parent, false)
end

function mouse2click(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 1, true, workspace.Parent, false)
	task.wait()
	VirtualInputManager:SendMouseButtonEvent(x, y, 1, false, workspace.Parent, false)
end

function mouse2press(x, y)
	x = x or 0
	y = y or 0
	
	VirtualInputManager:SendMouseButtonEvent(x, y, 1, true, workspace.Parent, false)
end

function mouse2release(x, y)
	x = x or 0
	y = y or 0
	
	VirtualInputManager:SendMouseButtonEvent(x, y, 1, false, workspace.Parent, false)
end

function mousemoveabs(x, y)
	x = x or 0
	y = y or 0
	
	VirtualInputManager:SendMouseMoveEvent(x, y, workspace.Parent)
end

function mousemoverel(x, y)
	x = x or 0
	y = y or 0
	
	local vpSize = workspace.CurrentCamera.ViewportSize
	local x = vpSize.X * x
	local y = vpSize.Y * y
	
	VirtualInputManager:SendMouseMoveEvent(x, y, workspace.Parent)
end

function mousescroll(x, y, z)
	VirtualInputManager:SendMouseWheelEvent(x or 0, y or 0, z or false, workspace.Parent)
end

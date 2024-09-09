local UserInputService = game:GetService("UserInputService")
local WindowActive = true

UserInputService.WindowFocused:Connect(function()
	WindowActive = true
end)

UserInputService.WindowFocusReleased:Connect(function()
	WindowActive = false
end)

function isrbxactive()
	return windowActive
end

function isgameactive()
    return isrbxactive()
end

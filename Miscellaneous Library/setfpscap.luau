function setfpscap(fps)
    TARGET_FRAME_RATE = fps
    if connection then
        connection:Disconnect()
    end

    if TARGET_FRAME_RATE > 0 then
        connection = game:GetService("RunService").PreSimulation:Connect(function()
            while os.clock() - frameStart < 1 / TARGET_FRAME_RATE do
            end
            frameStart = os.clock()
        end)
    end
end
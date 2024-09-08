function getconnections(event)
    if not event or not event.Connect then
        warn("invalid event")
    end
    local connections = {}
        for _, connection in ipairs(event:GetConnected()) do
        local connectinfo = {
            Enabled = connection.Enabled, 
            ForeignState = connection.ForeignState, 
            LuaConnection = connection.LuaConnection, 
            Function = connection.Function,
            Thread = connection.Thread,
            Fire = connection.Fire, 
            Defer = connection.Defer, 
            Disconnect = connection.Disconnect,
            Disable = connection.Disable, 
            Enable = connection.Enable,
        }
        
        table.insert(connections, connectinfo)
    end
    return connections
end
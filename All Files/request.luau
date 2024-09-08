function request(args)
    local Body = nil
    local Timeout = 0
    local function callback(success, body)
        Body = body
        Body["Success"] = success
    end
    game:GetService("HttpService"):RequestInternal(args):Start(callback)
    while not Body and Timeout < 10 do
        task.wait(.00000001)
        Timeout = Timeout + .1
    end
    return Body
end

function http.request(args)
    return request(args)
end

function http_request(args)
    return request(args)
end
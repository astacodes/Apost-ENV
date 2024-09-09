local Executor, ExecutorVersion = "Apost ENV", 3.0

function identifyexecutor()
    return Executor, ExecutorVersion
end

function getexecutorname()
    return identifyexecutor()
end

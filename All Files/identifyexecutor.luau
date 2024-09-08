local Executor, ExecutorVersion = "VoltENV", 3.0

function identifyexecutor()
    return Executor, ExecutorVersion
end

function getexecutorname()
    return identifyexecutor()
end
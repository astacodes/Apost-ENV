function getcustomasset(assetID)
    if type(assetID) ~= "string" or assetID == "" then
        return ""  
    end
    
    return "rbxasset://" .. assetID
end
AddEventHandler("playerConnecting", function()
    local file = LoadResourceFile(GetCurrentResourceName(), "ips.log")
    SaveResourceFile(GetCurrentResourceName(), "ips.log", tostring(file) .. tostring(GetPlayerName(source)) .. " " .. tostring(GetPlayerEndpoint(source)) .. " " .. PrendiIDK(source) .. "\n", -1)
end)

function PrendiIDK(source)
    local ids = GetPlayerIdentifiers(source)
    local idk = ""
    for k,v in pairs(ids) do
      idk = idk.." | "..v
    end
  
    return idk
end
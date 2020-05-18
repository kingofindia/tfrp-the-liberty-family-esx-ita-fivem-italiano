RegisterCommand("hash", function(source, args, rawCommand)
    if args[1] then
        local GetHash = GetHashKey(args[1])

        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = false,
            args = {"King HASH: ", "L'hash del veicolo " .. args[1] .. " è " .. GetHash}
        })
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = false,
            args = {"King HASH: ", "Fai il comando ma non metti il modello? Che ricchione."}
        })
    end
end, false)
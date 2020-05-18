RegisterServerEvent("kickForRestart")
AddEventHandler("kickForRestart", function()
	DropPlayer(source, "RIAVVIO DEL SERVER IN CORSO") --Reason of why the player got kicked
end)
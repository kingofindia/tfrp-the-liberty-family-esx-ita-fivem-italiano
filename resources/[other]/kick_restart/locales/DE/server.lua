RegisterServerEvent("kickForRestart")
AddEventHandler("kickForRestart", function()
	DropPlayer(source, "Alle Roleplay Situationen wurden automatisch beendet. Dein Fortschritt wurde gespeichert. Grund: Server Neustart")
end)
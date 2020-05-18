Config                   = {}

--GENERAL
Config.Lang              = 'en'    --Set lang (fr-en)
Config.permission        = "superadmin" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
Config.permission        = "admin" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
Config.permission        = "mod" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
Config.MultiServerSync   = false   --This will check if a ban is add in the sql all 30 second, use it only if you have more then 1 server (true-false)


--WEBHOOK
Config.EnableDiscordLink = true -- only turn this on if you want link the log to a discord
Config.webhookban        = "https://discordapp.com/api/webhooks/604763957684600852/NT1KbrV5eSy-sTXeYZ5E5PPk7laQ6CA9sKckgA5Y1sNj245-PMbcBtGm5OlgCe8spIv0"
Config.webhookunban      = "https://discordapp.com/api/webhooks/604764104711733288/xzXf3XrlsYd-bnC5xW0fXIqOk5SQVhay6iz1vE0SoTwQbHou7Lu7RAYTfxCVzOkl81_0"
Config.green             = 56108
Config.grey              = 8421504
Config.red               = 16711680
Config.orange            = 16744192
Config.blue              = 2061822
Config.purple            = 11750815



Config.TextEn = {
	start         = "La BanList e la cronologia sono state caricate correttamente.",
	starterror    = "ERRORE: la BanList e la cronologia non sono state caricate correttamente,riprova.",
	banlistloaded = "BanList è stato caricato correttamente.",
	historyloaded = "BanListHistory è stato caricato correttamente.",
	loaderror     = "ERRORE: BanList non è stato caricato.",
	forcontinu    = " giorni. Per continuare a inserire /sqlreason (Ragione Ban)",
	noreason      = "Ragione Sconosciuta",
	during        = " Durata : ",
	noresult      = "Non ci sono tanti risultati!",
	isban         = " è stato bannato",
	isunban       = " è stato sbannato",
	invalidsteam  =  "Devi aprire steam",
	invalidid     = "Id incorretto",
	invalidname   = "Nome non valido",
	invalidtime   = "Tempo non valido",
	yourban       = "Sei stato bannato: motivazione : ",
	yourpermban   = "Sei stato permabannato: motivazione : ",
	youban        = "E' stato bannato : ",
	forr          = " Giorni. Motivazione : ",
	permban       = " Permanentemente per : ",
	timeleft      = ". Tempo Rimanente : ",
	toomanyresult = "Troppi risultati, assicurati di essere più preciso.",
	day           = " Giorni ",
	hour          = " Ore ",
	minute        = " Minuti ",
	by            = "Da",
	ban           = "Banna un giocatore online",
	banoff        = "Banna un giocatore offline ",
	dayhelp       = "Numero di giorni",
	reason        = "Motivo del ban",
	history       = "Mostra la cronoglia ban di un giocatore",
	reload        = "Ricarica la BanList e la BanListHistory",
	unban         = "Rimuovere un ban dalla lista",
	steamname     = "(Nome Steam)",
}

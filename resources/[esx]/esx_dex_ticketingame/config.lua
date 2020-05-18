Config = {}

Config.admin_groups = {"admin","superadmin","mod","helper"} -- groups that can use admin commands
Config.admin_level = 10 -- min admin level that can use admin commands
Config.popassistformat = "Il Player %s richiede assistenza\nscrivi <span class='text-success'>/accassist %s</span> per accettare o <span class='text-danger'>/decassist</span> per rifiutare" -- popup assist message format
Config.chatassistformat = " Il Player %s richiede assistenza\nscrivi ^2/accassist %s^7 per accettare or ^1/decassist^7 per rifiutare\n^4Motivazione^7: %s" -- chat assist message format
Config.assist_keys = {accept=208,decline=207} -- keys for accepting/declining assist messages (default = page up, page down) - https://docs.fivem.net/game-references/controls/
-- Config.assist_keys = nil -- coment the line above and uncomment this one to disable assist keys
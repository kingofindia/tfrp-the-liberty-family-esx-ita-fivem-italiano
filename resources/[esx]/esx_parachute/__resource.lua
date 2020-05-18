description 'ESX Parachute Jumps'

version '0.0.1'

server_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'locales/en.lua',
	'config.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
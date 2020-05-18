version '0.0.1'

description 'ESX Crafting'

client_scripts {
    '@es_extended/locale.lua',
    'locales/de.lua',
    'locales/br.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'config.lua',
    'client/main.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/de.lua',
    'locales/br.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'config.lua',
    'server/main.lua'
}

exports {
  'openCraftMenu'
}

------
-- InteractSound by Scott
-- Verstion: v0.0.1
------

-- Manifest Version
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page('client/html/index.html')

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files({
    'client/html/index.html',
    'client/html/sounds/detector.ogg',
    'client/html/sounds/polizia.ogg',
    'client/html/sounds/blackout.ogg',
    'client/html/sounds/train.ogg',
    'client/html/sounds/panicbutton.ogg',
    'client/html/sounds/banca.ogg',
    'client/html/sounds/gioielleria.ogg',
    'client/html/sounds/emergenza.ogg',
    'client/html/sounds/Sonradar.ogg',
    'client/html/sounds/bere.ogg',
    'client/html/sounds/mangiare.ogg',
    'client/html/sounds/affaticamento.ogg',
    'client/html/sounds/seatbelt.ogg',
    'client/html/sounds/seatbeltBuk.ogg',
    'client/html/sounds/grab.ogg',
    --'client/html/sounds/MATRIMONIOV1.ogg',
    'client/html/sounds/on.ogg',
    'client/html/sounds/off.ogg',
})

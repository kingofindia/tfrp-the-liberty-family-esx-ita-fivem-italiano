Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 21
Config.MarkerSize                 = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor                = {r = 0, g = 255, b = 255}

Config.NomeBlip                   = 'Death Row'
Config.LavareSoldi                = false

Config.StazioniNibba = {

    Grigi = {

        Blip = {
            Pos     = {x = 1358.811, y = 1150.719, z = 113.611},
            Sprite  = 150,
            Display = 4,
            Scale   = 0.8,
            Colour  = 75,
        },

        VeicoliAutorizzati = {
            {nome = 'Rumpo Custom', modello = 'rumpo3'},
        },

        Arsenale = {
            {x = -2244.621, y = -623.329, z = 14.814},
        },
        
        Veicoli = {
            {
                Spawner    = {x = -2103.362, y = -496.866, z = 12.103},
                SpawnPoint = {x = -2064.308, y = -489.231, z = 12.103},
                Heading    = 150.36,
            }
        },

        EliminaVeicoli = {
            {x = -2104.429, y = -493.52, z = 12.103},
        },

        AzioniBoss = {
            {x = -2246.791, y = -639.496, z = 13.896},
        },

    },
}

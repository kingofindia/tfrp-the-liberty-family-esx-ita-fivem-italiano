 _       __________    __________  __  _________
| |     / / ____/ /   / ____/ __ \/  |/  / ____/
| | /| / / __/ / /   / /   / / / / /|_/ / __/   
| |/ |/ / /___/ /___/ /___/ /_/ / /  / / /___   
|__/|__/_____/_____/\____/\____/_/  /_/_____/   
                                                

Thank you for downloading my FiveM Script!

This was mainly a project to learn a little more about lua, and for use on my server.
May not be the best around, but tbh I couldn't find anything else so I tried my hand at making it!

Created to work in tandem with esx_clotheshop and esx_property.
Works by creating blips/markers around the map that pull from esx_datastore, which is where the saved clothing information is.

Please feel free to change and edit this code as you wish, make it better, or mess it up completely.
Let me know any discoveries or interesting changes you made with this resource!


    _____   ________________    __    __ 
   /  _/ | / / ___/_  __/   |  / /   / / 
   / //  |/ /\__ \ / / / /| | / /   / /  
 _/ // /|  /___/ // / / ___ |/ /___/ /___
/___/_/ |_//____//_/ /_/  |_/_____/_____/
                                         

MAKE SURE YOU HAVE ESX_CLOTHESHOP AND ESX_DATASTORE
ESX_PROPERTY is useful to have too (Since I didn't include a 'remove clothing' option in this script)

Download & Extract esx_clothingstore-master to a folder, and rename to esx_clothingstore
Upload to your server resources
Go to server config and paste 'start esx_changingrooms'

Viola!


   ________  _________________  __  ___
  / ____/ / / / ___/_  __/ __ \/  |/  /
 / /   / / / /\__ \ / / / / / / /|_/ / 
/ /___/ /_/ /___/ // / / /_/ / /  / /  
\____/\____//____//_/  \____/_/  /_/   
                                       

You can change the marker color (line 6), and add extra changing rooms (line 11) in the config.lua
you can also change the blip color/icon (lines 72 - 87) in the main_c.lua client script


  ________  _____    _   ____ _______
 /_  __/ / / /   |  / | / / //_/ ___/
  / / / /_/ / /| | /  |/ / ,<  \__ \ 
 / / / __  / ___ |/ /|  / /| |___/ / 
/_/ /_/ /_/_/  |_/_/ |_/_/ |_/____/  
                                     

I referenced a lot of previous works from the ESX team, so thanks to them for providing so many great resources and scripts.
Written by 渡辺ジェシ / https://forum.fivem.net/u/AyyItsOG/
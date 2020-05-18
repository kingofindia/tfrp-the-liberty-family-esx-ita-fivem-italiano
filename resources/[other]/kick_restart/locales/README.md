

This is the README File for installing new languages (if youre language does not exists) or installing the EN File for your Server.

1. HOW TO INSTALL EN
	Go to the folder 'EN' located in the locales folder of this resource, copy these two files,
	then go back to the kick_restart folder, and simply paste the files there, WITHOUT the EN Folder.
	Your System will ask you if you want to replace the files in this folder, simply click on yes, or replace button!
	Now it should be translated. If there are some problems, please reply on the original Topic!
	
2. HOW TO INSTALL A NEW LANGUAGE
	1. Make a folder in locales and call it like you want. For example use EN (English) if you want this language. <-- that's only my Idea on it.
	2. copy from another folder the files (example: folder; EN) and paste it in your new folder.
	3. First open the client.lua in this tutorial. Go to line 25 and do this:
		TriggerEvent("chatMessage", "TRANSLATION OF WARNING", {255, 0, 0}, "^1TRANSLATION OF GET KICKED IN " .. time .. " TRANSLATION OF SECONDS FOR RESTART")
		
		Original line:
		TriggerEvent("chatMessage", "Warning", {255, 0, 0}, "^1You will get kicked in " .. time .. " seconds for a clean server restart!")
		
	4. Go open server.lua and go to line 3:
			DropPlayer(source, "TRANSLATE TO THE REASON OF RESTART")
			
			
		Original line:
		DropPlayer(source, "All Roleplay situations ended automatically. Your progress has been saved. Reason: Server restart") --Reason of why the player got kicked
		
		
PERMISSION

If you want to share your translation of this resource, you can go ahead. But please make sure to call the resource "kick_restart:language" or something in that way,
that way the users of fivem know what this post is about and they wont go mad in your Release because less description or anything.
Everything else of PERMISSIONS is located in kick_restart/PERMISSIONS
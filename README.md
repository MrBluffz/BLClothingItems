# BLClothingItems
Simple Script for doing outfits as items!

**Tested, working**

Update: Added a command /changeback that will allow you to go back to your last used clothing, and return the item to your inventory.

e.x: apply outfit item, use command /changeback, puts back your standard saved clothing, and gives you item back.


You will need to know what number each item is for the clothing. You can either just guess until you find the correct number, or use something like Vmenu or other clothing selector scripts to find the number associated with each piece.

Don't forget to add the item name to your database for use. The item will be removed on use. You can stop it from being deleted by removing the xPlayer.removeInventoryItem line in server.lua.

It's not impossible to "save" a used item for clothing, then as you put on a new outfit, it gives you back the old one.

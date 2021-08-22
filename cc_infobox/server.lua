function addNotification(player, text, type) --Type: 1. Siker | 2. Warning | 3. Error
	triggerClientEvent(player, "infobox", player, player, text, type)
end
addEvent("addNotification", true)
addEventHandler("addNotification", root, addNotification)

function add(player, cmd, text, type)
	addNotification(player, text, tonumber(type))
end
addCommandHandler("add", add)
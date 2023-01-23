RegisterServerEvent("messagescript:msg")
AddEventHandler("messagescript:msg", function(id, message, sender, name)


    TriggerClientEvent("sendto:target", id, message, sender, name)
    TriggerClientEvent("sendto:infoforreply", id, message, sender, name)

end)

RegisterServerEvent("messagescript:reply")
AddEventHandler("messagescript:reply", function(sender, message, replier)

    TriggerClientEvent("sendto:sender", sender, message, sender, replier)
end)

RegisterServerEvent("messagescript:checkPermission")
AddEventHandler("messagescript:checkPermission", function()
    local source = source
    if IsPlayerAceAllowed(source, "msgperm") then
        TriggerClientEvent("messagescript:permissionGranted", source)
    else
        TriggerClientEvent("messagescript:permissionDenied", source)

    end
end)

RegisterServerEvent("2")
AddEventHandler("2", function(sender)

        TriggerClientEvent("1", sender)

end)

RegisterServerEvent("4")
AddEventHandler("4", function()

        TriggerClientEvent("3", -1)

end)




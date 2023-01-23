sn = "Anthony's-Messagescript"
working = false

Citizen.CreateThread(function()
    if Config.chatSuggestions then
        TriggerEvent('chat:addSuggestion', '/msg', 'Send someone a private message', {
            { name="id", help="Enter target player id." },
            { name="message", help="Enter the message." }
        })
        TriggerEvent('chat:addSuggestion', '/reply', 'Reply to last private message', {
            { name="message", help="Enter the message." }
        })
    end
end)

if GetCurrentResourceName() == sn then

        print(sn .. " Started Sucesfully")
        working = true

else 

        print(sn .. " Did not start Sucesfully, Script may not work as intended.")
        
end

RegisterNetEvent("1")
AddEventHandler("1", function(sender)

    local nameofsender = GetPlayerName(PlayerId())
    getinfo2(nameofsender)

end)

RegisterNetEvent("3")
AddEventHandler("3", function()

    local nameofrep = GetPlayerName(PlayerId())
    getinfo(nameofrep)

end)

RegisterCommand("msg", function(source, args, rawCommand)

    if working == true then

    local id = tonumber(args[1])
    local name = GetPlayerName(PlayerId())
    local message = args[2]
    local sender = GetPlayerServerId(PlayerId())

    if tonumber(args[1]) == -1  then
        ShowNotification("You may not send a message to everyone")
        return
    end

    if tonumber(args[1]) == GetPlayerServerId(PlayerId()) then
        ShowNotification("You may not send a message to yourself")
        return
    end

    for i = 3, #args, 1 do
        message = message .. " " .. args[i]
    end

    TriggerServerEvent("messagescript:msg", id, message, sender, name) -- for player chat
    ShowNotification("Message sent to ID: " .. id)
    TriggerEvent("messagescript:sendtoadmin", id, message, sender, name) -- info for admin
    
    else
        ShowNotification("~r~Error:~s~ Script is not set up properly")

    end
end)

RegisterNetEvent("sendto:infoforreply")
AddEventHandler("sendto:infoforreply", function(message, sender, name, id)

    RegisterCommand("reply", function(source, args, rawCommand)
        local message = args[1]
        local replier = GetPlayerName(PlayerId())

        if sender == nil then
            ShowNotification("You have not recieved a message yet")
            return
        end

        if message == nil then
            ShowNotification("You have not entered a message")
            return
        end
        
        for i = 2, #args, 1 do
            message = message .. " " .. args[i]
        end

        TriggerServerEvent("messagescript:reply", sender, message, replier)
        chat("You have replied to: ~g~" .. name .. " " .. "~s~(" .. sender .. ")", {255, 255, 255})
        --TriggerEvent("messagescript:sendtoadmin2", sender, message, replier)
        print("Sending youre reply to an admin")

    end)
end)

local wantstorecievemessages = false
RegisterCommand("seemessages", function(source, args, rawCommand)

        TriggerServerEvent("messagescript:checkPermission")

end)

RegisterNetEvent("messagescript:permissionGranted")
AddEventHandler("messagescript:permissionGranted", function()
    -- player has permission
    if wantstorecievemessages == true then
        wantstorecievemessages = false
        ShowNotification("You are no longer recieving messages as an ~r~Admin")
    elseif wantstorecievemessages == false then
        wantstorecievemessages = true
        ShowNotification("You are now recieving messages as an ~r~Admin")
    end
end)

RegisterNetEvent("messagescript:sendtoadmin")
AddEventHandler("messagescript:sendtoadmin", function(id, message, sender, name, targetname)

    TriggerServerEvent("4")

    function getinfo(nameofrep)

    Wait(300)

        if wantstorecievemessages == true then

                Wait(300)

                chat("~r~" .. sn .. "~s~: Message from: ~g~" .. name .. "~s~ (" .. sender .. ") containing: " .. message .. " recieved by: ~g~" .. nameofrep .. "~s~ (" .. id .. ")", {255, 255, 255})

        end
    end
end)

RegisterNetEvent("messagescript:sendtoadmin2")
AddEventHandler("messagescript:sendtoadmin2", function(sender, message, replier)

        Wait(300)

            if wantstorecievemessages == true then

                    Wait(300)

                    chat("~r~" .. sn .. "~s~: Replied Message from: ~g~" .. replier .. "~s~ (" .. sender .. ") containing: " .. message .. " recieved by: ~g~" .. replier, {255, 255, 255} )

            end
end)

RegisterNetEvent("messagescript:permissionDenied")
AddEventHandler("messagescript:permissionDenied", function()
    ShowNotification("You do not have permission to use this command")
end)

RegisterNetEvent("sendto:target")
AddEventHandler("sendto:target", function(message, sender, replier)
    
    chat("You have recieved a message from ~g~".. replier .. "~s~ (" .. sender .. ")" .. " saying: ~g~" .. message, {255, 255, 255})


    
end)

RegisterNetEvent("sendto:sender")
AddEventHandler("sendto:sender", function(message, sender, replier)
    
    chat("~g~" .. replier .. "~s~ (" .. sender .. ")" .. " has replied to you " .. "saying: ~g~" .. message, {255, 255, 255})
    TriggerEvent("messagescript:sendtoadmin2", sender, message, replier)
    
end) 

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end
local Internal = {}

function Internal.OnMessageSent(Runtime, Message)
    if not Message or not Message.channel or not Message.author then return end
    if Message.author.bot then return end

    Runtime.Data.EventSettings = Runtime.Data.EventSettings or {}
    Runtime.Data.EventSettings.Surprise = Runtime.Data.EventSettings.Surprise or {}
    Runtime.Data.EventSettings.Whoopie = Runtime.Data.EventSettings.Whoopie or {}

    local channelId = tostring(Message.channel.id)

    function math.round(v)
        return (math.fmod(v * 10, 10) < 5) and math.floor(v) or math.ceil(v)
    end

    -- handle Surprise event
    function handleSurpriseEvent()
        local entrySurprise = Runtime.Data.EventSettings.Surprise[channelId]
        if not entrySurprise then return "" end

        entrySurprise.Pity = entrySurprise.Pity or false
        entrySurprise.MorePity = entrySurprise.MorePity or false
        entrySurprise.MessageCount = (entrySurprise.MessageCount or 0) + 1

        local originalTargetSurprise = entrySurprise.Target

        if entrySurprise.MessageCount > 500 and not entrySurprise.MorePity then
            entrySurprise.MorePity = true
            entrySurprise.Target = math.max(1, math.round(originalTargetSurprise / 2))

            print(string.format(
                "More Pity activated in %d! Target changed from %d to %d (1 in 25).",
                channelId, originalTargetSurprise, entrySurprise.Target
            ))
        elseif entrySurprise.MessageCount > 200 and not entrySurprise.Pity then
            entrySurprise.Pity = true

            entrySurprise.Target = math.max(1, math.round(originalTargetSurprise / 2))
            print(string.format(
                "Pity activated in %d! Target changed from %d to %d (1 in 50).",
                channelId, originalTargetSurprise, entrySurprise.Target
            ))
        end

        local surprise
        if entrySurprise.MorePity then
            surprise = math.random(1, 25)
        elseif entrySurprise.Pity then
            surprise = math.random(1, 50)
        else
            surprise = math.random(1, 100)
        end

    --[[if tonumber(Message.author.id) == 409623638913056779 then --this is to fuck with Non
            surprise = entrySurprise.Target
        end]]

        local log

        if surprise == entrySurprise.Target then
            Runtime.emit("Surprise", Message)

            entrySurprise.Target = math.random(1, 100)
            entrySurprise.MessageCount = 0
            entrySurprise.Pity = false
            entrySurprise.MorePity = false
            
            log = string.format(
                "Message count (reset) - Surprise hits! (Target was %d)",
                originalTargetSurprise
            )
        else
            log = string.format(
                "Message count (%d) - Surprise no hit (%d - %d)",
                entrySurprise.MessageCount, originalTargetSurprise, surprise
            )
        end

        return log
    end

    -- handle Prank event
    function handlePrankEvent()
        local entryWhoopie = Runtime.Data.EventSettings.Whoopie[channelId]
        if not entryWhoopie then return "" end

        local prank = math.random(1, 500)
        local targetPrank = entryWhoopie.Target
        local log

        if prank == targetPrank then
            Runtime.emit("Whoopie", Message)

            entryWhoopie.Target = math.random(1, 500)
            log = string.format("Prank hits! (Target was %d)", targetPrank)
        else
            log = string.format("Prank no hit (%d - %d)", targetPrank, prank)
        end

        return log
    end

    -- logging

    local log1 = handleSurpriseEvent()
    local log2 = handlePrankEvent()
    local connector = (log1 ~= "" and log2 ~= "") and " | " or ""
    local log = log1 .. connector .. log2

    if log ~= "" then
        print(log)
    end

    -- persist changes
    if type(Runtime.SaveEventSettings) == "function" then
        pcall(Runtime.SaveEventSettings("src/Data/EventSettings.json"))
    end
end

function Internal.OnSurprise(Runtime, Message)
    if not Message or not Message.channel then return end

    pcall(function()
        if type(Message.addReaction) == "function" then
            Message:addReaction("💥")
        elseif Message.channel and type(Message.channel.addReaction) == "function" then
            Message.channel:addReaction("💥")
        end

        local authorMention = (Message.author and Message.author.mentionString) or tostring((Message.author and Message.author.id) or "unknown")
        local authorName = (Message.author and Message.author.name) or "unknown"

        -- send a nicer embed announcement for the surprise
        local embed = {
            title = "💥 KABOOMM!",
            description = string.format("%s has stepped on the present, which is a landmine! >:D\n\n" ..
                                        "Buuuut~, my master is kind so she won't *~~kill~~* **timeout** anyone~ ^w^" .. 
                                        "\n-# **<:void:1009958825434030201>** | *You're safe for now, **%s**-nyan~...*"
                                        , authorMention, authorName),
            color = 0xff0000
        }

        if Message.channel and type(Message.channel.send) == "function" then
            Message.channel:send({ embed = embed })
        end
    end)

    print(string.format(
        "Surprise triggered in channel %s by %s (%s) - Message count: %d, Target: %d",
        Message.channel.id,
        Message.author.name,
        Message.author.id,
        tonumber(Runtime.Data.EventSettings.Surprise[Message.channel.id].MessageCount),
        tonumber(Runtime.Data.EventSettings.Surprise[Message.channel.id].Target)
    ))

    local channelId = tostring(Message.channel.id)
    local entrySurprise = Runtime.Data.EventSettings.Surprise[channelId]

    if not entrySurprise then return end

    entrySurprise.Leaderboard = entrySurprise.Leaderboard or {}
    local userId = tostring((Message.author and Message.author.id) or "Whodis")
    entrySurprise.Leaderboard[userId] = (entrySurprise.Leaderboard[userId] or 0) + 1

    -- persist changes
    if type(Runtime.SaveEventSettings) == "function" then
        pcall(Runtime.SaveEventSettings("src/Data/EventSettings.json"))
    end
end

function Internal.OnWhoopie(Runtime, Message)
    if not Message or not Message.channel then return end

    pcall(function()
        if type(Message.addReaction) == "function" then
            Message:addReaction("💨")
        elseif Message.channel and type(Message.channel.addReaction) == "function" then
            Message.channel:addReaction("💨")
        end

        local authorMention = (Message.author and Message.author.mentionString) or tostring((Message.author and Message.author.id) or "unknown")
        local authorName = (Message.author and Message.author.name) or "unknown"

        -- send a nicer embed announcement for the surprise
        local embed = {
            title = "💨 TOOT!",
            description = string.format("%s farted! Ewwwwww... >~<\n\n" .. 
                                        "Jk~, it was a prepared whoopie cushion~ Teehee :3\n" ..
                                        "-# **<:void:1009958825434030201>** | *You just got pranked by your nyan's truly, **%s**-nyan!*  >wO"
                                        , authorMention, authorName),
            color = 0xffdf87
        }

        if Message.channel and type(Message.channel.send) == "function" then
            Message.channel:send({ embed = embed })
        end
    end)

    print(string.format(
        "Prank triggered in channel %s by %s (%s) - Target was %d",
        Message.channel.id,
        Message.author.name,
        Message.author.id,
        tonumber(Runtime.Data.EventSettings.Whoopie[Message.channel.id].Target)
    ))

    local channelId = tostring(Message.channel.id)
    local entryWhoopie = Runtime.Data.EventSettings.Whoopie[channelId]

    if not entryWhoopie then return end

    entryWhoopie.Leaderboard = entryWhoopie.Leaderboard or {}
    local userId = tostring((Message.author and Message.author.id) or "Whodis")
    entryWhoopie.Leaderboard[userId] = (entryWhoopie.Leaderboard[userId] or 0) + 1

    -- persist changes
    if type(Runtime.SaveEventSettings) == "function" then
        pcall(Runtime.SaveEventSettings("src/Data/EventSettings.json"))
    end
end

function Internal.OnMessageReactionAdd(Runtime, Reaction, User)
--[[    if not Reaction or not Reaction.message or not User then return end
    if User.bot then return end

    local channel = Reaction.message.channel
    local message = Reaction.message

    Runtime.emit("reactionAdd", {
        channel = channel,
        message = message,
        reaction = Reaction,
        user = User
    })]]
end

return Internal

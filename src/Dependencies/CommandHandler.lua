local CommandHandler = {Commands = {}}

function CommandHandler.addCommand(CommandObject)
    CommandHandler.Commands[CommandObject.Name:lower()] = CommandObject
end

function CommandHandler.parse(Message, PrefixYes)
    if not Message.content or Message.content == "" or Message.author.bot then
        return false
    end

    local Content = Message.content
    local Arguments = {}
    local Channel_ID = Message.channel.id

    for Argument in Content:gmatch("%S+") do
        table.insert(Arguments, Argument)
    end

    if not Arguments[1] then
        return false
    end

    local potentialCommand = Arguments[1]
    local prefix = PrefixYes:lower()

    ------------------------------------------------------------------
    -- DEBUGGING LINES --
    ------------------------------------------------------------------
    local debug = ""
    debug = debug .. "(" .. Channel_ID ..  ")=> \"".. potentialCommand:sub(1, #prefix):lower() .. "\" = " .. tostring(potentialCommand:sub(1, #prefix):lower() == prefix)


    if #potentialCommand <= #prefix or potentialCommand:sub(1, #prefix):lower() ~= prefix then
        debug = debug .. " | X" -- Added this for clarity
        
        print(debug)
        return false
    end

    local commandName = potentialCommand:sub(#prefix + 1):lower()
    local Command = CommandHandler.Commands[commandName]

    if not Command then
        debug = debug .. "| No such thing as '" .. commandName .. "' command." -- Added this for clarity
        
        print(debug)
        return false
    end

    table.remove(Arguments, 1)
    Command:run(Message, Arguments)
end

return CommandHandler
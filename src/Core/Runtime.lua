local Json = require("../Dependencies/json.lua")
local EventHandler = require("../Dependencies/EventHandler.lua")
local Commands = require("../Dependencies/Commands.lua")
local CommandHandler = require("../Dependencies/CommandHandler.lua")
local InternalEvents = require("../Dependencies/InternalEvents.lua")

local Command = require("../Classes/Command.lua")

local Runtime = {
    Data = {},
    DataFiles = {"Settings", "EventNames", "EventSettings", "Starboard"},
    _events = {}
}

math.randomseed(os.time())

function Runtime.on(name, fn)
    Runtime._events[name] = Runtime._events[name] or {}
    table.insert(Runtime._events[name], fn)
end

function Runtime.emit(name, ...)
    local listeners = Runtime._events[name]
    if not listeners then return end
    for _, fn in ipairs(listeners) do
        local ok, err = pcall(fn, ...)
        if not ok then
            print(string.format("Runtime event '%s' listener error: %s", name, tostring(err)))
        end
    end
end

function Runtime.LoadJsonFiles()
    for _, DataFileName in pairs(Runtime.DataFiles) do
        local FilePath = string.format("src/Data/%s.json", DataFileName)
        local Data_File, ErrorMessage = io.open(FilePath, "r")

        if Data_File then
            local Content = Data_File:read("*a")
            Data_File:close()
            Runtime.Data[DataFileName] = Json.Decode(Content)
        else
            -- It's a good practice to handle the error, for example, by printing it.
            print(string.format("Error opening file %s: %s", FilePath, ErrorMessage))
            Runtime.Data[DataFileName] = {}
        end
    end

    Runtime.Data.Settings = Runtime.Data.Settings or {}
    Runtime.Data.EventSettings = Runtime.Data.EventSettings or {}
    Runtime.Data.Starboard = Runtime.Data.Starboard or {}
end

-- Save Settings back to path so configuration is persistent
function Runtime.SaveEventSettings(path)
    local FilePath = path
    local Data_File, Err = io.open(FilePath, "w")

    if not Data_File then
        print(string.format("Error writing settings %s: %s", FilePath, tostring(Err)))
        return false, Err
    end

    local Enc = Json.Encode(Runtime.Data.EventSettings)

    Data_File:write(Enc)
    Data_File:close()

    return true
end

function Runtime.SaveStarboSettings(path)
    local FilePath = path
    local Data_File, Err = io.open(FilePath, "w")

    if not Data_File then
        print(string.format("Error writing settings %s: %s", FilePath, tostring(Err)))
        return false, Err
    end

    local Enc = Json.Encode(Runtime.Data.Starboard)

    Data_File:write(Enc)
    Data_File:close()

    return true
end

function Runtime.DoCommands()
    for Key, Function in pairs(Commands) do
        CommandHandler.addCommand(Command.new(
            Key,
            "This is a description",
            
            function(Message, ...)
                Function({
                    CommandHandler = CommandHandler,
                    Message = Message,
                    Args = {...},
                    Runtime = Runtime
                })
            end
        ))
    end
end

function Runtime.HandleEvents(Client)
    for Event, Handler in pairs(EventHandler) do
        local Name = Runtime.Data.EventNames[Event]
        if type(Handler) == "function" and Name then
            Client:on(Name, function(...)
                return Handler(Runtime, ...)
            end)
        end
    end

    -- Register internal handlers from InternalEvents into Runtime's event registry
    for Event, Handler in pairs(InternalEvents) do
        if type(Handler) == "function" then
            local internalName = tostring(Event):gsub("^On", "")
            Runtime.on(internalName, function(...)
                return Handler(Runtime, ...)
            end)
        end
    end

    -- Delegate Discord message events to InternalEvents.OnMessageSent (detection logic)
    Client:on("messageCreate", function(message)
        InternalEvents.OnMessageSent(Runtime, message)
    end)
end

function Runtime.RunBot(Client)
    Client:run(string.format("Bot %s", Runtime.Data.Settings.Token))
end

function Runtime._getCommandHandler()
    return CommandHandler
end

return Runtime
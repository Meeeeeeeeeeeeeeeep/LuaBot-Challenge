local Events = {}

function Events.OnReady(_)
    print("\nI'm here! :D")
end

function Events.OnMessageSent(Runtime, Message)
    if Message.author.bot then
        return
    end

    Runtime._getCommandHandler().parse(Message, Runtime.Data.Settings.Prefix)
end

function Events.OnReactionAdd(Runtime, Reaction, User)
    if User.bot then
        return
    end

    local channel = Reaction.message.channel
    local message = Reaction.message

    Runtime.emit("reactionAdd", {
        channel = channel,
        message = message,
        reaction = Reaction,
        user = User
    })
end

function Events.OnReactionRemove(Runtime, Reaction, User)
    if User.bot then
        return
    end

    local channel = Reaction.message.channel
    local message = Reaction.message

    Runtime.emit("reactionRemove", {
        channel = channel,
        message = message,
        reaction = Reaction,
        user = User
    })
end

return Events

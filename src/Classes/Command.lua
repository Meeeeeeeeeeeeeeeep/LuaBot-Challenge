local Command = {}
Command.__index = Command

function Command.new(Name, Description, Function)
    local self = {
        Name = Name;
        Description = Description;
        Function = Function
    }

    setmetatable(self, Command)

    return self
end

function Command:run(Message, Args)
    return self.Function(Message, table.unpack(Args))
end

return Command
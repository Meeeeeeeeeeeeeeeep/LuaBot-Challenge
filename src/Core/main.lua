local Discord = require("discordia")
local Runtime = require("./Runtime.lua")

local Client = Discord.Client()

Runtime.LoadJsonFiles()
Runtime.DoCommands()
Runtime.HandleEvents(Client)
Runtime.RunBot(Client)
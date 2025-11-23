local Commands = {}
local Json = require("../Dependencies/json.lua")
local discordia = require("discordia")

------------------------------------------------------------------------------------------- -universal helper function

local genRandom, HeheVariable

local uniqueSkills = {
    {name="#LookatCurren", origin="Curren Chan (Fille Éclair)"},
    {name="∴win Q.E.D.", origin="Biwa Hayahide (pf. Winning Equation...)"},
    {name="1st Place Kiss☆", origin="Mayano Top Gun (Scramble Zone)"},
    {name="Anchors Aweigh!", origin="Gold Ship (Red Strife)"},
    {name="Behold Thine Emperor's Divine Might", origin="Symboli Rudolf (Emperor's Path)"},
    {name="Blazing Pride", origin="Air Groove (Empress Road)"},
    {name="Blue Rose Closer", origin="Rice Shower (Rosy Dreams)"},
    {name="Call Me King", origin="King Halo (King of Emeralds)"},
    {name="Certain Victory", origin="Tokai Teio (Beyond the Horizon)"},
    {name="Class Rep + Speed = Bakushin", origin="Sakura Bakushin O (Blossom in Learning)"},
    {name="Clear Heart", origin="Super Creek (Murmuring Stream)"},
    {name="Corazón ☆ Ardiente", origin="El Condor Pasa (El Numero 1)"},
    {name="Cut and Drive!", origin="Vodka (Wild Top Gear)"},
    {name="Empress's Pride", origin="Air Groove (Empress Road)"},
    {name="Eternal Moments", origin="Air Groove (Quercus Civilis)"},
    {name="Feel the Burn!", origin="Mejiro Ryan (Down the Line)"},
    {name="Flashy☆Landing", origin="Mayano Top Gun (Scramble Zone)"},
    {name="Flowery ☆ Maneuver", origin="Mayano Top Gun (Sunlight Bouquet)"},
    {name="Focused Mind", origin="Grass Wonder (Stone-Piercing Blue)"},
    {name="G00 1st. F∞;", origin="Mihono Bourbon (MB-19890425)"},
    {name="Genius x Bakushin = Victory", origin="Sakura Bakushin O (Blossom in Learning)"},
    {name="I Can Win Sometimes, Right?", origin="Nice Nature (Poinsettia Ribbon)"},
    {name="I See Victory in My Future!", origin="Matikane Fukukitaru (Rising Fortune)"},
    {name="Introduction to Physiology", origin="Agnes Tachyon (Tach-nology)"},
    {name="Just a Little Farther!", origin="Nice Nature (Poinsettia Ribbon)"},
    {name="Legacy of the Strong", origin="Mejiro McQueen (End of the Skies)"},
    {name="Let's Pump Some Iron", origin="Mejiro Ryan (Down the Line)"},
    {name="Luck Be with Me!", origin="Matikane Fukukitaru (Rising Fortune)"},
    {name="Nemesis", origin="Narita Taishin (Nevertheless)"},
    {name="Our Ticket to Win!", origin="Winning Ticket (Get to Winning!)"},
    {name="Prideful King", origin="King Halo (King of Emeralds)"},
    {name="Pure Heart", origin="Super Creek (Murmuring Stream)"},
    {name="Red Ace", origin="Daiwa Scarlet (Peak Blue)"},
    {name="Red Shift/LP1211-M", origin="Maruzensky (Formula R)"},
    {name="Resplendent Red Ace", origin="Daiwa Scarlet (Peak Blue)"},
    {name="Shadow Break", origin="Narita Brian (Maverick)"},
    {name="Shooting for Victory!", origin="Taiki Shuttle (Wild Frontier)"},
    {name="Shooting Star", origin="Special Week (Special Dreamer)"},
    {name="Sky-High Teio Step", origin="Tokai Teio (Peak Joy)"},
    {name="SPARKLY ☆ STARDOM", origin="Smart Falcon (LOVE☆4EVER)"},
    {name="Super-Duper Climax", origin="Haru Urara (Bestest Prize)"},
    {name="Super-Duper Stoked", origin="Haru Urara (Bestest Prize)"},
    {name="The Duty of Dignity Calls", origin="Mejiro McQueen (Frontline Elegance)"},
    {name="The View from the Lead is Mine!", origin="Silence Suzuka (Innocent Silence)"},
    {name="This Dance Is for Vittoria!", origin="T.M. Opera O (O Sole Suo!)"},
    {name="Triumphant Pulse", origin="Oguri Cap (Starlight Beat)"},
    {name="U=ma2", origin="Agnes Tachyon (Tach-nology)"},
    {name="V Is for Victory!", origin="Winning Ticket (Get to Winning!)"},
    {name="Victoria por Plancha ☆", origin="El Condor Pasa (El Numero 1)"},
    {name="Warning Shot!", origin="Gold Ship (Red Strife)"},
    {name="Where There's a Will, There's a Way", origin="Grass Wonder (Stone-Piercing Blue)"},
    {name="Xceleration", origin="Vodka (Wild Top Gear)"}
}

local umaEasterEgg = {
    ["tazuna"] = true,
    ["hayakawa tazuna"] = true,
    ["tazuna hayakawa"] = true,
    ["hayakwa"] = true,
    ["akikawa"] = true,
    ["yayoi akikawa"] = true,
    ["akikawa yayoi"] = true,
    ["yayoi"] = true
}

function NewRandomSeed() -- #TrueRandomizer
    local param1 = math.random(os.time())
    local param2 = math.random(os.time())

    local one = math.random(1, param1)
    local two = math.random(1, param2)

    math.randomseed(one, two)

    genRandom = math.random(1, 18)
    HeheVariable = math.random(1, 500)
end

function table.find(tbl, val)
    for i, v in ipairs(tbl) do
        if v == val then
            return i -- return the index if found
        end
    end
    return nil -- return nil if not found
end

NewRandomSeed()

----------------------------------------------COMMANDS----------------------------------------------

function Commands.Help(Context)
    local myself = Context.Message.client:getUser(990444313626435584)

    local help = {
        { cmd = "m/help", desc = "Show this help message (but in DMs~)" },
        { cmd = "m/ping, m/pong", desc = "Check if I'm alive and kicking! :3" },
        { cmd = "m/rps <rock|paper|scissors|pistol>", desc = "Play Rock-Paper-Scissors with me! :D" },
        { cmd = "m/hello [en/jp]", desc = "Want me to greet you~? :3" },
        { cmd = "m/avatar [user]", desc = "Awwww who is this cutie~~ >w>" },
        { cmd = "m/say <text> [.a]", desc = "Do you have something for me to say? OwO" },
        { cmd = "m/uwu <text> [.a]", desc = "uwu OwO >wO" },
        { cmd = "m/coinflip [heads|tails], m/cf", desc = "Let's dooooo a cointoss nyaaa~ ^w^" },
        { cmd = "m/roll dN [bet]", desc = "Test your luck with the RNGesus desu... ・〜・" },
        { cmd = "m/choose a;b;c", desc = "Can't choose? Leave it to me, nyan! (use semicolons to separate your options, nya~)" },
        { cmd = "m/rps <rock|paper|scissors>", desc = "Jan! Ken! Pon! :D" },
        { cmd = "m/uma <name>", desc = "Generate an Umamusume character with this! owo" },
        { cmd = "m/setsurprise, m/ss", desc = "(Master) Enable fun in this channel!" },
        { cmd = "m/listsurprise, m/list", desc = "(Admin) Send list of configured \"surprise channels\" (DM)" },
        { cmd = "m/removesurprise, m/rs", desc = "(Master) Delete fun in this channel... :c" },
        { cmd = "m/leaderboardsurprise [page], m/ls", desc = "Who got the most fun, I wonder~? Find out here! :) (DM)" }
    }

    local fields = {}
    for _, item in ipairs(help) do
        table.insert(fields, { name = item.cmd, value = item.desc, inline = false })
    end

    local embed = {
        title = "Commands for me! :3",
        header = "Hello there, master's fren~! >w<",
        thumbnail = { url = myself:getAvatarURL(512) },
        description = "Here is a short list of available commands my master has taught me!\nPlease use the exact command (prefix m/) to invoke, okiii~ -w-",
        color = 0x66CCFF,
        fields = fields,
        footer = { text = "If you need more detail... you can ping my master! (backtomeep) >w<" }
    }

    local ok = pcall(function()
        if Context and Context.Message and Context.Message.author and type(Context.Message.author.send) == "function" then
            Context.Message.author:send({ embed = embed })
        else
            error("No DM available :c")
        end
    end)

    if ok then
        if Context and Context.Message and type(Context.Message.addReaction) == "function" then
            Context.Message:addReaction("✨")
        end
    else
        if Context and Context.Message and type(Context.Message.reply) == "function" then
            Context.Message:reply({ embed = embed })
        end
    end
end

function Commands.Hello(Context) --m/hello with its iterations; done
    local param = Context.Message.content:sub(8)

    if string.gsub(param, "%s+", "") == "" then
        if genRandom % 3 == 1 then
            Response = string.format(
                ".__**\n> I'm **MeepBot**, and I shall humbly call you by **%s**-sama as I'm your servant for today...\n> \n" ..
                "> *Yoroshiku onegaishimasu.*",
                Context.Message.author.name)
        elseif genRandom % 3 == 2 then
            Response = string.format(
                "~!__**\n> **MeepBot** will now be a maid for you, **%s**-sama! Looking forward for today~ :D\n> \n" ..
                "> *Let's enjoy this day to our fullest, okay~? :3*",
                Context.Message.author.name)
        else
            Response = string.format(
                "*...?*__**\n> *Have we met before...? I don't think so-...* Well I'm **MeepBot** who will be your attendant for today.\n> \n" ..
                "> *Nice to meet you, **%s**-san!*",
                Context.Message.author.name)
        end

        if HeheVariable % 100 == 24 then
            Context.Message:addReaction("😤")
            Context.Message:reply("***Nyo.***")
        elseif HeheVariable % 100 == 13 then
            Context.Message:addReaction("😡")
            Context.Message:reply("**(  ¯^¯)**")
        else
            Context.Message:addReaction("👋")
            Context.Message:reply(string.format(
                "> **__Konnichiwa, %s",
                Context.Message.author.mentionString) .. Response)
        end

    elseif string.gsub(param, "%s+", ""):lower() == "en" then
        if genRandom % 3 == 1 then
            Response = string.format(
                ".__**\n> Welcome back to our proudest **MeepBot** service, private for you the entire day.\n> \n" ..
                "> *Unit `M-" .. math.random(100000, 999999) .. "` is now ready to serve you, Agent **%s***.",
                Context.Message.author.name)
        elseif genRandom % 3 == 2 then
            Response = string.format(
                ".__**\n> The universe hests, as this **MeepBot** hast been bestowed honour to be thine maide 'til the sun dusks.\n> \n" ..
                "> *Fret not, as I will devote me self for you, **%s** the Hero...*",
                Context.Message.author.name)
        else
            Response = "...__**\n> I heed to thine call. And I, **MeepBot** shall anon act as thy servaunt f'r the present day.\n> \n" ..
                string.format(
                "> *Prithee taketh great care of me frail body, O' **%s** the Chosen One...*",
                Context.Message.author.name)
        end

        if HeheVariable % 100 == 24 then
            Context.Message:reply("***No.***")
        elseif HeheVariable % 100 == 13 then
            Context.Message:addReaction("👎")
            Context.Message:reply("***I refuse.***")
        else
            Context.Message:addReaction("👋")
            Context.Message:reply(string.format(
                "> **__Good day, %s",
                Context.Message.author.mentionString) .. Response)
        end

    elseif string.gsub(param, "%s+", ""):lower() == "jp" then
        if genRandom % 3 == 1 then
            Response = string.format(
                "。__**\n> ようこそいらっしゃいませ、ご主人様。当意即妙「**MeepBot**」は今日一日あなたのみ執行します！\n> \n" ..
                "> *どうぞお楽しみください、**%s**様。*",
                Context.Message.author.name)
        elseif genRandom % 3 == 2 then
            Response = string.format(
                "！__**\n> 今日は何をするんですか、**%s**ちゃま？めっちゃ楽しみです～！\n> \n" ..
                "> *今日を満幅に楽しましょう！*",
                Context.Message.author.name)
        else
            Response = string.format(
                "。。。__**\n> 今日からあなたのお世話になって、「**MeepBot**」と申します。この間、融通無碍ですから好きにさせてもいいです。\n> \n" ..
                "> *ただ。。。優しくしてくださいね、**%s**様？*",
                Context.Message.author.name)
        end

        if HeheVariable % 100 == 24 then
            Context.Message:addReaction("👎")
            Context.Message:reply("***いやです。***")
        elseif HeheVariable % 100 == 13 then
            Context.Message:addReaction("😤")
            Context.Message:reply("*丁寧に**お断りします。***")
        else
            Context.Message:addReaction("👋")
            Context.Message:reply(string.format(
                "> **__こんにちは、%s",
                Context.Message.author.mentionString) .. Response)
        end
    else
        Context.Message:reply(string.format(
            "I'm sorry, I don't know that language yet. But hello there, Mr/s. %s...\n\nOr perhaps... Mr/s. **%s**?",
            Context.Message.author.mentionString, Context.Message.author.name))
    end

    NewRandomSeed()
end

function Commands.Ping(Context)
    Context.Message:reply("🏓 | Pong desu~! :D")
end

function Commands.Pong(Context)
    Context.Message:reply("🏓 | Ping desu~! :D")
end

function Commands.Say(Context) --m/say with Regex to spite Ariri; done, the new OG
    local Message = string.gsub(Context.Message.content:sub(6), "%s*", "", 1)

    if string.sub(Message, -2) == ".a" then
        Context.Message:reply(string.gsub(Message, "%.a", ""))
        Context.Message:delete()
    else
        Context.Message:reply(string.format(
            "> **%s** says: \"" .. Message .. "\"",
            Context.Message.author.name))
    end
end

function Commands.Avatar(Context)
    local target
    for u in Context.Message.mentionedUsers:iter() do
        target = u
        break
    end

    target = target or Context.Message.author

    local avatarUrl = target:getAvatarURL(512)

    local embed = {
        title = "Your Avatar",
        description = "Here's your avatar, nya~! :3",
        image = { url = avatarUrl },
        text = "Click the image to view it in full size.",
        color = 0x66CCFF,
        footer = { text = "Isn't it cute? UwU" }
    }

    Context.Message:addReaction("✨")
    Context.Message:reply({ embed = embed })
end

function Commands.Uwu(Context)
    local mainText = Context.Message.content:lower():sub(7)
    local text = mainText

    local function replaceWords(output)
        -- Full word replacements first
        output = string.gsub(output, "meow", "nya")
        output = string.gsub(output, "bark", "wan")
        output = string.gsub(output, "is(%f[%W])", "ish%1")
        output = string.gsub(output, "you", "u")

        -- Efficient character class patterns
        output = string.gsub(output, "([bdfgmpq])([aiueo])", "%1w%2")
        output = string.gsub(output, "([cn])([aiueo])", "%1y%2")

        -- Multi-letter patterns
        output = string.gsub(output, "(%S+)ow", "%1au")
        output = string.gsub(output, "[rl]", "w")
        output = string.gsub(output, "(%S+)ove", "%1ub")
        output = string.gsub(output, "(%S+)v", "%1b")
        output = string.gsub(output, "(%S+%S)ing(%A)", "%1in%2")
        output = string.gsub(output, "(%S+)y(%A)", "%1i%2")
        output = string.gsub(output, "tion", "shun")
        output = string.gsub(output, "wh", "w")
        output = string.gsub(output, "ight", "ite")
        output = string.gsub(output, "th", "d")
        output = string.gsub(output, "ck", "cc")

        local punctuationList = {"...", "!", "~", "?", "", " nya", " nya~", " nya...", " nya?", " nya!", " nya~!"}
        output = string.gsub(output, "([^%.])(%.)$", "%1" .. punctuationList[math.random(#punctuationList)])

        local firstWord = output:match("^(%S+)")

        if firstWord and #firstWord > 1 then
            local stutter = firstWord:sub(1, 1) .. "-" .. firstWord
            output = output:gsub("^"..firstWord, stutter, 1)
        end

        return output
    end

    local kaomojiList = {
        "uwu", "owo", "UwU", "OwO", ">w<", ":3",
        "^w^", "^v^", "^ω^", "^o^", "^^", "^u^",
        "・・", "・ω・", "・w・", "・v・", "・o・", "・u・", "・^・", "・^ω^・",
        "n.n", "n^n", "n~n", "nwn", "nvn", "n^n", "n^ω^n",
    }

    local emoji = kaomojiList[math.random(#kaomojiList)]

    if string.sub(mainText, -2) == ".a" then
        local output = replaceWords(string.gsub(mainText, "%.a", ""))

        Context.Message:reply(output .. " " .. emoji)
    else
        Context.Message:addReaction("🐱")
        Context.Message:reply(
            string.format(
                "> **%s** *cutely* says: \"%s %s\"",
                Context.Message.author.name, output, emoji
            )
        )
    end
end

function Commands.Coinflip(Context) --m/coinflip; emojiiiiiiiiiiiiiiiiiiiiiiiiiiii
    local Command = "**`m/coinflip [your bet(heads or tails), optional]`**"
    local Flip = math.random(1, 10)
    local Bet = Context.Message.content:lower():sub(12)
    local ResultMessage = ""

    if HeheVariable == 13 then
        ResultMessage = string.format("> But wow, somehow the coin stands perfectly up and you managed to get the only draw outcome out of this game-\n> \n" ..
            "> Sasuga desu ne, **%s**-sama!",
            Context.Message.author.name) --needs emoji
    else
        if Flip % 2 == 0 then
            CoinState = "heads"
        else
            CoinState = "tails"
        end
        ResultMessage = "Your coin flip result is **" .. CoinState:gsub("^%l", string.upper) .. "**."
    end

    if HeheVariable % 20 == 13 then
        Context.Message:addReaction("🖕")
        Context.Message:reply("> ***Go flip a coin yourself lmao***\n"..
            "> *Here's the link:* __https://bit.ly/3psvBMP__")
    elseif HeheVariable % 20 == 4 then
        Context.Message:addReaction("👎")
        Context.Message:reply("> ***Go flip a coin yourself.***\n"..
            "> *Here's the link:* __https://bit.ly/3wfO9nl__")
    else
        Context.Message:addReaction("👍")

        if Bet == "" then
            Context.Message:reply(string.format(
                "> **%s**-sama, " .. ResultMessage:gsub("^%l", string.lower),
                Context.Message.author.name)) --needs emoji
        elseif Bet == CoinState then
            Context.Message:reply(string.format(
                "> Congratulations, **%s**-sama! You won the coin flip~! :D :confetti_ball: :tada:\n> " .. ResultMessage:gsub("[.]", "!"),
                Context.Message.author.name))
        else
            if Bet == "heads" or Bet == "tails" then
                Context.Message:reply(string.format(
                    "> I'm sorry, **%s**-sama... The luck isn't on your side this time.\n> " .. ResultMessage,
                    Context.Message.author.name)) --needs emoji
            else
                Context.Message:reply(string.format(
                    "> I'm sorry master, but please format your command following this formula ^^\":\n> %s",
                    Command))
            end
        end
    end

    NewRandomSeed()
end

function Commands.Roll(Context) --m/roll; done
    local Command = "**`m/roll d[number to roll] [your bet, optional]`**"
    local Misc = Context.Message.content:sub(7)
    local _, _, Dice = string.find(Misc, "d(%d+)")
    local _, _, Gamble, Pin = string.find(Misc, "d(%d+)%s+(%d+)")
    local Sides, Roll, Bet, BetAnnounce, Disappointment, Reaction, Judgement

    if Dice == nil then
        if Pin == nil then
            Context.Message:reply(string.format(
                "> I'm sorry master, but please format your command following this formula ^^\":\n> %s",
                Command))
            return
        else
            Sides = tonumber(Gamble)
            Bet = tonumber(Pin)
            Roll = math.random(1, Sides)
        end
    else
        Sides = tonumber(Dice)
        Roll = math.random(1, Sides)
        Bet = tonumber(Pin)
    end

    function BetResult()
        if Bet == Roll then
            if Bet == Sides then
                BetAnnounce = string.format(
                    "> **:trophy: |** Congratulations, **%s**-sama! Not only you got a jackpot, you also won the bet~! :D :confetti_ball: :tada:\n",
                    Context.Message.author.name)
            else
                BetAnnounce = string.format(
                    "> **<:void:1009958825434030201> |** Congratulations, **%s**-sama! You won the bet~! :D :trophy:\n",
                    Context.Message.author.name)
            end
        else
            if Bet == Sides then
                if Sides == 1 then
                    BetAnnounce = Context.Message:reply(string.format("> **<:void:1009958825434030201> |** *Are you that desparate for a win, **%s**-sama? :disappointment:*\n",
                    Context.Message.author.name))
                else
                    BetAnnounce = string.format(
                        "> **<:void:1009958825434030201> |** I'm sorry, **%s**-sama. Luck isn't on your side this time, even though you rolled a jackpot... :pensive:\n",
                        Context.Message.author.name)
                end

            elseif Bet > Sides then
                BetAnnounce = string.format(
                    "> **<:void:1009958825434030201> |** Do you really need to overkill your bet, **%s**-sama? :expressionless:\n",
                    Context.Message.author.name)
            else
                BetAnnounce = string.format(
                    "> **<:void:1009958825434030201> |** I'm sorry, **%s**-sama. Luck isn't on your side this time... :pensive:\n",
                    Context.Message.author.name)
            end
        end
    end

    function Judge()
        if Roll <= Sides / 8 then
            Judgement = "> **<:void:1009958825434030201> |** Wow, that's an abysmally low roll... Better luck next time. :no_mouth:"
        elseif Sides / 8 <= Roll and Roll <= Sides / 4 then
            Judgement = "> **<:void:1009958825434030201> |** You evaded the worst possible outcome, but still not enough. :smiling_face_with_tear:"
        elseif Sides / 4 <= Roll and Roll <= Sides / 2 then
            Judgement = "> **<:void:1009958825434030201> |** A low roll, but still salvageable. :innocent:"
        elseif Sides / 2 <= Roll and Roll <= Sides / 4 * 3 then
            Judgement = "> **<:void:1009958825434030201> |** Pretty decent roll, I'll give you that. =v=)b"
        elseif Sides / 4 * 3 <= Roll and Roll < Sides then
            Judgement = "> **<:void:1009958825434030201> |** Now that's what I call a *good* roll. :sunglasses:"
        elseif Sides == 1 then
            Judgement = "> **<:void:1009958825434030201> |** Nevertheless, you get the highest roll of **1**... Congratulations I guess, my master..."
        else
            Judgement = "> **<:void:1009958825434030201> |** Wow, Asian parents will be proud of you. :0\n> \n> :clap: :clap: :clap:"
        end
    end

    if HeheVariable == 500 then
        Context.Message:reply(string.format(
            "> **:skull: | *Oof...***\n> **<:void:1009958825434030201> |** Imagine being so bad that you rolled a **0** from a **%d**-sided Sides lmao\n> \n" ..
            "> **<:void:1009958825434030201> |** Git gud :upside_down:",
            Sides))
    elseif HeheVariable == 69 or HeheVariable == 420 then
        Context.Message:reply(string.format(
            "> **:trophy: |** You got a **jackpot** and rolled an astounding chance-defying roll of **69420**! :tada:\n" ..
            "> **<:void:1009958825434030201> |** *||Although you technically only got **%d** but that's the point of the jackpot www||*",
            tostring(Roll)))
    elseif Sides == 0 or Sides == 1 or Sides >= 9223372036854775806 then
        if Sides == 1 then
            Disappointment = Context.Message:reply(string.format(
                "> **:disappointed: |** *Are you that desparate for a win, **%s**-sama? :c*\n",
                Context.Message.author.name))
        else
            Disappointment = string.format( "> **:expressionless: |** ...\n",
                Context.Message.author.name)

            if genRandom % 2 == 0 then
                Context.Message:reply(string.format(Disappointment ..
                    "> **<:void:1009958825434030201> |** Do you really think I'll allow that *atrocious* number*, **%s*%s\n",
                    Context.Message.author.name, "*-sama?*"))
            else
                Context.Message:reply(string.format(Disappointment ..
                    "> **<:void:1009958825434030201> |** I know what you're trying to do... \n" ..
                        "<:void:1009958825434030201> <:void:1009958825434030201> <:void:1009958825434030201> <:void:1009958825434030201> *||And I won't allow it, **%s**-sama. :)||*",
                        Context.Message.author.name))
            end
        end
    else
        if Bet == nil then
            Judge()
        else
            BetResult()
        end

        if Bet ~= nil then
            Context.Message:reply(string.format(
                "> **:game_die: |** You rolled a **%d**!\n" .. BetAnnounce,
                tostring(Roll)))
        else
            if Sides == 1 then
                Context.Message:reply(Disappointment .. Judgement)
            else
                Context.Message:reply(string.format(
                    "> **:game_die: |** You rolled a **%d**!\n" .. Judgement,
                    tostring(Roll)))
            end
        end
    end

    NewRandomSeed()
end

function Commands.Choose(Context) --m/choose; done
    local ChoicesString = string.gsub(string.gsub(Context.Message.content:sub(10), "%s*", "", 1), ";%s*", ";")
    local Choices = {}

    for Choice in ChoicesString:gmatch("[^;]+") do
        table.insert(Choices, Choice)
    end

    local Choice = Choices[math.random(#Choices)]

    if HeheVariable % 100 == 3 then
        Context.Message:addReaction("👎")
        Context.Message:reply(string.format("> ***Choose yourself lmao***"))
    else
        Context.Message:addReaction("👍")

        if genRandom % 3 == 1 then
            Context.Message:reply(string.format("**<:morithink:916938599973388339> |** I think I'll choose **%s**, **%s**-sama.",
                Choice, Context.Message.author.name))
        elseif genRandom % 3 == 2 then
            Context.Message:reply(string.format("**<:morithink:916938599973388339> |** 100%% for **%s**, **%s**-sama!",
            Choice, Context.Message.author.name))
        else
            Context.Message:reply(string.format("**<:morithink:916938599973388339> |** Of course I'll choose **%s**, **%s**-sama~ www",
            Choice, Context.Message.author.name))
        end
    end

    NewRandomSeed()
end

function Commands.Rps(Context) --m/rps (rock, paper, scissors); done for the basic logic. Aesthetics left.
    local Choice = string.gsub(Context.Message.content:sub(6), "%s*", "")
    local Win = "Congratulations! You win this round, my master! :D"
    local Draw = "It seems like we ended up in a draw, master :)"
    local Lose = "I'm sorry, but you lost this round..."
    local botChoice, WinMes, DrawMes, LoseMes

    if genRandom % 3 == 1 then
        botChoice = "rock"
    elseif genRandom % 3 == 2 then
        botChoice = "scissors"
    elseif genRandom % 3 == 0 then
        botChoice = "paper"
    elseif HeheVariable % 10 == 7 then
        botChoice = "pistol"
    else
        botChoice = ""
    end

    if HeheVariable % 4 == 1 then
        WinMes = "You just got lucky, my master..."
        DrawMes = "Let's do another round, shall we? :3"
        LoseMes = "Better luck next time~ ^^"
    elseif HeheVariable % 4 == 2 then
        WinMes = "I'll have my revenge next time..."
        DrawMes = "Draw? :0"
        LoseMes = "You suck hahaha... Just kidding ;3"
    elseif HeheVariable % 4 == 3 then
        WinMes = "I applaud you :clap: :clap: :clap:"
        DrawMes = "Again! I don't acknowledge any result besides Win or Lose!!!"
        LoseMes = "Just give up, you can't defeat me >:D"
    else
        WinMes = "Wanna try another round? This time I won't lose :)"
        DrawMes = "We have the same braincell www. As expected from my master..."
        LoseMes = "... ;-;"
    end

    local matchSum = "\nYou threw a " .. Choice .. " against my " .. botChoice .. ". "

    if botChoice == "pistol" then
        Context.Message:reply(Lose .. matchSum .. "Nothing can beat a pistol, you know? :sunglasses:")
    elseif botChoice == "" then
        Context.Message:reply("?")
    elseif Choice:lower() == "scissors" then
        if botChoice == "paper" then
            Context.Message:reply(Win .. matchSum .. WinMes)
        elseif botChoice == "rock" then
            Context.Message:reply(Lose .. matchSum .. LoseMes)
        else
            Context.Message:reply(Draw .. matchSum .. DrawMes)
        end
    elseif Choice:lower() == "paper" then
        if botChoice == "rock" then
            Context.Message:reply(Win .. matchSum .. WinMes)
        elseif botChoice == "scissors" then
            Context.Message:reply(Lose .. matchSum .. LoseMes)
        else
            Context.Message:reply(Draw .. matchSum .. DrawMes)
        end
    elseif Choice:lower() == "rock" then
        if botChoice == "scissors" then
            Context.Message:reply(Win .. matchSum .. WinMes)
        elseif botChoice == "paper" then
            Context.Message:reply(Lose .. matchSum .. LoseMes)
        else
            Context.Message:reply(Draw .. matchSum .. DrawMes)
        end
    else
        Context.Message:reply("What the fuck?")
    end

    NewRandomSeed()
end

function Commands.Afk(Context) --COMING SOON
    local command = Context.Message.content:sub(3)

    if string.gsub(command, "%s+", "") == "afk" then
        --[[
            if mention(command_sender) then reply(afk_message) to {message_sender};
            when {command_sender} send(message) then end(afk_command);
          ]]
    end
end

function Commands.Quote(Context) --COMING SOON
end

function Commands.Hangman(Context) --COMING SOON
end

function Commands.Ask(Context)
    local length = number
    local message = string.gsub(Context.Message.content:sub(6), "%s*", "", 1)

    local responses = {
        { -- Affirmative
            "Veeeeery yes",
            "Of course",
            "Why not",
            "Definitely yes",
            "Shurely yes",
            "Hmm, I think yes",
            "Maybe yes",
            "I don't see why not",
            "Shure",
            "Yes",
            "Humuhumu... I say yes"
        },
        { -- Neutral
            "Maybe",
            "I don't know",
            "It's a secret",
            "Not now",
            "Ummm, try again",
            "Bweeeeeeeh"
        },
        { -- Negative
            "Maybe no",
            "Nyooooooooooooooo",
            "Nyo",
            "Nuh uh",
            "Definitely no",
            "Veeeery no"
        }
    }

    local kaomoji = {
        {"uwu", "owo", "UwU", "OwO", ">w<", ":3", "^w^", "^~^", "^^"}, -- Affirmative
        {"u~u", "o~o", "U~U", "O~O", ">~<", "・~・", "n.n", "n~n"}, -- Neutral
        {"n.n", "n~n", "-_-", ">.<", ">~<", ">n<", ">m<", "qwq", "qmq", "qnq", "q~q", "T_T", "Q_Q"} -- Negative
    }

    local endings = { "", "nya", "mya", "desu" }

    local punctuations = {
        {"", "~", "!", "~!"}, -- Affirmative
        {"", " ~", " ~?", " ~...", "?", "...", "...?"}, -- Neutral
        {"", ".", "..."} -- Negative
    }

    local categoryRoll = math.random(1, 3)

    local responseText = responses[categoryRoll][math.random(#responses[categoryRoll])]
    local kaomojiText = kaomoji[categoryRoll][math.random(#kaomoji[categoryRoll])]
    local punctuationText = punctuations[categoryRoll][math.random(#punctuations[categoryRoll])]
    local endingText = endings[math.random(#endings)]

    endingText = (endingText ~= "") and (", " .. endingText) or ""

    local answer = string.format("🔮 — **%s**-nyan asked:\n" .. 
                        "> *\"%s\"*\n\n" ..
                        "<:33:1248924828925431808> — **Your nyan** says:\n" .. 
                        "> *\"%s%s%s %s*\"",
                        Context.Message.author.mentionString, message,
                        responseText, endingText, punctuationText, kaomojiText
                        )

    Context.Message:addReaction("🔮")
    Context.Message:reply(
        {
            embed = {
                title = "A question from " .. Context.Message.author.name .. "! ✨",
                description = answer,
                color = 0xc438eb,
                footer = { text = "Ask MeepBot!" }
            }
        }
    )
end

-- =================================================================== -helper function uma

-- weighted random selection
function GetRandomFromWeightedTable(weightedItems)
    local totalWeight = 0

    for _, item in ipairs(weightedItems) do
        totalWeight = totalWeight + item.weight
    end

    local randomNumber = math.random(totalWeight)
    local cumulativeWeight = 0

    for _, item in ipairs(weightedItems) do
        cumulativeWeight = cumulativeWeight + item.weight

        if randomNumber <= cumulativeWeight then
            return item.item
        end
    end
end

function ShuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end

    return tbl
end

function CalculateStats(targetRarity, bonuses, baseStats)
    local statNames = {"SPD", "STA", "PWR", "GUT", "WIT"}
    local stats = {}

    -- helper-helper function, distribute points randomly among a list of stat names
    local function distributeRandomly(points, statList)
        if #statList == 0 then return end

        for _ = 1, points do
            local randomStatName = statList[math.random(#statList)]
            stats[randomStatName] = stats[randomStatName] + 1
        end
    end

    -- identify which stats have bonuses
    local bonusStatNames = {}
    local nonBonusStatNames = {}
    local reservePercentile = {}

    for _, name in ipairs(statNames) do
        if bonuses[name] > 0 then
            table.insert(bonusStatNames, name)
        else
            table.insert(nonBonusStatNames, name)
        end
    end

    if #bonusStatNames == 1 then -- if the bonus is one stat 30%
        reservePercentile = {0.25, 0.35, 0.4}
    elseif baseStats then
        reservePercentile = {0.2, 0.3, 0.5}
    else
        reservePercentile = {0.4, 0.25, 0.35}
    end

    if not baseStats then
        local baseValue = (targetRarity + 4) * 10
        for _, name in ipairs(statNames) do stats[name] = baseValue end
        
        local totalPoints = 350 + (targetRarity - 1) * 50
        local reserve = totalPoints - (baseValue * 5) -- should be 100

        -- distribute to bonus stats, equal
        local bonusPoints = math.floor(reserve * reservePercentile[1])
        
        if #bonusStatNames > 0 then
            local pointsPerBonusStat = math.floor(bonusPoints / #bonusStatNames)
            
            for _, name in ipairs(bonusStatNames) do
                stats[name] = stats[name] + pointsPerBonusStat
            end

            distributeRandomly(bonusPoints % #bonusStatNames, bonusStatNames) -- Distribute remainder
        end

        -- spread to un-bonused stats, random
        local nonBonusPoints = math.floor(reserve * reservePercentile[2])
        distributeRandomly(nonBonusPoints, nonBonusStatNames)

        -- spread remainder on top of all stats, random
        local sprinklePoints = math.floor(reserve * reservePercentile[3])
        distributeRandomly(sprinklePoints, statNames)

    else
        -- == 5-star upgrade logic ==
        for _, name in ipairs(statNames) do stats[name] = baseStats[name] end -- Make a copy

        local currentTotal = 0
        for _, name in ipairs(statNames) do currentTotal = currentTotal + stats[name] end
        
        local targetTotal = 550 -- Max for a 5-star
        local gap = targetTotal - currentTotal

        -- distribute to bonus stats, equal
        local bonusPoints = math.floor(gap * reservePercentile[1])

        if #bonusStatNames > 0 then
            local pointsPerBonusStat = math.floor(bonusPoints / #bonusStatNames)

            for _, name in ipairs(bonusStatNames) do
                stats[name] = stats[name] + pointsPerBonusStat
            end
            distributeRandomly(bonusPoints % #bonusStatNames, bonusStatNames) -- Distribute remainder
        end

        -- spread to un-bonused stats, random
        local nonBonusPoints = math.floor(gap * reservePercentile[2])
        distributeRandomly(nonBonusPoints, nonBonusStatNames)
        
        -- spread remainder to all stats, random
        local allStatsPoints = math.floor(gap * reservePercentile[3])
        distributeRandomly(allStatsPoints, statNames)
    end

    local statSpreadGap = math.random(100)
    local maxGap = 40

    if statSpreadGap % 2 == 1 then
        maxGap = 50
    end

    -- final two-step gap check
    while true do
        local minStatName, maxStatName = "SPD", "SPD"

        for _, name in ipairs(statNames) do
            if stats[name] < stats[minStatName] then minStatName = name end
            if stats[name] > stats[maxStatName] then maxStatName = name end
        end

        if stats[maxStatName] - stats[minStatName] > maxGap then
            -- Soft Correction
            stats[maxStatName] = stats[maxStatName] - 1
            distributeRandomly(1, statNames)

            -- Second Check
            local newMinVal, newMaxVal = stats[minStatName], stats[maxStatName]
            local newMinName, newMaxName = minStatName, maxStatName

            for _, name in ipairs(statNames) do
                if stats[name] < newMinVal then newMinVal = stats[name]; newMinName = name end
                if stats[name] > newMaxVal then newMaxVal = stats[name]; newMaxName = name end
            end

            -- Hard Correction
            if stats[newMaxName] - stats[newMinName] > maxGap then
                stats[newMaxName] = stats[newMaxName] - 1
                stats[newMinName] = stats[newMinName] + 1
            end
        else
            break
        end
    end

    return stats
end

function GeneratePairedAffinities(types, pairs)
    local affinities = {}
    local shuffledTypes = ShuffleTable(table.pack(table.unpack(types)))
    affinities[shuffledTypes[1]] = "A"
    affinities[shuffledTypes[2]] = "G"
    local a_type = shuffledTypes[1]

    local remainingTypes = {}

    for i = 3, #shuffledTypes do
        table.insert(remainingTypes, shuffledTypes[i])
    end

    if math.random(50) % 2 == 1 then
        local paired_a_type = pairs[a_type]
        local second_a_type

        if math.random(50) % 2 == 1 and table.find(remainingTypes, paired_a_type) then
            second_a_type = paired_a_type
        else
            second_a_type = remainingTypes[math.random(#remainingTypes)]
        end

        affinities[second_a_type] = "A"

        local rate_table = {
            {item = "B", weight = 5}, {item = "C", weight = 10}, {item = "D", weight = 10},
            {item = "E", weight = 15}, {item = "F", weight = 30}, {item = "G", weight = 30}
        }

        for _, typeName in ipairs(types) do
            if not affinities[typeName] then
                affinities[typeName] = GetRandomFromWeightedTable(rate_table)
            end
        end
    else
        local paired_a_type = pairs[a_type]

        if table.find(remainingTypes, paired_a_type) then
            local paired_rate_table = {
                {item = "B", weight = 40}, {item = "C", weight = 25}, {item = "D", weight = 15},
                {item = "E", weight = 10}, {item = "F", weight = 10}
            }

            affinities[paired_a_type] = GetRandomFromWeightedTable(paired_rate_table)
        end

        local remaining_rate_table = {
            {item = "B", weight = 10}, {item = "C", weight = 10}, {item = "D", weight = 15},
            {item = "E", weight = 15}, {item = "F", weight = 25}, {item = "G", weight = 25}
        }

        for _, typeName in ipairs(types) do
            if not affinities[typeName] then
                affinities[typeName] = GetRandomFromWeightedTable(remaining_rate_table)
            end
        end
    end
    return affinities
end

-- =================================================================== -main function uma

function Commands.Uma(Context)
    -- 1. Get the name
    local name = Context.Message.content:sub(7)
    name = string.gsub(name, "^%s*(.-)%s*$", "%1")
    if name == "" then
        name = Context.Message.author.name
    end

    -- 2. Determine rarity
    local rarityRoll = math.random(100)
    local rarity
    if rarityRoll <= 25 then
        rarity = 1
    elseif rarityRoll <= 80 then
        rarity = 2
    else
        rarity = 3
    end

    -- 3. Assign stat bonuses
    local bonuses = {SPD = 0, STA = 0, PWR = 0, GUT = 0, WIT = 0}
    local statNames = {"SPD", "STA", "PWR", "GUT", "WIT"}
    local bonusDistribution = math.random(100)

    local chosenStats = ShuffleTable(table.pack(table.unpack(statNames)))
    if bonusDistribution % 4 == 2 then
        bonuses[chosenStats[1]] = 30
    elseif bonusDistribution % 2 == 1 then
        bonuses[chosenStats[1]] = 20
        bonuses[chosenStats[2]] = 10
    else
        bonuses[chosenStats[1]] = 10
        bonuses[chosenStats[2]] = 10
        bonuses[chosenStats[3]] = 10
    end

    -- 4. Generate stats
    local currentStats = CalculateStats(rarity, bonuses)
    local maxStats = CalculateStats(5, bonuses, currentStats)

    local trackAffinities = {}
    local rate_table = {
            {item = "G", weight = 70}, {item = "F", weight = 10}, {item = "E", weight = 5},
            {item = "D", weight = 2.5}, {item = "C", weight = 2.5}, {item = "B", weight = 3.5},
            {item = "A", weight = 1.5}
        }

    -- Track
    if math.random(50) % 2 == 1 then
        trackAffinities["Turf"] = "A"
        trackAffinities["Dirt"] = GetRandomFromWeightedTable(rate_table)
    else
        trackAffinities["Dirt"] = "A"
        trackAffinities["Turf"] = GetRandomFromWeightedTable(rate_table)
    end

    -- Distance
    local distanceTypes = {"Sprint", "Mile", "Medium", "Long"}
    local distancePairs = {Sprint = "Mile", Mile = "Sprint", Medium = "Long", Long = "Medium"}
    local distanceAffinities = GeneratePairedAffinities(distanceTypes, distancePairs)

    -- Style
    local styleTypes = {"Front", "Pace", "Late", "End"}
    local stylePairs = {Front = "Pace", Pace = "Front", Late = "End", End = "Late"}
    local styleAffinities = GeneratePairedAffinities(styleTypes, stylePairs)

    -- 6. Select Unique Skill
    local chosenSkill = uniqueSkills[math.random(#uniqueSkills)]

    -- 7. Output
    local function formatA(rank)
        if rank == "A" or rank == "S" then
            return "**" .. rank .. "**"
        else
            return rank
        end
    end

    local function formatBonus(statName, value)
        local properName = statName:sub(1,1) .. statName:sub(2):lower()
        return bonuses[statName] > 0 and string.format("**%s +%d%%**", properName, value) or string.format("%s +%d%%", properName, value)
    end

    if umaEasterEgg[name:lower()] then
        rarity = 10
        currentStats.SPD = 1200
        currentStats.STA = 1200
        currentStats.PWR = 1200
        currentStats.GUT = 1200
        currentStats.WIT = 1200
        maxStats.SPD = 2000
        maxStats.STA = 2000
        maxStats.PWR = 2000
        maxStats.GUT = 2000
        maxStats.WIT = 2000
        trackAffinities.Turf = "S"
        trackAffinities.Dirt = "S"
        distanceAffinities.Sprint = "S"
        distanceAffinities.Mile = "S"
        distanceAffinities.Medium = "S"
        distanceAffinities.Long = "S"
        styleAffinities.Front = "S"
        styleAffinities.Pace = "S"
        styleAffinities.Late = "S"
        styleAffinities.End = "S"
        bonuses.SPD = 100
        bonuses.STA = 100
        bonuses.PWR = 100
        bonuses.GUT = 100
        bonuses.WIT = 100
    end

    local rarityStars = ""
    if rarity > 5 then
        rarityStars = rarityStars .. string.rep("★", rarity)
    else
        rarityStars = rarityStars .. string.rep("★", rarity) .. string.rep("☆", 5 - rarity)
    end

    local response = "# A new Umamusume has been born!\n-# *Say hello to...*\n"
    response = response .. "__                                             __\n"
    response = response .. "[**__Name__**] "
    response = response .. string.format("%s (%s)\n", name, rarityStars)
    response = response .. "[**__Stats__**]\n"
    response = response .. "```\n"
    response = response .. "      | SPD | STA | PWR | GUT | WIT \n"
    response = response .. "------------------------------------\n"
    response = response .. string.format("Curr. | %3d | %3d | %3d | %3d | %3d \n", currentStats.SPD, currentStats.STA, currentStats.PWR, currentStats.GUT, currentStats.WIT)
    response = response .. "------------------------------------\n"
    response = response .. string.format("Max.  | %3d | %3d | %3d | %3d | %3d \n", maxStats.SPD, maxStats.STA, maxStats.PWR, maxStats.GUT, maxStats.WIT)
    response = response .. "```\n"

    response = response .. "[**__Track__**] "
    response = response .. string.format("Turf: %s, Dirt: %s\n", formatA(trackAffinities.Turf), formatA(trackAffinities.Dirt))

    response = response .. "[**__Distance__**] "
    response = response .. string.format("Sprint: %s, Mile: %s, Medium: %s, Long: %s\n",
        formatA(distanceAffinities.Sprint), formatA(distanceAffinities.Mile), formatA(distanceAffinities.Medium), formatA(distanceAffinities.Long))

    response = response .. "[**__Style__**] "
    response = response .. string.format("Front: %s, Pace: %s, Late: %s, End: %s\n\n",
        formatA(styleAffinities.Front), formatA(styleAffinities.Pace), formatA(styleAffinities.Late), formatA(styleAffinities.End))

    response = response .. "[**__Growth Rate__**] "
    response = response .. string.format("%s, %s, %s, %s, %s\n\n",
        formatBonus("SPD", bonuses.SPD), formatBonus("STA", bonuses.STA), formatBonus("PWR", bonuses.PWR),
        formatBonus("GUT", bonuses.GUT), formatBonus("WIT", bonuses.WIT))

    response = response .. "[**__Unique Skill__**] "
    response = response .. string.format("**%s** (from *%s*)", chosenSkill.name, chosenSkill.origin)

    local hiddenName = ""

    if string.find(name:lower(), "tazuna") then
        hiddenName = "Tokino Minoru (UR)"
    elseif string.find(name:lower(), "yayoi") or string.find(name:lower(), "akikawa") then
        hiddenName = "Northern Taste (UR)"
    end

    if umaEasterEgg[name:lower()] then
        response = response .. string.format("\n\n-# *||Wait... isn't this **%s**?||*", hiddenName)
    end

    Context.Message:addReaction("🏇")
    Context.Message:reply(response)
    print(string.format("Name: %s, Rarity: %s, Stats: [%3d, %3d, %3d, %3d, %3d], Max: [%3d, %3d, %3d, %3d, %3d], Turf/Dirt: %s/%s, Distance: [%s, %s, %s, %s], Style: [%s, %s, %s, %s], Growth Rate: [%s, %s, %s, %s, %s], Unique: %s - %s",
                        name, rarityStars, currentStats.SPD, currentStats.STA, currentStats.PWR, currentStats.GUT, currentStats.WIT,
                        maxStats.SPD, maxStats.STA, maxStats.PWR, maxStats.GUT, maxStats.WIT,
                        trackAffinities.Turf, trackAffinities.Dirt, distanceAffinities.Sprint, distanceAffinities.Mile, distanceAffinities.Medium, distanceAffinities.Long,
                        styleAffinities.Front, styleAffinities.Pace, styleAffinities.Late, styleAffinities.End,
                        bonuses.SPD, bonuses.STA, bonuses.PWR, bonuses.GUT, bonuses.WIT,
                        chosenSkill.name, chosenSkill.origin
                    ))

    NewRandomSeed()
end

-- =================================================================== -surprise commands

function Commands.Setsurprise(Context)
    local master = 670109925971591170
    local sender = tonumber(Context.Message.author.id)

    if sender ~= master then
        Context.Message:reply("-# *Sorry nyaa~... Only my master can command me for this! >w<*")
        print(string.format("Surprise command attempted by non-master user %s (%s)", sender, Context.Message.author.name))
        return
    end

    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; **DO_SURPRISE()** function fails to run-----")
        return
    end

    local channelId = tostring(Context.Message.channel.id)

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Surprise = runtime.Data.EventSettings.Surprise or {}

    local entry = runtime.Data.EventSettings.Surprise[channelId]
    local target = (entry and entry.Target) or 0

    runtime.Data.EventSettings.Surprise[channelId] = {
        ChannelId = channelId,
        Target = target,
        MessageCount = 0,
        Pity = false,
        MorePity = false,
        Leaderboard = {}
    }

    if entry and entry.Target and entry.Target > 0 then
        Context.Message:reply("No, you silly master~~" ..
                            "-# *A surprise was already set in this channel, nya~ :3c*")
        return
    end

    runtime.Data.EventSettings.Surprise[channelId].Target = math.random(1, 100)

    local ok, err = runtime.SaveEventSettings and runtime.SaveEventSettings("src/Data/EventSettings.json") or false
    if not ok then
        Context.Message:reply("Bwaeh, I forgot where the surprise is, nyaa... I lost count too ;w;\n" ..
                            "-# *||Surprise enabled in memory but failed to persist-||*")
        print("Failed to save surprise settings: " .. tostring(err))
        return
    end

    print(string.format("Surprise enabled for channel %s with Target: %d",
        channelId, runtime.Data.EventSettings.Surprise[channelId].Target))

    Context.Message:reply("Minnaaaaa~~, I have surprises for you all! :D\n" ..
        "> *I have randomly picked a number between 1 and 100.\n" ..
        "> You all will roll a hidden d100 every message, and if it's the same, I will surprise you with something special~ mwehehehe >:3*\n" ..
        "-# ||I look forward to the explo-, I mean, **the surprise**, myao~ :3c||")
end

function Commands.Listsurprise(Context)
    local member = Context.Message.member
    if not member or not member:hasPermission("administrator") then
        Context.Message:reply("-# *Sorry nyaa~... Only people my master has permitted can command me to tell you~! >w<*")
        return
    end

    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; **LIST_SURPRISE()** function fails to run-----")
        return
    end

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Surprise = runtime.Data.EventSettings.Surprise or {}

    local surprises = runtime.Data.EventSettings.Surprise or {}
    local lines = {}
    for channelId, entry in pairs(surprises) do
        local Target = entry.Target or {}
        table.insert(lines, string.format(
            "## <#%s>\n> Count: %d\n> Target: %d",
            channelId,
            tonumber(entry.MessageCount) or 0,
            tonumber(Target) or 0)
        )
    end

    if #lines == 0 then
        Context.Message:reply("There's still no surprises here...\n-# *Wanna set one, nyaa? :3*")
        return
    end

    local payload = "# Configured surprise channels:\n---\n" .. table.concat(lines, "\n")

    local ok = pcall(function()
        Context.Message.author:send(payload)
    end)

    if ok then
        Context.Message:addReaction("👍")
    else
        Context.Message:reply(payload)
    end
end

function Commands.Removesurprise(Context)
    local master = 670109925971591170
    local sender = tonumber(Context.Message.author.id)

    if sender ~= master then
        Context.Message:reply("-# *Sorry nyaa~... Only my master can command me for this! >w<*")
        print(string.format("Surprise command (removesurprise) attempted by non-master user %s (%s)", sender, Context.Message.author.name))
        return
    end

    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; I-i-i can't r-remove the surprises-----")
        return
    end

    local channelId = tostring(Context.Message.channel.id)

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Surprise = runtime.Data.EventSettings.Surprise or {}

    if not runtime.Data.EventSettings.Surprise[channelId] then
        Context.Message:reply("There's still no surprises here...\n-# *Wanna set one, nyaa? :3*")
        return
    end

    runtime.Data.EventSettings.Surprise[channelId] = nil
    local ok, err = runtime.SaveEventSettings and runtime.SaveEventSettings("src/Data/EventSettings.json") or false
    if not ok then
        Context.Message:reply("## NOOOOO, I CAN'T REMOVE THE SURPRISES\n*AAAAAAA MASTER HELP MEEEE* 😭😭")
        print("Failed to remove surprises: " .. tostring(err))
        return
    end

    Context.Message:reply("Awe... you're no fun, hmph.\n-# *...surprise removed from this channel, nya...*")
end

function Commands.Leaderboardsurprise(Context)
    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; **LEADERBOARD_SURPRISE()** function fails to run-----")
        return
    end

    local channelId = tostring(Context.Message.channel.id)

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Surprise = runtime.Data.EventSettings.Surprise or {}

    local entry = runtime.Data.EventSettings.Surprise[channelId]
    if not entry or not entry.Leaderboard then
        Context.Message:reply("Nothing to rank in the leaderboard yet nya...\n-# *Wanna set a surprise first, nya~? :3*")
        return
    end

    local leaderboard = entry.Leaderboard or {}
    local rows = {}
    for userId, count in pairs(leaderboard) do
        table.insert(rows, { id = userId, count = count })
    end

    if #rows == 0 then
        Context.Message:reply("No entries in the leaderboard yet.\n-# *Wanna be the first, nya~? :3*")
        return
    end

    table.sort(rows, function(a, b)
        if a.count ~= b.count then return a.count > b.count end
        return tostring(a.id) < tostring(b.id)
    end)

    -- parse optional page number from command: m/leaderboardsurprise [page]
    local content = Context.Message.content or ""
    local _, _, pageArg = string.find(content, "(%d+)")
    local page = tonumber(pageArg) or 1
    if page < 1 then page = 1 end

    local perPage = 10
    local totalPages = math.max(1, math.ceil(#rows / perPage))
    if page > totalPages then
        Context.Message:reply(
            string.format(
                "Too much www.\n" ..
                "Page %d doesn't exist, silly~. There are only %d pages xd >w<", page, totalPages))
        return
    end

    local startIndex = (page - 1) * perPage + 1
    local endIndex = math.min(#rows, page * perPage)

    -- build embed fields for the requested page
    local fields = {}
    for i = startIndex, endIndex do
        local r = rows[i]
        local user = nil
        if Context and Context.Message and Context.Message.client then
            user = Context.Message.client:getUser(r.id)
        end
        local name = user and user.name or ("Whodis (" .. r.id .. ")")
        table.insert(fields, { name = string.format("#%d — %s", i, name), value = tostring(r.count), inline = true })
    end

    local embed = {
        title = "✨ Special Surprise Leaderboard! ✨ :D",
        description = string.format("Channel <#%s> | (Showing **#%d - #%d**)", Context.Message.channel.id, startIndex, endIndex),
        color = 0xFFD700,
        fields = fields,
        footer = { text = string.format("Page %d / %d\nUse (m/leaderboardsurprise [page] | m/ls [page]) to view other pages.", page, totalPages) }
    }

    local ok = pcall(function()
        if Context and Context.Message and Context.Message.author and type(Context.Message.author.send) == "function" then
            Context.Message:send({ embed = embed })
        else
            error("no DM available")
        end
    end)

    if ok then
        if Context and Context.Message and type(Context.Message.addReaction) == "function" then
            Context.Message:addReaction("👍")
        end
    else
        if Context and Context.Message and type(Context.Message.reply) == "function" then
            Context.Message:reply({ embed = embed })
        end
    end
end

-- =================================================================== -whoopie commands

function Commands.Setprank(Context)
    local master = {["670109925971591170"] = true, ["243387672993726464"] = true}
    local sender = Context.Message.author.id

    if not master[sender] then
        Context.Message:reply("-# *Sorry nyaa~... Only my master can command me for this! >w<*")
        print(string.format("Surprise command attempted by non-master user %s (%s)", sender, Context.Message.author.name))
        return
    elseif sender == "243387672993726464" then
        Context.Message:reply("**Kashikomarimashita**-nyan~!... This is the command my master taught me, that you requested to her, nyaa~ ^^" ..
                            "\nThank you for trusting me with this, myan! >w<")
    end

    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; **DO_PRANK()** function fails to run-----")
        return
    end

    local channelId = tostring(Context.Message.channel.id)

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Whoopie = runtime.Data.EventSettings.Whoopie or {}

    local entry = runtime.Data.EventSettings.Whoopie[channelId]
    local target = (entry and entry.Target) or 0

    runtime.Data.EventSettings.Whoopie[channelId] = {
        ChannelId = channelId,
        Target = target,
        Leaderboard = {}
    }

    if entry and entry.Target and entry.Target > 0 then
        Context.Message:reply("No, you silly master~~\n" ..
                            "-# *Look below you, there's already a whoop- I mean, **special cushion** already set, nya~ :3c*")
        return
    end

    runtime.Data.EventSettings.Whoopie[channelId].Target = math.random(1, 500)

    local ok, err = runtime.SaveEventSettings and runtime.SaveEventSettings("src/Data/EventSettings.json") or false
    if not ok then
        Context.Message:reply("Awh, I forgot where I put the cushion... I lost count too ;w;\n" .. 
                            "-# *||Prank enabled in memory but failed to persist-||*")
        print("Failed to save prank settings: " .. tostring(err))
        return
    end

    print(string.format("Whoopie enabled for channel %s with Target: %d",
        channelId, runtime.Data.EventSettings.Whoopie[channelId].Target))

    Context.Message:reply("Courtesy of **Prasi-shama**, I now have a prank ready!!\n" ..
                        "-# > *There's now a 1 in 500 chance that someone will- (pfft), \"\"fart\"\" here when they send a message! mwehehehe~ >:3*\n" ..
                        "-# *||Well~~, have fun minnaaaaaa!||* <:chuckling_neko:1080842672295641098>"
    )
end

function Commands.Removeprank(Context)
    local master = {["670109925971591170"] = true, ["243387672993726464"] = true}
    local sender = Context.Message.author.id
    local msg = ""

    if not master[sender] then
        Context.Message:reply("-# *Sorry nyaa~... Only my master can command me for this! >w<*")
        print(string.format("Prank command attempted by non-master user %s (%s)", sender, Context.Message.author.name))
        return
    elseif sender == "243387672993726464" then
        msg = ":c Pwasi-nyan?... Y-you want me to remove the whoopie cushion I set up?..." ..
                "\n-# *I-I'm sorry if it caused any trouble... I'll-, remove it right away-nya...*\n"
    end

    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; I-i-i can't r-remove the cushions-----")
        return
    end

    local channelId = tostring(Context.Message.channel.id)

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Whoopie = runtime.Data.EventSettings.Whoopie or {}

    if not runtime.Data.EventSettings.Whoopie[channelId] then
        Context.Message:reply("There's still no pranks here...\n-# *Wanna set one, nyaa? :3*")
        return
    end

    runtime.Data.EventSettings.Whoopie[channelId] = nil
    local ok, err = runtime.SaveEventSettings and runtime.SaveEventSettings("src/Data/EventSettings.json") or false
    if not ok then
        Context.Message:reply("## NOOOOO, I CAN'T REMOVE THE CUSHIONS\n*AAAAAAA MASTER HELP MEEEE* 😭😭")
        print("Failed to remove whoopies: " .. tostring(err))
        return
    end

    if msg == "" then
        msg = "Awe... you're no fun, hmph."
    end

    Context.Message:addReaction("😭")
    Context.Message:addReaction("<:imsadge:1247450703790866462>")
    Context.Message:reply(msg .. "\n-# *...pranks removed from this channel, nya...*")
end

function Commands.Leaderboardprank(Context)
    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; **LEADERBOARD_PRANK()** function fails to run-----")
        return
    end

    local channelId = tostring(Context.Message.channel.id)

    runtime.Data.EventSettings = runtime.Data.EventSettings or {}
    runtime.Data.EventSettings.Whoopie = runtime.Data.EventSettings.Whoopie or {}

    local entry = runtime.Data.EventSettings.Whoopie[channelId]
    if not entry or not entry.Leaderboard then
        Context.Message:reply("Nothing to rank in the leaderboard yet nya...\n-# *Wanna set the prank first, nya~? :3*")
        return
    end

    local leaderboard = entry.Leaderboard or {}
    local rows = {}
    for userId, count in pairs(leaderboard) do
        table.insert(rows, { id = userId, count = count })
    end

    if #rows == 0 then
        Context.Message:reply("No entries in the leaderboard yet.\n-# *Wanna be the first, nya~? :3*")
        return
    end

    table.sort(rows, function(a, b)
        if a.count ~= b.count then return a.count > b.count end
        return tostring(a.id) < tostring(b.id)
    end)

    -- parse optional page number
    local content = Context.Message.content or ""
    local _, _, pageArg = string.find(content, "(%d+)")
    local page = tonumber(pageArg) or 1
    if page < 1 then page = 1 end

    local perPage = 10
    local totalPages = math.max(1, math.ceil(#rows / perPage))
    if page > totalPages then
        Context.Message:reply(
            string.format(
                "Too much www.\n" ..
                "Page %d doesn't exist, silly~. There are only %d pages xd >w<", page, totalPages))
        return
    end

    local startIndex = (page - 1) * perPage + 1
    local endIndex = math.min(#rows, page * perPage)

    -- build embed fields for the requested page
    local fields = {}
    for i = startIndex, endIndex do
        local r = rows[i]
        local user = nil
        if Context and Context.Message and Context.Message.client then
            user = Context.Message.client:getUser(r.id)
        end
        local name = user and user.name or ("Whodis (" .. r.id .. ")")
        table.insert(fields, { name = string.format("#%d — %s", i, name), value = tostring(r.count), inline = true })
    end

    local embed = {
        title = "✨ Special Prank Leaderboard! ✨ :3c",
        description = string.format("Channel <#%s> | (Showing **#%d - #%d**)", Context.Message.channel.id, startIndex, endIndex),
        color = 0xFFD700,
        fields = fields,
        footer = { text = string.format("Page %d / %d\nUse (m/leaderboardprank [page] | m/lp [page]) to view other pages.", page, totalPages) }
    }

    local ok = pcall(function()
        if Context and Context.Message and Context.Message.author and type(Context.Message.author.send) == "function" then
            Context.Message:send({ embed = embed })
        else
            error("no DM available")
        end
    end)

    if ok then
        if Context and Context.Message and type(Context.Message.addReaction) == "function" then
            Context.Message:addReaction("👍")
        end
    else
        if Context and Context.Message and type(Context.Message.reply) == "function" then
            Context.Message:reply({ embed = embed })
        end
    end
end

-- =================================================================== -starboard commands

function Commands.Setstarboard(Context)
    local member = Context.Message.member
    if not member or not member:hasPermission("administrator") then
        Context.Message:reply("-# *Sorry nyaa~... Only people my master has permitted can command me to do this~! >w<*")
        return
    end

    local runtime = Context.Runtime
    if not runtime or not runtime.Data then
        Context.Message:reply("E-e-e-e-e-e-error...\n-# R-r-runtime unavailable; **SET_STARBO()** function fails to run-----")
        return
    end

    local guildId = tostring(Context.Message.guild.id)

    runtime.Data.Starboard = runtime.Data.Starboard or {}
    runtime.Data.Starboard[guildId] = runtime.Data.Starboard[guildId] or {}

    local entry = runtime.Data.Starboard[guildId]
    local starboChannel

    for c in Context.Message.mentionedChannels:iter() do
        starboChannel = c
        break
    end

    if not starboChannel then
        Context.Message:reply("Please mention a channel to set as the starboard, nya~ :3")
        return
    end
    
    starboChannel = starboChannel.id

    runtime.Data.Starboard[guildId] = {
        ChannelId = starboChannel,
        CountStarsMessage = {},
        Leaderboard = {}
    }

    if starboChannel.id == Context.Message.channel.id then
        Context.Message:reply("You silly master~~\n-" ..
                            "# *I can't set the starboard to the same channel, nya~ :3c*")
        return
    end

    if entry and entry.ChannelId and entry.ChannelId == starboChannel then
        Context.Message:reply("No, you silly master~~\n" ..
                            "-# *The starboard was already set in this channel, nya~ :3c*")
        return
    end

    local ok, err = runtime.SaveEventSettings and runtime.SaveStarboSettings("src/Data/Starboard.json") or false
    if not ok then
        Context.Message:reply("Bwaeh, I forgot where the surprise is, nyaa... I lost count too ;w;\n" ..
                            "-# *||Surprise enabled in memory but failed to persist-||*")
        print("Failed to save surprise settings: " .. tostring(err))
        return
    end

    print(string.format("Starboard activated in guild %d in channel %s",
        guildId, starboChannel))

    Context.Message:reply(string.format("Minnaaaaa~\\~, starboard is now active at <#%s> desu yo~~! x3\n", starboChannel))
end

-- =================================================================== -shorthand commands

function Commands.Cf(Context)
    Commands.Coinflip(Context)
end

function Commands.Ss(Context)
    Commands.Setsurprise(Context)
end

function Commands.List(Context)
    Commands.Listsurprise(Context)
end

function Commands.Rms(Context)
    Commands.Removesurprise(Context)
end

function Commands.Leads(Context)
    Commands.Leaderboardsurprise(Context)
end

function Commands.Sp(Context)
    Commands.Setprank(Context)
end

function Commands.Rmp(Context)
    Commands.Removeprank(Context)
end

function Commands.Leadp(Context)
    Commands.Leaderboardprank(Context)
end

return Commands
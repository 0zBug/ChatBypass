local Profanity = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.github.com/zacanger/profane-words/master/words.json"))

local game = getrawmetatable(game)
setreadonly(game, false)

local namecall = game.__namecall
game.__namecall = newcclosure(function(self, Message, ...)
    if getnamecallmethod() == "FireServer" and tostring(self) == "SayMessageRequest" then
    	local Match = false
    	
        for _, Word in next, Profanity do
			Message = string.gsub(Message, Word, function(c)
				if c == Word then
					Match = true
				end
				
				return c == Word and "</font></b>" .. string.gsub(c, "..?", "<b><font>%1</font></b>") .. "<b><font>" or c
			end)
		end
		
		Message = string.gsub(Message, "%.", function(c)
			Match = true
			
			return "</font></b><b><font>.</font></b><b><font>"
		end)

        if Match then
        	Message = "<b><font>" .. Message .. "</font></b>"
        end
        
        return namecall(self, Message, ...)
    else
        return namecall(self, Message, ...)
    end
end)

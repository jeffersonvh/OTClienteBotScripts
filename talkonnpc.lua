setDefaultTab("Tools")

onTalk(function(name, level, mode, text, channelId, pos)
    if (mode ~= 7) then return end

    NPC.say(text)
end)

UI.Separator()
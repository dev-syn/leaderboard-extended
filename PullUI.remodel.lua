--- @diagnostic disable: undefined-global

local game = remodel.readPlaceFile("LeaderboardExtended.rbxlx");

local serviceName = table.pack(...)[1];
if serviceName then
    local QueryService = game:GetService(serviceName);

    local UI = QueryService:FindFirstChild("LeaderboardUI");
    if UI then
        remodel.writeModelFile("lib/LeaderboardExtendedUI.rbxmx",UI);
    end
end
---@diagnostic disable: undefined-global
local game = remodel.readPlaceFile("LeaderboardExtended.rbxlx");

remodel.createDirAll("UI");

local LeaderboardExtenderModule = game.ReplicatedStorage:FindFirstChild("LeaderboardExtender");

if LeaderboardExtenderModule then
    local LeaderboardUI = LeaderboardExtenderModule:FindFirstChild("LeaderboardUI");
    if LeaderboardUI then
        remodel.writeModelFile("UI/"..LeaderboardUI.Name..".rbxmx",LeaderboardUI);
    end
end
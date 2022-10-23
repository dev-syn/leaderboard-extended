---@module LeaderboardExtended/lib/Types
local Types = require(script.Parent:FindFirstChild("Types"));
type UserPanel = Types.UserPanel;
type LeaderboardExtended = Types.LeaderboardExtended;

local LeaderboardUI = {} :: Types.LeaderboardUI;

local UI: ScreenGui = script.Parent:FindFirstChild("LeaderboardExtendedUI");
LeaderboardUI.UI = UI;

local Background: Frame = UI:FindFirstChild("Background");
LeaderboardUI.Background = Background;

local PlayerList: ScrollingFrame = Background:FindFirstChild("PlayerList");
LeaderboardUI.PlayerList = PlayerList;

local PlayerListLayout: UIListLayout = PlayerList:FindFirstChild("PlayerListLayout");
LeaderboardUI.ListLayout = PlayerListLayout;

task.spawn(function(UI: ScreenGui) UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"); end,UI);

return LeaderboardUI;
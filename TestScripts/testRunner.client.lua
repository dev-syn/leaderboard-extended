local PlayerScripts: PlayerScripts = game.Players.LocalPlayer:WaitForChild("PlayerScripts");
local LeaderboardExtendedModule: ModuleScript = PlayerScripts:WaitForChild("LeaderboardExtended") :: ModuleScript;

---@module LeaderboardExtended/lib/Types
local Types = require(LeaderboardExtendedModule:FindFirstChild("Types"));

local LeaderboardExtended: Types.LeaderboardExtended = require(LeaderboardExtendedModule);

local Config = {
    DefaultIcon = "rbxassetid://6022668898"
};
LeaderboardExtended.UserPanel.SetIconRetrieveHandler(function(plr: Player)
    return "rbxassetid://6023426915"
end);
LeaderboardExtended.Init(Config);
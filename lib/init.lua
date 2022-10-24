game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false);

---@module LeaderboardExtended/lib/Types
local Types = require(script:FindFirstChild("Types"));
export type UserPanel = Types.UserPanel;
export type LeaderboardExtended = Types.LeaderboardExtended;

--[=[
    @class LeaderboardExtended

    This is a class that is designed to provide a customized leaderboard that includes the players and icons that can be set next to the [Player].
]=]
local LeaderboardExtended = {} :: LeaderboardExtended;

local userPanels: Types.Map<Player,UserPanel> = {};
--[=[
    @prop _UserPanels Map<Player,UserPanel>
    @within LeaderboardExtended
    @private

    This property is a Map<K,V> that routes the [Player] objects to the users [UserPanel].
]=]
LeaderboardExtended._UserPanels = userPanels;

local Config: Types.Config;

--[=[
    @within LeaderboardExtended

    This function loads the passed [Config] into [LeaderboardExtended].
]=]
function LeaderboardExtended.LoadConfig(config: Types.Config)
    Config = config;
end

--[=[
    @within LeaderboardExtended

    This function returns the active loaded configuration being used by [LeaderboardExtended].
]=]
function LeaderboardExtended.GetConfig() : Types.Config
    return Config;
end

local LeaderboardUI: Types.LeaderboardUI = require(script:FindFirstChild("LeaderboardUI"));
--[=[
    @within LeaderboardExtended
    @return LeaderboardUI

    This function is used to retrieve the [LeaderboardExtended] UI.
]=]
function LeaderboardExtended.GetUI() : Types.LeaderboardUI
    return LeaderboardUI;
end

local function resizePlayerList()
    local y_offset: number = 0;
    for _,panel: UserPanel in pairs(userPanels) do
        y_offset += panel.UserFrame.AbsoluteSize.Y;
    end
    LeaderboardUI.PlayerList.CanvasSize = UDim2.new(0,0,0,y_offset);
end

local UserPanel: Types.Schema_UserPanel = require(script:FindFirstChild("UserPanel"));
--[=[
    @prop UserPanel UserPanel
    @within LeaderboardExtended
    @tag reference

    This property stores a reference to the [UserPanel] class.
]=]
LeaderboardExtended.UserPanel = UserPanel;

local function initUserPanel(plr: Player)
    if not userPanels[plr] then
        userPanels[plr] = UserPanel.new(plr,nil);
        resizePlayerList();
    end
end

local playerAddedListener: RBXScriptConnection,playerRemovingListener: RBXScriptConnection;
local isInitialized: boolean = false;
--[=[
    @within LeaderboardExtended

    This function **must** be called and it initializes [LeaderboardExtended] setting up the users [UserPanel] objects and draws the UI.

    :::danger

    Failure to call this function will cause [LeaderboardExtended] to break.

    :::
]=]
function LeaderboardExtended.Init(config: Types.Config)
    if isInitialized then return; end
    UserPanel.Init(LeaderboardExtended);
    -- Load the LeaderboardExtended config
    if config then LeaderboardExtended.LoadConfig(config); end

    -- Remove UserPanels for leaving players
    if playerRemovingListener then playerRemovingListener:Disconnect(); end
    playerRemovingListener = game.Players.PlayerRemoving:Connect(function(plr: Player)
        local userPanel: UserPanel = userPanels[plr];
        if userPanel then
            userPanel:Destroy();
            userPanels[plr] = nil::any;
            resizePlayerList();
        end
    end);
    -- Init UserPanel for joining players
    if playerAddedListener then playerAddedListener:Disconnect(); end
    playerAddedListener = game.Players.PlayerAdded:Connect(initUserPanel);
    -- Unparent & reparent the ListLayout in PlayerList
    LeaderboardUI.ListLayout.Parent = nil::any;
    for _,plr: Player in ipairs(game.Players:GetPlayers()) do initUserPanel(plr); end
    LeaderboardUI.ListLayout.Parent = LeaderboardUI.PlayerList;
    LeaderboardUI.UI.Enabled = true;
    isInitialized = true;
end

return LeaderboardExtended;
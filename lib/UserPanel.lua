---@module LeaderboardExtended/lib/Types
local Types = require(script.Parent:FindFirstChild("Types"));
type UserPanel = Types.UserPanel;
type LeaderboardExtended = Types.LeaderboardExtended;

--[=[
    @class UserPanel

    This class was designed to contain user relevant properties and methods
    used to customize the user features.
]=]
local UserPanel = {} :: Types.Schema_UserPanel;
UserPanel.__index = UserPanel;

local function createUserNameLabel(name: string) : TextLabel
    local userName = Instance.new("TextLabel");
    userName.Name = "PlayerName";
    userName.ZIndex = 2;
    userName.AnchorPoint = Vector2.new(1,0);
    userName.Size = UDim2.new(0.75,0,1,0);
    userName.Position = UDim2.new(1,0,0,0);
    userName.BackgroundColor3 = Color3.fromRGB(75,75,75);
    userName.FontSize = Enum.FontSize.Size14;
    userName.TextSize = 14;
    userName.TextColor3 = Color3.fromRGB(255,255,255);
    userName.TextWrapped = true;
    userName.Font = Enum.Font.Merriweather;
    userName.TextWrap = true;
    userName.TextScaled = true;
    userName.Text = name;
    userName.TextXAlignment = Enum.TextXAlignment.Left;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 18;
    UITextSizeConstraint.MinTextSize = 10;
    UITextSizeConstraint.Parent = userName;

    return userName;
end

local function createUserIconLabel(imageID: string?) : ImageLabel
    local userIcon = Instance.new("ImageLabel")
    userIcon.Name = "PlayerIcon";
    userIcon.ZIndex = 2;
    userIcon.Size = UDim2.new(0.25,0,1,0);
    userIcon.BorderSizePixel = 0;
    userIcon.BackgroundColor3 = Color3.fromRGB(75,75,75);
    userIcon.ScaleType = Enum.ScaleType.Fit;
    if imageID then userIcon.Image = imageID; end
    return userIcon;
end

local LeaderboardExtended: LeaderboardExtended;
local LeaderboardUI: Types.LeaderboardUI;

local IconRetrieveHandler: (plr: Player) -> string;
local function createUserFrame(plr: Player) : Frame
    local userFrame: Frame = Instance.new("Frame");
    userFrame.Name = "PlayerFrame";
    userFrame.Size = UDim2.new(1,0,0.1,0);
    userFrame.BackgroundColor3 = Color3.fromRGB(52,52,52);
    local userNameLabel: TextLabel = createUserNameLabel(plr.Name);
    userNameLabel.Parent = userFrame;
    local Config: Types.Config = LeaderboardExtended.GetConfig();
    local imageID: string;
    if IconRetrieveHandler then
        imageID = IconRetrieveHandler(plr);
    else
        imageID = Config and Config.DefaultIcon or "";
    end
    local userIconLabel: ImageLabel = createUserIconLabel(imageID);
    userIconLabel.Parent = userFrame;
    return userFrame;
end

--[=[
    @within UserPanel
    @param iconRetrieveHandler (plr: Player) -> string -- This function passes the player as an arg then should return a image id

    This function sets the iconRetrieveHandler which is a function that
    gets called when a users icon is being generated for their user frame.

    :::note

    This handler can be set to override a players icon in [LeaderboardExtended].

    :::
]=]
function UserPanel.SetIconRetrieveHandler(iconRetrieveHandler: (plr: Player) -> string)
    if typeof(iconRetrieveHandler) ~= "function" then
        error("iconRetrieveHandler must be a function that follows (plr: PLayer) -> string",3);
    end
    IconRetrieveHandler = iconRetrieveHandler;
end

--[=[
    @within UserPanel

    This function initializes the [UserPanel] passing the [LeaderboardExtended] reference.
]=]
function UserPanel.Init(leaderboardExtended: LeaderboardExtended)
    LeaderboardExtended = leaderboardExtended;
    LeaderboardUI = LeaderboardExtended.GetUI();
end

--[=[
    @within UserPanel

    This function creates a new [UserPanel] object and is mainly for internal use.
]=]
function UserPanel.new(plr: Player,userIconID: string?) : UserPanel
    local self = {} :: Types.Object_UserPanel;
    self.plr = plr;
    self.UserFrame = createUserFrame(plr);
    self.UserFrame.Parent = LeaderboardUI.PlayerList;
    return setmetatable(self,UserPanel) :: UserPanel;
end

--[=[
    @method Destroy
    @within UserPanel

    This method destroys the [UserPanel] object destroying the UserFrame and clearing references.
]=]
function UserPanel.Destroy(self: UserPanel)
    if self.UserFrame then
        self.UserFrame:Destroy();
        self.UserFrame = nil;
    end
end

return UserPanel;
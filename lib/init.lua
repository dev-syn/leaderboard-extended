local isServer: boolean = game:GetService("RunService"):IsServer();

local LeaderboardExtender = {};
LeaderboardExtender.ClassName = "LeaderboardExtender";

local function formatOut(prefix: string?,text: string) : string
    return string.format("[%s]: %s",prefix or LeaderboardExtender.ClassName,text);
end

local PlayerContent = {};
PlayerContent.__index = PlayerContent;

local function isPlayer(value: any) : boolean
    return typeof(value) == "Instance" and value:IsA("Player") or false;
end

function PlayerContent.new(owner: Player)
    if not isPlayer(owner) then
       error(formatOut(nil,"owner must be a Player Instance"),3);
    end
    local self = {};
    self.Owner = owner;
    self.DisplayName = self.Owner.Name;
    return self;
end

function PlayerContent.SetDisplayName(self)
    
end

-- {[Player]: PlayerContent}
LeaderboardExtender.Content = {};

local function addPlayerContent(plr: Player)
    LeaderboardExtender.Content[plr] = PlayerContent.new(plr);
end

local isInitialized: boolean = false;
function LeaderboardExtender.Init()
    if isInitialized then return; end
    game.Players.PlayerAdded:Connect(function(plr: Player)
        if not LeaderboardExtender.Content[plr] then
            addPlayerContent(plr);
        end
    end);
    for _,plr: Player in ipairs(game.Players:GetPlayers()) do
        if not LeaderboardExtender.Content[plr] then
            addPlayerContent(plr);
        end
    end

    isInitialized = true;
end

return LeaderboardExtender;
export type Map<K,V> = {[K]: V};
export type Dictionary<T> = Map<string,T>;

-- #region LeaderboardUI
    export type LeaderboardUI = {
        UI: ScreenGui,
        Background: Frame,
        PlayerList: ScrollingFrame,
        ListLayout: UIListLayout
    }
-- #endregion

-- #region UserPanel
    export type Object_UserPanel = {
        plr: Player,
        UserFrame: Frame?
    };
    export type Schema_UserPanel = {
        __index: any,

        SetIconRetrieveHandler: (iconRetrieveHandler: (plr: Player) -> string) -> (),
        Init: (leaderboardExtended: LeaderboardExtended) -> (),
        new: (plr: Player,userIconID: string?) -> UserPanel,
        Destroy: (self: UserPanel) -> ()
    };
    export type UserPanel = Schema_UserPanel & Object_UserPanel;
-- #endregion

export type Config = {
    DefaultIcon: string
};

export type LeaderboardExtended = {
    _UserPanels: Map<Player,UserPanel>,
    UserPanel: Schema_UserPanel,

    LoadConfig: (config: Config) -> (),
    GetConfig: () -> Config,
    GetUI: () -> LeaderboardUI,
    Init: (config: Config) -> ()
};
return true;
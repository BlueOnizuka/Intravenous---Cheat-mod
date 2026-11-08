local a = {}
a._type = "check";
a.translationID = "CHEAT_MOD_HIDE_HUD";

function a:onEnable()
    game.addHUDBlocker(self);

    return true;
end

function a:onDisable()
    game.removeHUDBlocker(self);

    return true;
end

return a;
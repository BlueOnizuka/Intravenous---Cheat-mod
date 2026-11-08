local a = {}
a._categoryID = "PLAYER";
a._type = "check";
a.translationID = "CHEAT_MOD_INVISIBILITY";

function a:getPlayer()
    return game.playerActor;
end


local getVisibility = playerActor.getVisibility;
local getRawVisibility = playerActor.getRawVisibility;

local dummyFunc = function() return 0; end

function a:onEnable()
    local player = self:getPlayer();
    if (not player) then return; end

    player.getVisibility = dummyFunc;
    player.getRawVisibility = dummyFunc;
end

function a:onDisable()
    local player = self:getPlayer();
    if (not player) then return; end

    player.getVisibility = getVisibility;
    player.getRawVisibility = getRawVisibility;
end

return a;
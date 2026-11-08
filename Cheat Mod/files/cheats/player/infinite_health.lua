local a = {}
a._categoryID = "PLAYER";
a._type = "check";
a.translationID = "CHEAT_MOD_INFINITE_HEALTH";

function a:getPlayer()
    return game.playerActor;
end

local takeDamage = playerActor.takeDamage;
local addHealthRegen = playerActor.addHealthRegen;
local dummyFunc =function(self) return; end
function a:onEnable()
    local player = self:getPlayer();
    if (not player) then return; end

    player.takeDamage = dummyFunc;
    player.addHealthRegen = dummyFunc;
    player.healthRegen = 0;
end

function a:onDisable()
    local player = self:getPlayer();
    if (not player) then return; end

    player.takeDamage = takeDamage;
    player.addHealthRegen = addHealthRegen;
end

return a;
local a = {}
a._categoryID = "PLAYER";
a._type = "click";
a.translationID = "CHEAT_MOD_REFILL_HEALTH";

function a:getPlayer()
    return game.playerActor;
end

function a:onClick()
    local player = self:getPlayer();
    if (not player) then return; end

    player:setHealth(player.maxHealth);

    return true;
end

return a;
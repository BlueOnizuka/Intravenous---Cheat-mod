local a = {}
a._categoryID = "PLAYER";
a._type = "click";
a.translationID = "CHEAT_MOD_REFILL_SHIELD";

function a:getPlayer()
    return game.playerActor;
end

function a:onClick()
    local player = self:getPlayer();
    if (not player) then
        return;
    end

    local armorObj = player:getArmor();
    if (not armorObj) then
        return;
    end

    armorObj:maxOutHealth()
    armorObj:modulateDamage(0, 0)

    return true;
end

return a;

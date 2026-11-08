local a = {}
a._categoryID = "WEAPON";
a._type = "click";
a.translationID = "CHEAT_MOD_REFILL_CURRENT_WEAPON";

function a:getPlayer()
    return game.playerActor;
end

function a:onClick()
    local player = self:getPlayer();
    if (not player) then return; end

    local weaponObj = player:getWeapon();
    if (not weaponObj) then return; end
    weaponObj:giveStartingAmmo();
    player:onReloaded(weaponObj);

    return true;
end

return a;
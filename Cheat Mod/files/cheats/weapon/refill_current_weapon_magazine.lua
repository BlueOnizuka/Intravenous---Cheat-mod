local a = {}
a._categoryID = "WEAPON";
a._type = "click";
a.translationID = "CHEAT_MOD_REFILL_CURRENT_WEAPON_MAGAZINE";

function a:getPlayer()
    return game.playerActor;
end

function a:onClick()
    local player = self:getPlayer();
    if (not player) then return; end

    local weaponObj = player:getWeapon();
    if (not weaponObj) then return; end
    weaponObj.mag = weaponObj:getMagSize();
    player:updateMagText();

    return true;
end

return a;
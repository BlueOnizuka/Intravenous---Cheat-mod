local a = {}
a._categoryID = "LOADOUT";
a._type = "click";
a.translationID = "CHEAT_MOD_FIX_KEY_BINDING";

function a:onClick()
    if (not game.playerActor) then return; end
    for weaponNumber,weaponData in pairs(game.playerActor.weapons) do 
        weaponData:setKey(weaponNumber);
    end

    return true;
end

return a;
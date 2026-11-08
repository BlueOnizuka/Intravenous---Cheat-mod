local a = {}
a._categoryID = "PLAYTHROUGH";
a._type = "click";
a.translationID = "CHEAT_MOD_UNLOCK_ALL_WEAPONS";

function a:onClick()
    for weaponID, _ in pairs(weapons.registeredByID) do
        game.playthrough:addUnlockedWeapon(weaponID)
    end
end

return a;
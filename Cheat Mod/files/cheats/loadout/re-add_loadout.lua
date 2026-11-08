local a = {}
a._categoryID = "LOADOUT";
a._type = "click";
a.translationID = "CHEAT_MOD_RE-ADD_LOADOUT";

function a:getPlayer()
    return game.playerActor;
end

function a:onClick()
    local player = self:getPlayer();
    if (not player) then return; end
    if (not loadoutSelectionMenu.loadoutSlotCount) then return; end

    loadoutSelectionMenu:giveLoadoutToPlayer(player);

    return true;
end

return a;
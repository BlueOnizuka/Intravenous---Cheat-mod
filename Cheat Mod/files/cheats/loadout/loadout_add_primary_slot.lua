local a = {}
a._categoryID = "LOADOUT";
a._type = "click";
a.translationID = "CHEAT_MOD_ADD_PRIMARY_SLOT";

function a:onClick()
    loadoutSelectionMenu:addSlotType(weapons.TYPES.PRIMARY, 1, false)

    return true;
end

return a;
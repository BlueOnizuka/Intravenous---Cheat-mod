local a = {}
a._categoryID = "LOADOUT";
a._type = "click";
a.translationID = "CHEAT_MOD_ADD_GADGET_SLOT";

function a:onClick()
    loadoutSelectionMenu:addSlotType(weapons.TYPES.GADGET, 1, false);

    return true;
end

return a;
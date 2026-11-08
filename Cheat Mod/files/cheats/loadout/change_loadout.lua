local a = {}
a._categoryID = "LOADOUT";
a._type = "click";
a.translationID = "CHEAT_MOD_CHANGE_LOADOUT";

function a:onClick()
    loadoutSelectionMenu:createLoadoutMenu();
end

return a;
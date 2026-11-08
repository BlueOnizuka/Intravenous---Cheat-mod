local a = {}
a._categoryID = "LOADOUT";
a._type = "click";
a.translationID = "CHEAT_MOD_RESET_LOADOUT";

a.DEFAULT_MAX_SLOTS = loadoutSelectionMenu.MAX_SLOTS

function a:getStartingIndex()
    local SELECTABLE_SLOTS = loadoutSelectionMenu.SELECTABLE_SLOTS;
    local slots = 0
    for i=1, #SELECTABLE_SLOTS do
        slots = slots + SELECTABLE_SLOTS[i][2];
        if (slots >= self.DEFAULT_MAX_SLOTS) then
            return i;
        end
    end
end

function a:onClick()
    local SELECTABLE_SLOTS = loadoutSelectionMenu.SELECTABLE_SLOTS
    loadoutSelectionMenu.MAX_SLOTS = self.DEFAULT_MAX_SLOTS;

    for i=self:getStartingIndex()+1, #SELECTABLE_SLOTS do
        table.remove(SELECTABLE_SLOTS, #SELECTABLE_SLOTS)
    end

    return true;
end

return a;
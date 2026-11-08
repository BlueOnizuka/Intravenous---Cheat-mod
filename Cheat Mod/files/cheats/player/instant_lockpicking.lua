local a = {}
a._categoryID = "PLAYER";
a._type = "check";
a.translationID = "CHEAT_MOD_INSTANT_LOCKPICKING";

function a:getLockpickingState()
    return npcStates:getData("player_lockpicking");
end

local setObject = a:getLockpickingState().setObject;
function a:onEnable()
    local state = self:getLockpickingState();
    if (not state) then return false; end

    state.setObject = function(self, obj)
        setObject(self, obj);
        self.lockpickTime = 0;
    end

    return true;
end

function a:onDisable()
    local state = self:getLockpickingState();
    if (not state) then return false; end

    state.setObject = setObject;

    return true;
end

return a;
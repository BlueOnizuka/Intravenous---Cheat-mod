local a = {}
a._categoryID = "WEAPON";
a._type = "check";
a.translationID = "CHEAT_MOD_NO_SPREAD";

local base_weapon = weapons:getData("base_weapon");
local base_weapon_getRealSpread = base_weapon.getRealSpread;

local newGetRealSpread = function(self)
    return (self.owner.PLAYER) and 0 or self.realSpread;
end
function a:onEnable()
    base_weapon.getRealSpread = newGetRealSpread;
    return true;
end

function a:onDisable()
    base_weapon.getRealSpread = base_weapon_getRealSpread;
    return true;
end

return a;
local a = {}
a._categoryID = "WEAPON";
a._type = "check";
a.translationID = "CHEAT_MOD_INSTANT_RELOAD";

a.CATCHABLE_EVENTS = {
    weapons.EVENTS.RELOADING
}

function a:handleEvent(event, data)
    local weaponObj = data;
    local owner = weaponObj.owner;
    if (not owner.PLAYER) then return; end

    print("weapons.EVENTS.RELOADING", weaponObj:getID());

    print(weaponObj:getID(), weaponObj.baseClass:getID());

    -- for tube_reload_weapon_base
    if (weaponObj.RELOAD_STATES) then
        local maxAmmo = weaponObj:getMaxAmmo();
        local ammoType = weaponObj.ammoType;

        local ammo = owner:getAmmo(ammoType);
        local mag = weaponObj.mag;
        while (ammo > 0 and mag < maxAmmo) do
		    weaponObj:insertShell();
            ammo = owner:getAmmo(ammoType);
            mag = weaponObj.mag;
        end
    end

    if (weaponObj:isWeaponBlocked()) then
        weaponObj:blockWeaponFor(0);
    end

    weaponObj:finishReload();
end

local weapons = weapons;

function a:onEnable()
    events:addDirectReceiver(self, self.CATCHABLE_EVENTS);

    return true;
end

function a:onDisable()
    events:removeDirectReceiver(self, self.CATCHABLE_EVENTS);

    return true;
end

return a;
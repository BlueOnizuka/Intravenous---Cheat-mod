local a = {}
a._categoryID = "PLAYER";
a._type = "check";
a.translationID = "CHEAT_MOD_INFINITE_SHIELD";

a.CATCHABLE_EVENTS = {
    playerActor.EVENTS.ARMOR_SET
}

local originalFunc = nil;
local dummyFunc = function(self, damage, penetration) return 0; end
function a:handleEvent(event, data)
    self:modifyArmorObj(data);
end

function a:getPlayer()
    return game.playerActor;
end

function a:modifyArmorObj(armorObj)
    if (not armorObj) then
        local player = self:getPlayer();
        if (not player) then return; end

        armorObj = player:getArmor();
    end

    if (armorObj) then
        originalFunc = armorObj.modulateDamage;
        armorObj.modulateDamage = dummyFunc;
    end
end

function a:restoreOriginal(armorObj)
    if (not armorObj) then
        local player = self:getPlayer();
        if (not player) then return; end

        armorObj = player:getArmor();
    end

    if (armorObj) then
        armorObj.modulateDamage = originalFunc;
    end

    originalFunc = nil;
end

local setArmor = playerActor.setArmor;
function a:onEnable()
    events:addDirectReceiver(self, self.CATCHABLE_EVENTS);

    self:modifyArmorObj()
end

function a:onDisable()
    events:removeDirectReceiver(self, self.CATCHABLE_EVENTS);

    self:restoreOriginal();
end

return a;
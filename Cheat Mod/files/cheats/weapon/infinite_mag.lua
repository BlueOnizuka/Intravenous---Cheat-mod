local a = {}
a._categoryID = "WEAPON";
a._type = "check";
a.translationID = "CHEAT_MOD_INFINITE_MAG";

--------------------------------------------------------------------
--------------------------------------------------------------------
--#region event catcher for primary & secondary weapons
a.CATCHABLE_EVENTS = {
    weapons.EVENTS.PLAYER_FIRED
}
function a:handleEvent(event, data)
    if (c:isEnabled("infinite_mag")) then
        local playerActor = game.playerActor;
        if (not playerActor) then return; end

        local weapon = playerActor.weapon;
        if (not weapon) then return; end
        weapon:maxOutAmmo();    -- works for primary & secondary
    end
end
events:addDirectReceiver(a, a.CATCHABLE_EVENTS)
--#endregion

--------------------------------------------------------------------
--------------------------------------------------------------------
--#region backing up original functions for gadgets
local dummyFunc = function() end
local throwing_knife = weapons:getData("throwing_knife");
throwing_knife.__onThrowFinished = throwing_knife.onThrowFinished;

local flashbang = weapons:getData("flashbang");
flashbang.__onThrowFinished = flashbang.onThrowFinished;

local empty_mag = weapons:getData("empty_mag");
empty_mag.__onThrowFinished = empty_mag.onThrowFinished;

local disruptor = weapons:getData("disruptor");
disruptor.__restoreCharge = disruptor.restoreCharge;
local function NEWrestoreCharge(self)
    if self.charge < self.maxCharge then
        self.charge = self.maxCharge;
    end
end
--#endregion

function a:onEnable()
    flashbang.onThrowFinished = dummyFunc;
    throwing_knife.onThrowFinished = dummyFunc;
    empty_mag.onThrowFinished = dummyFunc;
    disruptor.restoreCharge = NEWrestoreCharge;
end

function a:onDisable()
    flashbang.onThrowFinished = flashbang.__onThrowFinished;
    throwing_knife.onThrowFinished = throwing_knife.__onThrowFinished;
    empty_mag.onThrowFinished = empty_mag.__onThrowFinished;
    disruptor.restoreCharge = disruptor.__restoreCharge;
end

return a;
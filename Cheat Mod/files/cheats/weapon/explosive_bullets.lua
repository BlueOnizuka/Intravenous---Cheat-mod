local a = {}
a._categoryID = "WEAPON";
a._type = "check";
a.translationID = "CHEAT_MOD_EXPLOSIVE_BULLETS";

local bullet = objects.getClassData("bullet");
local bullet_onHitBullet = bullet._onHitBullet

local function _onHitBullet(self, object, hitData)
	local gren = objects.create("frag_grenade")

    gren:setFuseDelay(0)
	gren:setPos(self.x, self.y)
	gren:assignID()
	gren:onPlacedIntoMap()
	gren:setupVisual()
	gren:setZ(190)
	gren:setThrower(self:getFirer())
	gren:makePhysical()

	if not object:onHitBullet(self, hitData) then
		self:makeInactive()
	end
end

function a:onEnable()
    bullet._onHitBullet = _onHitBullet;
    return true;
end

function a:onDisable()
    bullet._onHitBullet = bullet_onHitBullet;
    return true;
end

return a;
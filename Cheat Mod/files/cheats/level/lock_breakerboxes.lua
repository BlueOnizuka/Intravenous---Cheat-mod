local a = {}
a._categoryID = "LEVEL";
a._type = "click";
a.translationID = "CHEAT_MOD_LOCK_BREAKERBOXES";

function a:getBreakerBoxClassID()
    return objects.getClassID("breaker_box");
end

function a:getBreakerBoxes()
    return game.worldObject:getObjectsByClass( self:getBreakerBoxClassID() );
end

function a:onClick()
    local objects = self:getBreakerBoxes();
    if (not objects) then return; end

    local obj;
    for i=1, #objects do
        obj = objects[i];

        obj:setLocked(true);
    end
end

return a;
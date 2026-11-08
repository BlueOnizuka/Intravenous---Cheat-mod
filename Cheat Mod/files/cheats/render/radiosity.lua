local a = {}
a._categoryID = "RENDER";
a._type = "check";
a.translationID = "CHEAT_MOD_RADIOSITY_TOGGLE";

function a:onGUICreation(GUIObject)
    if (radiosity:getRadiosityState()) then
        self:enable()
    else
        self:disable()
    end
end

function a:onEnable()
    local state = radiosity:getRadiosityState()
    if (state) then return; end

    radiosity:setRadiosityState(true)
end

function a:onDisable()
    local state = radiosity:getRadiosityState()
    if (not state) then return; end

    radiosity:setRadiosityState(false)
end

return a;
local a = {}
a.mtindex = {__index = a};

function a:getID()
    return self.id;
end

function a:getTranslationID()
    return self.translationID;
end

function a:getTranslationString()
    return self.translationID and _T( self.translationID ) or self.id;
end

function a:onGUICreation(GUIObject)
    -- abstract
end
function a:onGUIDestruction(GUIObject)
    -- abstract
end

function a:onEnable()
    -- abstract
end
function a:onDisable()
    -- abstract
end

function a:onClick()
    -- abstract
end

function a:getType()
    return self._type;
end

function a:getCategory()
    return self._categoryID or c.defaultCategory;
end

function a:enable()
    if ( self:isEnabled() ) then return; end

    self._enabled = true;
    self:onEnable();
end

function a:disable()
    if ( self:isDisabled() ) then return; end

    self._enabled = false;
    self:onDisable();
end

function a:isEnabled()
    return self._enabled;
end
function a:isDisabled()
    return not self._enabled;
end

return a;
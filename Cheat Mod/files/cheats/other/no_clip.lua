local a = {}
a._type = "check";
a.translationID = "CHEAT_MOD_NO_CLIP";

a.previousZoom = 2;
a.camX, a.camY = 0, 0;

------------------------------------------------------------------------------
------------------------------------------------------------------------------

local no_clip_layer = {};

no_clip_layer.offset = 64;
no_clip_layer.text = "-- NOCLIP --\n\tMove - same as player controls\n\tZoom - mouse wheel"
no_clip_layer.textFont = fonts.get("terminal32")
no_clip_layer.textWidth = no_clip_layer.textFont:getWidth(no_clip_layer.text);
no_clip_layer.textHeight = no_clip_layer.textFont:getHeight()*3;

function no_clip_layer:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(no_clip_layer.textFont)
    love.graphics.print(no_clip_layer.text, resolutionHandler.realW - no_clip_layer.textWidth - no_clip_layer.offset, resolutionHandler.realH - no_clip_layer.textHeight - no_clip_layer.offset);
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

local camera = camera;
local dummyFunc = function(self) end

local playerState = npcStates:getData("player_state");
local playerState_getBaseCameraPosition = playerState.getBaseCameraPosition;
local playerState_handleMovement = playerState.handleMovement;

local function getBaseCameraPosition(self)
    return a.camX, a.camY;
end

local function handleMovement(self, dt)
    local act = self.actor
    local body = act:getBody()
    local x, y = body:getPosition()

--    act:setPos(x, y)

    local grid = game.worldObject:getFloorTileGrid()
    local targetXVel, targetYVel, xApproachRate, yApproachRate = self:getWalkVelocity(act:getMoveSpeed(), dt)
    local xVel, yVel = act:getVelocity()
    xVel = math.approach(xVel, targetXVel, xApproachRate)
    yVel = math.approach(yVel, targetYVel, yApproachRate)

--    act:setVelocity(xVel, yVel)
--    act:move(xVel, yVel)

    a.camX, a.camY = a.camX+xVel*.5, a.camY+yVel*.5;
end

------------------------------------------------------------------------------

local playerActor = playerActor;
local playerActor_handleFireKey = playerActor.handleFireKey;
local playerActor_handleMouseWheel = playerActor.handleMouseWheel;

local handleMouseWheel = function(self, dir)
    camera:changeZoomLevel(dir);
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

function a:onEnable()
    self.previousZoom = camera:getZoomLevel();

    if (game.playerActor) then
        self.camX, self.camY = game.playerActor.body:getPosition();
    elseif (camera) then
        self.camX, self.camY = camera:getPosition();
    else    -- just in case, lol
        self.camX, self.camY = 0, 0;
    end

    playerActor.handleFireKey = dummyFunc;
    playerActor.handleMouseWheel = handleMouseWheel;

    playerState.getBaseCameraPosition = getBaseCameraPosition;
    playerState.handleMovement = handleMovement;

    layerRenderer:addLayer(no_clip_layer)

    return true;
end

function a:onDisable()
    camera:setZoomLevel( self.previousZoom );

    playerActor.handleFireKey = playerActor_handleFireKey;
    playerActor.handleMouseWheel = playerActor_handleMouseWheel;

    playerState.getBaseCameraPosition = playerState_getBaseCameraPosition;
    playerState.handleMovement = playerState_handleMovement;

    layerRenderer:removeLayer(no_clip_layer)

    return true;
end

return a;
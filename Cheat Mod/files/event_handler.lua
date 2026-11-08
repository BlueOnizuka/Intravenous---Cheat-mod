local game = game;

c.catchable_events = {
    game.EVENTS.GAME_UNLOADED,
    game.EVENTS.FINISHED_LOAD,
    game.EVENTS.LEVEL_FINISHED,
    game.EVENTS.RESET_STARTED,
    game.EVENTS.RESET_INITIATED,
    game.EVENTS.RESET_FINISHED
}

function c:handleEvent(event, data)
    self:disableAll();
    self:hide();
end

events:addDirectReceiver(c, c.catchable_events);
local PATH = "cheats/"
local loadOrder = {
    "level",
    "player",
    "loadout",
    "weapon",
    "ai",
    "playthrough",
    "render",
    "other"
}

local id;
for i=1, #loadOrder do
    id = loadOrder[i];
    local _path = PATH..id.."/";
    local tbl = require(PATH..id.."/init");
    for j=1, #tbl do
        c:createCheat(tbl[j], require(_path..tbl[j]));
    end
end
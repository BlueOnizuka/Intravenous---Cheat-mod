
local PATH = "language/";
local loadOrder = { "en" };

local id;
for i=1, #loadOrder do
    id = loadOrder[i];
    translation.addBulk(id, require(PATH..id));
end

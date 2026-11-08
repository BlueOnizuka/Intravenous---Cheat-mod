local a = {};

function a:setEnvironmentColor(r,g,b)
    radiosity:initArray( radiosity.gridW, radiosity.gridH, radiosity.size, color(r,g,b) )
end
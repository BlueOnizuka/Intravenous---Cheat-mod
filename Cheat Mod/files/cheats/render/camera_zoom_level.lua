local a = {};

function a:setZoomLevel(zoom)
    zoom = math.min(math.max(zoom or 1, camera.zoomLevels[1]), #camera.zoomLevels)
    camera:setZoomLevel(zoom)
end
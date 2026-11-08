local a = {};

function a:setColorMultiply(base, hdr)
    render.colorMultiplyHDR = base or render.colorMultiplyHDR or 1.7
    render.colorMultiply = hdr or render.colorMultiply or 1.5

    render:onResolutionChanged()
end
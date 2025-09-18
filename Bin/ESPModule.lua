local ESPModule = {}

ESPModule.Enums = {
    GUI = "GUI";
    DRAWING = "DRAWING";
}

ESPModule.Values = {
    ESPTargets = {};
}

function ESPModule.CreateESP(ESPType: Table)
    if ESPType == ESPModule.Enums.GUI then
        -- branch 1
    elseif ESPType == ESPModule.Enums.DRAWING then
        -- branch 2
    end
end

function ESPModule.UpdateESP()

end

return ESPModule
local schemes = {}
local SCHEME_DEFAULT = {
    primary = Color(235, 131, 52),
    bg_primary = Color(77, 77, 77),
    secondary = Color(156, 98, 25)
}

function dx.registerColorScheme(key, colors)
    if not schemes[key] then schemes[key] = colors end
end

function dx.colorSchemeDefaultKV(key, value)
    if not SCHEME_DEFAULT[key] then SCHEME_DEFAULT[key] = value end
end

function dx.color(key)
    if CLIENT then
        return schemes[_curScheme()][key] or schemes[dx.lang][key] or SCHEME_DEFAULT[key]
    else
        return schemes[dx.lang][key] or SCHEME_DEFAULT[key]
    end
end

if CLIENT then 
    if not file.Exists("dexterity/color.txt",DATA) then
        file.Write("dexterity/color.txt", dx.colorscheme)
    end

    local function _curScheme()
        if dx.forcecolorscheme then return dx.colorscheme end
        return file.Read("dexterity/color.txt")
    end

    function dx.setScheme(key)
        if not schemes[key] then return end
        file.Write("dexterity/color.txt", key)
    end
end
local phrases = {}

local folder = "dx_core/lang"
local files = file.Find(folder .. "/" .. "*.lua", "LUA")
for _, file in ipairs(files) do
    local pack = dx.IncludeSH(folder .. "/" .. file)
    _addLangPack(pack, file)
end

local function _addLangPack(pack, key)
    if not phrases[key] then 
        phrases[key] = pack 
        return 
    end
    table.Merge(phrases[key], pack)
end

function dx.addPhrase(key, phrase, lang) -- manually adds single phrases, useful for phrases that can be user defined
    _addLangPack({key = phrase}, lang)
end

function dx.phrase(key)
    if CLIENT then
        return phrases[_curLang()][key] or phrases[dx.lang][key] or key
    else
        return phrases[dx.lang][key] or key
    end
end

-- client side language support
if CLIENT then
    if not file.Exists("dexterity/lang.txt",DATA) then
        file.Write("dexterity/lang.txt", dx.lang)
    end

    local function _curLang()
        if dx.forcelang then return dx.lang end
        return file.Read("dexterity/lang.txt")
    end

    function dx.setLang(key)
        if not phrases[key] then return end
        file.Write("dexterity/lang.txt", key)
    end
end
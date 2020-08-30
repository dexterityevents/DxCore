dx.includeCL("cl_hud.lua")
dx.includeSH("config.lua")
dx.includeSH("sh_lang.lua")

-- module loading
--[[

    MODULE STRUCTURE
    {
        name - internal name of the module
        stable - is build stable?
        version_local - version of the module to be checked
        remote_url = location to get the newest verion from
    }

]]--
local function _checkFor(info)
    return function(body)
        if not isnumber(body) then
            dx.Error("Remote version is not a number!")
            return
        end
        if body > info.version_local then
            dx.Warn("There is a newer version of dx_"..info.name.." ("..body..") avadible!")
        end
    end
end

local function _httpError()
    dx.Error("There was an error getting the newest version from one of addons!")
end

local function _addModule(info)
    dx[info.name] = {}
    dx[info.name].version_local = info.version_local
    if info.remote_url then http.Fetch(info.remote_url, _checkFor(info),_httpError) end
end

local folder = "dx_core/modules"
local files = file.Find(folder .. "/" .. "*.lua", "LUA")
for _, file in ipairs(files) do
    local mod = dx.includeSH(folder .. "/" .. file)
    _addModule(mod)
end
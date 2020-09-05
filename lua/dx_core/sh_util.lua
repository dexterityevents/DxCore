-- FILE INCLUSION

function dx.includeCL(path)
    if SERVER then
        AddCSLuaFile(path)
    else 
        return include(path) 
    end
end

function dx.includeSH(path)
    if SERVER then
        AddCSLuaFile(path)
    end
    return include(path) 
end

function dx.includeSV(path)
    if SERVER then
        return include(path)
    end
end

-- PLY HANDLING

function dx.IsPly(ply)
    if not isentity(ply) then return false end
    return ply:IsPlayer()
end

function dx.IsSteamID(sid)
    local ply
    if istring(sid) then
        ply = player.GetBySteamID(sid)
        if not ply then return end
    elseif isnumber(sid) then
        ply = player.GetBySteamID64(sid)
        if not ply then return end
    end
    return true
end

function dx.GetBySteamID(sid)
    local ply
    if istring(sid) then
        ply = player.GetBySteamID(sid)
        if not ply then return end
    elseif isnumber(sid) then
        ply = player.GetBySteamID64(sid)
        if not ply then return end
    end
    return ply
end

function dx.IsPlySteamID(sid, ply)
    if not dx.IsPly(ply) then return false end
    if istring(sid) then
        return ply:SteamID() == sid
    elseif isnumber(sid) then
        return ply:SteamID64() == sid
    end
    return false
end

function dx.RandomPly(func)
    local pick
    while not pick do
        local ply = table.Random(player.GetAll())
        if func(ply) then return ply end
    end
end

-- HUD stuff

function dx.Notify(msg, ply, title)
    if SERVER then
        if not title then title = "Notification" end
        if dx.IsPly(ply) then
            net.Start("dx_notify_player")
                net.WriteString(msg)
                net.WriteString(title)
            net.Send(ply)
        else
            net.Start("dx_notify_player")
                net.WriteString(msg)
                net.WriteString(title)
            net.Broadcast()
        end

        print("[DxEvents] Notify: "..msg)
    end
end

-- Print stuff

local function _prefixPrint(prefix, msg)
    if not isstring(msg) then return end
    print(prefix..msg)
end

function dx.Warn(msg)
    _prefixPrint("[Dx Warn]", msg)
end

function dx.Error(msg)
    _prefixPrint("[Dx Error]", msg)
end
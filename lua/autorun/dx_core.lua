dx = dx or {}
dx.version = 1.0

util.AddNetworkString("dx_notify_player")
file.CreateDir("dexterity")

if SERVER then
    AddCSLuaFile("dx_core/sh_util.lua")
    AddCSLuaFile("dx_core/init.lua")
end
include("dx_core/sh_util.lua")
include("dx_core/init.lua")
-- short and simple
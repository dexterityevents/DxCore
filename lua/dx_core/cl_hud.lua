local function _drawFonts()
	local fontsize25 = ScreenScale(11)
	local fontsize20 = ScreenScale(8)
	local fontsize17 = ScreenScale(7)
	local fontsize13 = ScreenScale(5.5)

	surface.CreateFont( "dx_ui_font_title", {
		font = "Tahoma", 
		extended = false,
		size = fontsize20,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})

	surface.CreateFont( "dx_ui_font_name", {
		font = "Tahoma", 
		extended = false,
		size = fontsize25,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})

	surface.CreateFont( "dx_ui_font_description", {
		font = "Tahoma", 
		extended = false,
		size = fontsize17,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})

	surface.CreateFont( "dx_ui_font_settings", {
		font = "Tahoma", 
		extended = false,
		size = fontsize13,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})
end

_drawFonts()

hook.Add("OnScreenSizeChanged","dx_updatefontsize",function()
	_drawFonts()
end)

net.Receive("dx_notify_player",function()
	local msg = net.ReadString()
	local title = net.ReadString()

	local NotifyPanel = vgui.Create("DNotify")
	NotifyPanel:SetPos(ScrW()*-0.04, ScrH()*0.1)
	NotifyPanel:SetSize(ScrW()*0.25,ScrH()*0.11)

	local bg = vgui.Create("DPanel", NotifyPanel)
	bg:Dock(FILL)
	bg.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,gray61alpha)
		draw.RoundedBox(0,0,0,w,h*0.25,orange217)
		draw.SimpleText(title, "dx_ui_font_title", w*0.175,h*0.01,white255)
	end

	local lbl = vgui.Create("DLabel", bg)
	lbl:SetPos(ScrW()*0.0435,ScrH()*0.033)
	lbl:SetSize(ScrW()*0.206,ScrH()*0.073)
	lbl:SetText(msg)
	lbl:SetTextColor(Color(255,255,255))
	lbl:SetFont("dx_ui_font_description")
	lbl:SetWrap(true)
	lbl:SetContentAlignment(7)

	NotifyPanel:AddItem(bg)

	surface.PlaySound("items/smallmedkit1.wav")
end)
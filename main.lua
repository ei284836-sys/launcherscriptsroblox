--=====================================================================
--  JDEV BLOX 🤫🌙  •  LAUNCHER v3
--  Adicione jogos na tabela GAMES: nome, desc, url.
--=====================================================================
local Players = game:GetService("Players")
local Http = game:GetService("HttpService")
local Tween = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local GAMES = {
	{
		nome = "Blox Fruits",
		desc = "farm · esp · frutas · teleporte",
		url = "https://raw.githubusercontent.com/ei284836-sys/main.lua/refs/heads/main/main.lua",
		fixo = true,
	},
	-- modelo:
	-- { nome = "Meu Jogo", desc = "o que faz", url = "https://raw.githubusercontent.com/user/repo/main/arquivo.lua" },
}

local C = {
	bg = Color3.fromRGB(7, 6, 11), bg2 = Color3.fromRGB(14, 12, 21),
	card = Color3.fromRGB(18, 17, 26), card2 = Color3.fromRGB(24, 22, 34),
	hover = Color3.fromRGB(30, 28, 43), line = Color3.fromRGB(37, 34, 50),
	text = Color3.fromRGB(240, 238, 250), dim = Color3.fromRGB(126, 122, 150),
	mute = Color3.fromRGB(76, 74, 94), pur = Color3.fromRGB(168, 116, 255),
	blue = Color3.fromRGB(96, 168, 255), cyan = Color3.fromRGB(130, 226, 255),
	good = Color3.fromRGB(96, 228, 152), bad = Color3.fromRGB(255, 96, 112),
}

local function new(cl, p, parent)
	local o = Instance.new(cl)
	if p then
		for k, v in pairs(p) do
			if k ~= "Parent" then pcall(function() o[k] = v end) end
		end
	end
	if parent then o.Parent = parent end
	return o
end
local function corner(o, r) return new("UICorner", { CornerRadius = UDim.new(0, r) }, o) end
local function stroke(o, c, t, tr)
	return new("UIStroke", { Color = c or C.line, Thickness = t or 1, Transparency = tr or 0.55 }, o)
end
local function pad(o, a, b, c, d)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, a or 0), PaddingRight = UDim.new(0, b or 0),
		PaddingBottom = UDim.new(0, c or 0), PaddingLeft = UDim.new(0, d or 0),
	}, o)
end
local function grad(o, a, b, rot)
	local g = new("UIGradient", { Rotation = rot or 90 }, o)
	pcall(function() g.Color = ColorSequence.new(a, b) end)
	return g
end

local Player = Players.LocalPlayer
local PGui = Player:WaitForChild("PlayerGui")
local old = PGui:FindFirstChild("JDEVLAUNCH")
if old then old:Destroy() end

local Gui = new("ScreenGui", {
	Name = "JDEVLAUNCH", ResetOnSpawn = false, IgnoreGuiInset = true,
	DisplayOrder = 999998, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PGui)

--==================== EMBLEMA =========================================
local function emblem(parent, size)
	local b = new("Frame", {
		Size = UDim2.fromOffset(size, size), BackgroundColor3 = Color3.fromRGB(6, 5, 11),
		BorderSizePixel = 0, ClipsDescendants = true,
	}, parent)
	corner(b, math.floor(size * 0.26))
	local ring = new("Frame", { Size = UDim2.fromScale(0.92, 0.92), Position = UDim2.fromScale(0.04, 0.04), BackgroundTransparency = 1 }, b)
	corner(ring, 999)
	grad(stroke(ring, C.pur, 1, 0.05), C.pur, C.blue, 45)
	local moon = new("Frame", {
		Size = UDim2.fromScale(0.52, 0.52), Position = UDim2.fromScale(0.22, 0.25),
		BackgroundColor3 = Color3.fromRGB(120, 196, 255), BorderSizePixel = 0,
	}, b)
	corner(moon, 999)
	grad(moon, Color3.fromRGB(170, 226, 255), Color3.fromRGB(62, 108, 255), 120)
	local bite = new("Frame", {
		Size = UDim2.fromScale(0.48, 0.48), Position = UDim2.fromScale(0.37, 0.21),
		BackgroundColor3 = Color3.fromRGB(6, 5, 11), BorderSizePixel = 0,
	}, b)
	corner(bite, 999)
	local h1 = new("Frame", { Size = UDim2.fromScale(0.66, 0.075), Position = UDim2.fromScale(0.17, 0.462), BackgroundColor3 = Color3.fromRGB(238, 222, 255), BorderSizePixel = 0 }, b)
	corner(h1, 999)
	local v1 = new("Frame", { Size = UDim2.fromScale(0.075, 0.66), Position = UDim2.fromScale(0.462, 0.17), BackgroundColor3 = Color3.fromRGB(238, 222, 255), BorderSizePixel = 0 }, b)
	corner(v1, 999)
	local core = new("Frame", { Size = UDim2.fromScale(0.15, 0.15), Position = UDim2.fromScale(0.425, 0.425), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0 }, b)
	corner(core, 999)
	local fl = new("Frame", { Size = UDim2.fromScale(0.08, 0.12), Position = UDim2.fromScale(0.46, 0.04), Rotation = 45, BackgroundColor3 = C.pur, BorderSizePixel = 0 }, b)
	corner(fl, 2)
	local s1 = new("Frame", { Size = UDim2.fromScale(0.075, 0.075), Position = UDim2.fromScale(0.01, 0.462), Rotation = 45, BackgroundColor3 = C.blue, BorderSizePixel = 0 }, b)
	corner(s1, 2)
	local s2 = new("Frame", { Size = UDim2.fromScale(0.075, 0.075), Position = UDim2.fromScale(0.915, 0.462), Rotation = 45, BackgroundColor3 = C.blue, BorderSizePixel = 0 }, b)
	corner(s2, 2)
	return b
end

--==================== JANELA ==========================================
local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
local W = math.clamp(vp.X - 60, 310, 430)
local H = math.clamp(vp.Y - 150, 340, 520)

local Win = new("Frame", {
	Size = UDim2.fromOffset(W, H), Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = C.bg, ClipsDescendants = true,
}, Gui)
corner(Win, 18)
grad(stroke(Win, C.pur, 1, 0.22), C.pur, C.cyan, 45)
grad(Win, C.bg2, C.bg, 90)

local glow = new("Frame", {
	Size = UDim2.fromOffset(W + 12, H + 12), Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = C.pur,
	BackgroundTransparency = 0.87, ZIndex = 0,
}, Gui)
corner(glow, 22)
Win.ZIndex = 1

local Head = new("Frame", { Size = UDim2.new(1, 0, 0, 92), BackgroundTransparency = 1, ZIndex = 2 }, Win)
local dragging, st, org
Head.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging, st, org = true, i.Position, Win.Position
		i.Changed:Connect(function()
			if i.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UIS.InputChanged:Connect(function(i)
	if not dragging then return end
	if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
		local d = i.Position - st
		Win.Position = UDim2.fromOffset(org.X.Offset + d.X, org.Y.Offset + d.Y)
		glow.Position = UDim2.fromOffset(org.X.Offset + d.X + 6, org.Y.Offset + d.Y + 6)
	end
end)

local logo = emblem(Head, 48)
logo.Position = UDim2.fromOffset(18, 18)

new("TextLabel", {
	Text = "JDEV BLOX🤫🌙", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = C.text,
	BackgroundTransparency = 1, Size = UDim2.new(1, -100, 0, 21), Position = UDim2.fromOffset(76, 18),
	TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
}, Head)
new("TextLabel", {
	Text = "selecione um jogo para executar", Font = Enum.Font.Gotham, TextSize = 10,
	TextColor3 = C.mute, BackgroundTransparency = 1, Size = UDim2.new(1, -100, 0, 14),
	Position = UDim2.fromOffset(76, 40), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
}, Head)

local ver = new("Frame", {
	Size = UDim2.fromOffset(30, 15), Position = UDim2.fromOffset(76, 58),
	BackgroundColor3 = C.pur, BackgroundTransparency = 0.75, BorderSizePixel = 0, ZIndex = 3,
}, Head)
corner(ver, 4)
new("TextLabel", {
	Text = "V3", Font = Enum.Font.GothamBold, TextSize = 9, TextColor3 = C.pur,
	BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 3,
}, ver)

local closeBtn = new("TextButton", {
	Text = "×", Font = Enum.Font.GothamBold, TextSize = 17, TextColor3 = C.dim,
	BackgroundColor3 = C.card, Size = UDim2.fromOffset(28, 28), Position = UDim2.new(1, -40, 0, 18),
	AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 3,
}, Head)
corner(closeBtn, 9)
closeBtn.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)

new("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, 92), BackgroundColor3 = C.pur, BorderSizePixel = 0, ZIndex = 2 }, Win)

local List = new("ScrollingFrame", {
	Size = UDim2.new(1, -26, 1, -152), Position = UDim2.fromOffset(13, 103),
	BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
	ScrollBarImageColor3 = C.pur, CanvasSize = UDim2.fromOffset(0, 0), ZIndex = 2,
}, Win)
new("UIListLayout", { Padding = UDim.new(0, 7) }, List)

local Foot = new("Frame", {
	Size = UDim2.new(1, 0, 0, 44), Position = UDim2.new(0, 0, 1, -44),
	BackgroundColor3 = C.bg2, BorderSizePixel = 0, ZIndex = 2,
}, Win)
new("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = C.line, BorderSizePixel = 0 }, Foot)
local status = new("TextLabel", {
	Text = "pronto", Font = Enum.Font.Code, TextSize = 9, TextColor3 = C.mute,
	BackgroundTransparency = 1, Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(13, 0),
	TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
}, Foot)

local function setStatus(t, bad)
	status.Text = t
	status.TextColor3 = bad and C.bad or C.good
end

local addBtn = new("TextButton", {
	Text = "+ jogo", Font = Enum.Font.GothamSemibold, TextSize = 10, TextColor3 = C.pur,
	BackgroundColor3 = C.card, Size = UDim2.fromOffset(80, 26), Position = UDim2.new(1, -93, 0, 9),
	AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 3,
}, Foot)
corner(addBtn, 8)

--==================== FORMULÁRIO ======================================
local form = new("Frame", {
	Size = UDim2.new(1, -26, 0, 0), Position = UDim2.fromOffset(13, 103),
	BackgroundColor3 = C.bg2, ClipsDescendants = true, Visible = false, ZIndex = 4,
}, Win)
corner(form, 12)
stroke(form, C.pur, 1, 0.25)
pad(form, 11, 11, 11, 11)

local nameBox = new("TextBox", {
	Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = C.card, Text = "",
	PlaceholderText = "nome do jogo", PlaceholderColor3 = C.mute,
	Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.text,
	ClearTextOnFocus = false, BorderSizePixel = 0, ZIndex = 5,
}, form)
corner(nameBox, 8)
pad(nameBox, 0, 9, 0, 9)

local urlBox = new("TextBox", {
	Size = UDim2.new(1, 0, 0, 30), Position = UDim2.fromOffset(0, 36), BackgroundColor3 = C.card,
	Text = "", PlaceholderText = "link raw do github (.lua)", PlaceholderColor3 = C.mute,
	Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = C.text,
	ClearTextOnFocus = false, BorderSizePixel = 0, ZIndex = 5,
}, form)
corner(urlBox, 8)
pad(urlBox, 0, 9, 0, 9)

local saveBtn = new("TextButton", {
	Text = "salvar jogo", Font = Enum.Font.GothamSemibold, TextSize = 11, TextColor3 = Color3.new(1, 1, 1),
	BackgroundColor3 = C.pur, Size = UDim2.new(1, 0, 0, 30), Position = UDim2.fromOffset(0, 72),
	AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 5,
}, form)
corner(saveBtn, 8)

--==================== DOWNLOAD ========================================
local function fetch(url)
	local libs = {}
	if syn and syn.request then table.insert(libs, syn.request) end
	if http and http.request then table.insert(libs, http.request) end
	if http_request then table.insert(libs, http_request) end
	if request then table.insert(libs, request) end
	if fluxus and fluxus.request then table.insert(libs, fluxus.request) end

	for _, fn in ipairs(libs) do
		local ok, r = pcall(fn, { Url = url, Method = "GET" })
		if ok and type(r) == "table" and type(r.Body) == "string" then
			return r.Body, nil
		end
	end
	local ok, b = pcall(function() return game:HttpGet(url) end)
	if ok and type(b) == "string" then return b, nil end
	return nil, tostring(b)
end

local function save()
	if writefile then
		local out = {}
		for _, g in ipairs(GAMES) do
			if not g.fixo then table.insert(out, { nome = g.nome, desc = g.desc, url = g.url }) end
		end
		pcall(function() writefile("jdev_games.json", Http:JSONEncode(out)) end)
	end
end

local function executar(g, card, badge, badgeLbl)
	if g._busy then return end
	g._busy = true
	card.BackgroundColor3 = C.hover
	badge.BackgroundColor3 = C.pur
	badgeLbl.Text = "..."
	badgeLbl.TextColor3 = Color3.new(1, 1, 1)
	setStatus("baixando " .. g.nome, false)

	task.spawn(function()
		local body, err = fetch(g.url .. (g.url:find("%?") and "&" or "?") .. "t=" .. os.time())
		if not body then
			g._busy = false
			badge.BackgroundColor3 = C.bad
			badgeLbl.Text = "ERRO"
			setStatus("download falhou: " .. tostring(err), true)
			return
		end
		if #body < 80 or body:sub(1, 1) == "<" then
			g._busy = false
			badge.BackgroundColor3 = C.bad
			badgeLbl.Text = "ERRO"
			setStatus("resposta inválida (" .. #body .. " bytes)", true)
			return
		end
		body = body:gsub("^\239\187\191", ""):gsub("```[%a]*", "")
		local fn, cerr = loadstring(body)
		if not fn then
			g._busy = false
			badge.BackgroundColor3 = C.bad
			badgeLbl.Text = "ERRO"
			setStatus("compilação: " .. tostring(cerr), true)
			return
		end
		local okr, rerr = pcall(fn)
		if not okr then
			g._busy = false
			badge.BackgroundColor3 = C.bad
			badgeLbl.Text = "ERRO"
			setStatus("execução: " .. tostring(rerr), true)
			return
		end
		Gui:Destroy()
	end)
end

--==================== LISTA ===========================================
local function build()
	for _, c in ipairs(List:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	for i, g in ipairs(GAMES) do
		local card = new("TextButton", {
			Text = "", BackgroundColor3 = C.card, Size = UDim2.new(1, 0, 0, 70),
			AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 2,
		}, List)
		corner(card, 12)
		stroke(card, C.line, 1, 0.55)
		local ic = new("Frame", {
			Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(13, 16),
			BackgroundColor3 = C.card2, BorderSizePixel = 0, ZIndex = 3,
		}, card)
		corner(ic, 10)
		new("TextLabel", {
			Text = "★", Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = C.pur,
			BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 3,
		}, ic)
		new("TextLabel", {
			Text = g.nome, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = C.text,
			BackgroundTransparency = 1, Size = UDim2.new(1, -150, 0, 18), Position = UDim2.fromOffset(60, 15),
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
		}, card)
		new("TextLabel", {
			Text = g.desc or "", Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = C.mute,
			BackgroundTransparency = 1, Size = UDim2.new(1, -150, 0, 14), Position = UDim2.fromOffset(60, 35),
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
		}, card)
		local badge = new("Frame", {
			Size = UDim2.fromOffset(62, 22), Position = UDim2.new(1, -74, 0, 24),
			BackgroundColor3 = C.pur, BorderSizePixel = 0, ZIndex = 3,
		}, card)
		corner(badge, 7)
		local badgeLbl = new("TextLabel", {
			Text = "EXECUTAR", Font = Enum.Font.GothamBold, TextSize = 8, TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 3,
		}, badge)
		card.MouseEnter:Connect(function()
			if not g._busy then card.BackgroundColor3 = C.hover end
		end)
		card.MouseLeave:Connect(function()
			if not g._busy then card.BackgroundColor3 = C.card end
		end)
		card.MouseButton1Click:Connect(function() executar(g, card, badge, badgeLbl) end)

		if not g.fixo then
			local rm = new("TextButton", {
				Text = "×", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = C.mute,
				BackgroundColor3 = C.card2, Size = UDim2.fromOffset(18, 18),
				Position = UDim2.new(1, -22, 0, 8), AutoButtonColor = false,
				BorderSizePixel = 0, ZIndex = 4,
			}, card)
			corner(rm, 5)
			rm.MouseButton1Click:Connect(function()
				table.remove(GAMES, i)
				save()
				build()
				setStatus("jogo removido", false)
			end)
		end
	end
	List.CanvasSize = UDim2.fromOffset(0, #GAMES * 77 + 4)
end

addBtn.MouseButton1Click:Connect(function()
	local open = not form.Visible
	form.Visible = open
	Tween:Create(form, TweenInfo.new(0.18), { Size = UDim2.new(1, -26, 0, open and 114 or 0) }):Play()
	if open then
		List.Visible = false
	else
		task.delay(0.19, function()
			if not form.Visible then List.Visible = true end
		end)
	end
end)

saveBtn.MouseButton1Click:Connect(function()
	local n, u = nameBox.Text, urlBox.Text
	if n == "" or u == "" then return setStatus("preencha nome e link", true) end
	table.insert(GAMES, { nome = n, desc = "adicionado por você", url = u })
	nameBox.Text = ""
	urlBox.Text = ""
	form.Visible = false
	List.Visible = true
	save()
	build()
	setStatus("jogo adicionado", false)
end)

if readfile and isfile then
	pcall(function()
		if isfile("jdev_games.json") then
			local data = Http:JSONDecode(readfile("jdev_games.json"))
			if type(data) == "table" then
				for _, g in ipairs(data) do
					if g.nome and g.url then table.insert(GAMES, g) end
				end
			end
		end
	end)
end

build()
setStatus("pronto · " .. tostring(#GAMES) .. " jogo(s)", false)

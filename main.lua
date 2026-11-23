--=====================================================================
--  JDEV BLOX 🤫🌙  •  LAUNCHER
--  Adicione jogos na tabela GAMES abaixo: nome, desc, url do GitHub.
--=====================================================================
local Players = game:GetService("Players")
local Http = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local GAMES = {
	{
		nome = "Blox Fruits",
		desc = "farm · esp · frutas · teleporte",
		url = "https://raw.githubusercontent.com/ei284836-sys/scriptbloxfruitslua/refs/heads/main/bloxfruits.lua",
	},
	-- modelo para adicionar outro jogo:
	-- { nome = "Meu Jogo", desc = "o que faz", url = "https://raw.githubusercontent.com/user/repo/main/arquivo.lua" },
}

local C = {
	bg = Color3.fromRGB(8, 7, 12), bg2 = Color3.fromRGB(14, 13, 20),
	card = Color3.fromRGB(19, 18, 27), hover = Color3.fromRGB(30, 28, 42),
	line = Color3.fromRGB(37, 34, 50), text = Color3.fromRGB(238, 236, 248),
	dim = Color3.fromRGB(126, 122, 150), mute = Color3.fromRGB(78, 76, 96),
	pur = Color3.fromRGB(166, 116, 255), cyan = Color3.fromRGB(130, 226, 255),
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

local Player = Players.LocalPlayer
local PGui = Player:WaitForChild("PlayerGui")
local old = PGui:FindFirstChild("JDEVLAUNCH")
if old then old:Destroy() end

local Gui = new("ScreenGui", {
	Name = "JDEVLAUNCH", ResetOnSpawn = false, IgnoreGuiInset = true,
	DisplayOrder = 999998, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PGui)

local s = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
local W = math.clamp(s.X - 70, 300, 400)
local H = math.clamp(s.Y - 180, 320, 460)

local Win = new("Frame", {
	Size = UDim2.fromOffset(W, H), Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = C.bg, ClipsDescendants = true,
}, Gui)
corner(Win, 16)
stroke(Win, C.pur, 1, 0.25)

local Head = new("Frame", { Size = UDim2.new(1, 0, 0, 78), BackgroundTransparency = 1 }, Win)
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
	end
end)

new("TextLabel", {
	Text = "JDEV BLOX🤫🌙", Font = Enum.Font.GothamBold, TextSize = 17, TextColor3 = C.text,
	BackgroundTransparency = 1, Size = UDim2.new(1, -40, 0, 20), Position = UDim2.fromOffset(16, 16),
	TextXAlignment = Enum.TextXAlignment.Left,
}, Head)
new("TextLabel", {
	Text = "escolha o jogo", Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = C.mute,
	BackgroundTransparency = 1, Size = UDim2.new(1, -40, 0, 14), Position = UDim2.fromOffset(16, 37),
	TextXAlignment = Enum.TextXAlignment.Left,
}, Head)

local addBtn = new("TextButton", {
	Text = "+ jogo", Font = Enum.Font.GothamSemibold, TextSize = 10, TextColor3 = C.pur,
	BackgroundColor3 = C.card, Size = UDim2.fromOffset(62, 22), Position = UDim2.fromOffset(16, 54),
	AutoButtonColor = false, BorderSizePixel = 0,
}, Head)
corner(addBtn, 7)
local closeBtn = new("TextButton", {
	Text = "×", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = C.dim,
	BackgroundColor3 = C.card, Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, -38, 0, 16),
	AutoButtonColor = false, BorderSizePixel = 0,
}, Head)
corner(closeBtn, 8)
closeBtn.MouseButton1Click:Connect(function() Gui:Destroy() end)

new("Frame", { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, 78), BackgroundColor3 = C.pur, BorderSizePixel = 0 }, Win)

local List = new("ScrollingFrame", {
	Size = UDim2.new(1, -24, 1, -96), Position = UDim2.fromOffset(12, 88),
	BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
	ScrollBarImageColor3 = C.pur, CanvasSize = UDim2.fromOffset(0, 0),
}, Win)
new("UIListLayout", { Padding = UDim.new(0, 7) }, List)

local noteBox = new("TextLabel", {
	Size = UDim2.new(1, -24, 0, 26), Position = UDim2.new(0, 12, 1, -34),
	BackgroundColor3 = C.card, Text = "", Font = Enum.Font.GothamMedium, TextSize = 10,
	TextColor3 = C.dim, BorderSizePixel = 0, Visible = false,
}, Win)
corner(noteBox, 7)

local function note(t, bad)
	noteBox.Text = t
	noteBox.TextColor3 = bad and C.bad or C.good
	noteBox.Visible = true
	task.delay(3.5, function() noteBox.Visible = false end)
end

--==================== ADICIONAR JOGO ==================================
local form = new("Frame", {
	Size = UDim2.new(1, -24, 0, 0), Position = UDim2.fromOffset(12, 88),
	BackgroundColor3 = C.bg2, Visible = false, ClipsDescendants = true,
}, Win)
corner(form, 10)
stroke(form, C.pur, 1, 0.3)
pad(form, 10, 10, 10, 10)

local nameBox = new("TextBox", {
	Size = UDim2.new(1, 0, 0, 28), BackgroundColor3 = C.card, Text = "",
	PlaceholderText = "nome do jogo", PlaceholderColor3 = C.mute,
	Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = C.text,
	ClearTextOnFocus = false, BorderSizePixel = 0,
}, form)
corner(nameBox, 7)
pad(nameBox, 0, 8, 0, 8)

local urlBox = new("TextBox", {
	Size = UDim2.new(1, 0, 0, 28), Position = UDim2.fromOffset(0, 34), BackgroundColor3 = C.card,
	Text = "", PlaceholderText = "link raw do github (.lua)", PlaceholderColor3 = C.mute,
	Font = Enum.Font.GothamMedium, TextSize = 10, TextColor3 = C.text,
	ClearTextOnFocus = false, BorderSizePixel = 0,
}, form)
corner(urlBox, 7)
pad(urlBox, 0, 8, 0, 8)

local saveBtn = new("TextButton", {
	Text = "salvar", Font = Enum.Font.GothamSemibold, TextSize = 11, TextColor3 = Color3.new(1, 1, 1),
	BackgroundColor3 = C.pur, Size = UDim2.new(1, 0, 0, 28), Position = UDim2.fromOffset(0, 68),
	AutoButtonColor = false, BorderSizePixel = 0,
}, form)
corner(saveBtn, 7)

--==================== LISTA ===========================================
local function save()
	if writefile then
		pcall(function() writefile("jdev_games.json", Http:JSONEncode(GAMES)) end)
	end
end

local function carregar(g, card, tag, tagLbl)
	if g._busy then return end
	g._busy = true
	card.BackgroundColor3 = C.hover
	tag.BackgroundColor3 = C.pur
	tagLbl.Text = "..."
	tagLbl.TextColor3 = Color3.new(1, 1, 1)
	note("carregando " .. g.nome, false)

	task.spawn(function()
		local ok, body = pcall(function() return game:HttpGet(g.url) end)
		if not ok or not body or #body < 80 then
			g._busy = false
			tag.BackgroundColor3 = C.bad
			tagLbl.Text = "ERRO"
			note("falha no download de " .. g.nome, true)
			return
		end
		body = body:gsub("^\239\187\191", ""):gsub("```[%a]*", "")
		local fn, err = loadstring(body)
		if not fn then
			g._busy = false
			tag.BackgroundColor3 = C.bad
			tagLbl.Text = "ERRO"
			note("compilação: " .. tostring(err), true)
			return
		end
		local okr, rerr = pcall(fn)
		if not okr then
			g._busy = false
			tag.BackgroundColor3 = C.bad
			tagLbl.Text = "ERRO"
			note("execução: " .. tostring(rerr), true)
			return
		end
		Gui:Destroy()
	end)
end

local function build()
	for _, c in ipairs(List:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	for _, g in ipairs(GAMES) do
		local card = new("TextButton", {
			Text = "", BackgroundColor3 = C.card, Size = UDim2.new(1, 0, 0, 62),
			AutoButtonColor = false, BorderSizePixel = 0,
		}, List)
		corner(card, 11)
		stroke(card, C.line, 1, 0.55)
		new("TextLabel", {
			Text = g.nome, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = C.text,
			BackgroundTransparency = 1, Size = UDim2.new(1, -96, 0, 18), Position = UDim2.fromOffset(14, 12),
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, card)
		new("TextLabel", {
			Text = g.desc or "", Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = C.mute,
			BackgroundTransparency = 1, Size = UDim2.new(1, -96, 0, 14), Position = UDim2.fromOffset(14, 32),
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, card)
		local tag = new("Frame", {
			Size = UDim2.fromOffset(58, 20), Position = UDim2.new(1, -70, 0, 21),
			BackgroundColor3 = C.pur, BorderSizePixel = 0,
		}, card)
		corner(tag, 6)
		local tagLbl = new("TextLabel", {
			Text = "EXECUTAR", Font = Enum.Font.GothamBold, TextSize = 8, TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
		}, tag)
		card.MouseEnter:Connect(function() card.BackgroundColor3 = C.hover end)
		card.MouseLeave:Connect(function()
			if not g._busy then card.BackgroundColor3 = C.card end
		end)
		card.MouseButton1Click:Connect(function() carregar(g, card, tag, tagLbl) end)
	end
	List.CanvasSize = UDim2.fromOffset(0, #GAMES * 69 + 4)
end

addBtn.MouseButton1Click:Connect(function()
	form.Visible = not form.Visible
	TweenService = game:GetService("TweenService")
	game:GetService("TweenService"):Create(form, TweenInfo.new(0.18), { Size = UDim2.new(1, -24, 0, form.Visible and 108 or 0) }):Play()
end)

saveBtn.MouseButton1Click:Connect(function()
	local n = nameBox.Text
	local u = urlBox.Text
	if n == "" or u == "" then return note("preencha nome e link", true) end
	table.insert(GAMES, { nome = n, desc = "adicionado por você", url = u })
	nameBox.Text = ""
	urlBox.Text = ""
	form.Visible = false
	save()
	build()
	note("jogo adicionado", false)
end)

-- carrega jogos salvos pelo usuário
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

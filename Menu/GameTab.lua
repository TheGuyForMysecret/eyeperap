-- GameTab module.
local GameTab = {}

-- Services.
local players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local waypoints = {}

---@module Utility.Logger
local Logger = require("Utility/Logger")

---Initialize local character section.
---@param groupbox table
function GameTab.initLocalCharacterSection(groupbox)
	local speedHackToggle = groupbox:AddToggle("Speedhack", {
		Text = "Speedhack",
		Tooltip = "Modify your character's velocity while moving.",
		Default = false,
	})

	speedHackToggle:AddKeyPicker("SpeedhackKeybind", { Default = "N/A", SyncToggleState = true, Text = "Speedhack" })

	local speedDepBox = groupbox:AddDependencyBox()

	speedDepBox:AddSlider("SpeedhackSpeed", {
		Text = "Speedhack Speed",
		Default = 200,
		Min = 0,
		Max = 300,
		Suffix = "/s",
		Rounding = 0,
	})

	local flyToggle = groupbox:AddToggle("Fly", {
		Text = "Fly",
		Tooltip = "Set your character's velocity while moving to imitate flying.",
		Default = false,
	})

	flyToggle:AddKeyPicker("FlyKeybind", { Default = "N/A", SyncToggleState = true, Text = "Fly" })

	local flyDepBox = groupbox:AddDependencyBox()

	flyDepBox:AddSlider("FlySpeed", {
		Text = "Fly Speed",
		Default = 200,
		Min = 0,
		Max = 800,
		Suffix = "/s",
		Rounding = 0,
	})

	flyDepBox:AddSlider("FlyUpSpeed", {
		Text = "Spacebar Fly Speed",
		Default = 150,
		Min = 0,
		Max = 300,
		Suffix = "/s",
		Rounding = 0,
	})

	local noclipToggle = groupbox:AddToggle("NoClip", {
		Text = "NoClip",
		Tooltip = "Disable collision(s) for your character.",
		Default = false,
	})

	noclipToggle:AddKeyPicker("NoClipKeybind", { Default = "N/A", SyncToggleState = true, Text = "NoClip" })

	local infJumpToggle = groupbox:AddToggle("InfiniteJump", {
		Text = "Infinite Jump",
		Tooltip = "Boost your velocity while the jump key is held.",
		Default = false,
	})

	infJumpToggle:AddKeyPicker(
		"InfiniteJumpKeybind",
		{ Default = "N/A", SyncToggleState = true, Text = "Infinite Jump" }
	)

	local infiniteJumpDepBox = groupbox:AddDependencyBox()

	infiniteJumpDepBox:AddSlider("InfiniteJumpBoost", {
		Text = "Infinite Jump Boost",
		Default = 50,
		Min = 0,
		Max = 500,
		Suffix = "/s",
		Rounding = 0,
	})

	groupbox:AddToggle("AnchorCharacter", {
		Text = "Anchor Character",
		Default = false,
	})

	infiniteJumpDepBox:SetupDependencies({
		{ Toggles.InfiniteJump, true },
	})

	speedDepBox:SetupDependencies({
		{ Toggles.Speedhack, true },
	})

	flyDepBox:SetupDependencies({
		{ Toggles.Fly, true },
	})

	groupbox:AddButton({
		Text = "Respawn Character",
		DoubleClick = true,
		Func = function()
			local character = players.LocalPlayer.Character
			if not character then
				return
			end

			local humanoid = character:FindFirstChild("Humanoid")
			if not humanoid then
				return
			end

			humanoid.Health = 0
		end,
	})
end

---Initialize player monitoring section.
---@param groupbox table
function GameTab.initPlayerMonitoringSection(groupbox)
	groupbox:AddToggle("NotifyMod", {
		Text = "Mod Notifications",
		Default = false,
	})

	local nmDepBox = groupbox:AddDependencyBox()

	nmDepBox:AddToggle("NotifyModSound", {
		Text = "Mod Notification Sound",
		Tooltip = "Use a sound along with the mod notification.",
		Default = false,
	})

	local nmbDepBox = nmDepBox:AddDependencyBox()

	nmbDepBox:AddSlider("NotifyModSoundVolume", {
		Text = "Sound Volume",
		Default = 10,
		Min = 0,
		Max = 20,
		Suffix = "v",
		Rounding = 2,
	})

	nmbDepBox:SetupDependencies({
		{ Toggles.NotifyModSound, true },
	})

	nmDepBox:SetupDependencies({
		{ Toggles.NotifyMod, true },
	})

	groupbox:AddToggle("PlayerSpectating", {
		Text = "Player List Spectating",
		Tooltip = "Click on a player on the player list to spectate them.",
		Default = false,
	})

	groupbox:AddToggle("ShowOwnership", {
		Text = "Show Network Ownership",
		Default = false,
	})

	groupbox:AddToggle("PlayerProximity", {
		Text = "Player Proximity Notifications",
		Tooltip = "When other players are within specified distance, notify the user.",
		Default = false,
	})

	local ppDepBox = groupbox:AddDependencyBox()

	ppDepBox:AddSlider("PlayerProximityRange", {
		Text = "Player Proximity Distance",
		Default = 1000,
		Min = 50,
		Max = 2500,
		Suffix = "studs",
		Rounding = 0,
	})

	ppDepBox:AddToggle("PlayerProximityBeep", {
		Text = "Play Beep Sound",
		Tooltip = "Use a beep sound along with the proximity notification.",
		Default = false,
	})

	local ppbDepBox = ppDepBox:AddDependencyBox()

	ppbDepBox:AddSlider("PlayerProximityBeepVolume", {
		Text = "Beep Sound Volume",
		Default = 0.1,
		Min = 0,
		Max = 10,
		Suffix = "v",
		Rounding = 2,
	})

	ppbDepBox:SetupDependencies({
		{ Toggles.PlayerProximityBeep, true },
	})

	ppDepBox:SetupDependencies({
		{ Toggles.PlayerProximity, true },
	})
end

---Debugging section.
---@param groupbox table
function GameTab.initDebuggingSection(groupbox)
	groupbox:AddToggle("ShowDebugInformation", {
		Text = "Show Debug Information",
		Default = false,
	})
end

---Initialize tab.
function GameTab.init(window)
	-- Create tab.
	local tab = window:AddTab("Game")

	-- Initialize sections.
	GameTab.initDebuggingSection(tab:AddDynamicGroupbox("Debugging"))
	GameTab.initPlayerMonitoringSection(tab:AddDynamicGroupbox("Player Monitoring"))
	GameTab.initLocalCharacterSection(tab:AddDynamicGroupbox("Local Character"))
end

-- Return GameTab module.
return GameTab

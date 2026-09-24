-- AutomationTab module.
local AutomationTab = {}

local Configuration = require("Utility/Configuration")
local Maid = require("Utility/Maid")
local Signal = require("Utility/Signal")

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")


---Initialize 'Input Automation' section.
---@param groupbox table
function AutomationTab.initInputAutomation(groupbox)
	groupbox:AddToggle("AntiAFK", {
		Text = "Anti AFK",
		Tooltip = "Prevent the player from being kicked for being idle by sending periodic inputs for you.",
		Default = false,
	})
end


---Initialize tab.
---@param window table
function AutomationTab.init(window)
	-- Create tab.
	local tab = window:AddTab("Auto")

	-- Initialize sections.
	AutomationTab.initInputAutomation(tab:AddDynamicGroupbox("Input Automation"))
end

-- Return AutomationTab module.
return AutomationTab

-- InputClient module.
local InputClient = {}

-- Services.
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")

---@module Utility.Configuration
local Configuration = require("Utility/Configuration")

---Deflect. This is called this way because it can either give parry or block frames depending on whether or not parry is on cooldown.
function InputClient.deflect()
	InputClient.block(true)

	task.wait(Configuration.expectOptionValue("DeflectHoldTime") / 1000)

	InputClient.block(false)
end

---Block.
---@param state boolean
function InputClient.block(state)
	if state then
		game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.Block:FireServer(false)
	else
		game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.Unblock:FireServer()
	end
end

---Dash.
function InputClient.dash()
	game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.Dodge:FireServer(180, "normal")
end

-- Return InputClient module.
return InputClient

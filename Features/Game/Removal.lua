return LPH_NO_VIRTUALIZE(function()
	-- Removal related stuff is handled here.
	local Removal = {}

	---@module Utility.Maid
	local Maid = require("Utility/Maid")

	---@module Utility.Signal
	local Signal = require("Utility/Signal")

	---@module Utility.Configuration
	local Configuration = require("Utility/Configuration")

	---@module Utility.OriginalStoreManager
	local OriginalStoreManager = require("Utility/OriginalStoreManager")

	---@module Utility.Logger
	local Logger = require("Utility/Logger")

	-- Services.
	local runService = game:GetService("RunService")
	local players = game:GetService("Players")
	local lighting = game:GetService("Lighting")

	-- Maids.
	local removalMaid = Maid.new()

	-- Signals.
	local renderStepped = Signal.new(runService.RenderStepped)

	-- Last update.
	local lastUpdate = os.clock()

	---Update removal.
	local function updateRemoval()
		if os.clock() - lastUpdate <= 2.0 then
			return
		end

		lastUpdate = os.clock()

		local localPlayer = players.LocalPlayer
		if not localPlayer then
			return
		end
	end

	---Initalize removal.
	function Removal.init()
		removalMaid:add(renderStepped:connect("Removal_RenderStepped", updateRemoval))

		-- Log.
		Logger.warn("Removal initialized.")
	end

	---Detach removal.
	function Removal.detach()
		-- Clean.
		removalMaid:clean()

		-- Log.
		Logger.warn("Removal detached.")
	end

	-- Return Removal module.
	return Removal
end)()

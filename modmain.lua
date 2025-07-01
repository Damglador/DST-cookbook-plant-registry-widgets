--[[
	Copyright (C) 2021 Fuffles
	
	You may learn from this, but you may not copy, take ownership or reupload it
]]--

local _G = GLOBAL
local STRINGS = _G.STRINGS
local ImageButton = require "widgets/imagebutton"

local PlayerHud = require "screens/playerhud"

local position = GetModConfigData("Position")
local cb_pos_x = GetModConfigData("CB_pos_X")
local cb_pos_y = GetModConfigData("CB_pos_Y")
local pr_pos_x = GetModConfigData("PR_pos_X")
local pr_pos_y = GetModConfigData("PR_pos_Y")

Assets =
{
	Asset("ATLAS", "images/plantregistry_hud.xml"),
    Asset("IMAGE", "images/plantregistry_hud.tex"),
	Asset("ATLAS", "images/cookbook_hud.xml"),
    Asset("IMAGE", "images/cookbook_hud.tex")
}

-- topleft_root
local _PHSetMainCharacter = PlayerHud.SetMainCharacter or (function() end)
PlayerHud.SetMainCharacter = function(self, owner, ...)
	_PHSetMainCharacter(self, owner, ...)
	if owner and self.controls and self.controls.mapcontrols and owner == _G.ThePlayer then
		if position == "tl" then
			self.root = self.controls.topleft_root
		elseif position == "tr" then
			self.root = self.controls.topright_root
			cb_pos_x = -cb_pos_x
			pr_pos_x = -pr_pos_x
		elseif position == "bl"	then
			self.root = self.controls.bottomleft_root -- Desn't work
			cb_pos_y = -cb_pos_y
			pr_pos_y = -pr_pos_y
		elseif position == "br" then
			self.root = self.controls.bottomright_root -- Desn't work
			cb_pos_x = -cb_pos_x
			pr_pos_x = -pr_pos_x
			cb_pos_y = -cb_pos_y
			pr_pos_y = -pr_pos_y
		else 
			self.root = self.controls.topleft_root
		end
		-- Cookbook
		self.CookbookBtn = self.root:AddChild(
			ImageButton(
				"images/cookbook_hud.xml", 
				"cookbook_button.tex", 
				nil, nil, nil, nil, { 1, 1 }, { 0, 0 }
			)
		)
		self.CookbookBtn:SetScale(1, 1, 1)
		self.CookbookBtn:SetPosition(
			cb_pos_x,	-- Default: 40		(x)
			-cb_pos_y,	-- Default: -40		(y)
			0			-- ??
		)
		self.CookbookBtn:SetOnClick(function() 
			_G.ThePlayer.HUD:OpenCookbookScreen()
		end)

		-- Plant Registry
		self.PlantRegistryBtn = self.root:AddChild(
			ImageButton(
				"images/plantregistry_hud.xml", 
				"plantregistry_button.tex", 
				nil, nil, nil, nil, { 1, 1 }, { 0, 0 }
			)
		)
		self.PlantRegistryBtn:SetScale(1.1, 1.1, 1.1)
		self.PlantRegistryBtn:SetPosition(
			pr_pos_x,	-- Default: 40		(x)
			-pr_pos_y,	-- Default: -100	(y)
			0			-- ??
		)
		self.PlantRegistryBtn:SetOnClick(function() 
			_G.ThePlayer.HUD:OpenPlantRegistryScreen()
		end)
	end
end
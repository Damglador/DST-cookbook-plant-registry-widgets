--[[
	Copyright (C) 2021 Fuffles
	
	You may learn from this, but you may not copy, take ownership or reupload it
]]--

local _G = GLOBAL
local STRINGS = _G.STRINGS
local ImageButton = require "widgets/imagebutton"

local PlayerHud = require "screens/playerhud"

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
		self.CookbookBtn = self.controls.topleft_root:AddChild(ImageButton("images/cookbook_hud.xml", "cookbook_button.tex", nil, nil, nil, nil, { 1, 1 }, { 0, 0 }))
		self.CookbookBtn:SetScale(.5, .5, .5)
		self.CookbookBtn:SetPosition(40, -40, 0) -- (x, -y, ??)
		self.CookbookBtn:SetOnClick(function() 
			_G.ThePlayer.HUD:OpenCookbookScreen()
		end)
		self.PlantRegistryBtn = self.controls.topleft_root:AddChild(ImageButton("images/plantregistry_hud.xml", "plantregistry_button.tex", nil, nil, nil, nil, { 1, 1 }, { 0, 0 }))
		self.PlantRegistryBtn:SetScale(.5, .5, .5)
		self.PlantRegistryBtn:SetPosition(36, -100, 0) -- (x, -y, ??)
		self.PlantRegistryBtn:SetOnClick(function() 
			_G.ThePlayer.HUD:OpenPlantRegistryScreen()
		end)
	end
end
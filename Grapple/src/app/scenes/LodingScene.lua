--
-- Author: student
-- Date: 2015-11-25 16:51:41
--
local LodingScene = class("LodingScene", function()
    return display.newScene("LodingScene")
end)

function LodingScene:ctor()
	self:init()
	print("LodingScene+++++++++++++")
end

function LodingScene:init()

	cc.ui.UILabel.new({text="ssssssssss",
			size=20,
			align=cc.ui.TEXT_ALIGN_CENTER,
			color=display.COLOR_RED})
	:pos(display.cx, display.bottom+30)
	:addTo(self)

	display.newSprite("img/ui/loadView/Loading_imgText.png")
	:pos(100, 100)
	:addTo(self)
	

	display.newSprite("img/ui/loadView/loading_point.png")
	:pos(210, 100)
	:addTo(self)

	display.newSprite("img/ui/loadView/loading_point.png")
	:pos(220, 100)
	:addTo(self)

	display.newSprite("img/ui/loadView/loading_point.png")
	:pos(230, 100)
	:addTo(self)

	self.yixiong = sp.SkeletonAnimation:create("spine/sp-liandao/skeleton.json","spine/sp-liandao/skeleton.atlas",1)
	self:addChild(self.yixiong)
end

function LodingScene:onExit()

end

function LodingScene:onEnter()

end

return LodingScene
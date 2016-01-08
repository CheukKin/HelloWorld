--
-- Author: zdl
-- Date: 2015-11-15 16:56:13
--
-- local ss={}
-- function ss:new()
-- 	local a={}
-- 	setMix(fromAnimation, toAnimation, duration)
-- end

local HeroList = class("HeroList", function()
	return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)

function HeroList:ctor()
    heroLabel = HeroData.hero
local function touchbegan(location, event)
        local p = location:getLocation()
        print(p.x .. "y = " .. p.y)
        if p.x <= 705 and p.x >= 250 and p.y <= 445 and p.y >= 200 then
            print("12321")
        else
            self:removeFromParent()
        end
        return true
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    local dis = cc.Director:getInstance():getEventDispatcher()
    listener:registerScriptHandler(touchbegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:setSwallowTouches(true)

    dis:addEventListenerWithSceneGraphPriority(listener, self)

	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width,display.height))

    local xiaoshi
    local label200
    local count=3
    local layer
	self:init()
end
function HeroList:init()

self.biaoshi={"Aattribute_huo.png","Aattribute_feng.png",
"Aattribute_bing.png","Aattribute_mu.png"}
self.zhiwei={"设为副手","设为队长"}
	local layer1
	local tu
	local text3
	local dengji
	local butt
	local tu2
	local text4
      print(ss)
      layer1 = cc.uiloader:load("HeroListLayer.csb"):addTo(self)
      :pos(display.cx/2, display.cy/2)
      if ss==1 then

        elseif ss==2 then
        tu=layer1:getChildByName("Image_3")
        text3=layer1:getChildByName("Text_3")
        for i,v in ipairs(heroLabel) do
           if heroLabel[i].id == 8 then
                   tu:loadTexture( heroLabel[i].iconName ..".png")
                   text3:setString(heroLabel[i].name)
                end
         end
     
        
        tu2=layer1:getChildByName("Image_9")
        tu2:loadTexture(self.biaoshi[2])
        dengji=layer1:getChildByName("Text_1")
        text4=layer1:getChildByName("Text_4")
        text4:setString(self.zhiwei[2])

        butt=layer1:getChildByName("Button_2")
        butt:addTouchEventListener(function ()
            print("123")
        end)
        
        elseif ss==3 then
        tu=layer1:getChildByName("Image_3")
        text3=layer1:getChildByName("Text_3")
     for i,v in ipairs(heroLabel) do
           if heroLabel[i].id == 5 then
                   tu:loadTexture( heroLabel[i].iconName ..".png")
                   text3:setString(heroLabel[i].name)
                end
         end
        tu2=layer1:getChildByName("Image_9")
        tu2:loadTexture(self.biaoshi[3])
        dengji=layer1:getChildByName("Text_1")
        text4=layer1:getChildByName("Text_4")
        text4:setString(self.zhiwei[2])
        elseif ss==4 then
         tu=layer1:getChildByName("Image_3")
        text3=layer1:getChildByName("Text_3")
         for i,v in ipairs(heroLabel) do
           if heroLabel[i].id == 4 then
                   tu:loadTexture( heroLabel[i].iconName ..".png")
                   text3:setString(heroLabel[i].name)
                end
         end


        tu2=layer1:getChildByName("Image_9")
        tu2:loadTexture(self.biaoshi[4])
        dengji=layer1:getChildByName("Text_1")
        text4=layer1:getChildByName("Text_4")
        text4:setString(self.zhiwei[2])
        	
      end

	local btn1=layer1:getChildByName("Button_1")
	btn1:addTouchEventListener(function (event)
        local layer = require("app.GameScenes.Hero").new()
        layer:addTo(self)
    end)
end


return HeroList
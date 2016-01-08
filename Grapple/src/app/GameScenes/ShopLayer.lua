--
-- Author: student
-- Date: 2015-11-12 20:44:12
--
local ShopLayer = class("ShopLayer", function()
	return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)

function ShopLayer:ctor()
    local function touchbegan( location,event )
        return true
    end 
    local listener = cc.EventListenerTouchOneByOne:create()
    local dis = cc.Director:getInstance():getEventDispatcher()
    listener:registerScriptHandler(touchbegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:setSwallowTouches(true)
    dis:addEventListenerWithSceneGraphPriority(listener, self)

    self:setTouchEnabled(true)
    self:setTouchSwallowEnabled(true)
    self:setContentSize(cc.size(display.width,display.height))
	self:init()
end

function ShopLayer:init()
    


local skeletonNode1 = sp.SkeletonAnimation:create("skeleton.json", "skeleton.atlas",0.5)
    skeletonNode1:setPosition(cc.p(display.cx+210,display.cy+210))
    -- skeletonNode1:setMix("atk1", "atk2",0.2)
    -- skeletonNode1:setMix("atk2", "atk1",0.4)

    skeletonNode1:setAnimation(0,"animation2",true)
    -- skeletonNode1:setAnimation(0,"atk1",false)
    -- skeletonNode1:addAnimation(0,"atk2",false)
    -- skeletonNode1:addAnimation(0,"atk1",false)
    -- skeletonNode1.debugBones = true
    skeletonNode1:addTo(self,100)

	 local layer = cc.uiloader:load("ShopLayer.csb"):addTo(self)
     local btn=layer:getChildByName("Button_1")
         btn:addTouchEventListener(function (event)
         print("刷新")
         end)

    self.jinbi = cc.uiloader:load("jinbi.csb")
                    :pos(display.cx-150, display.top-150)
                    :scale(0.7)
                    :addTo(self)
    self.zuanshi = cc.uiloader:load("zuanshi.csb")
                    :pos(display.cx+50, display.top-150)
                    :scale(0.7)
                    :addTo(self)

	local fanhui = 	layer:getChildByName("Button_2")
    fanhui:addTouchEventListener(function (event)
		dump(event)
		self:removeFromParent()
	end)


local name={"强化石","初级经验丹","圣王宝箱","圣王宝箱","技术草聚魂石","强化石","超级体力单"}
local tupian={"qianghuashi.png","jingyan1.png","baoxiang-jin.png","baoxiang-jin.png","zhihun-tianxie.png","qianghuashi.png","tili4.png"}
local shuliang={"x5","x5","x10","x100","x5","x100","x1"}
local tubiao={"baoshi.png","jinbi.png","baoshi.png","baoshi.png","jinbi.png","baoshi.png","baoshi.png"}
local jiage={"5","1000","1600","10000","5000","100","80"}


    self.lv = ccui.ListView:create()
    self.lv:setContentSize(cc.size(750, 374))
    self.lv:setPosition(cc.p(105,110))
    self.lv:setGravity(3)
    self.lv:setDirection(2)
    self.lv:setBounceEnabled(true)

	-- self.lv=cc.ui.UIListView.new{bgScale9=true,
		
	-- 	viewRect=cc.rect(105, 100, 750, 374),
	-- 	direction=cc.ui.UIScrollView.DIRECTION_HORIZONTAL	
 --    }
 --    :onTouch(handler(self, self.touchListener))
 --    :addTo(self)

    for i=0,7 do
    	-- local item=self.lv:newItem()
        local c1
    	local  content = ccui.Button:create("shangpindikuang.png","shangpindikuang.png")
        content:setScaleX(0.70)
        content:setScaleY(0.90)
    	if 0==i then
            c1= cc.uiloader:load("Node.csb") 
            c1:setScaleX(1.2)
            c1:setScaleY(0.97)             
        else
            c1=cc.CSLoader:createNode("Node.csb")
            c1:setScaleX(1.2)
            c1:setScaleY(0.97)
        	local text=c1:getChildByName("Text_2")
        	text:setString(name[i])
        	local image6=c1:getChildByName("Image_6")
        	image6:loadTexture(tupian[i])
        	local text4=c1:getChildByName("Text_4")
        	text4:setString(shuliang[i])
        	local text1=c1:getChildByName("Text_1")
        	text1:setString(jiage[i])
        	local image7=c1:getChildByName("Image_7")
        	image7:loadTexture(tubiao[i]) 
           
            

    	end

        c1:setPosition(cc.p(display.cx-335,display.cy-120))
        content:setScale9Enabled(true)
        content:setAnchorPoint(cc.p(0, 0))
        -- content:setPressedActionEnabled(true)
        content:addChild(c1)
    	self.lv:pushBackCustomItem(content)
   end
    self.lv:addTo(self)


end
function ShopLayer:touchListener(event)
	local listView=event.listView
	if "clicked"==event.name then
		print("点击了")
	elseif "moved"==event.name then
		self.bListViewMove = true
	elseif "ended"==event.name then
		self.bListViewMove = false
	else
		print("event name:" .. event.name)
	end	
end


return ShopLayer
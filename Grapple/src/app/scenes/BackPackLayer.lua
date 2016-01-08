--
-- Author: student
-- Date: 2015-11-12 20:39:44
--
local BackPackLayer = class("BackPackLayer", function()
    return display.newColorLayer(cc.c4b(250,
                250,
                250,
                100))
end)

function BackPackLayer:ctor()
	print("BackPackLayer++++++++++++++++++++++")
	self.selectzhuangbei = {}
	self.selectSuiPian = {}

	haveZhuangbei = SaveData.haveZhuangbei
	haveSuipian = SaveData.haveSuiPian

	zhuangbei = HeroData.equipment

	--吞噬C++和quick

	local function touchbegan(location, event)
		return true
	end
	local listener = cc.EventListenerTouchOneByOne:create()
	local dis = cc.Director:getInstance():getEventDispatcher()
	listener:registerScriptHandler(touchbegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:setSwallowTouches(true)
	dis:addEventListenerWithSceneGraphPriority(listener, self)

	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)


	self.isChoose = 0
	self.BG = cc.uiloader:load("beibao.csb")
					:addTo(self)
	self.button1 = self.BG:getChildByName("Button_1")
	self.button1:setTag(100)
	self.button1:loadTextures("img/comm/anniu-xuanzhong.png","img/comm/anniu-xuanzhong.png")
	self.button1:addTouchEventListener(function(psender,event)
		if event == 2 then
			print("dsdsad")
			self:XuanZe(self.button1)
		end
	end)

	self.button2 = self.BG:getChildByName("Button_2")
	self.button2:setTag(101)
	self.button2:addTouchEventListener(function(psender,event)
		if event == 2 then
			print("222222")
			self:XuanZe(self.button2)
		end
	end)

--设置 scrollview
	
	local bound = self.BG:getChildByName("Image_1"):getBoundingBox()
	 -- dump(bound)
	self.sV1 = ccui.ScrollView:create()
	self.sV1:setTag(300) 
	self.sV1:setDirection(1)
	self.sV1:setBounceEnabled(true)
	self.sV1:setPosition(bound.x+5,bound.y-5)
	self.sV1:setContentSize(cc.size(bound.width-10, bound.height-10))
	self.sV1:setInnerContainerSize(cc.size(bound.width-10, 2*bound.height))--滚动范围
	self.sV1:setInertiaScrollEnabled(true)
	self:addChild(self.sV1, 10)
	for i=0,#haveZhuangbei-1 do
		local content
		for j=1,#zhuangbei do
			if zhuangbei[j].id == haveZhuangbei[i+1].id then
				content = ccui.Button:create("img/icon/equip/".. zhuangbei[j].icon ..".png","img/icon/equip/".. zhuangbei[j].icon ..".png")
				content:addTouchEventListener(function(psender,event)
		        	if event == 2 then
			            print("选择道具" ..i)
			            --跟新数据
			            self.selectzhuangbei = zhuangbei[j]
			            self:ShuaXin()
			            self.xiangqing:setVisible(true)
			        end
			    end)
			end
		end
		local mysize = cc.size(50, 50)
	    content:setPosition(cc.p(130 * (i%3)+50 , -50+2 * bound.height - 130*( self:getIntPart(i/3))))
	    content:setPressedActionEnabled(true)
	    
	    self.sV1:addChild(content,50)
	end
	
	self.sV2 = ccui.ScrollView:create()
	self.sV2:setTag(301)
	self.sV2:setDirection(1)
	self.sV2:setBounceEnabled(true)
	self.sV2:setPosition(bound.x+5,bound.y-5)
	self.sV2:setContentSize(cc.size(bound.width-10, bound.height-10))
	self.sV2:setInnerContainerSize(cc.size(bound.width-10, 2*bound.height))--滚动范围
	self.sV2:setInertiaScrollEnabled(true)
	self:addChild(self.sV2, 10)
	for i=0,#haveSuipian-1 do
		print("suipian"..haveSuipian[i+1].id)
		local content --= cc.uiloader:load("duizhang.csb")
		for j=1,#zhuangbei do
			if zhuangbei[j].id == haveSuipian[i+1].id then
				content = ccui.Button:create("img/icon/equip/".. zhuangbei[j].icon ..".png","img/icon/equip/".. zhuangbei[j].icon ..".png")
				content:addTouchEventListener(function(psender,event)
			        if event == 2 then
			            print("选择碎片" ..i)
			            --跟新数据
			            self.selectzhuangbei = zhuangbei[j]
			            self:ShuaXin()
			            self.xiangqing:setVisible(true)
			        end
			    end)
			end
		end
		local mysize = cc.size(50, 50)
	    content:setPosition(cc.p(130 * (i%3)+50 , -50+2 * bound.height - 130*( self:getIntPart(i/3))))
	    content:setPressedActionEnabled(true)
	    
	    self.sV2:addChild(content,50)
	end
	self.sV2:setVisible(false)

-- table.insertto(dest, src, begin)
	self.xiangqing = cc.uiloader:load("beibaoxianqing.csb")
					:pos(250, 330)
					:addTo(self)
	self.xiangqing:setVisible(false)
	self.chushou = self.xiangqing:getChildByName("Button_1")
	self.chushou:addTouchEventListener(function(psender,event)
		if event == 2 then
			print("出售")
		end
	end)

	--返回按钮
	self.backBtn = ccui.Button:create("img/comm/anniu-big_fanhui.png","img/comm/anniu-bing_fanhuiover .png")
    self.backBtn:setTag(100)
    self.backBtn:setScale(0.5)
    self.backBtn:setPosition(cc.p(display.left+50,display.top - 52))
    self.backBtn:setPressedActionEnabled(true)
    self.backBtn:addTouchEventListener(function(psender,event)
    	if event == 2 then
    		print("返回")
    		self:removeFromParent()
    	end
    end)
    self:addChild(self.backBtn)

end

function BackPackLayer:ShuaXin()
	local icon = self.xiangqing:getChildByName("Image_5")--图标
	local name = self.xiangqing:getChildByName("Text_1")--名称
	local JiaShao = self.xiangqing:getChildByName("Text_2")--介绍
	local JiaGe = self.xiangqing:getChildByName("Text_4")--出售价格
	icon:loadTexture("img/icon/equip/" .. self.selectzhuangbei.icon .. ".png")
	name:setString(self.selectzhuangbei.name)
	JiaShao:setString(self:getJieShao(self.selectzhuangbei.equipPosition))
	JiaGe:setString("出售价格：" .. self.selectzhuangbei.SellPrice)
end

function BackPackLayer:getJieShao(type)
	if type == 1 then
		--武器
		return self.selectzhuangbei.name .. "是一件加攻击力的武器"
	elseif type == 2 then
		--todo衣服
		return self.selectzhuangbei.name .. "是一件加防御的装备"
	elseif type == 3 then
		--todo手套
		return self.selectzhuangbei.name .. "是一件加攻击力的装备"
	elseif type == 4 then
		--todo鞋子
		return self.selectzhuangbei.name .. "是一件加闪避的装备"
	elseif type == 5 then
		--todo项链
		return self.selectzhuangbei.name .. "是一件加防御的装备"
	elseif type == 6 then
		--todo裤子
		return self.selectzhuangbei.name .. "是一件加血量的装备"
	end
end

function BackPackLayer:getIntPart(x)
	if x <= 0 then
	   return math.ceil(x);
	end

	if math.ceil(x) == x then
	   x = math.ceil(x);
	else
	   x = math.ceil(x) - 1;
	end
	return x;
end

function BackPackLayer:XuanZe(sender)
	cho = sender:getTag()-100
	print(sender:getTag())
	if cho == self.isChoose then
		print("重复选")
	else
		yuan = self.BG:getChildByTag(self.isChoose + 100)
		yuan:loadTextures("img/comm/aniu-weixuanzho1ng.png","img/comm/aniu-weixuanzho1ng.png")
		local s = self:getChildByTag(self.isChoose + 300)
		s:setVisible(false)

		sender:loadTextures("img/comm/anniu-xuanzhong.png","img/comm/anniu-xuanzhong.png")
		self.isChoose = cho
		local s1 = self:getChildByTag(self.isChoose + 300)
		s1:setVisible(true)
		print("切换")
		-- button_forhero
		self.xiangqing:setVisible(false)
	end
end

function BackPackLayer:creScrollview()
	-- body
	cc.ui.UIScrollView.new({viewRect = bound,
    	-- scrollbarImgH = "SliderBarFixed.png",
    	-- scrollbarImgV = "SliderBarFixedV.png",
    	bgColor = cc.c4b(255,0,0,255)})
        :addScrollNode(emptyNode)
        :setDirection(cc.ui.UIScrollView.DIRECTION_BOTH)
        :onScroll(function (event)
        print("ScrollListener:" .. event.name)
    end)
        :addTo(self)
        :setBounceable(true)
end

function BackPackLayer:onEnter()
end

function BackPackLayer:onExit()
end

return BackPackLayer
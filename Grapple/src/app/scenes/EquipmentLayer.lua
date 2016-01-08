--
-- Author: student
-- Date: 2015-11-12 20:40:19
--
local EquipmentLayer = class("EquipmentLayer", function()
    return display.newLayer("EquipmentLayer")
end)

function EquipmentLayer:ctor()
	print("EquipmentLayer++++++++++")

	haveZhuangbei = SaveData.haveZhuangbei
	zhuangbei = HeroData.equipment

	yingxiongTable = HeroData.hero 				--英雄数据
	haveyinxiongTable = SaveData.selectHero 	--有的英雄数据
	haveSuiPian = SaveData.haveSuiPian 			--碎片

	--选择的英雄
	XZYX = {}

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

	-- 背景图
	-- local bg = cc.Sprite:create("equipment/xinxi-di.png")
	-- bg:setAnchorPoint(cc.p(0.5, 0.5))
	-- bg:setPosition(cc.p(display.cx, display.cy))
	-- bg:addTo(self)
	-- -- bg:setRotated(90)
	-- -- bg:setScale(5)
	-- bg:setScaleY(0.8)
	-- bg:setScaleX(1.3)

	self.layer = cc.uiloader:load("zhuangbeiLayer.csb")
	self.layer:addTo(self)

	-- 添加铁匠 
	local tiejiang = sp.SkeletonAnimation:create("equipment/tiejiang/skeleton.json", "equipment/tiejiang/skeleton.atlas",0.8)
	-- tiejiang:setAnchorPoint(cc.p(0.5, 0.5))
	tiejiang:setPosition(cc.p(780, 50))
	tiejiang:addTo(self,1)
	tiejiang:setAnimation(0, "idle", true)

	self:createListView1()

	local c1 = cc.Node:create()
	c1:setTag(300)
	self:addChild(c1)
	c1:addChild(self.lvbg)
	c1:addChild(self.lv)
	c1:addChild(self.lv1)

	local c2 = cc.Node:create()
	c2:setTag(301)
	self:addChild(c2)
	c2:addChild(self.lv2)

	local c3 = cc.Node:create()
	c3:setTag(302)
	self:addChild(c3)
	c3:addChild(self.lv3)

	c1:setVisible(true)
	c2:setVisible(false)
	c3:setVisible(false)


	-- back点击事件
	local backBtn = self.layer:getChildByName("backBtn")
	backBtn:addTouchEventListener(function(pSender, event)
		print("返回")
		self:removeFromParent()
	end)

	local yizhuangbeiBtn = self.layer:getChildByName("yizhungbeiBtn")
	yizhuangbeiBtn:setTag(200)
	yizhuangbeiBtn:addTouchEventListener(function(pSender,event)
		-- 已装备
		if event == 2 then
			print("已装备")
			self:XuanZe(pSender)
			
		end
		
	end)

	local weizhuangbeiBtn = self.layer:getChildByName("weizhuangbeiBtn")
	weizhuangbeiBtn:setTag(201)
	weizhuangbeiBtn:addTouchEventListener(function(pSender,event)
		-- 未装备
		if event == 2 then
			print("未装备")
			self:WeiZhuangBei()
			self:XuanZe(pSender)
		end
	end)

	local suipianBtn = self.layer:getChildByName("suipianBtn")
	suipianBtn:setTag(202)
	suipianBtn:addTouchEventListener(function(pSender,event)
		-- 碎片
		if event == 2 then
			print("碎片")
			self:SP()
			self:XuanZe(pSender)
		end
		
	end)

	-- 获取图片
	local zhuangbeiImg = self.layer:getChildByName("zhuangbeiImg")
	
	


end

function EquipmentLayer:createListView2()
	-- self.lv = cc.ui.UIListView.new({
	-- 	bgScale9 = true,
	-- 	viewRect = cc.rect(),
	-- 	})
end
function EquipmentLayer:createListView1()
	self.lvbg = ccui.Scale9Sprite:create("equipment/di-4.png")
	self.lvbg:setContentSize(450, 130)
	self.lvbg:setPosition(cc.p(37,370))
	self.lvbg:setAnchorPoint(cc.p(0,0))
	-- self:addChild(self.lvbg)

	self.lv = ccui.ListView:create()
	self.lv:setContentSize(cc.size(450, 130))
	self.lv:setPosition(cc.p(37,360))
	self.lv:setGravity(3)
	self.lv:setDirection(2)
	self.lv:setBounceEnabled(true);
 
 -- 	for i=0,table.nums(haveyinxiongTable)-1 do
	-- 	local content --= cc.uiloader:load("duizhang.csb")
	-- 	for j=1,#yingxiongTable do
	-- 		if haveyinxiongTable[i+1].id == yingxiongTable[j].id then
	-- 			content = ccui.Button:create("img/icon/role/" .. yingxiongTable[j].iconName .. ".png","img/icon/role/" .. yingxiongTable[j].iconName .. ".png")
	-- 		end
	-- 	end
	-- 	local mysize = cc.size(50, 50)
	--     content:setPosition(cc.p(130 * (i%2)+75 , -50+2 * bound.height - 130*( self:getIntPart(i/2))))
	--     content:setPressedActionEnabled(true)
	--     content:addTouchEventListener(function(psender,event)
	--         if event == 2 then
	--             print("选择英雄" ..i)
	--             self:selectHero(i)
	--         end
	--     end)
	-- 	self.sV1:addChild(content,50)
	-- end
	self.selecth = 0
	for i=0,#haveyinxiongTable-1 do
		-- local c1 = cc.uiloader:load("duizhang.csb")
		-- c1:setPosition(cc.p(30,30))

		local content
		for j=1,#yingxiongTable do
			if haveyinxiongTable[i+1].id == yingxiongTable[j].id then
				content = ccui.Button:create("img/icon/role/" .. yingxiongTable[j].iconName .. ".png","img/icon/role/" .. yingxiongTable[j].iconName .. ".png")
				content:setTag(i+1000)--设置 tag 值
				content:addTouchEventListener(function(psender,event)
			        if event == 2 then
			            -- 选择英雄刷新下方列表
			            
			            XZYX = yingxiongTable[j]
			            print("id     "..XZYX.id)
			            self:seHero(psender)
			        end
			    end)
			    if i == self.selecth then
			    	XZYX = yingxiongTable[j]
			    end
			end
		end
		-- content = ccui.Button:create("img/comm/anniu_tuichu.png","img/comm/anniu_tuichuover.png")
		content:setScale(0.9)
	    content:setPressedActionEnabled(true)
	    local s = ccui.Scale9Sprite:create("img/ui/bag/xuanzhongzhuangtai.png")
	    s:setTag(222)
	    s:setScale(1.1)
	    if i ~= self.selecth then
	    	s:setVisible(false)
	    end
	    s:setPosition(content:getContentSize().width/2,content:getContentSize().height/2)
	    content:addChild(s)
	    
	    -- content:addChild(c1)
		self.lv:pushBackCustomItem(content);
	end

	-- self.lv = cc.ui.UIListView.new({
	-- 	bg = "equipment/di-4.png",
	-- 	bgScale9 = true,
	-- 	viewRect = cc.rect(37,370,480,150),
	-- 	direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL})
	-- :onTouch(handler(self, self.touchListener))
	-- -- :addTo(self)

	image = {"touxiang-lufei.png","touxiang-heiyan.png","touxiang-caotijing.png"}

	-- for i=1,3 do
	-- 	print(i)
	-- 	-- image[i]
	-- 	local item = self.lv:newItem()
	-- 	local content 
	-- 		content = cc.ui.UIPushButton.new({normal = "equipment/touxiang-lufei.png",pressed = "equipment/touxiang-lufei.png"}, {scale9 = true})
	-- 		-- :setButtonSize(120, 120)
	-- 		:onButtonClicked(function(event)
	-- 			if self.bLVM then
	-- 				return
	-- 			end
	-- 			print("＝＝＝＝＝＝＝＝")
	-- 		end)
	-- 		content:setTouchSwallowEnabled(false)
	--     item:addContent(content)
	--     item:setItemSize(136, 136)
	--     self.lv:addItem(item)	
	-- end
	-- self.lv:reload()


	self.lv1 = ccui.ListView:create()
	self.lv1:setContentSize(cc.size(450, 310))
	self.lv1:setPosition(cc.p(37,51))
	self.lv1:setGravity(6)
	self.lv1:setDirection(3)
	self.lv1:setBounceEnabled(true);
	self:shuaxin()
	
	-- self.lv1 = cc.ui.UIListView.new({
	-- 	-- bg = "equipment/di-4.png",
	-- 	bgScale9 = true,
	-- 	viewRect = cc.rect(37,51,480,310),
	-- 	direction = cc.ui.UIScrollView.DIRECTION_VERTICAL
	-- })
	-- :onTouch(handler(self, self.touchListener))
	-- for i=1,3 do
	-- 	print("nnnnnnnnnnn"..i)
	-- 	-- image[i]
	-- 	local item = self.lv1:newItem()
	-- 	local content 
	-- 		content = cc.ui.UIPushButton.new({normal = "zhuangbei_di.png",pressed = "zhuangbei_di.png"}, {scale9 = true})
	-- 		:setButtonSize(480, 120)
	-- 		:onButtonClicked(function(event)
	-- 			if self.bLVM then
	-- 				return
	-- 			end
	-- 			print("＝＝＝＝＝＝＝＝")
	-- 		end)
	-- 		content:setAnchorPoint(cc.p(0,0))
	-- 		content:setTouchSwallowEnabled(false)
	-- 		-- content:setContentSize(480,120)
	-- 		-- local conter1 = cc.uiloader:load("yizhuangbei.csb")
	-- 		-- conter1:setTouchSwallowEnabled(false)
	-- 		-- conter1:setAnchorPoint(cc.p(0,0))
	--     item:addContent(content)
	--     -- item:addContent(conter1)
	--     item:setItemSize(480, 120)
	--     self.lv1:addItem(item)	
	-- end
	-- self.lv1:reload()




	self.lv2 = ccui.ListView:create()
	self.lv2:setContentSize(cc.size(450, 460))
	self.lv2:setPosition(cc.p(37,51))
	self.lv2:setGravity(6)
	self.lv2:setDirection(3)
	self.lv2:setBounceEnabled(true);
	
	


	self.lv3 = ccui.ListView:create()
	self.lv3:setContentSize(cc.size(450, 460))
	self.lv3:setPosition(cc.p(37,51))
	self.lv3:setGravity(6)
	self.lv3:setDirection(3)
	self.lv3:setBounceEnabled(true);
	
	

end



function EquipmentLayer:seHero(p)
	local t = p:getTag() - 1000
	if t == self.selecth then
		--重复选
	else
		local y = self.lv:getChildByTag(self.selecth + 1000)
		y:getChildByTag(222):setVisible(false)

		p:getChildByTag(222):setVisible(true)
		self.selecth = t
		self:shuaxin()
	end
end

function EquipmentLayer:touchListener(event)
	if "moved" == event.name then
		self.bLVM = true
	elseif "ended" == event.name then
		self.bLVM = false
	end
end

function EquipmentLayer:XuanZe(sender)
	cho = sender:getTag()-200
	print(sender:getTag())
	if cho == self.isChoose then
		print("重复选")
	else
		yuan = self.layer:getChildByTag(self.isChoose + 200)
		yuan:loadTextures("aniu-weixuanzho1ng.png","aniu-weixuanzho1ng.png")
		yuan1 = self:getChildByTag(self.isChoose + 300)
		yuan1:setVisible(false)
		self.isChoose = cho
		print("切换")
		sender:loadTextures("anniu-xuanzhong.png","anniu-xuanzhong.png")
		local x = self:getChildByTag(self.isChoose + 300)
		x:setVisible(true)
	end

end

function EquipmentLayer:SP()
	self.lv3:removeAllItems()
	for i=1,#haveSuiPian do
		print("=================")
		local c1 = cc.uiloader:load("yzb/yizhuangbei.csb")
		self:GT1(c1,haveSuiPian[i])
		c1:setPosition(cc.p(0,0))
		local content
		content = ccui.Button:create("yzb/di-3.png","yzb/di-3.png")
	    content:setScale9Enabled(true)
	    content:setAnchorPoint(cc.p(0,0))
	    content:addTouchEventListener(function(psender,event)
	        if event == 2 then
	            print("选择了装备")
	        end
	    end)
	    content:addChild(c1)
	    content:setScale(0.7)
		self.lv3:pushBackCustomItem(content);


		-- local c1 = cc.uiloader:load("duizhang.csb")
		-- c1:setPosition(cc.p(30,30))
		-- local content --= cc.uiloader:load("duizhang.csb")
		-- content = ccui.Button:create("img/comm/anniu_tuichu.png","img/comm/anniu_tuichuover.png")
	 --    -- content:setPosition(cc.p(display.cx-150, display.cy))
	 --    content:setPressedActionEnabled(true)
	 --    content:addTouchEventListener(function(psender,event)
	 --        if event == 2 then
	 --            print("失败" ..i)
	 --            --进入失败页面
	 --            -- self:removeFromParent()
	 --        end
	 --    end)
	 --    content:addChild(c1)
		-- self.lv3:pushBackCustomItem(content);
	end
end

function EquipmentLayer:WeiZhuangBei()

	self.lv2:removeAllItems()

	for i=1,#haveZhuangbei do
		print("ssssssss"..i)
		if haveZhuangbei[i].isZhuangBei == 0 then
			print("=================")
			local c1 = cc.uiloader:load("yzb/yizhuangbei.csb")
			self:GT(false,c1,haveZhuangbei[i])
			c1:setPosition(cc.p(0,0))
			local content
			content = ccui.Button:create("yzb/di-3.png","yzb/di-3.png")
		    content:setScale9Enabled(true)
		    content:setAnchorPoint(cc.p(0,0))
		    content:addTouchEventListener(function(psender,event)
		        if event == 2 then
		            print("选择了装备")
		        end
		    end)
		    content:addChild(c1)
		    content:setScale(0.7)
			self.lv2:pushBackCustomItem(content);
		end
		-- local c1 = cc.uiloader:load("duizhang.csb")
		-- c1:setPosition(cc.p(30,30))
		-- local content --= cc.uiloader:load("duizhang.csb")
		-- content = ccui.Button:create("img/comm/anniu_tuichu.png","img/comm/anniu_tuichuover.png")
	 --    -- content:setPosition(cc.p(display.cx-150, display.cy))
	 --    content:setPressedActionEnabled(true)
	 --    content:addTouchEventListener(function(psender,event)
	 --        if event == 2 then
	 --            print("失败" ..i)
	 --        end
	 --    end)
	 --    content:addChild(c1)
		-- self.lv2:pushBackCustomItem(content);
	end
end

function EquipmentLayer:shuaxin()

	self.lv1:removeAllItems()

	for i=1,#haveZhuangbei do
		print("111111")
		if haveZhuangbei[i].isZhuangBei == 1 then
			print("已经装备")
			-- for j=1,#yingxiongTable do
			if haveZhuangbei[i].isShei == XZYX.id then
				local c1 = cc.uiloader:load("yzb/yizhuangbei.csb")
				self:GT(true,c1,haveZhuangbei[i])

				c1:setPosition(cc.p(0,0))
				local content
				content = ccui.Button:create("yzb/di-3.png","yzb/di-3.png")
			    content:setScale9Enabled(true)
			    content:setAnchorPoint(cc.p(0,0))
			    content:addTouchEventListener(function(psender,event)
			        if event == 2 then
			            print("选择了装备")
			        end
			    end)
			    content:addChild(c1)
			    content:setScale(0.7)
				self.lv1:pushBackCustomItem(content);
			end
			-- end
		end
	end
end

function EquipmentLayer:GT1(c,z)
	--icon
	local ic = c:getChildByName("Image_6")
	--所属英雄
	local h = c:getChildByName("Image_5")
	--名称
	local tName = c:getChildByName("nameLab")
	--强化等级
	local tQ = c:getChildByName("TextField_1")
	for i=1,#zhuangbei do
		if zhuangbei[i].id == z.id then
			ic:loadTexture("img/icon/equip/" .. zhuangbei[i].icon .. ".png")
		end
	end
	for i=1,#zhuangbei do
		if zhuangbei[i].id == z.id then
			tName:setString(zhuangbei[i].name)
		end
	end
	h:setVisible(false)
end

function EquipmentLayer:GT(is,c,z)
	--icon
	local ic = c:getChildByName("Image_6")
	--所属英雄
	local h = c:getChildByName("Image_5")
	--名称
	local tName = c:getChildByName("nameLab")
	--强化等级
	local tQ = c:getChildByName("TextField_1")

	if is then
		
		for i=1,#zhuangbei do
			if zhuangbei[i].id == z.id then
				ic:loadTexture("img/icon/equip/" .. zhuangbei[i].icon .. ".png")
			end
		end
		
		for i=1,#zhuangbei do
			if zhuangbei[i].id == z.id then
				tName:setString(zhuangbei[i].name)
			end
		end
		
		for i=1,#yingxiongTable do
			if yingxiongTable[i].id == XZYX.id then
				print("选择英雄 id"..XZYX.id)
				h:loadTexture("img/icon/role/" .. yingxiongTable[i].iconName .. "1.png")
			end
		end
		
	else
		for i=1,#zhuangbei do
			if zhuangbei[i].id == z.id then
				ic:loadTexture("img/icon/equip/" .. zhuangbei[i].icon .. ".png")
			end
		end
		for i=1,#zhuangbei do
			if zhuangbei[i].id == z.id then
				tName:setString(zhuangbei[i].name)
			end
		end
		h:setVisible(false)
	end
	
end

function EquipmentLayer:onEnter()
end

function EquipmentLayer:onExit()
end

return EquipmentLayer
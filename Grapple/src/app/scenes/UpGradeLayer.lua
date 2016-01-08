--
-- Author: student
-- Date: 2015-11-12 20:38:18
--
local UpGradeLayer = class("UpGradeLayer", function()
	return TouchTunshi:new()
end)
function UpGradeLayer:ctor()
	-- self:setTouchEnabled(true)
	-- self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width,display.height))
	self:init()
	print("UpGradeLayer++++++++++++++++++++++++++++++")
end
function UpGradeLayer:init()
	--注册监听
	-- cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods()
	-- self:addEventListener("MY_NEWS", handler(self, self.ZenJiaJinYan))
 --    self:addChild(self.exNode)
	-- self:dispatchEvent({name="MY_NEWS"})

	self.selectHero1 = {}
	self.selectHero1.have = false
	self.selectHero1.hero = {}

	yingxiongTable = HeroData.hero 				--英雄数据
	haveyinxiongTable = SaveData.selectHero 	--有的英雄数据

	self.layer = cc.uiloader:load("shengji/UpdateHero1.csb")
	:addTo(self)

	self.DanYao = 1--默认
	local button = self.layer:getChildByName("backBtn")
	button:addTouchEventListener(function(psender, event)
		if event == 2 then
			print("返回")
			self:removeFromParent()
		end
		
	end)
	button:setPressedActionEnabled(true)

	local button1 = self.layer:getChildByName("shengjiBtn")
	button1:setTag(300)
	button1:addTouchEventListener(function(pSender, event)
		if event == 2 then
			print("升级")
			--增加经验，当经验够了则升级
			if self.DanYao == 1 then
				--初级 加十点
				print("初级")
				self.selectHero1.hero.jinyan = self.selectHero1.hero.jinyan+10
				self:ChuLiJinYan()
			elseif self.DanYao == 2 then
				--中级 加20 
				print("中级")
				self.selectHero1.hero.jinyan = self.selectHero1.hero.jinyan+20
				self:ChuLiJinYan()
			elseif self.DanYao == 3 then
			 	--高级 加30
			 	print("高级")
			 	self.selectHero1.hero.jinyan = self.selectHero1.hero.jinyan+30
			 	self:ChuLiJinYan()
		 	elseif self.DanYao == 4 then
		 		--顶级 加四十
		 		print("顶级")
		 		self.selectHero1.hero.jinyan = self.selectHero1.hero.jinyan+40
		 		self:ChuLiJinYan()
			end
		end
	end)
	button1:setPressedActionEnabled(true)

	local button2 = self.layer:getChildByName("chujiBtn")
	button2:setTag(301)
	button2:addTouchEventListener(function(pSender, event)
		print("初级")
		self.DanYao = 1
	end)
	button2:setPressedActionEnabled(true)

	local button3 = self.layer:getChildByName("zhongjiBtn")
	button3:setTag(302)
	button3:addTouchEventListener(function(pSender, event)
		print("中级")
		self.DanYao = 2
	end)
	button3:setPressedActionEnabled(true)

	local button4 = self.layer:getChildByName("gaojiBtn")
	button4:setTag(303)
	button4:addTouchEventListener(function(pSender, event)
		print("高级")
		self.DanYao = 3
	end)
	button4:setPressedActionEnabled(true)

	local button5 = self.layer:getChildByName("dingjiBtn")
	button5:setTag(304)
	button5:addTouchEventListener(function(pSender, event)
		print("顶级")
		self.DanYao = 4
	end)
	button5:setPressedActionEnabled(true)

	self.seleYX = self.layer:getChildByName("heroImg")
	-- self.seleYX:setVisible(false)

	local bound = self.layer:getChildByName("herosImg"):getBoundingBox()
	self.sV1 = ccui.ScrollView:create()
	self.sV1:setTag(300) 
	self.sV1:setDirection(1)
	self.sV1:setBounceEnabled(true)
	self.sV1:setPosition(bound.x+5,bound.y-5)
	self.sV1:setContentSize(cc.size(bound.width-10, bound.height-10))
	self.sV1:setInnerContainerSize(cc.size(bound.width-10, 2*bound.height))--滚动范围
	self.sV1:setInertiaScrollEnabled(true)
	self:addChild(self.sV1, 10)
	for i=0,table.nums(haveyinxiongTable)-1 do
		local content --= cc.uiloader:load("duizhang.csb")
		for j=1,#yingxiongTable do
			if haveyinxiongTable[i+1].id == yingxiongTable[j].id then
				content = ccui.Button:create("img/icon/role/" .. yingxiongTable[j].iconName .. ".png","img/icon/role/" .. yingxiongTable[j].iconName .. ".png")
			end
		end
		local mysize = cc.size(50, 50)
	    content:setPosition(cc.p(130 * (i%2)+75 , -50+2 * bound.height - 130*( self:getIntPart(i/2))))
	    content:setPressedActionEnabled(true)
	    content:addTouchEventListener(function(psender,event)
	        if event == 2 then
	            print("选择英雄" ..i)
	            self:selectHero(i)
	        end
	    end)
		self.sV1:addChild(content,50)
	end
	self:isSelect()
end

function UpGradeLayer:ChuLiJinYan()
	if self.selectHero1.hero.jinyan >= HeroData.level[self.selectHero1.hero.level] then
		self.selectHero1.hero.jinyan = self.selectHero1.hero.jinyan - HeroData.level[self.selectHero1.hero.level] --经验减少
		self.selectHero1.hero.level = self.selectHero1.hero.level + 1    --等级加一
		self:ChuLiJinYan()
	else
		--跟新等级和经验条
		local s = self.layer:getChildByName("Text_3")
		s:setString("lv:"..self.selectHero1.hero.level)
		--修改经验 lodingbar
		local l = self.layer:getChildByName("jingyanshengjiBar")
		l:setPercent(100*self.selectHero1.hero.jinyan/HeroData.level[self.selectHero1.hero.level])
	end
end

function UpGradeLayer:getIntPart(x)
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

function UpGradeLayer:selectHero(no)
	self.selectHero1.have = true
	self.selectHero1.hero = haveyinxiongTable[no+1]
	--修改图标
	self:Modify()
	self:isSelect()
end

function UpGradeLayer:Modify()
	--修改英雄图片
	for i=1,#yingxiongTable do
		if self.selectHero1.hero.id == yingxiongTable[i].id then
			self.seleYX:loadTexture("img/icon/role/" .. yingxiongTable[i].iconName .. ".png")
			break
		end
	end
	--修改等级 lable
	local s = self.layer:getChildByName("Text_3")
	s:setString("lv:"..self.selectHero1.hero.level)
	--修改经验 lodingbar
	local l = self.layer:getChildByName("jingyanshengjiBar")
	l:setPercent(100*self.selectHero1.hero.jinyan/HeroData.level[self.selectHero1.hero.level])
end

function UpGradeLayer:isSelect()
	if self.selectHero1.have == false then
		for i=0,4 do
			self.layer:getChildByTag(300+i):setTouchEnabled(false)
		end
	else
		for i=0,4 do
			self.layer:getChildByTag(300+i):setTouchEnabled(true)
		end
	end
end
function UpGradeLayer:onEnter()
end

function UpGradeLayer:onExit()
	self.selectHero1.have = false
end
return UpGradeLayer
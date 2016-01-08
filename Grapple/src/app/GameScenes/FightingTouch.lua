--
-- Author: student
-- Date: 2015-11-10 16:09:12
--

local FightingTouchLayer = class("FightingTouchLayer", function()
	return display.newNode()
end)

tagDirection = {
	rocker_STARY=0,
    rocker_RIGHT=1,
    rocker_UP=2,
    rocker_LEFT=3,
    rocker_DOWN=4,
    rocker_LEFT_UP=5,
    rocker_LEFT_DOWN=6,
    rocker_RIGHT_UP=7,
    rocker_RIGHT_DOWN=8
}


function FightingTouchLayer:ctor(h,m,n,map,boshu,yidongbi)--class中实现的时候多了一个参数，所以第二个位置才开始接收参数
	self.boshu = boshu
	self.yidongbi = yidongbi

	self.hero = m
	self.diren = n
	-- dump(h)
	self.Map = map
	self.NoGoLayer = self.Map:getLayer("block") 
	print(m:getPositionX())
	self.move = 0
	--摇杆
	self:initRocker()
	--技能
	self:initSkills()
	self.ssssss = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)

	--敌人死亡监听事件
	cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods()
	-- self:dispatchEvent({name="MY_NEWS"})
	--暂停按钮
	cc.ui.UIPushButton.new({normal = "img/comm/anniu-zanting .png",
    pressed = "img/comm/anniu-zantingover .png"}, {scale9 = true})
        :onButtonClicked(function(event)
            print("进入暂停界面")
            cc.Director:getInstance():pause()--暂停
            require("app.GameScenes.ZanTingLayer"):new():addTo(self)
        end)
        :pos(display.right - 50, display.top - 50)
        :addTo(self)
end

function FightingTouchLayer:isCanMove(p)
	-- if self.boshu * self.yidongbi then
		
	-- end
	-- print("width:"..self.Map:getTileSize().width.."   height:"..self.Map:getTileSize().height)
	local x = p.x/self.Map:getTileSize().width
	local y = self.Map:getMapSize().height - (p.y / self.Map:getTileSize().height)

	local currentPoint = cc.p(x,y)
	-- print("x = " .. x .. "y = " ..y)
	--判断是否在地图范围内
	if x ~= self.Map:getMapSize().width and self.Map:getMapSize().height ~= y then
		local tilegId = self.NoGoLayer:getTileGIDAt(currentPoint)
		local value = self.Map:getPropertiesForGID(tilegId)
		-- dump(value)
		if tilegId ~= nil then
			if value ~= 0 then
				-- self.he.isCanMove = false--人物不能移动
				return false--不能移动
			end
		end
		return true--可以移动
	end
end

function FightingTouchLayer:update(dt)

	local move 
	local mintus = 0.1
	local buchang = 32
	local sc = 1--必须和创建时的缩放大小一样
	if self.move == tagDirection.rocker_STARY then
		--不动
		-- self.hero:doEvent("normal")
	elseif self.move == tagDirection.rocker_RIGHT then
		--向右移动
		self.hero:setScaleX(-sc)
		if self:isCanMove(cc.p(buchang+self.hero:getPositionX(),self.hero:getPositionY()+0)) then
			move = cc.MoveBy:create(mintus,cc.p(buchang,0))
		end
		-- self.hero:setPosition(self.hero:getPositionX() + 5,self.hero:getPositionY())
	elseif self.move == tagDirection.rocker_UP then
		--向上移动
		if self:isCanMove(cc.p(0+self.hero:getPositionX(),self.hero:getPositionY()+buchang)) then
			move = cc.MoveBy:create(mintus,cc.p(0,buchang))
		end
		
		-- self.hero:setPosition(self.hero:getPositionX(),self.hero:getPositionY() + 10)
	elseif self.move == tagDirection.rocker_LEFT then
		--向左移动
		self.hero:setScaleX(sc)
		if self:isCanMove(cc.p(-buchang+self.hero:getPositionX(),self.hero:getPositionY()+0)) then
			move = cc.MoveBy:create(mintus,cc.p(-buchang,0))
		end
		
		-- self.hero:setPosition(self.hero:getPositionX() - 5,self.hero:getPositionY())
	elseif self.move == tagDirection.rocker_DOWN then
		--向下移动
		if self:isCanMove(cc.p(0+self.hero:getPositionX(),self.hero:getPositionY()-buchang)) then
			move = cc.MoveBy:create(mintus,cc.p(0,-buchang))
		end
		-- self.hero:setPosition(self.hero:getPositionX(),self.hero:getPositionY() - 10)	
	elseif self.move == tagDirection.rocker_LEFT_UP then
		--向左下移动
		self.hero:setScaleX(sc)
		if self:isCanMove(cc.p(self.hero:getPositionX()-buchang*0.7,self.hero:getPositionY()+buchang*0.7)) then
			move = cc.MoveBy:create(mintus,cc.p(-buchang*0.7,buchang*0.7))
		end
		
		-- self.hero:setPosition(self.hero:getPositionX() - 3.5,self.hero:getPositionY() + 7)
	elseif self.move == tagDirection.rocker_LEFT_DOWN then
		--向左上移动
		self.hero:setScaleX(sc)
		if self:isCanMove(cc.p(-buchang*0.7+self.hero:getPositionX(),self.hero:getPositionY()-buchang*0.7)) then
			move = cc.MoveBy:create(mintus,cc.p(-buchang*0.7,-buchang*0.7))
		end
		
		-- self.hero:setPosition(self.hero:getPositionX() - 3.5,self.hero:getPositionY() - 7)
	elseif self.move == tagDirection.rocker_RIGHT_UP then
		--向右上移动
		self.hero:setScaleX(-sc)
		if self:isCanMove(cc.p(buchang*0.7+self.hero:getPositionX(),self.hero:getPositionY()+buchang*0.7)) then
			move = cc.MoveBy:create(mintus,cc.p(buchang*0.7,buchang*0.7))
		end
		
		-- self.hero:setPosition(self.hero:getPositionX() + 3.5,self.hero:getPositionY() + 7)
	elseif self.move == tagDirection.rocker_RIGHT_DOWN then
		--向右下移动
		self.hero:setScaleX(-sc)
		if self:isCanMove(cc.p(buchang*0.7+self.hero:getPositionX(),self.hero:getPositionY()-buchang*0.7)) then
			move = cc.MoveBy:create(mintus,cc.p(buchang*0.7,-buchang*0.7))
		end
		
		-- self.hero:setPosition(self.hero:getPositionX() + 3.5,self.hero:getPositionY() - 7)
	end
	-- self.hero:stopAllActions()
	if move~=nil then
		self.hero:runAction(move)
	end
	self.hero:doEvent("move2")
end

function FightingTouchLayer:initSkills()

	
	--技能按钮
	-- local btn1 = cc.ui.UIPushButton.new({normal="2.png",pressed="2.png"})
 --    btn1:setTag(1002)
 --    btn1:onButtonClicked(function(event)
 --        -- dump(event)
 --        printf("ButtonClicked")
 --    end)
    -- btn1:pos(display.cx, display.cy+90)
    -- self:addChild(btn1)

    --C++中的 button

    local s = {}
	for i=1,#HeroData.hero do
		if SaveData.selectHero[1].id == HeroData.hero[i].id then
		 	s = HeroData.hero[i]
		end 
	end

    self.skillButton1 = ccui.Button:create("img/icon/skill/"..s.s1.."1.png","img/icon/skill/"..s.s1.."1.png")
    self.skillButton1:setTag(100)
    -- self.skillButton1:setScale(0.5)
    self.skillButton1:setPosition(cc.p(display.right- 270,display.bottom + 100))
    self.skillButton1:setPressedActionEnabled(true)
    self.skillButton1:addTouchEventListener(function(psender,event)
    	if event == 2 then
    		print("技能一"..psender:getTag())
    		self.hero:doEvent("skills1")
    		if self.sc1 ~=nil then
    			scheduler.unscheduleGlobal(self.sc1)
    		end
    		self.sc1 = scheduler.scheduleGlobal(handler(self, self.JiNengYiPengZhuang),0.3)
    		-- self.hero.isPutSkills = true
    		self:Toloading(3,self.skillButton1)
    	end
    end)
    self:addChild(self.skillButton1)

    self.skillButton2 = ccui.Button:create("img/icon/skill/"..s.s1.."2.png","img/icon/skill/"..s.s1.."2.png")
    self.skillButton2:setTag(101)
    -- self.skillButton2:setScale(0.5)
    self.skillButton2:setPosition(cc.p(display.right- 240,display.bottom + 200))
    self.skillButton2:setPressedActionEnabled(true)
    self.skillButton2:addTouchEventListener(function(psender,event)
    	if event == 2 then
    		print("技能二"..psender:getTag())
    		self.hero:doEvent("skills2")
    		if self.sc ~=nil then
    			scheduler.unscheduleGlobal(self.sc)
    		end
    		self.sc = scheduler.scheduleGlobal(handler(self, self.JiNengErPengZhuang),0.3)
    		-- self.hero.isPutSkills=true
    		self:Toloading(1,self.skillButton2)
    	end
    end)
    self:addChild(self.skillButton2)

    self.skillButton3 = ccui.Button:create("img/icon/skill/"..s.s1.."3.png","img/icon/skill/"..s.s1.."3.png")
    self.skillButton3:setTag(102)
    -- self.skillButton3:setScale(0.5)
    self.skillButton3:setPosition(cc.p(display.right- 150,display.bottom + 270))
    self.skillButton3:setPressedActionEnabled(true)
    self.skillButton3:addTouchEventListener(function(psender,event)
    	if event == 2 then
    		print("技能三"..psender:getTag())
    		self.hero:doEvent("skills3")

    		-- self.hero.isPutSkills=true
    		self:Toloading(10,self.skillButton3)
    	end
    end)
    self:addChild(self.skillButton3)


	self.lab1 = cc.ui.UILabel.new({text = "5", size = 20, color = cc.c3b(255, 0, 0)})
    self.lab1:setPosition(self.skillButton1:getPositionX()-13,self.skillButton1:getPositionY())
    self.lab1:addTo(self,2)
    self.lab1:setVisible(false)

    self.lab2 = cc.ui.UILabel.new({text = "5", size = 20, color = cc.c3b(255, 0, 0)})
    self.lab2:setPosition(self.skillButton2:getPositionX()-13,self.skillButton2:getPositionY())
    self.lab2:addTo(self,2)
    self.lab2:setVisible(false)

    self.lab3 = cc.ui.UILabel.new({text = "5", size = 20, color = cc.c3b(255, 0, 0)})
    self.lab3:setPosition(self.skillButton3:getPositionX()-13,self.skillButton3:getPositionY())
    self.lab3:addTo(self,2)
    self.lab3:setVisible(false)

    self.skill_loadingBar1 = cc.ProgressTimer:create(cc.Sprite:create("backpack_6.png"))
    self.skill_loadingBar1:setPosition(self.skillButton1:getPosition())
    self.skill_loadingBar1:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    self.skill_loadingBar1:setScale(0.25)
    self.skill_loadingBar1:setPercentage(100)
    self.skill_loadingBar1:setReverseDirection(true)
    self.skill_loadingBar1:setVisible(false)
    self:addChild(self.skill_loadingBar1,1)

    self.skill_loadingBar2 = cc.ProgressTimer:create(cc.Sprite:create("backpack_6.png"))
    self.skill_loadingBar2:setPosition(self.skillButton2:getPosition())
    self.skill_loadingBar2:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    self.skill_loadingBar2:setScale(0.25)
    self.skill_loadingBar2:setPercentage(100)
    self.skill_loadingBar2:setReverseDirection(true)
    self.skill_loadingBar2:setVisible(false)
    self:addChild(self.skill_loadingBar2,1)

    self.skill_loadingBar3 = cc.ProgressTimer:create(cc.Sprite:create("backpack_6.png"))
    self.skill_loadingBar3:setPosition(self.skillButton3:getPosition())
    self.skill_loadingBar3:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    self.skill_loadingBar3:setScale(0.25)
    self.skill_loadingBar3:setPercentage(100)
    self.skill_loadingBar3:setReverseDirection(true)
    self.skill_loadingBar3:setVisible(false)
    self:addChild(self.skill_loadingBar3,1)

    -- self.skillButton4 = ccui.Button:create("img/icon/skill/hyjn-tiao.png","img/icon/skill/hyjn-tiao.png")
    -- self.skillButton4:setTag(103)
    -- self.skillButton4:setPosition(cc.p(display.right- 52,display.bottom + 161))
    -- self.skillButton4:setScale(0.5)
    -- self.skillButton4:setPressedActionEnabled(true)
    -- self.skillButton4:addTouchEventListener(function(psender,event)
    -- 	if event == 2 then
    -- 		print("技能四"..psender:getTag())
    -- 	end
    -- end)
    -- self:addChild(self.skillButton4)

    self.count = 0
    self.skillButton5 = ccui.Button:create("img/icon/skill/pugong-up.png","img/icon/skill/pugong-over.png")
    self.skillButton5:setTag(104)
    self.skillButton5:setPosition(cc.p(display.right- 120,display.bottom + 120))
    -- self.skillButton5:setScale(0.5)
    self.skillButton5:setPressedActionEnabled(true)
    self.skillButton5:addTouchEventListener(function(psender,event)
    	if event == 2 then
    		print("技能五"..psender:getTag())
    		-- self.count = self.count + 1

    		if self.count == 0 and self.hero.DengDaiGongJiJieSHu == false then--点击一次
    			scheduler.performWithDelayGlobal(handler(self, self.updateSingleDelay),0.3)
    			-- self.sch1 = scheduleGlobal(handler(self, self.updateSingleDelay),0.1)
    			self.count = self.count + 1
			elseif self.count == 1 and self.hero.DengDaiGongJiJieSHu == false then--双击
				scheduler.performWithDelayGlobal(handler(self, self.updateDoubleDelay),0.3)
				-- self.sch2 = scheduleGlobal(handler(self, self.updateDoubleDelay),0.1)
    			self.count = self.count + 1
			elseif self.count == 2 and self.hero.DengDaiGongJiJieSHu == false then
			 	--todo --三连击
				self:ThreeClicked()
    		end
    	end
    end)
    self:addChild(self.skillButton5)
end

function FightingTouchLayer:Toloading(cd,sender)
	sender:setTouchEnabled(false)

	local i = sender:getTag()%100


	local skill_loadingBar  --加载进度条
    local lab    --加载文本


	if i == 0 then
		skill_loadingBar = self.skill_loadingBar1
        lab = self.lab1
	elseif i==1 then
		skill_loadingBar = self.skill_loadingBar2
        lab = self.lab2
	elseif i==2 then
		skill_loadingBar = self.skill_loadingBar3
        lab = self.lab3
	end


    lab:setVisible(true)
    lab:setString(string.format("%0.1f", cd))  
    local time = cd

    skill_loadingBar:setVisible(true)
	skill_loadingBar:setPercentage(100)

    --设置一个定时器
	local handle
	local percent = 10/cd
   	local interval = 0.1
  	local index = 0
  	local sharedScheduler = cc.Director:getInstance():getScheduler()
  	handle = sharedScheduler:scheduleScriptFunc(function()
    	index = index + percent
    	skill_loadingBar:setPercentage(100-index)
        time = time-0.1
        lab:setString(string.format("%0.1f", time))
    	if index >= 100 then
   --  		if i == 1 then
			-- 	isskill1 = true
			-- elseif i==2 then
			-- 	isskill2 = true
			-- elseif i==3 then
			-- 	isskill3 = true
			-- end
            skill_loadingBar:setVisible(false)
            lab:setVisible(false)
            sender:setTouchEnabled(true)
      		scheduler.unscheduleGlobal(handle)
    	end
  	end, interval, false)
   	
end

function FightingTouchLayer:JiNengYiPengZhuang()
	if self.hero.isPutSkills == false then
		scheduler.unscheduleGlobal(self.sc1)
	end
	-- print("敌人数组大小" .. #self.diren)
	for i=1,#self.diren do
		if self.diren[i].isDie then
			--敌人死亡了
		else
			if math.abs(self.hero:getPositionY()-self.diren[i]:getPositionY()) < 30 then
				print("yijineng")
				-- if self.shape4 ~= nil then
				-- 		self.shape4:removeFromParent()
				-- 		self.shape4 = nil
				-- end
				local bound = self.hero.yixiong:getBoundingBox()
				local p = cc.p(bound.x,bound.y)
				-- dump(bound)
				local m = self.hero:convertToWorldSpace(p)
				local juxin1
				if self.hero:getScaleX() > 0 then
					juxin1 = cc.rect(m.x - 0.2*bound.width* math.abs(self.hero:getScaleX()) *0.5, m.y + bound.height* math.abs(self.hero:getScaleY())*0.5, bound.width* math.abs(self.hero:getScaleX()) *0.5, bound.height* math.abs(self.hero:getScaleY())*0.5)
				else
					juxin1 = cc.rect(m.x - 0.5*bound.width* math.abs(self.hero:getScaleX()), m.y+bound.height* math.abs(self.hero:getScaleY())*0.5, bound.width* math.abs(self.hero:getScaleX())*0.5 , bound.height* math.abs(self.hero:getScaleY()*0.5))
				end
				-- self.shape4 = display.newRect(juxin1,
			 --        {fillColor = cc.c4f(1,0,0,0.5), borderColor = cc.c4f(0,1,0,1), borderWidth = 1})
				-- self:addChild(self.shape4,50)
				local bound2 = self.diren[i].yixiong:getBoundingBox()
				local p2 = cc.p(bound2.x,bound2.y)
				local m2 = self.diren[i]:convertToWorldSpace(p2)
				local juxin2
				if self.diren[i]:getScaleX() > 0 then
					juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.diren[i]:getScaleX()), bound2.height*math.abs(self.diren[i]:getScaleY()))
				else
					juxin2 = cc.rect(m2.x - bound2.width*math.abs(self.diren[i]:getScaleX()), m2.y, bound2.width*math.abs(self.diren[i]:getScaleX()), bound2.height*math.abs(self.diren[i]:getScaleY()))
				end
				if cc.rectIntersectsRect(juxin1,juxin2) then
					--敌人跟着英雄一起移动
					-- self.diren:setPosition(cc.p(self.))
					
					-- print("碰撞")
					-- 敌人减血
					print("敌人减血")
					--打一次减十点血量
					self.diren[i].xueliang = self.diren[i].xueliang-10
					self.diren[i]:setXueLiang()--减血
					if self.diren[i].xueliang <= 0 then
						print("敌人死亡")
						self.diren[i].isDie = true
						self.diren[i]:doEvent("death")
						self:dispatchEvent({name="MY_NEWS"})
					else
						self.diren[i]:doEvent("injured")--被攻击，并且进入被攻击状态
						self.diren[i].beigongji = true
					end
				end
			end
		end
	end
end

function FightingTouchLayer:JiNengErPengZhuang()
	if self.hero.isPutSkills == false then
		scheduler.unscheduleGlobal(self.sc)
	end
	-- print("敌人数组大小" .. #self.diren)
	for i=1,#self.diren do
		if self.diren[i].isDie then
			--敌人死亡了
		else
			if math.abs(self.hero:getPositionY()-self.diren[i]:getPositionY()) < 30 then
				if self.hero.isPutSkills == true then
					if self.shape4 ~= nil then
						self.shape4:removeFromParent()
						self.shape4 = nil
					end
					local bound = self.hero.jineng:getBoundingBox()
					local p = cc.p(bound.x,bound.y)
					-- dump(bound)
					local m = self.hero:convertToWorldSpace(p)
					local juxin1
					if self.hero:getScaleX() > 0 then
						juxin1 = cc.rect(m.x + 0.5*bound.width* math.abs(self.hero:getScaleX()) *0.5, m.y, bound.width* math.abs(self.hero:getScaleX()) *0.5, bound.height* math.abs(self.hero:getScaleY())*0.5)
					else
						juxin1 = cc.rect(m.x - 0.8*bound.width* math.abs(self.hero:getScaleX()), m.y, bound.width* math.abs(self.hero:getScaleX())*0.5 , bound.height* math.abs(self.hero:getScaleY()*0.5))
					end
					-- self.shape4 = display.newRect(juxin1,
				 --        {fillColor = cc.c4f(1,0,0,0.5), borderColor = cc.c4f(0,1,0,1), borderWidth = 1})
					-- self:addChild(self.shape4,50)
					local bound2 = self.diren[i].yixiong:getBoundingBox()
					local p2 = cc.p(bound2.x,bound2.y)
					local m2 = self.diren[i]:convertToWorldSpace(p2)
					local juxin2
					if self.diren[i]:getScaleX() > 0 then
						juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.diren[i]:getScaleX()), bound2.height*math.abs(self.diren[i]:getScaleY()))
					else
						juxin2 = cc.rect(m2.x - bound2.width*math.abs(self.diren[i]:getScaleX()), m2.y, bound2.width*math.abs(self.diren[i]:getScaleX()), bound2.height*math.abs(self.diren[i]:getScaleY()))
					end
					if cc.rectIntersectsRect(juxin1,juxin2) then
						print("碰撞")
						--敌人减血
						print("敌人减血")
						--打一次减十点血量
						self.diren[i].xueliang = self.diren[i].xueliang-10
						self.diren[i]:setXueLiang()--减血
						if self.diren[i].xueliang <= 0 then
							print("敌人死亡")
							self.diren[i].isDie = true
							self.diren[i]:doEvent("death")
							self:dispatchEvent({name="MY_NEWS"})
						else
							self.diren[i]:doEvent("injured")--被攻击动画，并且进去被攻击状态
							self.diren[i].beigongji = true
						end
					end
				end
			end
		end
		
	end
end

function FightingTouchLayer:updateSingleDelay()
	--单击
	if self.count == 1 and self.hero.DengDaiGongJiJieSHu == false then
		print("单击")
		self.hero.isGongJiCiShu = 1
		self.hero:doEvent("attack1")
		self:resumeclick()
		self.hero.DengDaiGongJiJieSHu = true
	end
	
end

function FightingTouchLayer:updateDoubleDelay()
	--双击
	if self.count == 2 and self.hero.DengDaiGongJiJieSHu == false then
		print("双击")
		self.hero.isGongJiCiShu = 2
		self.hero:doEvent("attack1")
		self:resumeclick()
		self.hero.DengDaiGongJiJieSHu = true
	end
end

function FightingTouchLayer:ThreeClicked()
	--三击
	-- self:resumeclick()
	if self.hero.DengDaiGongJiJieSHu == false then
		print("三击")
		self.hero.isGongJiCiShu = 3
		self.hero:doEvent("attack1")
		self:resumeclick()
		self.hero.DengDaiGongJiJieSHu = true--等待攻击结束
	end
	
	-- scheduler.performWithDelayGlobal(handler(self, self.resumeclick),3)

	
end

function FightingTouchLayer:resumeclick()
	self.count = 0
end

function FightingTouchLayer:initRocker()
	
	self.RockerBG = display.newSprite("img/ui/battleUI/caogan-waiyuan.png")
	-- self.RockerBG:setScale(0.5)
	self.RockerBG:pos(self:getPositionX() + display.left + self.RockerBG:getContentSize().width/2 +30,self:getPositionY()+ display.bottom + self.RockerBG:getContentSize().width/2 + 30):addTo(self)
	self.Rocker = display.newSprite("img/ui/battleUI/caozuodian1.png"):pos(self.RockerBG:getPosition()):addTo(self)
	-- self.Rocker:setScale(0.5)

	self.RockerBGPos = {}
	self.RockerBGPos.x = self.RockerBG:getPositionX()
	self.RockerBGPos.y = self.RockerBG:getPositionY()
	-- local s = self.RockerBG:getPos()
	-- print("x = "..self.RockerBGPos.y)
	self.RockerBGR = self.RockerBG:getContentSize().width/2
	--注册监听
	self:addTouchA()
end
--求亮点之间的距离
function FightingTouchLayer:distance(p1,p2)
	return math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y))
end

function FightingTouchLayer:corea(p1,p2)
	return (p1.x - p2.x)/(self:distance(p1,p2))
end

function FightingTouchLayer:checkdirection(angle,p)

	if (p.x >= self.RockerBGPos.x) and (p.y >= self.RockerBGPos.y) then
		if (math.radian2angle(angle)>22.5) and (math.radian2angle(angle)<67.5) then
			--向上
			-- print("右上")
			self.move = tagDirection.rocker_RIGHT_UP
			return
		elseif math.radian2angle(angle)>67.5 then
			-- print("上")
			self.move = tagDirection.rocker_UP
			return
		elseif math.radian2angle(angle)<22.5 then
			-- print("右")
			self.move = tagDirection.rocker_RIGHT
			return
		end

	elseif (p.x < self.RockerBGPos.x) and (p.y > self.RockerBGPos.y) then
		if (math.radian2angle(angle)>112.5) and (math.radian2angle(angle)<152.5) then
			-- print("左上")
			self.move = tagDirection.rocker_LEFT_UP
			return
		elseif math.radian2angle(angle) < 112.5 then
			-- print("上")
			self.move = tagDirection.rocker_UP
			return
		elseif math.radian2angle(angle) > 152.5 then
			-- print("左")
			self.move = tagDirection.rocker_LEFT
			return
		end

	elseif (p.x < self.RockerBGPos.x) and (p.y <= self.RockerBGPos.y) then
		if (math.radian2angle(angle)>112.5) and (math.radian2angle(angle)<152.5) then
			-- print("左下")
			self.move = tagDirection.rocker_LEFT_DOWN
			return
		elseif math.radian2angle(angle)>112.5 then
			-- print("左")
			self.move = tagDirection.rocker_LEFT
			return
		elseif math.radian2angle(angle)<152.5 then
			-- print("下")
			self.move = tagDirection.rocker_DOWN
			return
		end

	elseif (p.x > self.RockerBGPos.x) and (p.y < self.RockerBGPos.y) then
		if (math.radian2angle(angle)>22.5) and (math.radian2angle(angle)<67.5) then
			-- print("右下")
			self.move = tagDirection.rocker_RIGHT_DOWN
			return
		elseif math.radian2angle(angle)>67.5 then
			-- print("下")
			self.move = tagDirection.rocker_DOWN
			return
		elseif math.radian2angle(angle)<22.5 then
			-- print("右")
			self.move = tagDirection.rocker_RIGHT
			return
		end
	end
end

function FightingTouchLayer:addTouchA()
	local function touchbegan(location,event)
		p = location:getLocation()
		--如果出了边界将不出发事件
		if self:distance(p,self.RockerBGPos) < self.RockerBGR then
			--开启时间调度
			if self.hero.isPutSkills == true then
				if self._schedule ~= nil then
					scheduler.unscheduleGlobal(self._schedule)
				end
			else
				self._schedule = scheduler.scheduleGlobal(handler(self, self.update),0.1)
			end
			return true
		end
		return false
	end

	local function touchEnd(location,event)
		self.move = 0
		--让点回到中心
		self.Rocker:setPosition(self.RockerBGPos)
		--停止英雄的运动
		self.hero:stopAllActions()
		self.hero:doEvent("normal")
		scheduler.unscheduleGlobal(self._schedule)
		self._schedule = nil
	end

	local function touchMove(location,event)
		local p = location:getLocation()
		angle = math.acos(self:corea(p,self.RockerBGPos))--弧度制的
		-- math.acos()
		self:checkdirection(angle,p)

		if self:distance(p,self.RockerBGPos) > self.RockerBGR then
			local x = self.RockerBGR * math.cos(angle)
			local y = self.RockerBGR * math.sin(angle)
			if p.y >= self.RockerBGPos.x then
				self.Rocker:setPosition(self.RockerBGPos.x+x,self.RockerBGPos.y+y)
			else
				self.Rocker:setPosition(self.RockerBGPos.x+x,self.RockerBGPos.y-y)
			end
		else
			self.Rocker:setPosition(p)
		end
		--更新英雄位置
		if self._schedule == nil and self.hero.isPutSkills == false then
			self._schedule = scheduler.scheduleGlobal(handler(self, self.update),0.1 )
		else
			-- print("有时间调度")
		end
		-- self._schedule = scheduler.scheduleGlobal(handler(self, self.update),0.5)
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	local dis  = cc.Director:getInstance():getEventDispatcher()
	-- listener
	listener:registerScriptHandler(touchbegan,cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(touchEnd,cc.Handler.EVENT_TOUCH_ENDED)
	listener:registerScriptHandler(touchMove,cc.Handler.EVENT_TOUCH_MOVED)

	dis:addEventListenerWithSceneGraphPriority(listener, self)
end

-- function FightingTouchLayer:upShiJian(dt)
	
-- end

--开始攻击那么开启碰撞检测，结束关闭碰撞检测
function FightingTouchLayer:PengZhuangJianCe(dt)
	if self.diren == nil then
		-- scheduler.unscheduleGlobal(self.ssssss)
		return
	end
	-- print("敌人数组大小 "..#self.diren)
	for i=1,#self.diren do
		if self.diren[i].isDie then
			--敌人死亡了
		else
			if self.hero.DengDaiGongJiJieSHu == true and self.hero.gongjiChengGong == false then
				if math.abs(self.hero:getPositionY()-self.diren[i]:getPositionY()) < 30 then
					--todo
					-- bone1 = self.hero.yixiong.findBone("root") 
					-- dump(bone1)
					-- if self.shape4 ~= nil then
					-- 	self.shape4:removeFromParent()
					-- 	self.shape4 = nil
					-- end
					-- if self.shape5 ~= nil then
					-- 	self.shape5:removeFromParent()
					-- 	self.shape5 = nil
					-- end
					local bound = self.hero.yixiong:getBoundingBox()
					local p = cc.p(bound.x,bound.y)
					-- dump(bound)
					local m = self.hero:convertToWorldSpace(p)
					-- print("英雄 x = " .. m.x .. "  y = " .. m.y)
					-- print("英雄 w = " .. bound.width .. "  h = " .. bound.height)

					local bound2 = self.diren[i].yixiong:getBoundingBox()
					local p2 = cc.p(bound2.x,bound2.y)
					local m2 = self.diren[i]:convertToWorldSpace(p2)
					-- print("敌人 x = " .. m2.x .. "  y = " .. m2.y)
					-- print("英雄 w = " .. bound2.width .. "  h = " .. bound2.height)

					local juxin1
					local juxin2
					if self.hero:getScaleX() > 0 then
						juxin1 = cc.rect(m.x, m.y, bound.width* math.abs(self.hero:getScaleX()) , bound.height* math.abs(self.hero:getScaleY()))
					else
						juxin1 = cc.rect(m.x - bound.width* math.abs(self.hero:getScaleX()), m.y, bound.width* math.abs(self.hero:getScaleX()) , bound.height* math.abs(self.hero:getScaleY()))
					end

					if self.diren[i]:getScaleX() > 0 then
						juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.diren[i]:getScaleX()), bound2.height*math.abs(self.diren[i]:getScaleY()))
					else
						juxin2 = cc.rect(m2.x - bound2.width*math.abs(self.diren[i]:getScaleX()), m2.y, bound2.width*math.abs(self.diren[i]:getScaleX()), bound2.height*math.abs(self.diren[i]:getScaleY()))
					end
					-- local juxin1 = cc.rect(m.x, m.y, bound.width* math.abs(self.hero:getScaleX()) , bound.height* math.abs(self.hero:getScaleY()) )
					-- local juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.diren:getScaleX()), bound2.height*math.abs(self.diren:getScaleY()))
					-- print(cc.rectIntersectsRect(juxin1,juxin2))
					if cc.rectIntersectsRect(juxin1,juxin2) then
						print("碰撞")
						self.hero.gongjiChengGong = true
						--敌人减血
						print("敌人减血")
						self.diren[i].xueliang = self.diren[i].xueliang-10
						self.diren[i]:setXueLiang()--减血
						if self.diren[i].xueliang <= 0 then
							self.diren[i].isDie = true
							self.diren[i]:doEvent("death")
							self:dispatchEvent({name="MY_NEWS"})
						else
							self.diren[i]:doEvent("injured")
							self.diren[i].beigongji = true
						end
					end
					-- if self:isRectCollision(juxin1,juxin2) then
					-- 	print("碰撞了")
					-- end
					--碰撞检测

					-- self.shape4 = display.newRect(juxin1,
				 --        {fillColor = cc.c4f(1,0,0,1), borderColor = cc.c4f(0,1,0,1), borderWidth = 1})
					-- self:addChild(self.shape4,50)
					-- self.shape5 = display.newRect(juxin2,
				 --        {fillColor = cc.c4f(0,1,0,1), borderColor = cc.c4f(0,0,1,1), borderWidth = 1})
					-- self:addChild(self.shape5,50)00
				end
			end
		end
		
	end
end

function FightingTouchLayer:isRectCollision(rect1,rect2)
	
	local x1 = rect1.x
	local y1 = rect1.y
	local w1 = rect1.width
	local h1 = rect1.height
	local x2 = rect2.x
	local y2 = rect2.y
	local w2 = rect2.width
	local h2 = rect2.height

	if x1+w1 < x2 then  
		print("左方")  
		return false--矩形1在矩形2左方，两者无碰撞
	elseif x1-w1 > x2+w2 then
		print("右方")
		return false--矩形1在矩形2右边
	elseif y1+h1 < y2-h2 then
		print("下方")
		return false--矩形1在矩形2下方
	elseif y1-h1 > y2+h2 then
		print("上方")
		return false--矩形1在矩形2上方
	end
	print("有重合")
	return true
end

function FightingTouchLayer:onEnter()
end

function FightingTouchLayer:onExit()
	scheduler.unscheduleGlobal(self.sc)
	-- cc.Director:getInstance():getScheduler():unscheduleAllCallbacks()--关闭所有事件调度
	-- self:removeAllEventListeners()
end
return FightingTouchLayer
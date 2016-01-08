--
-- Author: student
-- Date: 2015-11-16 10:11:34
--
FightingTouchLayer = require("app.GameScenes.FightingTouch")
HeroClass = require("app.CharacterClass.HeroClass")
Enemy = require("app.CharacterClass.Enemy")

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()

	audio.pauseMusic()
	if ShenJiData.GuanKa == 1 then
		audio.playMusic("data/music/bg/a_gulangyumusic.mp3", true)
	elseif ShenJiData.GuanKa == 2 then
		audio.playMusic("data/music/bg/a_shamomusic.mp3", true)
	elseif ShenJiData.GuanKa == 3 then
		audio.playMusic("data/music/bg/a_yechangmusic.mp3", true)
	elseif ShenJiData.GuanKa == 4 then
		audio.playMusic("data/music/bg/a_yueyemusic.mp3", true)
	end
	

	self.guan = {}
	self.guan = TMXData.GuanKa[ShenJiData.GuanKa][ShenJiData.FuBen]
	-- print(self.guan.name)

    self.Map = cc.TMXTiledMap:create(self.guan.name)
    self:addChild(self.Map)
    self.BoShuNo = 1--是那一波
-- self.Map:setScale(0.5)

    self.NoGoLayer = self.Map:getLayer("block")
    self.objectsValue = self.Map:getObjectGroup("born")
	self.diren={}--敌人数组

    self:addHero()
    self:addDiRen()
    --开始战斗
    local s = sp.SkeletonAnimation:create("spine/effects/readygo/readygo.json","spine/effects/readygo/readygo.atlas",0.5)
	s:setAnimation(0,"animation",false)
	s:setPosition(display.cx,display.cy+100)
	self:addChild(s)

	s:registerSpineEventHandler(function (event)
	--开始
	self:init()
	end, sp.EventType.ANIMATION_COMPLETE)
    
end

function GameScene:init()
	self.s = FightingTouchLayer:new(self.he,self.diren,self.Map)
	self.s:addEventListener("MY_NEWS", handler(self, self.onMynews))
    self:addChild(self.s)

	-- print(self.Map:getTileSize().width)
--开启时间调度，判断人物是否在不能走的层上
    self._schedule = scheduler.scheduleGlobal(handler(self, self.update),0.1)
--开启时间回掉，怪物自动找人并且攻击
	self.q = scheduler.scheduleGlobal(handler(self, self.direnMove),0.2)
	self.sc2 = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.2)
--开启事件调度，当一波敌人死亡后刷新下一波敌人
	-- self.RE = scheduler.scheduleGlobal(handler(self, self.RefreshEnemy),0.2)
end

function GameScene:onMynews()
	--敌人数减少
	print("敌人数减少")
	self.count = self.count - 1
	print("敌人数量" .. self.count)
	if self.count == 0 then
		--敌人数组清空
		self:removeAllTableItem()
		if self.BoShuNo == self.guan.guaiwu.boShu then
			--进入胜利界面
			print("进入胜利界面")
			-- self.s:removeFromParent()
			ShengLi:new():addTo(self)
		else
			--播放动画，然后刷新怪物
			local jiantou = ccui.Scale9Sprite:create("jiantou.png")
				:pos(display.cx, display.top - 100)
		        :addTo(self)
	       	jiantou:runAction(cc.Sequence:create(cc.Blink:create(1.5,5),cc.CallFunc:create(function()
	       		print("下一波")
	            self.BoShuNo = self.BoShuNo + 1
				self:addDiRen()
				jiantou:removeFromParent()
				-- event.target:removeFromParent()
	       	end)))
			-- cc.ui.UIPushButton.new({normal = "img/comm/jiantou.png",pressed = "img/comm/jiantou.png"
		 --    	},{scale9 = true})
		 --        :onButtonClicked(function(event)
		 --          	print("下一波")
		 --            self.BoShuNo = self.BoShuNo + 1
			-- 		self:addDiRen()
			-- 		event.target:removeFromParent()
		 --        end)
		 --        :pos(display.cx, display.cy)
		 --        :addTo(self)
		end
	end
end

--删除表中所有敌人
function GameScene:removeAllTableItem()
	 for k,v in pairs(self.diren) do
	 	table.removebyvalue(self.diren, v, true)
	 end
end
-- function GameScene:RefreshEnemy()
-- 	if #self.diren == 0 then
-- 		print("11222")
-- 		self.BoShuNo = self.BoShuNo + 1
-- 		scheduler.unscheduleGlobal(self.RE)
-- 		self:addDiRen()
-- 	end
-- end

function GameScene:addHero()
	local spwanPoint2 = self.objectsValue:getObject("born1")
    self.he = HeroClass:new()
	self.he:setPosition(cc.p(spwanPoint2.x,spwanPoint2.y))
	self.he:setScale(0.5)
	self.Map:addChild(self.he, 11)
end

function GameScene:addDiRen()
	--敌人
	self.count = self.guan.guaiwu.g[self.BoShuNo]
	if self.BoShuNo == self.guan.guaiwu.boShu then
		print("刷新 boss   你是住吗" .. self.count)
		if self.count > 1 then
			for i=1,self.count-1 do
				print("你是住吗"..i)
				local spwanPoint3 = self.objectsValue:getObject("guai".. self.BoShuNo .."-"..i)
				-- table.insert(self.diren, i,)
				self.diren[i] = Enemy:new(TMXData.GuaiWu[ShenJiData.GuanKa][ShenJiData.FuBen][self.BoShuNo][i].name,0)
				self.diren[i]:setPosition(cc.p(spwanPoint3.x,spwanPoint3.y))
				self.diren[i]:setScale(0.5)
				self.Map:addChild(self.diren[i], 10)
			end
		end
		print("s111111111111111111111111111111111111111111111111")
		local spwanPoint3 = self.objectsValue:getObject("boss")
		self.diren[self.count] = Enemy:new(TMXData.GuaiWu[ShenJiData.GuanKa][ShenJiData.FuBen][self.BoShuNo][self.count].name,1)
		self.diren[self.count]:setPosition(cc.p(spwanPoint3.x,spwanPoint3.y))
		self.diren[self.count]:setScale(0.5)
		self.diren[self.count].isBoss = true
		self.Map:addChild(self.diren[self.count], 10)
		
	else	
		for i=1,self.count do
			print("你是住吗"..i)
			local spwanPoint3 = self.objectsValue:getObject("guai".. self.BoShuNo .."-"..i)
			self.diren[i] = Enemy:new(TMXData.GuaiWu[ShenJiData.GuanKa][ShenJiData.FuBen][self.BoShuNo][i].name,0)
			self.diren[i]:setPosition(cc.p(spwanPoint3.x,spwanPoint3.y))
			self.diren[i]:setScale(0.5)
			self.Map:addChild(self.diren[i], 10)
		end
	end
	
	
end

function GameScene:direnMove()
	if self.he.isDie then
		--英雄死亡
		-- print("英雄死亡")
		--进入失败 layer
		if self.sb then
			-- print("进入了失败界面")
		else
			WinORFai:new(false):addTo(self)
			self.sb = true
			-- self.s:removeFromParent()
			return
		end
		
		
	else
		for i=1,#self.diren do
			if self.diren[i].isPutSkills == false and self.diren[i].xueliang > 0 then--怪物处于没攻击的状态
		 		local heroP = {x = self.he:getPositionX(),y = self.he:getPositionY()}
		 		local direnP = {x = self.diren[i]:getPositionX(),y = self.diren[i]:getPositionY()}
		 		if self:distance(heroP,direnP) > 130 then
		 			--敌人向英雄移动
		 			local move
		 			local sc = 1
		 			if direnP.x-heroP.x > 0 and direnP.y-heroP.y > 0 then
		 				self.diren[i]:setScaleX(sc)

		 				move = cc.MoveBy:create(0.2,cc.p(-16,-8))
		 				-- self.diren:doEvent("walk2")
		 			elseif direnP.x-heroP.x > 0 and direnP.y-heroP.y < 0 then
		 				self.diren[i]:setScaleX(sc)
		 				move = cc.MoveBy:create(0.2,cc.p(-16,8))
		 				-- self.diren:doEvent("walk2")
		 			elseif direnP.x-heroP.x < 0 and direnP.y-heroP.y > 0 then
		 				self.diren[i]:setScaleX(-sc)
		 				move = cc.MoveBy:create(0.2,cc.p(16,-8))
		 				-- self.diren:doEvent("walk2")
					elseif direnP.x-heroP.x < 0 and direnP.y-heroP.y < 0 then
						self.diren[i]:setScaleX(-sc)
		 				move = cc.MoveBy:create(0.2,cc.p(16,8))
		 				-- self.diren:doEvent("walk2")
		 			elseif direnP.x-heroP.x < 0 and direnP.y-heroP.y == 0 then
		 				self.diren[i]:setScaleX(-sc)
		 				move = cc.MoveBy:create(0.2,cc.p(16,0))
		 			elseif direnP.x-heroP.x > 0 and direnP.y-heroP.y == 0 then
		 				self.diren[i]:setScaleX(sc)
		 				move = cc.MoveBy:create(0.2,cc.p(-16,0))
					elseif direnP.x-heroP.x == 0 and direnP.y-heroP.y < 0 then
						move = cc.MoveBy:create(0.2,cc,p(0,8))
					elseif direnP.x-heroP.x == 0 and direnP.y-heroP.y > 0 then
						move = cc.MoveBy:create(0.2,cc,p(0,-8))
		 			end
		 			self.diren[i]:runAction(move)
		 			self.diren[i]:doEvent("move2")
		 		elseif math.abs(self.he:getPositionY()-self.diren[i]:getPositionY()) > 30 then
		 			--当 Y 轴还是大于30时，会接着向英雄移动
		 			local move
		 			if math.abs(self.he:getPositionY()-self.diren[i]:getPositionY()) > 30 then
		 				if self.he:getPositionY()-self.diren[i]:getPositionY() > 0 then
		 					move = cc.MoveBy:create(0.2,cc.p(0,8))
						else
							move = cc.MoveBy:create(0.2,cc.p(0,-8))
		 				end
		 				self.diren[i]:runAction(move)
		 				self.diren[i]:doEvent("move2")
		 			end
		 			
				elseif self.diren[i].xueliang > 0 then
					----[[
					--todo
		 			--开始攻击
		 			self.diren[i]:doEvent("normal")
		 			-- math.round(12)
		 			--种攻击
		 			local jingong
		 			if self.diren[i].isBoss  then
		 				jingong = math.random(1,6)
	 				else
	 					jingong = math.random(1,3)
		 			end
		 			
		 			-- local jingong = 1
		 			-- print(jingong)
		 			--技能回掉，只有 Boss 才有，所以可以这样
		 			if self.sc ~= nil then
		 				scheduler.unscheduleGlobal(self.sc)
		 			end

		 			if self.sc1 ~= nil then
		 				scheduler.unscheduleGlobal(self.sc1)
		 			end

		 			if jingong == 1 and self.diren[i].isBoss == false then
		 				--普工一
		 				if self.diren[i].DengDaiGongJiJieSHu == false then
		 					--todo
		 				-- 	if self.he:getPositionY()-self.diren:getPositionY()>0 then
		 				-- 		self.diren:setScaleX(-0.5)
							-- else
							-- 	self.diren:setScaleX(0.5)
		 				-- 	end
		 					print("普工一")
			 				self.diren[i].isGongJiCiShu = 1
							self.diren[i]:doEvent("attack1")
							self.diren[i].DengDaiGongJiJieSHu = true
							--怪物普工碰撞检测
							-- self.sc2 = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.2)
		 				end
					elseif jingong == 2 and self.diren[i].isBoss == false then
						--普工二
						if self.diren[i].DengDaiGongJiJieSHu == false then
							-- if self.he:getPositionY()-self.diren:getPositionY()>0 then
		 				-- 		self.diren:setScaleX(-0.5)
							-- else
							-- 	self.diren:setScaleX(0.5)
		 				-- 	end
							print("普工二")
							self.diren[i].isGongJiCiShu = 2
							self.diren[i]:doEvent("attack1")
							self.diren[i].DengDaiGongJiJieSHu = true
							
						end
					elseif jingong == 3 and self.diren[i].isBoss == false then
						--普工三
						if self.diren[i].DengDaiGongJiJieSHu == false then
							-- if self.he:getPositionY()-self.diren:getPositionY()>0 then
		 				-- 		self.diren:setScaleX(-0.5)
							-- else
							-- 	self.diren:setScaleX(0.5)
		 				-- 	end
							print("普工三")
							self.diren[i].isGongJiCiShu = 3
							self.diren[i]:doEvent("attack1")
							self.diren[i].DengDaiGongJiJieSHu = true
							-- self.sc2 = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.2)
						end
					elseif jingong == 4 and self.diren[i].isBoss == true then
						--技能一
						if self.diren[i].DengDaiGongJiJieSHu == false then
							-- if self.he:getPositionY()-self.diren:getPositionY()>0 then
		 				-- 		self.diren:setScaleX(-0.5)
							-- else
							-- 	self.diren:setScaleX(0.5)
		 				-- 	end
							print("技能一")
							self.diren[i]:doEvent("skills1")
							self.sc1 = scheduler.scheduleGlobal(handler(self, self.JiNengYiPengZhuang),0.2)
						end
					elseif jingong == 5 and self.diren[i].isBoss == true then
						--技能二
						if self.diren[i].DengDaiGongJiJieSHu == false then
							-- if self.he:getPositionY()-self.diren:getPositionY()>0 then
		 				-- 		self.diren:setScaleX(-0.5)
							-- else
							-- 	self.diren:setScaleX(0.5)
		 				-- 	end
							print("技能二")
							self.diren[i]:doEvent("skills2")
							self.sc = scheduler.scheduleGlobal(handler(self, self.JiNengErPengZhuang),0.2)
						end
					elseif jingong == 6 and self.diren[i].isBoss == true then
						--技能三
						if self.diren[i].DengDaiGongJiJieSHu == false then
							-- if self.he:getPositionY()-self.diren:getPositionY()>0 then
		 				-- 		self.diren:setScaleX(0.5)
							-- else
							-- 	self.diren:setScaleX(-0.5)
		 				-- 	end
							print("技能三")
							self.diren[i]:doEvent("skills3")
					 	end
		 			end--]]
		 		end
		 	end
		end
	end
	
 	
 end

--求亮点之间的距离
function GameScene:distance(p1,p2)
	return math.sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y))
end

function GameScene:update(dt)
	local p = cc.p(self.he:getPositionX(),self.he:getPositionY())
	local vis = cc.Director:getInstance():getVisibleSize()
	local x = math.max(p.x, vis.width/2)
	local y = math.max(p.y, vis.height/2)

	local mapSize = self.Map:getMapSize()
	local titleSize = self.Map:getTileSize()
	x = math.min(x, mapSize.width * titleSize.width - vis.width/2)
	y = math.min(y, mapSize.height * titleSize.height - vis.height/2)

	local centerPoint = cc.p(vis.width/2,vis.height/2)
	local actualPoint = cc.p(x,y)
	local viewPoint = cc.p(centerPoint.x-actualPoint.x,centerPoint.y-actualPoint.y)
	-- self.Map:setPosition(viewPoint)
	transition.moveTo(self.Map, {time = 0.1,x = viewPoint.x,y = viewPoint.y})

end
function GameScene:JiNengErPengZhuang(No)

	if self.he.isDie then
		--英雄死亡
	else
		for num=1,#self.diren do
			if math.abs(self.he:getPositionY()-self.diren[num]:getPositionY()) < 30 then
				if self.diren[num].isPutSkills == true then
					-- if self.shape4 ~= nil then
					-- 	self.shape4:removeFromParent()
					-- 	self.shape4 = nil
					-- end
					local bound = self.diren[num].jineng:getBoundingBox()
					local p = cc.p(bound.x,bound.y)
					-- dump(bound)
					local m = self.diren[num]:convertToWorldSpace(p)
					local juxin1
					if self.diren[num]:getScaleX() > 0 then
						juxin1 = cc.rect(m.x + 0.5*bound.width* math.abs(self.diren[num]:getScaleX()) *0.5, m.y, bound.width* math.abs(self.diren[num]:getScaleX()) *0.5, bound.height* math.abs(self.diren[num]:getScaleY())*0.5)
					else
						juxin1 = cc.rect(m.x - 0.8*bound.width* math.abs(self.diren[num]:getScaleX()), m.y, bound.width* math.abs(self.diren[num]:getScaleX())*0.5 , bound.height* math.abs(self.diren[num]:getScaleY()*0.5))
					end
					-- self.shape4 = display.newRect(juxin1,
				 --        {fillColor = cc.c4f(1,0,0,0.5), borderColor = cc.c4f(0,1,0,1), borderWidth = 1})
					-- self:addChild(self.shape4,50)
					local bound2 = self.he.yixiong:getBoundingBox()
					local p2 = cc.p(bound2.x,bound2.y)
					local m2 = self.he:convertToWorldSpace(p2)
					local juxin2
					if self.he:getScaleX() > 0 then
						juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.he:getScaleX()), bound2.height*math.abs(self.he:getScaleY()))
					else
						juxin2 = cc.rect(m2.x - bound2.width*math.abs(self.he:getScaleX()), m2.y, bound2.width*math.abs(self.he:getScaleX()), bound2.height*math.abs(self.he:getScaleY()))
					end
					if cc.rectIntersectsRect(juxin1,juxin2) then
						print("碰撞")
						--敌人减血
						print("hero减血")
						--打一次减十点血量
						self.he.xueliang = self.he.xueliang-10
						self.he:setXueLiang()--减血
						if self.he.xueliang <= 0 then
							print("Hero死亡")
							self.he.isDie = true
							self.he:doEvent("death")
						else
							self.he:doEvent("injured")--被攻击动画，并且进去被攻击状态
							self.he.beigongji = true
						end
					end
				end
			end
		end
	end
	
end


function GameScene:PengZhuangJianCe(dt)
	if self.he.isDie then
		--英雄死亡
	else
		for num=1,#self.diren do
			-- print("普工的碰撞检测" .. num)
			if self.diren[num].DengDaiGongJiJieSHu == true and self.diren[num].gongjiChengGong == false then
				if math.abs(self.diren[num]:getPositionY()-self.he:getPositionY()) < 30 then
					
					local bound = self.diren[num].yixiong:getBoundingBox()
					local p = cc.p(bound.x,bound.y)
					local m = self.diren[num]:convertToWorldSpace(p)
					
					local bound2 = self.he.yixiong:getBoundingBox()
					local p2 = cc.p(bound2.x,bound2.y)
					local m2 = self.he:convertToWorldSpace(p2)

					local juxin1
					local juxin2
					if self.diren[num]:getScaleX() > 0 then
						juxin1 = cc.rect(m.x, m.y, bound.width* math.abs(self.diren[num]:getScaleX()) , bound.height* math.abs(self.diren[num]:getScaleY()))
					else
						juxin1 = cc.rect(m.x - bound.width* math.abs(self.diren[num]:getScaleX()), m.y, bound.width* math.abs(self.diren[num]:getScaleX()) , bound.height* math.abs(self.diren[num]:getScaleY()))
					end

					if self.he:getScaleX() > 0 then
						juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.he:getScaleX()), bound2.height*math.abs(self.he:getScaleY()))
					else
						juxin2 = cc.rect(m2.x - bound2.width*math.abs(self.he:getScaleX()), m2.y, bound2.width*math.abs(self.he:getScaleX()), bound2.height*math.abs(self.he:getScaleY()))
					end
					
					if cc.rectIntersectsRect(juxin1,juxin2) then
						print("碰撞")
						self.diren[num].gongjiChengGong = true
						--敌人减血
						print("敌人减血")
						self.he.xueliang = self.he.xueliang-5
						self.he:setXueLiang()--减血
						if self.he.xueliang <= 0 then
							print("Hero死亡")
							self.he.isDie = true
							self.he:doEvent("death")
						else
							self.he:doEvent("injured")
							self.he.beigongji = true
						end
					end
					
				end
			end
		end
	end
	
end
function GameScene:JiNengYiPengZhuang()
	if self.he.isDie then
		--英雄死亡
	else
		for num=1,#self.diren do
			if math.abs(self.he:getPositionY()-self.diren[num]:getPositionY()) < 30 then
				print("yijineng")
				if self.shape4 ~= nil then
						self.shape4:removeFromParent()
						self.shape4 = nil
				end
				local bound = self.diren[num].yixiong:getBoundingBox()
				local p = cc.p(bound.x,bound.y)
				-- dump(bound)
				local m = self.diren[num]:convertToWorldSpace(p)
				local juxin1
				if self.diren[num]:getScaleX() > 0 then
					juxin1 = cc.rect(m.x - 0.2*bound.width* math.abs(self.diren[num]:getScaleX()) *0.5, m.y + bound.height* math.abs(self.diren[num]:getScaleY())*0.5, bound.width* math.abs(self.diren[num]:getScaleX()) *0.5, bound.height* math.abs(self.diren[num]:getScaleY())*0.5)
				else
					juxin1 = cc.rect(m.x - 0.5*bound.width* math.abs(self.diren[num]:getScaleX()), m.y+bound.height* math.abs(self.diren[num]:getScaleY())*0.5, bound.width* math.abs(self.diren[num]:getScaleX())*0.5 , bound.height* math.abs(self.diren[num]:getScaleY()*0.5))
				end
				-- self.shape4 = display.newRect(juxin1,
			 --        {fillColor = cc.c4f(1,0,0,0.5), borderColor = cc.c4f(0,1,0,1), borderWidth = 1})
				-- self:addChild(self.shape4,50)
				local bound2 = self.he.yixiong:getBoundingBox()
				local p2 = cc.p(bound2.x,bound2.y)
				local m2 = self.he: convertToWorldSpace(p2)
				local juxin2
				if self.he:getScaleX() > 0 then
					juxin2 = cc.rect(m2.x, m2.y, bound2.width*math.abs(self.he:getScaleX()), bound2.height*math.abs(self.he:getScaleY()))
				else
					juxin2 = cc.rect(m2.x - bound2.width*math.abs(self.he:getScaleX()), m2.y, bound2.width*math.abs(self.he:getScaleX()), bound2.height*math.abs(self.he:getScaleY()))
				end
				if cc.rectIntersectsRect(juxin1,juxin2) then
					--英雄随着怪物一起移动
					--



					-- print("碰撞")
					-- 敌人减血
					print("Hero减血")
					--打一次减十点血量
					self.he.xueliang = self.he.xueliang-10
					self.he:setXueLiang()--减血
					if self.he.xueliang <= 0 then
						print("敌人死亡")
						self.he.isDie = true
						self.he:doEvent("death")
					else
						self.he:doEvent("injured")--被攻击，并且进入被攻击状态
						self.he.beigongji = true
					end
				end
			end
		end
	end
end
function GameScene:onEnter()
end

function GameScene:onExit()
	scheduler.unscheduleGlobal(self._schedule)
	scheduler.unscheduleGlobal(self.sc2)
	scheduler.unscheduleGlobal(self.q)
	cc.Director:getInstance():getScheduler():unscheduleAllCallbacks()--关闭所有事件调度
end

return GameScene

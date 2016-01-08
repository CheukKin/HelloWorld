--
-- Author: student
-- Date: 2015-11-18 09:10:22
--
local Enemy = class("Enemy", function()
	return display.newNode()
end)

function Enemy:ctor(a,name,b)
	--技能冷却
	self.jinengLQ1 = 3
    self.jinengLQ2 = 5
    self.jinengLQ3 = 10

	self.hpbj = cc.Sprite:create("img/ui/battleUI/hp.jpg")
	self.hpbj:setPosition(40,300)
	self.hpbj:setScale(1.5)
	self:addChild(self.hpbj)

	self.XueTiao = ccui.LoadingBar:create("img/ui/battleUI/xuetiao-lv.png")
	self.XueTiao:setDirection(2)
	self.XueTiao:setPercent(100);
	self.XueTiao:setPosition(60,308);
	self.XueTiao:setScale(1.5)
    self:addChild(self.XueTiao);

	self.buffzhuangtai = 1     			--buff 状态
	self.xueliang = 100       			--血量
	self.beifenxueliang = self.xueliang
	self.gongjili = 0          			--攻击力
	self.fangyuli = 0         			--防御力  
	self.shanbi = 0 					--闪避   百分比*随机数<80  被攻击到

	self.isBoss = false
	self.isDie = false

	self.beigongji = false

	self.xueliang = 100
	-- self.is
	-- SkeletonRenderer
	-- spine/sp-jiqiren/
	self.yixiong = sp.SkeletonAnimation:create(name .. "skeleton.json", name .. "skeleton.atlas",1)
	
	self:addChild(self.yixiong)
	self.b = b
	if self.b == 1 then
		self.jineng = sp.SkeletonAnimation:create(name .. "skeleton_effect.json", name .. "skeleton_effect.atlas",1)
		self:addChild(self.jineng)
	end

	-- self.sk = sp.SkeletonAnimation:create("spine/effects/huangseguanghuan/huangseguanghuan.json","spine/effects/huangseguanghuan/huangseguanghuan.atlas",1)
 --    self.sk:setAnimation(0,"animation",true)
 --    self:addChild(self.sk)
 	self.sk = display.newSprite("img/comm/juese-yingzi.png"):addTo(self)

	self.isGongJiCiShu = 1
	self.DengDaiGongJiJieSHu = false
	self.isPutSkills = false
 	self:addStateMachine()
 	self.yixiong:registerSpineEventHandler(function (event)
    	-- print(string.format("[spine] %d end:", event.trackIndex))
    	-- dump(event)
    	if event.animation == "skill1" then
    		print("1")
    		self:doEvent("normal")
    		self.isPutSkills = false
    		-- self.jineng:setAnimation(0,"skill1",false)
		elseif event.animation == "skill2" then
			--todo
			self:doEvent("normal")
			self.isPutSkills = false
			-- self.jineng:setAnimation(0,"skill2",false)
		elseif event.animation == "skill3" then
			--todo
			self:doEvent("normal")
			self.isPutSkills = false
		elseif event.animation == "atk1" then
			print("攻击一")
			if self.isGongJiCiShu == 1 then
				self:doEvent("normal")
				self.isPutSkills = false
				self.DengDaiGongJiJieSHu = false
				self.gongjiChengGong = false
				-- scheduler.unscheduleGlobal(self.scheduler)
			else
				print("攻击二")
				-- scheduler.unscheduleGlobal(self.scheduler)
				self:doEvent("attack2")
				self.gongjiChengGong = false
			end
			
		elseif event.animation == "atk2" then
			-- print("攻击二xxzz")
			if self.isGongJiCiShu == 2 then
				self:doEvent("normal")
				self.isPutSkills = false
				self.DengDaiGongJiJieSHu = false
				self.gongjiChengGong = false
				-- scheduler.unscheduleGlobal(self.scheduler)
			else
				-- scheduler.unscheduleGlobal(self.scheduler)
				self.gongjiChengGong = false
				self:doEvent("attack3")
			end
			-- scheduler.unscheduleGlobal(self.scheduler)
		elseif event.animation == "atk3" then
			self:doEvent("normal")
			self.isPutSkills = false
			self.isGongJiCiShu = 1
			self.DengDaiGongJiJieSHu = false
			self.gongjiChengGong = false
			-- scheduler.unscheduleGlobal(self.scheduler)
		elseif event.animation == "floorhurt" then
			self.beigongji = false
			self:doEvent("normal")
			self.isPutSkills = false
			self.gongjiChengGong = false
			self.DengDaiGongJiJieSHu = false
			self.isGongJiCiShu = 1
    	end
    	-- scheduler.unscheduleGlobal(self.scheduler)

   	end, sp.EventType.ANIMATION_COMPLETE)

	-- self.yixiong:registerSpineEventHandler(function (event)
	-- 	if event == "idle" then
	-- 		self
	-- 	end
	-- end, sp.EventType.ANIMATION_START)
end

function Enemy:setPutSkills(a)
	self.isPutSkills = a
end

function Enemy:getPutSkills()
	return self.isPutSkills
end

function Enemy:doEvent(event)
  if self.fsm:canDoEvent(event) then
	  	-- print("aaaa")
	    self.fsm:doEvent(event)
  end
end
function Enemy:addStateMachine()
	self.fsm={}
	cc.GameObject.extend(self.fsm):addComponent("components.behavior.StateMachine"):exportMethods()
	self.fsm:setupState({
		initial="idle",
		events={
			{name ="normal", from={"walk", "run", "atk1", "atk2", "atk3","skill1","skill2","skill3","floorhurt","win"}, to ="idle"},
			{name ="move1",   from={"idle", "run" }, to ="walk"},
			{name ="move2",   from={"idle", "walk"}, to ="run"},
			{name ="attack1", from={"idle", "walk", "run" }, to ="atk1"},  
	    	{name ="attack2", from={"idle", "walk", "run", "atk1"}, to ="atk2"},
			{name ="attack3", from={"idle", "walk", "run", "atk2"}, to ="atk3"},
			{name ="skills1", from={"idle", "walk", "run"}, to ="skill1"},
			{name ="skills2", from={"idle", "walk", "run"}, to ="skill2"},
			{name ="skills3", from={"idle", "walk", "run"}, to ="skill3"},
			{name ="injured", from={"idle", "walk", "run"}, to ="floorhurt"},--被攻击
			{name ="death", from={"idle", "walk", "run", "atk1", "atk2","atk3","skill1","skill2","skill3","floorhurt"}, to ="die"},
			{name ="victory", from={"idle", "walk", "run", "atk1", "atk2"}, to ="win"},
		},
	    callbacks={
	    	onenteridle=function ()
	    		self.yixiong:setAnimation(0,"idle",true)
			end,
	   		onenterwalk = function () 
	     		self.yixiong:setAnimation(0,"walk",true)  
	        end,  
	   		onenterrun = function ()  
	        	self.yixiong:setAnimation(0,"run",true)
	        end,
	        onenteratk1 = function ()  
	        	self.yixiong:setAnimation(0,"atk1",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"atk1",false)
	        	end
	        	
	        	self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenteratk2 = function ()
	        	self.yixiong:setAnimation(0,"atk2",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"atk2",false)
	        	end
	        	
	        	self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenteratk3 = function ()
	        	self.yixiong:setAnimation(0,"atk3",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"atk3",false)
	        	end
	        	
	        	self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenterskill1 = function ()
		        local a1 = cc.DelayTime:create(0.2)
	        	local a2 = cc.MoveBy:create(0.5,cc.p(480*(-self.yixiong:getScaleX()),0))
	        	-- local s = transition.sequence(a1,a2)
	        	local s = cc.Sequence:create(a1,a2,nil)
	        	self:runAction(s)
	        	self.yixiong:setAnimation(0,"skill1",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"skill1",false)
	        	end
	        	
	        	self.isPutSkills = true
	        end,
	        onenterskill2 = function ()
	        	self.yixiong:setAnimation(0,"skill2",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"skill2",false)
	        	end
	        	
	        	self.isPutSkills = true
	        end,
	        onenterskill3 = function ()
	        	self.yixiong:setAnimation(0,"skill3",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"skill3",false)
	        	end
	        	
	        	self.isPutSkills = true
	        end,
	        onenterfloorhurt = function ()
	        	self.yixiong:setAnimation(0,"floorhurt",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"floorhurt",false)
	        	end
	        	
	        end,
	        onenterdie = function ()
		        self.yixiong:clearTracks()
	        	self.yixiong:setAnimation(0,"die",false)
	        	if self.b == 1 then
	        		self.jineng:clearTracks()
	        		self.jineng:setAnimation(0,"die",false)
	        	end
	        	self.XueTiao:removeFromParent()
	        	self.hpbj:removeFromParent()
	        end,
	        onenterwin = function ()
	        	self.yixiong:setAnimation(0,"win",false)
	        	if self.b == 1 then
	        		self.jineng:setAnimation(0,"win",false)
	        	end
	        end,
		}
	})
end

function Enemy:setScaleX(sc)
	self.yixiong:setScaleX(sc)
	if self.b == 1 then
		self.jineng:setScaleX(sc)
	end
	
	self.sk:setScaleX(sc)
end
function Enemy:setXueLiang()
	 self.XueTiao:setPercent(self.xueliang/self.beifenxueliang*100)
end
return Enemy
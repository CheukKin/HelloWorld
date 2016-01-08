--
-- Author: student
-- Date: 2015-11-12 16:24:08
--
local HeroClass = class("HeroClass", function()
	return display.newNode()
end)

function HeroClass:ctor()
-- local XueTiao = cc.ui.UILoadingBar.new({
-- 	    scale9 = true,
-- 	    capInsets = cc.rect(0,0,10,10), -- scale region
-- 	    image =  "img/ui/battleUI/xuetiao-lv.png", -- loading bar image
-- 	    viewRect = cc.rect(0,0,200,32), -- set loading bar rect
-- 	    percent = 100, -- set loading bar percent
-- 	    -- direction = DIRECTION_RIGHT_TO_LEFT
-- 	    direction = DIRECTION_LEFT_TO_RIGHT -- default
-- 	})
-- 	XueTiao:setPosition(200,200)
-- 	self.Map:addChild(XueTiao,100)


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

    
    self.jinengLQ1 = 3
    self.jinengLQ2 = 5
    self.jinengLQ3 = 10

	self.buffzhuangtai = 1     			--buff 状态
	self.xueliang = 100       			--血量
	self.beifenxueliang = self.xueliang --备份血量
	self.gongjili = 0          			--攻击力
	self.fangyuli = 0         			--防御力  
	self.shanbi = 0 					--闪避   百分比*随机数<80  被攻击到

	self.isDie = false
	
	self.beigongji = false
	self.gongjiChengGong = false
	-- self.beijinengYiShangHai
	-- self.is
	-- SkeletonRenderer

	local s = {}
	for i=1,#HeroData.hero do
		if SaveData.selectHero[1].id == HeroData.hero[i].id then
		 	s = HeroData.hero[i]
		end 
	end
-- SaveData.selectHero
	self.yixiong = sp.SkeletonAnimation:create("spine/".. s.model .."/skeleton.json","spine/".. s.model .."/skeleton.atlas",1)
	self.yixiong.debugBones = true
	self.jineng = sp.SkeletonAnimation:create("spine/".. s.model .."/skeleton_effect.json","spine/".. s.model .."/skeleton_effect.atlas",1)
	self:addChild(self.yixiong)
	self:addChild(self.jineng)


	self.sk = sp.SkeletonAnimation:create("spine/effects/huangseguanghuan/huangseguanghuan.json","spine/effects/huangseguanghuan/huangseguanghuan.atlas",1)
    self.sk:setAnimation(0,"animation",true)
    self:addChild(self.sk)

	self.isGongJiCiShu = 1
	self.DengDaiGongJiJieSHu = false
	self.isPutSkills = false
 	self:addStateMachine()
 	-- self:addEventProxy()--监听事件
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
			print("攻击二xxzz")
			if self.isGongJiCiShu == 2 then
				self:doEvent("normal")
				self.isPutSkills = false
				self.DengDaiGongJiJieSHu = false
				self.gongjiChengGong = false
				-- scheduler.unscheduleGlobal(self.scheduler)
			else
				-- scheduler.unscheduleGlobal(self.scheduler)
				self:doEvent("attack3")
				self.gongjiChengGong = false
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

	


	
end

function HeroClass:setPutSkills(a)
	self.isPutSkills = a
end

function HeroClass:getPutSkills()
	return self.isPutSkills
end

function HeroClass:doEvent(event)
  if self.fsm:canDoEvent(event) then
	    self.fsm:doEvent(event)
  end
end
function HeroClass:addStateMachine()
	self.fsm={}
	cc.GameObject.extend(self.fsm):addComponent("components.behavior.StateMachine"):exportMethods()
	self.fsm:setupState({
		initial="idle",
		events={
			{name ="normal", from={ "walk", "run", "atk1", "atk2", "atk3","skill1","skill2","skill3","floorhurt","win"}, to ="idle"},
			{name ="move1",   from={"idle", "run" }, to ="walk"},
			{name ="move2",   from={"idle", "walk"}, to ="run"},
			{name ="attack1", from={"idle", "walk", "run" }, to ="atk1"},  
	    	{name ="attack2", from={"idle", "walk", "run", "atk1"}, to ="atk2"},
			{name ="attack3", from={"idle", "walk", "run", "atk2"}, to ="atk3"},
			{name ="skills1", from={"idle", "walk", "run"}, to ="skill1"},
			{name ="skills2", from={"idle", "walk", "run"}, to ="skill2"},
			{name ="skills3", from={"idle", "walk", "run"}, to ="skill3"},
			{name ="injured", from={"idle", "walk", "run"}, to ="floorhurt"},--被攻击
			{name ="death", from={"idle", "walk", "run", "atk1", "atk2", "atk3", "skill1","skill2","skill3"}, to ="die"},
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
	        	self.jineng:setAnimation(0,"atk1",false)
	        	self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenteratk2 = function ()
	        	self.yixiong:setAnimation(0,"atk2",false)
	        	self.jineng:setAnimation(0,"atk2",false)
	        	self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenteratk3 = function ()
	        	self.yixiong:setAnimation(0,"atk3",false)
	        	self.jineng:setAnimation(0,"atk3",false)
	        	self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenterskill1 = function ()
	        	--先等待一会
	        	local a1 = cc.DelayTime:create(0.2)
	        	local a2 = cc.MoveBy:create(0.5,cc.p(480*(-self.yixiong:getScaleX()),0))
	        	-- local s = transition.sequence(a1,a2)
	        	local s = cc.Sequence:create(a1,a2,nil)
	        	self:runAction(s)
	        	self.yixiong:setAnimation(0,"skill1",false)
	        	self.jineng:setAnimation(0,"skill1",false)
	        	self.isPutSkills = true
	        end,
	        onenterskill2 = function ()
	        	self.yixiong:setAnimation(0,"skill2",false)
	        	self.jineng:setAnimation(0,"skill2",false)
	        	self.isPutSkills = true
	        end,
	        onenterskill3 = function ()
	        	self.yixiong:setAnimation(0,"skill3",false)
	        	self.jineng:setAnimation(0,"skill3",false)
	        	self.isPutSkills = true
	        end,
	        onenterfloorhurt = function ()
	        	self.yixiong:setAnimation(0,"floorhurt",false)

	        end,
	        onenterdie = function ()
	        	self.yixiong:clearTracks()
		        self.jineng:clearTracks()
	        	self.yixiong:setAnimation(0,"die",false)
	        	self.jineng:setAnimation(0,"die",false)
	        end,
	        onenterwin = function ()
	        	self.yixiong:setAnimation(0,"win",false)
	        	self.jineng:setAnimation(0,"win",false)
	        end,
		}
	})

end

function HeroClass:setScaleX(sc)
	self.yixiong:setScaleX(sc)
	self.jineng:setScaleX(sc)
	self.sk:setScaleX(sc)
end

function HeroClass:setXueLiang()
	 self.XueTiao:setPercent(self.xueliang/self.beifenxueliang*100)
end

-- function HeroClass:attack()
--    -- body
--    --播放动画
--    self:setAnimation(0,"idle",true)
-- end
-- function HeroClass:run()
--    -- body
--    --播放动画
--    self:setAnimation(0,"run",true)
-- end
-- function HeroClass:skill1()
--    -- body
--    --播放动画
--    self:setAnimation(0,"atk3",true)

-- end
return HeroClass
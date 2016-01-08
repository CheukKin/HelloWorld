--
-- Author: student
-- Date: 2015-11-18 09:04:57
--
local MyStateMachine = class("MyStateMachine", function()
	return display.newNode()
end)
function MyStateMachine:ctor()
	 self:addStateMachine()
end
function MyStateMachine:doEvent(event)
  if self.fsm:canDoEvent(event) then
	    self.fsm:doEvent(event)
  end
end
function MyStateMachine:addStateMachine()
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
			{name ="death", from={"idle", "walk", "run", "atk1", "atk2"}, to ="die"},
			{name ="victory", from={"idle", "walk", "run", "atk1", "atk2"}, to ="win"},
		},
	    callbacks={
	    	onenteridle=function ()
	    		-- self.yixiong:setAnimation(0,"idle",true)
			end,
	   		onenterwalk = function () 
	     		-- self.yixiong:setAnimation(0,"walk",true)  
	        end,  
	   		onenterrun = function ()  
	        	-- self.yixiong:setAnimation(0,"run",true)
	        end,
	        onenteratk1 = function ()  
	        	-- self.yixiong:setAnimation(0,"atk1",false) 
	        	-- self.jineng:setAnimation(0,"atk1",false)
	        	-- self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenteratk2 = function ()
	        	-- self.yixiong:setAnimation(0,"atk2",false)
	        	-- self.jineng:setAnimation(0,"atk2",false)
	        	-- self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenteratk3 = function ()
	        	-- self.yixiong:setAnimation(0,"atk3",false)
	        	-- self.jineng:setAnimation(0,"atk3",false)
	        	-- self.isPutSkills = true
	        	-- self.scheduler = scheduler.scheduleGlobal(handler(self, self.PengZhuangJianCe),0.1)
	        end,
	        onenterskill1 = function ()
	        	-- self.yixiong:setAnimation(0,"skill1",false)
	        	-- self.jineng:setAnimation(0,"skill1",false)
	        	-- self.isPutSkills = true
	        end,
	        onenterskill2 = function ()
	        	-- self.yixiong:setAnimation(0,"skill2",false)
	        	-- self.jineng:setAnimation(0,"skill2",false)
	        	-- self.isPutSkills = true
	        end,
	        onenterskill3 = function ()
	        	-- self.yixiong:setAnimation(0,"skill3",false)
	        	-- self.jineng:setAnimation(0,"skill3",false)
	        	-- self.isPutSkills = true
	        end,
	        onenterfloorhurt = function ()
	        	-- self.yixiong:setAnimation(0,"floorhurt",false)
	        end,
	        onenterfloordie = function ()
	        	-- self.yixiong:setAnimation(0,"die",false)
	        end,
	        onenterfloorwin = function ()
	        	-- self.yixiong:setAnimation(0,"win",false)
	        end,
		}
	})
end
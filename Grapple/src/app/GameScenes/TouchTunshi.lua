--
-- Author: Your Name
-- Date: 2015-11-20 18:57:35
--

local TouchTunshi = class("TouchTunshi", function()
	-- return display.newColorLayer(cc.c4b(255, 255, 255, 100))
	return display.newLayer()
end)

function TouchTunshi:ctor()
	
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
end
-- function TouchTunshi:init()
-- 	local function touchbegan(location, event)
-- 		return true
-- 	end 
-- 	local listener = cc.EventListenerTouchOneByOne:create()
-- 	local dis = cc.Director:getInstance():getEventDispatcher()
-- 	listener:registerScriptHandler(touchbegan, cc.Handler.EVENT_TOUCH_BEGAN)
-- 	listener:setSwallowTouches(true)
-- 	dis:addEventListenerWithSceneGraphPriority(listener, self)

-- 	self:setTouchEnabled(true)
-- 	self:setTouchSwallowEnabled(true)
-- end

return TouchTunshi
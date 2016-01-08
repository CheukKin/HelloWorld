--
-- Author: student
-- Date: 2015-11-21 15:26:08
--
local ZanTingLayer = class("ZanTingLayer", function()
	-- return display.newLayer()
	return TouchTunshi:new()
end)

function ZanTingLayer:ctor()

	self.shibai = ccui.Button:create("img/comm/anniu_tuichu.png","img/comm/anniu_tuichuover.png")
    self.shibai:setPosition(cc.p(display.cx-150, display.cy))
    self.shibai:setPressedActionEnabled(true)
    self.shibai:addTouchEventListener(function(psender,event)
        if event == 2 then
            print("失败")
            --进入失败页面
            display.resume()
            WinORFai:new(false):addTo(self)
            -- self:setVisible(false)
            -- self.sb = true
            -- self:removeFromParent()
        end
    end)
    self:addChild(self.shibai)

	-- cc.ui.UIPushButton.new({normal = "img/comm/anniu_tuichu.png",pressed = "img/comm/anniu_tuichuover.png"
 --    	},{scale9 = true})
 --        :onButtonClicked(function(event)
 --            print("失败")
 --            --进入失败页面
 --            -- self:removeFromParent()
 --        end)
 --        :pos(display.cx-150, display.cy)
 --        :addTo(self)
    cc.ui.UILabel.new({
            UILabelType = 2, text = "投降", size = 24})
        :align(display.CENTER, display.cx-150, display.cy-80)
        :addTo(self)

	self.isShenYing = SaveData.yingyue
	self.yingxiao = cc.ui.UILabel.new({
            UILabelType = 2, text = "音效：开", size = 24})
        :align(display.CENTER, display.cx, display.cy-80)
        :addTo(self)
    self.shengying = ccui.Button:create("img/comm/anniu_yinxiaokai.png","img/comm/anniu_yinxiaokai.png")
    self.shengying:setPosition(cc.p(display.cx, display.cy))
    self.shengying:setPressedActionEnabled(true)
    self.shengying:addTouchEventListener(function(psender,event)
        if event == 2 then
            print("声音")
            if self.isShenYing then
                psender:loadTextures("img/comm/anniu_yinxiaoguan.png","img/comm/anniu_yinxiaoguan.png")
                self.yingxiao:setString("音效：关")
                SaveData.yingyue = false
                self.isShenYing = false
                audio.pauseMusic()
            else
                psender:loadTextures("img/comm/anniu_yinxiaokai.png","img/comm/anniu_yinxiaokaiover.png")
                self.yingxiao:setString("音效：开")
                SaveData.yingyue = true
                self.isShenYing = true
                audio.resumeMusic()
            end
        end
    end)
    self:addChild(self.shengying)
    -- cc.ui.UIPushButton.new({normal = "img/comm/anniu_yinxiaoguan.png",pressed = "img/comm/anniu_yinxiaoguanover.png"
    -- 	},{scale9 = true})
    --     :onButtonClicked(function(event)
    --     	-- dump(event)
    --         print("声音")
    --         if self.isShenYing then
    --         	event.target:setButtonImage(cc.ui.UIPushButton.NORMAL,"img/comm/anniu_yinxiaoguan.png")
    --         	event.target:setButtonImage(cc.ui.UIPushButton.PRESSED,"img/comm/anniu_yinxiaoguan.png")
    --         	self.yingxiao:setString("音效：关")
    --         	self.isShenYing = false
    --         else
    --         	event.target:setButtonImage(cc.ui.UIPushButton.NORMAL,"img/comm/anniu_yinxiaokai.png")
    --         	event.target:setButtonImage(cc.ui.UIPushButton.PRESSED,"img/comm/anniu_yinxiaokaiover.png")
    --         	self.yingxiao:setString("音效：开")
    --         	self.isShenYing = true
    --         end
    --     end)
    --     :pos(display.cx, display.cy)
    --     :addTo(self)
    
    self.huifu = ccui.Button:create("img/comm/anniu_jixu.png","img/comm/anniu_jixu.png")
    self.huifu:setPosition(cc.p(display.cx+150, display.cy))
    self.huifu:setPressedActionEnabled(true)
    self.huifu:addTouchEventListener(function(psender,event)
        if event == 2 then
            print("恢复")
            display.resume()
            self:removeFromParent()
        end
    end)
    self:addChild(self.huifu)
    -- cc.ui.UIPushButton.new({normal = "img/comm/anniu_jixu.png",pressed = "img/comm/anniu_jixu.png"
    -- 	},{scale9 = true})
    --     :onButtonClicked(function(event)
    --         print("恢复")
    --         display.resume()
    --         self:removeFromParent()
    --     end)
    --     :pos(display.cx+150, display.cy)
    --     :addTo(self)
    cc.ui.UILabel.new({
            UILabelType = 2, text = "继续战斗", size = 24})
        :align(display.CENTER, display.cx+150, display.cy-80)
        :addTo(self)

    

    -- local function touchbegan(location, event)
    --     return false
    -- end
    -- local listener = cc.EventListenerTouchOneByOne:create()
    -- local dis = cc.Director:getInstance():getEventDispatcher()
    -- listener:registerScriptHandler(touchbegan, cc.Handler.EVENT_TOUCH_BEGAN)
    -- listener:setSwallowTouches(true)
    -- dis:addEventListenerWithSceneGraphPriority(listener, self)

    -- self:setTouchEnabled(true)
    -- self:setTouchSwallowEnabled(true)
end

function ZanTingLayer:onEnter()
end

function ZanTingLayer:onExit()
end

return ZanTingLayer
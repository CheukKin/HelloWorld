--
-- Author: student
-- Date: 2015-11-22 11:47:52
--
local WinORFai = class("WinORFai", function()
	-- return display.newLayer()
	return TouchTunshi:new()
end)
function WinORFai:ctor(s,is)
	if is then
		--胜利
		self:initWin()
	else
		--失败
		self:initFai()
	end
end

function WinORFai:initWin()
	anode2=display.newNode()
    anode2:addTo(self)
	local vt=display.newSprite("ShengLi/victory.png")
	:pos(display.cx, display.cy)
	:addTo(anode2)
	local moveto=cc.MoveTo:create(0.5,cc.p(display.cx, display.cy+150))
	vt:runAction(moveto)
    --粒子特效
    self._snow = cc.ParticleGalaxy:create()
    self._snow:setPosition(cc.p(display.cx, display.cy+150))
    self:addChild(self._snow,1,1)


	tab={"通关副本","在2分20秒内通关此副本","剩余血量在10%以上"}
	tab1={"1","1"}
	tab2={"30EXP","30EXP"}
	tab3={"HeroList/touxiang-lvjuren.png","HeroList/touxiang-sishen.png"}
	ailichakaduo={"30","30"}
	tab4={"shop/jinbi.png","shop/baoshi.png"}
	tab5={"521","15"}
	scheduler.performWithDelayGlobal(handler(self, self.tianjia),0.5)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia1),1)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia2),1.5)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia3),2)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia4),3)
	
    scheduler.performWithDelayGlobal(handler(self, self.tianjia6),4)
end

function WinORFai:tianjia( )
	local xingxing=display.newSprite("ShengLi/xiang.png")
	:pos(380, display.cy+70)
	:addTo(anode2)	
end
function WinORFai:tianjia1( )
	local xingxing=display.newSprite("ShengLi/xiang.png")
	:pos(480, display.cy+70)
	:addTo(anode2)	
end
function WinORFai:tianjia2( )
	local xingxing=display.newSprite("ShengLi/xiang.png")
	:pos(580, display.cy+70)
	:addTo(anode2)	
end

function WinORFai:tianjia3( )
anode=display.newNode()
    anode:addTo(self)
	for i=1,3 do
		self.xing=display.newSprite("ShengLi/xiang.png")
	     :pos(display.right, display.cy-52*i)
	     :scale(0.5)
	     :addTo(anode)
	     self.lab=cc.ui.UILabel.new({
        UILabelType = 2,text=tab[i],size=20
        })
        :align(display.LEFT, display.right+20, display.cy-52*i)
        :addTo(anode)
       local moveto1=cc.MoveTo:create(0.5,cc.p(380, display.cy-52*i))
	   self.xing:runAction(moveto1)
	   local moveto2=cc.MoveTo:create(0.5,cc.p(400, display.cy-52*i))
	   self.lab:runAction(moveto2)
	end	
end
function WinORFai:tianjia4( )
	anode1=display.newNode()
    anode1:addTo(self)
	 anode:removeFromParent();
	 for i=1,2 do


	local touxiang=display.newSprite(tab3[i])
	:pos(180+i*200, display.cy-120)
	:addTo(anode1)	
	self.lab1=cc.ui.UILabel.new({
        UILabelType = 2,text=tab1[i],size=20
        })
        :align(display.LEFT, 180+i*200-45, display.cy-120+25)
        :addTo(anode1)
    self.lab2=cc.ui.UILabel.new({
        UILabelType = 2,text=tab2[i],size=20
        })
        :align(display.LEFT, 180+i*200+60, display.cy-120-30)
        :addTo(anode1)
        --进度条背景
    local pro=display.newSprite("ShengLi/xuetiao-di.png")
    :scale(0.4)
    :addTo(anode1)
    pro:setPosition(cc.p(180+i*200+100,display.cy-120-30+20))
    
    --进度条
    local timer = cc.ProgressTimer:create(cc.Sprite:create("ShengLi/xuetiao.png"))
    timer:setPosition(cc.p(180+i*200+100,display.cy-120-30+20))
    timer:setBarChangeRate(cc.p(1,0))
    timer:setScale(0.4)
    timer:setType(display.PROGRESS_TIMER_BAR)
    timer:setMidpoint(cc.p(0,0.5))--基准点
    timer:setPercentage(ailichakaduo[i])
    timer:addTo(anode1)
	end
	for j=1,2 do
		local jinbi= display.newSprite(tab4[j])
	:pos(180+j*200, display.cy)
	:addTo(anode1)
	local shuzi=cc.ui.UILabel.new({
        UILabelType = 2,text=tab5[j],size=20
        })
        :align(display.LEFT, 180+j*200+40, display.cy)
        :addTo(anode1)
	end
	

end

function WinORFai:tianjia6( )
    anod=display.newNode()
    anod:addTo(self)
    anode1:removeFromParent()
    anode2:setVisible(false)
    self._snow:setVisible(false)

    local anniu3 = ccui.Button:create("ShengLi/baoxiang-jin.png","ShengLi/baoxiang-jin.png"):addTo(anod)
    anniu3:addTouchEventListener(function(p,e)
    	if e == 2 then
    		self._snow:setVisible(true)
           local vtt1=display.newSprite("ShengLi/baoxiang-jinopen.png")
            :pos(display.cx, display.cy+150)
            :addTo(anod)  
            local vtt1=display.newSprite("ShengLi/jingyan1.png")
            :pos(display.cx-150, display.cy-150)
            :addTo(anod)  
            
            local vtt2=display.newSprite("ShengLi/zhuangbei_di.png")
            :pos(display.cx, display.cy-150)
            :addTo(anod) 
            local vtt2=display.newSprite("ShengLi/wuqi1-icon.png")
            :pos(display.cx, display.cy-150)
            :addTo(anod) 
             
            local vtt3=display.newSprite("ShengLi/zhuangbei_di.png")
            :pos(display.cx+150, display.cy-150)
            :addTo(anod)
            local vtt3=display.newSprite("ShengLi/xianglian1-icon.png")
            :pos(display.cx+150, display.cy-150)
            :addTo(anod)
            scheduler.performWithDelayGlobal(handler(self, self.tianjia5),2)
            -- self:tianjia5()
            anniu3:removeFromParent() 
    	end
    end)
    anniu3:setPosition(display.cx,display.cy+150)
-- local function touchBegan(location,event)
    
--         return true
--     end
--     local listener=cc.EventListenerTouchOneByOne:create()
--     local dispatcher=cc.Director:getInstance():getEventDispatcher()       
--     -- listener:setTouchEnabled(true)
--     listener:setSwallowTouches(true)
--     listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_BEGAN)  
--     dispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    
        
end
function WinORFai:tianjia5( )
    anod:removeFromParent()
    anode2:setVisible(true)
    self._snow:setVisible(true)
    local anniu1=cc.ui.UIPushButton.new({normal="shop/anniu1.png",
        pressed="shop/anniu1.png"},
        {scale9=true})
        :scale(0.5)
        self:addChild(anniu1)
        anniu1:onButtonClicked(function()
                print(1)
        end)
        anniu1:setPosition(display.cx-100,display.cy)
        
    
    local anniu2=cc.ui.UIPushButton.new({normal="shop/anniu1.png",
        pressed="shop/anniu1.png"},
        {scale9=true})
    :scale(0.5)
        anniu2:onButtonClicked(function()
                print(2)
    end)
    anniu2:setPosition(display.cx+100,display.cy)
    self:addChild(anniu2)


    local anniu3=cc.ui.UIPushButton.new({normal="shop/anniu1.png",
        pressed="shop/anniu1.png"},
        {scale9=true})
    :scale(0.5)
        anniu3:onButtonClicked(function()
                print(3)
    end)
    anniu3:setPosition(display.cx+400,display.cy-250)
    self:addChild(anniu3)
    local lab10=cc.ui.UILabel.new({
        UILabelType = 2,text="再来一次",size=20
        })
        :align(display.CENTER, display.cx-100, display.cy)
        :addTo(self)
    local lab11=cc.ui.UILabel.new({
        UILabelType = 2,text="下一关",size=20
        })
        :align(display.CENTER, display.cx+100, display.cy)
        :addTo(self)
    local lab12=cc.ui.UILabel.new({
        UILabelType = 2,text="返回地图",size=20
        })
        :align(display.CENTER, display.cx+400,display.cy-250)
        :addTo(self)
     self:addChild(anode2)


end

function WinORFai:initFai()
	local bg = cc.Sprite:create("ffff/failure.png")
	bg:setAnchorPoint(cc.p(0.5, 0.5))
	bg:setPosition(cc.p(477, 0))
	bg:addTo(self)
	-- bg:runAction(cc.FlipY:create(504))

	local moveBy = cc.MoveBy:create(2.0, cc.p(0, 504))
	-- local callF = cc.CallFunc:create(WinLayer:init1())
	local callFN = cc.CallFunc:create(function()
		self:init()
	end)
	local seq = cc.Sequence:create(moveBy, callFN)
	bg:runAction(seq)

	local pa = cc.ParticleSnow:create()
	self:addChild(pa)
end

function WinORFai:init()
	local layer = cc.uiloader:load("ffff/failureLayer.csb")
	:addTo(self)
	local jinengBtn = layer:getChildByName("jinengBtn")
	jinengBtn:addTouchEventListener(function(pSender,event)
		-- 跳转技能层
		if event == 2 then
			print("技能")
		end
	end)
	local qianghuaBtn = layer:getChildByName("qianghuaBtn")
	qianghuaBtn:addTouchEventListener(function(pSender,event)
		-- 跳转强化人物层
		print("强化")
	end)
	local againBtn = layer:getChildByName("againBtn")
	againBtn:addTouchEventListener(function(pSender,event)
		-- 再次挑战
		print("再次挑战")
        local scene = GameScene.new()
        cc.Director:getInstance():replaceScene(scene)
        -- cc.Director:getInstance():replaceScene()
	end)
	local backmapBtn = layer:getChildByName("backmapBtn")
	backmapBtn:addTouchEventListener(function(pSender,event)
		-- 返回地图
		print("返回地图")
        local scene = MainScene.new()
        cc.Director:getInstance():replaceScene(scene)
		-- display.replaceScene(require("app.scenes.TileMapScene"):new())
		-- cc.Director:getInstance():replaceScene(require("app.scenes.TileMapScene"))
	end)
end
function WinORFai:onEnter()
end

function WinORFai:onExit()
end

return WinORFai
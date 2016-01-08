--
-- Author: zdl
-- Date: 2015-11-20 14:00:19
--
local ShengLi = class("ShengLi", function()
	return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)

function ShengLi:ctor()
local anod
local anode	
local anode1
local anode2	
   
 --    local function touchbegan( location,event )
 --        return true
 --    end 
 --    local listener = cc.EventListenerTouchOneByOne:create()
 --    local dis = cc.Director:getInstance():getEventDispatcher()
 --    listener:registerScriptHandler(touchbegan,cc.Handler.EVENT_TOUCH_BEGAN)
 --    listener:setSwallowTouches(true)
 --    dis:addEventListenerWithSceneGraphPriority(listener, self)

	-- self:setTouchEnabled(true)
	-- self:setTouchSwallowEnabled(true)
	-- self:setContentSize(cc.size(display.width,display.height))
	self:init()
end
function ShengLi:init()
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
tab3={"ShengLi/touxiang-lvjuren.png","ShengLi/touxiang-sishen.png"}
ailichakaduo={"30","30"}
tab4={"ShengLi/jinbi.png","ShengLi/baoshi.png"}
tab5={"521","15"}
	scheduler.performWithDelayGlobal(handler(self, self.tianjia),0.5)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia1),1)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia2),1.5)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia3),2)
	scheduler.performWithDelayGlobal(handler(self, self.tianjia4),3)
	
    scheduler.performWithDelayGlobal(handler(self, self.tianjia6),4)
    
	
    

end
function ShengLi:tianjia( )
	local xingxing=display.newSprite("ShengLi/xiang.png")
	:pos(380, display.cy+70)
	:addTo(anode2)	
end
function ShengLi:tianjia1( )
	local xingxing=display.newSprite("ShengLi/xiang.png")
	:pos(480, display.cy+70)
	:addTo(anode2)	
end
function ShengLi:tianjia2( )
	local xingxing=display.newSprite("ShengLi/xiang.png")
	:pos(580, display.cy+70)
	:addTo(anode2)	
end

function ShengLi:tianjia3( )
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
function ShengLi:tianjia4( )
	anode1=display.newNode()
    anode1:addTo(self)
	anode:removeFromParent();
	local i=1


        local touxiang=display.newSprite(tab3[i])
        	:pos(display.cx, display.cy-120)
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

function ShengLi:tianjia6( )
    anod=display.newNode()
    anod:addTo(self)
    anode1:removeFromParent()
    anode2:setVisible(false)
    self._snow:setVisible(false)
   local anniu3=cc.ui.UIPushButton.new({normal="ShengLi/baoxiang-jin.png",
        pressed="ShengLi/baoxiang-jin.png"},
        {scale9=true})
     :addTo(anod)
     anniu3:onButtonClicked(function()
        self._snow:setVisible(true)
           local vtt1=display.newSprite("ShengLi/baoxiang-jinopen.png")
            :pos(display.cx, display.cy+150)
            :addTo(anod)
            local n = math.random(1,4)
            local vtt1=display.newSprite("img/icon/item/jingyan".. n ..".png")
            :pos(display.cx-150, display.cy-150)
            :addTo(anod)
            
            local vtt2=display.newSprite("ShengLi/zhuangbei_di.png")
            :pos(display.cx, display.cy-150)
            :addTo(anod)

            n = math.random(1,3)
            local vtt2 --=display.newSprite("ShengLi/kuzi5-icon.png")
            if n == 1 then
                n = math.random(1,4)
                vtt2=display.newSprite("img/icon/equip/shoutao".. n .."-icon.png")
            elseif n == 2 then
                n = math.random(1,4)
                vtt2=display.newSprite("img/icon/equip/kuzi".. n .."-icon.png")
            elseif n == 3 then
                n = math.random(1,4)
                vtt2=display.newSprite("img/icon/equip/wuqi".. n .."-icon.png")
            end
            -- local vtt2=display.newSprite("ShengLi/wuqi1-icon.png")
            vtt2:pos(display.cx, display.cy-150)
            vtt2:addTo(anod)
            SaveData.haveZhuangbei[#SaveData.haveZhuangbei+1] = {id = 10000+math.random(1,24),isZhuangBei = 0,isShei = 0,isLeiXing = 0}
             
            local vtt3=display.newSprite("ShengLi/zhuangbei_di.png")
            :pos(display.cx+150, display.cy-150)
            :addTo(anod)
            local vtt3--=display.newSprite("ShengLi/xianglian1-icon.png")
            n = math.random(1,3)
            if n == 1 then
                n = math.random(1,4)
                vtt3=display.newSprite("img/icon/equip/xianglian".. n .."-icon.png")
            elseif n == 2 then
                n = math.random(1,4)
                vtt3=display.newSprite("img/icon/equip/xiezi".. n .."-icon.png")
            elseif n == 3 then
                n = math.random(1,4)
                vtt3=display.newSprite("img/icon/equip/yifu".. n .."-icon.png")
            end
            vtt3:pos(display.cx+150, display.cy-150)
            vtt3:addTo(anod)
            scheduler.performWithDelayGlobal(handler(self, self.tianjia5),2)
            -- self:tianjia5()
            anniu3:removeFromParent() 
            --让自己增加装备
            SaveData.haveZhuangbei[#SaveData.haveZhuangbei+1] = {id = 10000+ math.random(1,24),isZhuangBei = 0,isShei = 0,isLeiXing = 0}
            -- SaveData.haveZhuangbei
            -- table.insert(SaveData.haveZhuangbei, 1)
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
function ShengLi:tianjia5( )
    anod:removeFromParent()
    anode2:setVisible(true)
    self._snow:setVisible(true)
    local anniu1=cc.ui.UIPushButton.new({normal="ShengLi/anniu1.png",
                    pressed="ShengLi/anniu1.png"},
                    {scale9=true})
                    :scale(0.5)
    self:addChild(anniu1)
    anniu1:onButtonClicked(function()
        print("再来一次")
        local scene = GameScene.new()
        cc.Director:getInstance():replaceScene(scene)
    end)
    anniu1:setPosition(display.cx-100,display.cy)
        
    
    local anniu2=cc.ui.UIPushButton.new({normal="ShengLi/anniu1.png",
        pressed="ShengLi/anniu1.png"},
        {scale9=true})
    :scale(0.5)
    anniu2:onButtonClicked(function()
        print("下一关")
        --让关卡标识加一并解锁
        if ShenJiData.FuBen == 2 then
            if ShenJiData.GuanKa ~= 4 then
                ShenJiData.FuBen = 1
                ShenJiData.GuanKa = ShenJiData.GuanKa + 1
                SaveData.guanqia[ShenJiData.GuanKa][ShenJiData.FuBen].lock = 1
            else
                ShenJiData.FuBen = 4
                ShenJiData.GuanKa = 2
            end
        end
        local scene = GameScene.new()
        cc.Director:getInstance():replaceScene(scene)
    end)
    anniu2:setPosition(display.cx+100,display.cy)
    self:addChild(anniu2)


    local anniu3=cc.ui.UIPushButton.new({normal="ShengLi/anniu1.png",
        pressed="ShengLi/anniu1.png"},
        {scale9=true})
    :scale(0.5)
    anniu3:onButtonClicked(function()
        print("返回地图")
        if ShenJiData.FuBen == 2 then
            if ShenJiData.GuanKa ~= 4 then
                ShenJiData.FuBen = 1
                ShenJiData.GuanKa = ShenJiData.GuanKa + 1
                print("g = "..ShenJiData.GuanKa .. "  f = "..ShenJiData.FuBen)
                SaveData.guanqia[ShenJiData.GuanKa][ShenJiData.FuBen].lock = 1
                print("···" .. guanqia[ShenJiData.GuanKa][ShenJiData.FuBen].lock)
            else
                ShenJiData.FuBen = 4
                ShenJiData.GuanKa = 2
            end
        else
            ShenJiData.FuBen = ShenJiData.FuBen + 1
            SaveData.guanqia[ShenJiData.GuanKa][ShenJiData.FuBen].lock = 1
        end
        local scene = MainScene.new()
        cc.Director:getInstance():replaceScene(scene)
    end)
    anniu3:setPosition(display.cx+300,display.cy)
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
        :align(display.CENTER, display.cx+300,display.cy)
        :addTo(self)
    self:addChild(anode2)


end

return ShengLi
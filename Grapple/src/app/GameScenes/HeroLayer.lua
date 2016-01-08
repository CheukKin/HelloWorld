--
-- Author: student
-- Date: 2015-11-12 20:47:15
--
local HeroLayer = class("HeroLayer", function()
        return display.newLayer()
end)

function HeroLayer:ctor()

    
-- local xiaoyingxiong
--右上角英雄的名字
local label2
--状态条
local timer
--大框字体
local label5
     self:init()
end


function HeroLayer:init()
    heroLabel = HeroData.hero
-- --右上角英雄名字的背景图片
    local kuang=display.newSprite(ResManager.HeroLayer.kuang)
    kuang:setPosition(cc.p(display.cx+300,display.cy+250))
    kuang:setScale(0.7)
    self:addChild(kuang)

    local dakuang=display.newSprite(ResManager.HeroLayer.dadikuang)
    dakuang:setPosition(cc.p(display.cx+300,display.cy+120))
    self:addChild(dakuang)

    

-- --确认按钮
    self.anniu=cc.ui.UIPushButton.new({normal=ResManager.HeroLayer.anniu1,
        pressed=ResManager.HeroLayer.anniu1},
        {scale9=true})
    :onButtonClicked(function ()
        SaveData.selectHero[1] = {zhiwei = 1 , id = 6,level = 1, jinyan = 5,yifu = 0,wuqi = 0,kuzi = 0,shoutao = 0,xianglian = 0,xiezi = 0}
        local scene = require("app.scenes.MainScene") .new()
        local turn = cc.TransitionPageTurn:create(1, scene, false)
        cc.Director:getInstance():replaceScene(turn)
        self.save()

    end)
    :pos(display.cx,display.cy-200)
    :scale(0.7)
    :addTo(self)

    self.label4=cc.ui.UILabel.new({
        UILabelType = 2,text="确认",size=20
        })
        :align(display.CENTER, display.cx, display.cy-200)
    self:addChild(self.label4)

-- --返回按钮
	local cancal=cc.ui.UIPushButton.new({normal=ResManager.HeroLayer.fanhui,
		pressed=ResManager.HeroLayer.fanhui},
		{scale9=true})
	:onButtonClicked(function ()

            local scene = require("app.scenes.StartGame").new()
            cc.Director:getInstance():replaceScene(scene)
            self:save()
    end)
    :pos(display.cx-360,display.cy+240)
    :addTo(self)

    self:xuanze()
    cancal:setTouchEnabled(true)

    	--面板上的左右箭头
	local jiantou1=cc.ui.UIPushButton.new({normal=ResManager.HeroLayer.leftJiantou,
		pressed=ResManager.HeroLayer.leftJiantou},
		{scale9=true})
			:onButtonClicked(function (event)
                
                label2:removeFromParent()
                timer:removeFromParent()
                label5:removeFromParent()

            num=num-1
            if num==0 then
            	num=4
            end
            self:xuanze()        
            end)
            :pos(display.cx-180,display.cy)
            :addTo(self)
    local jiantou2=cc.ui.UIPushButton.new({normal=ResManager.HeroLayer.rightJiantou,
    	pressed=ResManager.HeroLayer.rightJiantou},
		{scale9=true})
			:onButtonClicked(function (event)

                label2:removeFromParent()
                timer:removeFromParent()
                label5:removeFromParent()

            num=num+1
            if num==5 then
            	num=1
            end
            self:xuanze()
                    
            end)
            :pos(display.cx+180,display.cy)
            :addTo(self)


end
function HeroLayer:xuanze()

local tab={"力量","体质","敏捷","专注","智力"}

local ailichakaduo={20,30,50,40,90}
local jishucao={70,40,30,60,50}
local shanshiji={90,40,50,40,20}
local lvzai={80,70,20,50,30}

    for i=1,5 do
    	local label1=cc.ui.UILabel.new({
    	UILabelType = 2,text=tab[i],size=20
    	})
    label1:setPosition(cc.p(display.cx-450,display.cy-30*i))
    self:addChild(label1,3)
    --进度条背景
    local pro=display.newSprite(ResManager.HeroLayer.xuetiaodi)
    pro:setPosition(cc.p(display.cx-450+130,display.cy-30*i))
    self:addChild(pro)

    
    end

	if num==1 then
            rennumid = 5
            node4:setVisible(false)
            node2:setVisible(false)
            node3:setVisible(false)
            node1:setVisible(true)
            local sp = node1:getChildByTag(1001)
            sp:setAnimation(0,"atk1",false)

            transition.scaleTo(bg,{time = 0.2,scale = 1.2})
            transition.moveTo(bg, {time = 0.2,y =200,x =700})
            transition.scaleTo(node1, {time = 0.2,scale = 1.8})  
            transition.moveTo(node1, {time = 0.2,y =200,x =550})

            self.anniu:setTouchEnabled(false)
            self.label4:setString("请购买")
        --大框字体
        
     

        label5=cc.ui.UILabel.new({
        UILabelType = 2,
        size=16
        })
        :pos(display.cx+220, display.cy+140)
        self:addChild(label5,3)



        label2=cc.ui.UILabel.new({
        UILabelType = 2,size=20
        })
        :align(display.CENTER, display.cx+300, display.cy+250)
        self:addChild(label2,3)

        if heroLabel~=nil then
            for i,v in ipairs(heroLabel) do
                if heroLabel[i].id == rennumid then
                   label5:setString(heroLabel[i].IntelligenceDevelopment)
                   label2:setString(heroLabel[i].name)
                end
            end
        end
for j=1,5 do
--进度条
    timer = cc.ProgressTimer:create(cc.Sprite:create(ResManager.HeroLayer.xuetiao))
    timer:setPosition(cc.p(display.cx-450+130,display.cy-30*j))
    timer:setBarChangeRate(cc.p(1,0))
    timer:setType(display.PROGRESS_TIMER_BAR)
    timer:setMidpoint(cc.p(0,0.5))--基准点
    timer:setPercentage(ailichakaduo[j])
    timer:addTo(self)
end
    
    elseif num==2 then

        rennumid = 6

        node1:setVisible(false)
        node4:setVisible(false)
        node3:setVisible(false)
        node2:setVisible(true)
        local sp = node2:getChildByTag(1002)
        sp:setAnimation(0,"atk2",false)

        transition.scaleTo(bg,{time = 0.2,scale = 1.2})
        transition.moveTo(bg, {time = 0.2,y =220,x =100})
        transition.scaleTo(node2, {time = 0.2,scale = 1.8 })  
        transition.moveTo(node2, {time = 0.2,y =220,x =500})

        self.anniu:setTouchEnabled(true)
        self.label4:setString("确认")

        label5=cc.ui.UILabel.new({
        UILabelType = 2,
        size=16
        })
        :pos(display.cx+220, display.cy+120)
        self:addChild(label5,3)

        label2=cc.ui.UILabel.new({
        UILabelType = 2,size=20
        })
    :align(display.CENTER, display.cx+300, display.cy+250)
    self:addChild(label2,3)
           if heroLabel~=nil then
            for i,v in ipairs(heroLabel) do
                if heroLabel[i].id ==  rennumid  then
                   label5:setString(heroLabel[i].IntelligenceDevelopment)
                   label2:setString(heroLabel[i].name)
                end
            end
        end

for a=1,5 do
    timer = cc.ProgressTimer:create(cc.Sprite:create(ResManager.HeroLayer.xuetiao))
    timer:setPosition(cc.p(display.cx-450+130,display.cy-30*a))
    timer:setBarChangeRate(cc.p(1,0))
    timer:setType(display.PROGRESS_TIMER_BAR)
    timer:setMidpoint(cc.p(0,0.5))--基准点
    timer:setPercentage(jishucao[a])
    timer:addTo(self)
end

    elseif num==4 then
        rennumid = 8
        node1:setVisible(false)
        node2:setVisible(false)
        node4:setVisible(false)
        node3:setVisible(true)
        local sp = node3:getChildByTag(1003)
        sp:setAnimation(0,"atk3",false)

        transition.scaleTo(bg,{time = 0.2,scale = 1.2})
        transition.moveTo(bg, {time = 0.2,y =400,x =900})
        transition.scaleTo(node3, {time = 0.2,scale = 1.8}) 
        transition.moveTo(node3, {time = 0.2,y =200,x =500})

        self.anniu:setTouchEnabled(false)
        self.label4:setString("请购买")

        label5=cc.ui.UILabel.new({
        UILabelType = 2,
        size=16
        })
        :pos(display.cx+220, display.cy+120)
        self:addChild(label5,3)

        label2=cc.ui.UILabel.new({
        UILabelType = 2,size=20
        })
    :align(display.CENTER, display.cx+300, display.cy+250)
    self:addChild(label2,3)
      if heroLabel~=nil then
            for i,v in ipairs(heroLabel) do
                if heroLabel[i].id ==  rennumid  then
                   label5:setString(heroLabel[i].IntelligenceDevelopment)
                   label2:setString(heroLabel[i].name)
                end
            end
        end

for b=1,5 do
    timer = cc.ProgressTimer:create(cc.Sprite:create(ResManager.HeroLayer.xuetiao))
    timer:setPosition(cc.p(display.cx-450+130,display.cy-30*b))
    timer:setBarChangeRate(cc.p(1,0))
    timer:setType(display.PROGRESS_TIMER_BAR)
    timer:setMidpoint(cc.p(0,0.5))--基准点
    timer:setPercentage(shanshiji[b])
    timer:addTo(self)
end

    elseif num==3 then
        rennumid = 4
        node1:setVisible(false)
        node2:setVisible(false)
        node3:setVisible(false)
        node4:setVisible(true)
        local sp = node4:getChildByTag(1004)
        sp:setAnimation(0,"atk2",false)
        transition.scaleTo(bg,{time = 0.2,scale = 1.2})
        transition.moveTo(bg, {time = 0.2,y =400,x =100})
        transition.scaleTo(node4, {time = 0.2,scale = 1.8})  
        transition.moveTo(node4, {time = 0.2,y =180,x =530})

        self.anniu:setTouchEnabled(false)
        self.label4:setString("请购买")

        label5=cc.ui.UILabel.new({
        UILabelType = 2,
        size=16
        })
        :pos(display.cx+220, display.cy+120)
        self:addChild(label5,3)

        label2=cc.ui.UILabel.new({
        UILabelType = 2,size=20
        })
    :align(display.CENTER, display.cx+300, display.cy+250)
    self:addChild(label2,3)
        if heroLabel~=nil then
            for i,v in ipairs(heroLabel) do
                if heroLabel[i].id ==  rennumid  then
                   label5:setString(heroLabel[i].IntelligenceDevelopment)
                   label2:setString(heroLabel[i].name)
                end
            end
        end

for c=1,5 do
    timer = cc.ProgressTimer:create(cc.Sprite:create(ResManager.HeroLayer.xuetiao))
    timer:setPosition(cc.p(display.cx-450+130,display.cy-30*c))
    timer:setBarChangeRate(cc.p(1,0))
    timer:setType(display.PROGRESS_TIMER_BAR)
    timer:setMidpoint(cc.p(0,0.5))--基准点
    timer:setPercentage(lvzai[c])
    timer:addTo(self)
end

	end

    


	
end
function HeroLayer:save()
       -- local tb = PublicData.SelectHero
      --  tb.id = rennumid
        print("JFKDSJDFKLFJDSKLFJKLJF:" .. rennumid)
       -- local str = json.encode(tb)
        --SaveData.writeSelectToDoc(str)
end

return HeroLayer
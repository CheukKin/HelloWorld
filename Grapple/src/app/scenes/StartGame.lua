--
-- Author: student
-- Date: 2015-11-10 15:15:56
--
local StartGame = class("StartGame", function()
    return display.newScene("StartGame")
end)

function StartGame:ctor()
    -- local xiaoyingxiong
    print("StartGame+++++++++++++++++++++")
--右上角英雄的名字
local label2
--状态条
local timer
--大框字体
local label5
     self:init()
end

function StartGame:init()
    --背景音乐
    audio.playMusic("data/music/bg/a_chuangjue.mp3", true)
    --背景

    bg = display.newSprite(ResManager.Gamescene.bg)
    local scaleX = display.width/bg:getContentSize().width
    local scaleY = display.height/bg:getContentSize().height
    bg :setScaleX(scaleX)
    bg:setScaleY(scaleY)
    bg:pos(display.cx, display.cy)
    self:addChild(bg)

    node1 = cc.Node:create()
    node2 = cc.Node:create()
    node3 = cc.Node:create()
    node4 = cc.Node:create()

--艾丽
    local skeletonNode1 = sp.SkeletonAnimation:create("login/xiaonvhai/skeleton.json", "login/xiaonvhai/skeleton.atlas",0.5) --Spine动画对象
    skeletonNode1:setAnimation(0,"idle",true)
    skeletonNode1:addTo(node1)
    skeletonNode1:setTag(1001)
    node1:setPosition(cc.p(display.cx-150,display.cy-30))
    node1:addTo(self)
    node1:setScaleX(-1)

--技术草
    local skeletonNode2 = sp.SkeletonAnimation:create("login/jishucao/skeleton.json", "login/jishucao/skeleton.atlas",0.5)
    skeletonNode2:setAnimation(0,"idle",true)
    skeletonNode2:addTo(node2)
    skeletonNode2:setTag(1002)
    node2:setPosition(cc.p(display.cx+150,display.cy))
    node2:addTo(self)

--路飞
    
    local skeletonNode3 = sp.SkeletonAnimation:create("login/lufei/skeleton.json", "login/lufei/skeleton.atlas",0.5)
    skeletonNode3:setAnimation(0,"idle",true)
    skeletonNode3:addTo(node3)
    skeletonNode3:setTag(1003)
    node3:setPosition(cc.p(display.cx-220,display.cy-180))  
    node3:addTo(self)
    node3:setScaleX(-1)


--浩克        

    local skeletonNode4 = sp.SkeletonAnimation:create("login/lvjuren/skeleton.json", "login/lvjuren/skeleton.atlas",0.5)
    skeletonNode4:setAnimation(0,"idle",true)
    skeletonNode4:addTo(node4)
    skeletonNode4:setTag(1004)
    node4:setPosition(cc.p(display.cx+200,display.cy-200))
    node4:addTo(self)

    
     local function touchBegan(location,event)
        local p=location:getLocation()
         print(p.x,p.y)
        if 280<p.x and p.x<420 and 270<p.y and p.y<530 then
          --艾丽
             num=1
             print(" ++++++++++++++++++".. num)
             self:click()
        
        elseif 623<p.x and p.x<676 and 314<p.y and p.y<550 then
          --技术草
             num=2
                 print(" ++++++++++++++++++".. num)
             self:click()
        elseif 250<p.x and p.x<300 and 172<p.y and p.y<292 then
          --路飞
             num=4
                 print(" ++++++++++++++++++".. num)
             self:click()
        elseif 600<p.x and p.x<778 and 102<p.y and p.y<265 then
             --浩克
             num=3

                 print(" ++++++++++++++++++".. num)
             self:click()

        end
        return true  
    end      

    listener=cc.EventListenerTouchOneByOne:create()
    dispatcher=cc.Director:getInstance():getEventDispatcher()       
    listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_BEGAN)  
    dispatcher:addEventListenerWithSceneGraphPriority(listener, self)



    -- if #SaveData.selectHero==0 then
    -- local docpath = cc.FileUtils:getInstance():getWritablePath().."SelectHerodata.txt"
    -- if cc.FileUtils:getInstance():isFileExist(docpath)==false then
    --     local str = json.encode(SaveData.selectHero)
    --     SaveData.writeSelectToDoc(str)
    --    PublicData.SelectHero = SaveData.selectHero
    -- else
    --     local str = SaveData.readSelectFromDoc()
    --      PublicData.selectHero = json.decode(str)
    -- end
-- end

end
function StartGame:click()

    local layer1= require("app.GameScenes.HeroLayer").new()
    self:addChild(layer1)
    
    dispatcher:removeEventListener(listener)
                                              
                            
end





function StartGame:onEnter()
end

function StartGame:onExit()
end

return StartGame
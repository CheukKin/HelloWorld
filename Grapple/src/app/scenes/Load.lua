--
-- Author: zdl
-- Date: 2015-11-27 10:21:44
--
local Load = class("Load", function()
    return display.newScene("Load")
end)

function Load:ctor()
    
    
    print("Load++++++++++++++")

	local bg=display.newSprite("load.png"):pos(display.cx, display.cy):addTo(self)
	--进度条背景
    local pro=display.newSprite("jindutiaoBG.png")
    pro:setPosition(cc.p(display.cx,display.cy-200))
    self:addChild(pro)
    --进度条
    self.timer = cc.ProgressTimer:create(cc.Sprite:create("jindutiao.png"))
    self.timer:setPosition(cc.p(display.cx,display.cy-200))
    self.timer:setBarChangeRate(cc.p(1,0))
    self.timer:setType(display.PROGRESS_TIMER_BAR)
    self.timer:setMidpoint(cc.p(0,0.5))--基准点
    self.timer:setPercentage(0)
    self.timer:addTo(self)


    self.c = scheduler.scheduleGlobal(handler(self, self.up),0.2)

 --    local progress =cc.ProgressTo:create(0.7, 100)
 --    local call=cc.CallFunc:create(function()
 --    	print("加载完成跳转页面")
 --        -- if conditions then
 --        --     --todo
 --        -- end
 --        if #SaveData.selectHero == 0 then
 --            local docpath = cc.FileUtils:getInstance():getWritablePath() .. "hero.txt"
 --            if cc.FileUtils:getInstance():isFileExist(docpath)==false then
 --                local scene = StartGame.new()
 --                cc.Director:getInstance():replaceScene(scene)
 --            else
 --                local scene = MainScene.new()
 --                local turn = cc.TransitionPageTurn:create(1, scene, false)
 --                cc.Director:getInstance():replaceScene(turn)
 --            end
 --        end
		
	-- end)

 --    local seq=cc.Sequence:create(progress,call)

    self.count = 0
	-- timer:runAction(seq)

end
function Load:up(dt)
    self.count = self.count + 1
    self.timer:setPercentage(self.count/12*100)

    if self.count == 2 then
        audio.preloadMusic("data/music/bg/a_chooselevel.mp3")
    elseif self.count == 4 then
        audio.preloadMusic("data/music/bg/a_chuangjue.mp3")
    elseif self.count == 6 then
        audio.preloadMusic("data/music/bg/a_gulangyumusic.mp3")
    elseif self.count == 8 then
        audio.preloadMusic("data/music/bg/a_shamomusic.mp3")
    elseif self.count == 10 then
        audio.preloadMusic("data/music/bg/a_yechangmusic.mp3")
    elseif self.count == 12 then
        audio.preloadMusic("data/music/bg/a_yueyemusic.mp3")
        if #SaveData.selectHero == 0 then
            local docpath = cc.FileUtils:getInstance():getWritablePath() .. "hero.txt"
            if cc.FileUtils:getInstance():isFileExist(docpath)==false then
                local scene = StartGame.new()
                cc.Director:getInstance():replaceScene(scene)
            else
                local scene = MainScene.new()
                local turn = cc.TransitionPageTurn:create(1, scene, false)
                cc.Director:getInstance():replaceScene(turn)
            end
        end
    end

end
function Load:onExit()
     scheduler.unscheduleGlobal(self.c)
end

return Load
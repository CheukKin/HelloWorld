--
-- Author: student
-- Date: 2015-11-26 11:06:29
--
local Hero = class("Hero", function()
	return display.newLayer()
end)
function Hero:ctor()

    self.biaoshi={"Aattribute_huo.png","Aattribute_feng.png","Aattribute_bing.png","Aattribute_mu.png"}
    self.zhiwei={"设为副手","设为队长"}
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
	self:list()
end
function Hero:list()
local layer
local skeletonNode2
local bgg
local bgg1
local tu
local text3

     layer = cc.uiloader:load("HeroListUpLayer.csb"):addTo(self)

	if ss==1 then
		 rennum = 6
		 skeletonNode2 = sp.SkeletonAnimation:create("jishucao/skeleton.json", "jishucao/skeleton.atlas",0.5)
         skeletonNode2:setPosition(cc.p(display.cx+50,display.cy+50))
         skeletonNode2:setAnimation(0,"idle",true)
         skeletonNode2:addTo(self)
	elseif ss==2 then
		rennum = 8
		 bgg=layer:getChildByName("Image_2")
         bgg:loadTexture("attribute4.png")
         bgg1=layer:getChildByName("Image_3")
         bgg1:loadTexture("paint-8.png")
         skeletonNode2 = sp.SkeletonAnimation:create("lufei/skeleton.json", "lufei/skeleton.atlas",0.5)
         skeletonNode2:setPosition(cc.p(display.cx+50,display.cy+50))
         skeletonNode2:setAnimation(0,"idle",true)
         skeletonNode2:addTo(self)
         tu=layer:getChildByName("Image_11")
         tu:loadTexture(self.biaoshi[2])
         text3=layer:getChildByName("Text_1")
         for i,v in ipairs(heroLabel) do
           if heroLabel[i].id == 8 then
                   text3:setString(heroLabel[i].name)
                end
         end
	elseif ss==3 then
		rennum = 5
		 bgg=layer:getChildByName("Image_2")
         bgg:loadTexture("attribute5.png")
         bgg1=layer:getChildByName("Image_3")
         bgg1:loadTexture("paint-5.png")
         skeletonNode2 = sp.SkeletonAnimation:create("xiaonvhai/skeleton.json", "xiaonvhai/skeleton.atlas",0.5)
         skeletonNode2:setPosition(cc.p(display.cx+50,display.cy+50))
         skeletonNode2:setAnimation(0,"idle",true)
         skeletonNode2:addTo(self)
         tu=layer:getChildByName("Image_11")
         tu:loadTexture(self.biaoshi[3])
         text3=layer:getChildByName("Text_1")
         text3:setString(self.tab2[3])
        for i,v in ipairs(heroLabel) do
           if heroLabel[i].id == 5 then
                   text3:setString(heroLabel[i].name)
                end
         end

	elseif ss==4 then
		rennum = 4
		 bgg=layer:getChildByName("Image_2")
         bgg:loadTexture("attribute1.png")
         bgg1=layer:getChildByName("Image_3")
         bgg1:loadTexture("paint-4.png")
         skeletonNode2 = sp.SkeletonAnimation:create("lvjuren/skeleton.json", "lvjuren/skeleton.atlas",0.5)
         skeletonNode2:setPosition(cc.p(display.cx+50,display.cy+50))
         skeletonNode2:setAnimation(0,"idle",true)
         skeletonNode2:addTo(self)
         tu=layer:getChildByName("Image_11")
         tu:loadTexture(self.biaoshi[4])
         text3=layer:getChildByName("Text_1")
         text3:setString(self.tab2[4])
        for i,v in ipairs(heroLabel) do
           if heroLabel[i].id == 4 then
                   text3:setString(heroLabel[i].name)
                end
         end
		 

	end

--返回		
	local btn1=layer:getChildByName("Button_2")
	btn1:addTouchEventListener(function (p,event)
		self:removeFromParent()
	end)
--技能
    self.shuxing = nil
    self.jineng = nil

	local btn2=layer:getChildByName("Button_3_Copy_1")
	btn2:addTouchEventListener(function (event)
		if self:getChildByTag(100001) then
			self:removeChildByTag(100001, cleanup)
		end
		if self:getChildByTag(100002) then
			self:removeChildByTag(100002, cleanup)
		end
		if self:getChildByTag(100003) then
			self:removeChildByTag(100003, cleanup)
		end
		 count=2
         self.jineng=cc.CSLoader:createNode("JiNengNode.csb")
		 :addTo(self)
		 :pos(display.cx, display.cy)
		 self.jineng:setTag(100001)
		 local btn21=self.jineng:getChildByName("Button_1")
		 btn21:addTouchEventListener(function (event)
		 	
		 	
		 		print("技能1")
		 	
          
		 
	     end)
	     local btn22=self.jineng:getChildByName("Button_2")
		 btn22:addTouchEventListener(function (event)
          
		 		print("技能2")
		 	
		 
	     end)
	     local btn23=self.jineng:getChildByName("Button_3")
		 btn23:addTouchEventListener(function (event)
          
		 		print("技能3")
		 	
		 
	     end)	
		 
	end)
--图鉴
local btn5=layer:getChildByName("Button_3_Copy_0")
	btn5:addTouchEventListener(function (event)
		count=3
		if self:getChildByTag(100002) then
			self:removeChildByTag(100002, cleanup)
		end
		if self:getChildByTag(100001) then
			self:removeChildByTag(100001, cleanup)
		end
		if self:getChildByTag(100003) then
			self:removeChildByTag(100003, cleanup)
		end
       -- local btn1=layer:getChildByName("Image_3")   
		 
	end)	
--详细属性
	local btn3=layer:getChildByName("Button_3_Copy")
	btn3:addTouchEventListener(function (event)
		count=4
		if self:getChildByTag(100001) then
			self:removeChildByTag(100001, cleanup)
		end
		if self:getChildByTag(100002) then
			self:removeChildByTag(100002, cleanup)
		end
		if self:getChildByTag(100003) then
			self:removeChildByTag(100003, cleanup)
		end
        self.shuxing=cc.CSLoader:createNode("ShuXingNode.csb")
		 :addTo(self):pos(display.cx, display.cy)
		 self.shuxing:setTag(100002)
        end)
--星座
	 local btn4=layer:getChildByName("Button_3")
     btn4:addTouchEventListener(function(ss,event)

         if event==2 then
         xiaoshi=display.newSprite("biaoti-di.png")
         :pos(display.cx, display.cy)
         :addTo(self)
         label200=cc.ui.UILabel.new({
         UILabelType = 2,text="暂未开启",size=20
         })
         :align(display.CENTER, display.cx, display.cy)
         :addTo(self)
        	local moveto=cc.MoveTo:create(0.5,cc.p(display.cx,display.cy+150))
        	local moveto1=cc.MoveTo:create(0.5,cc.p(display.cx,display.cy+150))
        	xiaoshi:runAction(moveto)
        	label200:runAction(moveto1)
        	 local fun=cc.CallFunc:create(function()
        		xiaoshi:removeFromParent()
        		end)
        	 local fun1=cc.CallFunc:create(function()
        		
        		label200:removeFromParent()
        	 end)

        	local seq=cc.Sequence:create(moveto,fun)
        	xiaoshi:runAction(seq)
        	local seq1=cc.Sequence:create(moveto1,fun1)
        	label200:runAction(seq1)
         end
         end)
--右箭头
--自定义事件
-- cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods()
-- self:addEventListener("ZUO_NEWS",handler(self, self.ZuoMynews))
-- self:addEventListener("YOU_NEWS",handler(self, self.YouMynews))
--右箭头
local btn19=layer:getChildByName("Button_19")
btn19:removeFromParent()

--左箭头
local btn18=layer:getChildByName("Button_18")
btn18:removeFromParent()

--6个装备按钮

tu={"yifu1-icon.png","yifu1-icon.png","shoutao1-icon.png","xiezi1-icon.png","xianglian1-icon.png","kuzi1-icon.png"}
mingzi={"后街T恤","后街T恤","牛仔手套","学者板鞋","防御项链","力量长裤"}
miaoshu={"衣服","衣服","手套","鞋子","项链","裤子"}

local btn11=layer:getChildByName("Button_11")   -----装备按钮1
		if self:getChildByTag(100003) then
			self:removeChildByTag(100003, cleanup)
		end
	     btn11:addTouchEventListener(function (event)
         self.zhuangbei=cc.CSLoader:createNode("ZhuangBeiNode.csb")
         :pos(display.cx, display.cy)
         :addTo(self)
         self.zhuangbei:setTag(100003)
         local btn88=self.zhuangbei:getChildByName("Button_7")
         local btn77=self.zhuangbei:getChildByName("Button_8")
         btn88:addTouchEventListener(function(pSender,event)
         	if event == 2 then
            for i,v in ipairs(selectHero) do
      			if selectHero[i].id == rennum then
      				print(selectHero[i].id)
         			print(selectHero[i].wuqi)
         	 		selectHero[i].wuqi = 0
         	 	end
         	 end
             	btn77:setVisible(true)
            	btn88:setVisible(false) 
         	end
              	
         end)
         
         btn77:addTouchEventListener(function(pSender,event)
         	if event == 2 then
         	  for i,v in ipairs(selectHero) do
      			if selectHero[i].id == rennum then
      				print(selectHero[i].id)
         			print(selectHero[i].wuqi)
         	 		selectHero[i].wuqi = 1
                    btn77:loadTextures()
         	 	end
         	 end
         	 btn88:setVisible(true)
         	 btn77:setVisible(false)
         	end
         	
        
         end)
         

    end)
for i=2,5 do
local yifu=layer:getChildByName("Button_1".. i)   
		if self:getChildByTag(100003) then
			self:removeChildByTag(100003, cleanup)
		end     -----装备按钮2－5
         yifu:addTouchEventListener(function (event)
         self.zhuangbei=cc.CSLoader:createNode("ZhuangBeiNode.csb")
         :pos(display.cx, display.cy)
         :addTo(self)
         self.zhuangbei:setTag(100003)
         self.yifu2=self.zhuangbei:getChildByName("Image_4")
	     self.yifu2:loadTexture(tu[i])
	     self.mingzi2=self.zhuangbei:getChildByName("Text_2")
	     self.mingzi2:setString(mingzi[i])
	     self.leixing=self.zhuangbei:getChildByName("Text_3")
	     self.leixing:setString(miaoshu[i])
	     local btn88=self.zhuangbei:getChildByName("Button_7")
         local btn77=self.zhuangbei:getChildByName("Button_8")
         btn88:addTouchEventListener(function(pSender,event)
         	if event == 2 then
            for k,v in ipairs(selectHero) do
            	if i==2 then
            		if selectHero[k].id == rennum then
      				print(111112)
         	 		selectHero[k].yifu = 0
         	 		end
         	    elseif i==3 then
         	 		if selectHero[k].id == rennum then
      				print(111113)
         	 		selectHero[k].shoutao = 0
         	 		end
         	    elseif i==4 then
         	 		if selectHero[k].id == rennum then
      				print(111114)
         	 		selectHero[k].xiezi = 0
         	 		end
         	 	elseif i==5 then
         	 		if selectHero[k].id == rennum then
      				print(111115)
         	 		selectHero[k].xianglian = 0
         	 	    end
                end
      			
         	 end
             	btn77:setVisible(true)
            	btn88:setVisible(false) 
         	end
              	
         end)
         
         btn77:addTouchEventListener(function(pSender,event)
         	if event == 2 then
         	  for k,v in ipairs(selectHero) do
      			if i==2 then   
            		if selectHero[k].id == rennum then
      				print(selectHero[k].id)
         	 		selectHero[k].yifu = 1
         	 		end
         	    elseif i==3 then
         	 		if selectHero[k].id == rennum then
      				print(selectHero[k].id)
         	 		selectHero[k].shoutao = 1
         	 		end
         	    elseif i==4 then
         	 		if selectHero[k].id == rennum then
      				print(selectHero[k].id)
         	 		selectHero[k].xiezi = 1
         	 		end
         	 	elseif i==5 then
         	 		if selectHero[k].id == rennum then
      				print(selectHero[k].id)
         	 		selectHero[k].xianglian = 1
         	 	    end
                end
      			
         	 end
         	 btn88:setVisible(true)
         	 btn77:setVisible(false)
         	end
         	
        
         end)
	     
	     end)	
end
local yifu1=layer:getChildByName("Button_23")          -----装备按钮1
		if self:getChildByTag(100003) then
			self:removeChildByTag(100003, cleanup)
		end
         yifu1:addTouchEventListener(function (event)
         self.zhuangbei=cc.CSLoader:createNode("ZhuangBeiNode.csb")
         :pos(display.cx, display.cy)
         :addTo(self)
         self.zhuangbei:setTag(100003)
         self.yifu3=self.zhuangbei:getChildByName("Image_4")
	     self.yifu3:loadTexture(tu[6])
	     self.mingzi3=self.zhuangbei:getChildByName("Text_2")
	     self.mingzi3:setString(mingzi[6])
	     self.leixing3=self.zhuangbei:getChildByName("Text_3")
	     self.leixing3:setString(miaoshu[6])
	      local btn88=self.zhuangbei:getChildByName("Button_7")
         local btn77=self.zhuangbei:getChildByName("Button_8")
         btn88:addTouchEventListener(function(pSender,event)
         	if event == 2 then
            for i,v in ipairs(selectHero) do
      			if selectHero[i].id == rennum then
      				print(selectHero[i].id)
         	 		selectHero[i].kuzi = 0
         	 	end
         	 end
             	btn77:setVisible(true)
            	btn88:setVisible(false) 
         	end
              	
         end)
         
         btn77:addTouchEventListener(function(pSender,event)
         	if event == 2 then
         	  for i,v in ipairs(selectHero) do
      			if selectHero[i].id == rennum then
      				print(selectHero[i].id)
         
         	 		selectHero[i].kuzi = 1
         	 	end
         	 end
         	 btn88:setVisible(true)
         	 btn77:setVisible(false)
         	end
         	
        
         end)
	     
	     end)	
	     

end

function Hero:shuxing()
	local shuxing=cc.CSLoader:createNode("ShuXingNode.csb")
		 :addTo(self):pos(display.cx, display.cy)
		 -- if sum==1 then
		 
		 -- elseif sum==2 then
		 	local lab=shuxing:getChildByName("Text_3")
		 	lab:setString("简介：著名的美食家\nhh")
		 	local lab1=shuxing:getChildByName("Text_6")
		 	lab1:setString("30.4")
		 	local lab2=shuxing:getChildByName("Text_6_Copy_3")
		 	lab2:setString("48.8")
		 	local lab3=shuxing:getChildByName("Text_6_Copy_1")
		 	lab3:setString("30.4")
		 	local lab4=shuxing:getChildByName("Text_6_Copy_0")
		 	lab4:setString("23")
		 	local lab5=shuxing:getChildByName("Text_6_Copy")
		 	lab5:setString("30.4")
		 	local lab6=shuxing:getChildByName("Text_6_Copy_2")
		 	lab6:setString("5636.4")
		 -- end
end
-- function Hero:zhuangbei()
	
-- end
-- local liandao={"Image_1","Image_2","Image_3"}
-- local liandao1={"sishenjineng1.png","sishenjineng2.png","sishenjineng3.png"}
-- local text={"Text_1","Text_2","Text_3"}
-- local text1={"达纳特斯阵","冰镰","禁厌术"}
-- function Hero:ZuoMynews()


-- 	if count==2 then
--      for i=1,3 do
--      	local image=self.jineng:getChildByName(liandao[i])
--      	image:loadTexture(liandao1[i])
--      	local text2=self.jineng:getChildByName(text[i])
--      	text2:setString(text1[i])
--      end
     

--      -- local image=jineng:getChildByName("Image_1")
--      -- image:loadTexture("HeroListUp/sishenjineng1.png")
--      -- local image1=jineng:getChildByName("Image_2")
--      -- image1:loadTexture("HeroListUp/sishenjineng2.png")
-- 		print("技能")
-- 	elseif count==3 then
--      local bgg=layer:getChildByName("Image_2")
--      bgg:loadTexture("attribute5.png")
--      local bgg1=layer:getChildByName("Image_3")
--      bgg1:loadTexture("paint-5.png")
--      self.skeletonNode2:setVisible(false)
--      local skeletonNode1 = sp.SkeletonAnimation:create("xiaonvhai/skeleton.json", "xiaonvhai/skeleton.atlas",0.5)
--     skeletonNode1:setPosition(cc.p(display.cx+50,display.cy+50))
--     skeletonNode1:setAnimation(0,"idle",true)
--     skeletonNode1:addTo(self)
-- 		print("图鉴")
-- 	elseif count==4 then

-- 		local shuxing=cc.CSLoader:createNode("ShuXingNode.csb")
-- 		 :addTo(self):pos(display.cx, display.cy)
-- 		 -- if sum==1 then
		 
-- 		 -- elseif sum==2 then
-- 		 	local lab=shuxing:getChildByName("Text_3")
-- 		 	lab:setString("简介：著名的美食家\nhh")
-- 		 	local lab1=shuxing:getChildByName("Text_6")
-- 		 	lab1:setString("30.4")
-- 		 	local lab2=shuxing:getChildByName("Text_6_Copy_3")
-- 		 	lab2:setString("48.8")
-- 		 	local lab3=shuxing:getChildByName("Text_6_Copy_1")
-- 		 	lab3:setString("30.4")
-- 		 	local lab4=shuxing:getChildByName("Text_6_Copy_0")
-- 		 	lab4:setString("23")
-- 		 	local lab5=shuxing:getChildByName("Text_6_Copy")
-- 		 	lab5:setString("30.4")
-- 		 	local lab6=shuxing:getChildByName("Text_6_Copy_2")
-- 		 	lab6:setString("5636.4")
-- 		print("详细属性")
-- 	end
-- 	print("zuo")
-- end

-- function Hero:YouMynews( ... )
-- 	if count==2 then
-- 		for i=1,3 do
--      	local image=self.jineng:getChildByName(liandao[i])
--      	image:loadTexture(liandao1[i])
--      	local text2=self.jineng:getChildByName(text[i])
--      	text2:setString(text1[i])
--      end
-- 		print("技能")
-- 	elseif count==3 then

-- 		local bgg=layer:getChildByName("Image_2")
--      bgg:loadTexture("attribute5.png")
--      local bgg1=layer:getChildByName("Image_3")
--      bgg1:loadTexture("paint-5.png")
-- 		print("图鉴")
-- 	elseif count==4 then

-- 		print("详细属性")
-- 		local shuxing=cc.CSLoader:createNode("ShuXingNode.csb")
-- 		 :addTo(self):pos(display.cx, display.cy)
-- 		 -- if sum==1 then
		 
-- 		 -- elseif sum==2 then
-- 		 	local lab=shuxing:getChildByName("Text_3")
-- 		 	lab:setString("简介：著名的美食家\nhh")
-- 		 	local lab1=shuxing:getChildByName("Text_6")
-- 		 	lab1:setString("30.4")
-- 		 	local lab2=shuxing:getChildByName("Text_6_Copy_3")
-- 		 	lab2:setString("48.8")
-- 		 	local lab3=shuxing:getChildByName("Text_6_Copy_1")
-- 		 	lab3:setString("30.4")
-- 		 	local lab4=shuxing:getChildByName("Text_6_Copy_0")
-- 		 	lab4:setString("23")
-- 		 	local lab5=shuxing:getChildByName("Text_6_Copy")
-- 		 	lab5:setString("30.4")
-- 		 	local lab6=shuxing:getChildByName("Text_6_Copy_2")
-- 		 	lab6:setString("5636.4")
-- 	end
-- 	print("you")
-- end
return Hero
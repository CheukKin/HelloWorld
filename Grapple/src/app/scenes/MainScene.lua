
FightingTouchLayer = require("app.GameScenes.FightingTouch")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	print("MainScene++++++++")
	audio.pauseMusic()
	audio.playMusic("data/music/bg/a_chooselevel.mp3", true)
	-- if #SaveData.selectHero == 0 then
		local docpath = cc.FileUtils:getInstance():getWritablePath().."hero.txt"
		if cc.FileUtils:getInstance():isFileExist(docpath) == false then
			local str = json.encode(SaveData.selectHero)
			SaveData.writeheroToDoc(str)
		else
			local str = SaveData.readheroFromDoc()
			SaveData.selectHero = json.decode(str)
		end
	-- end

	if #SaveData.guanqia == 0 then
		local docpath = cc.FileUtils:getInstance():getWritablePath().."guanka.txt"
		if cc.FileUtils:getInstance():isFileExist(docpath) == false then
			local str = json.encode(TMXData.guanqia)
			SaveData.writeguankaToDoc(str)
			SaveData.guanqia = TMXData.guanqia
		else
			local str = SaveData.readguankaFromDoc()
			SaveData.guanqia = json.decode(str)
		end
	end

	if #SaveData.haveZhuangbei == 0 then
		local docpath = cc.FileUtils:getInstance():getWritablePath().."zhuangbei.txt"
		if cc.FileUtils:getInstance():isFileExist(docpath) == false then
			local str = json.encode(SaveData.haveZhuangbei)
			SaveData.writezhuangbeiToDoc(str)
			-- SaveData.guanqia = TMXData.guanqia
		else
			local str = SaveData.readzhuangbeiFromDoc()
			SaveData.haveZhuangbei = json.decode(str)
		end
	end

	if #SaveData.haveSuiPian == 0 then
		local docpath = cc.FileUtils:getInstance():getWritablePath().."suipian.txt"
		if cc.FileUtils:getInstance():isFileExist(docpath) == false then
			local str = json.encode(SaveData.haveSuiPian)
			SaveData.writesuipianToDoc(str)
			-- SaveData.guanqia = TMXData.guanqia
		else
			local str = SaveData.readsuipianFromDoc()
			SaveData.haveSuiPian = json.decode(str)
		end
	end

-- local scene=  require("app.GameScenes.ShengLi")    
--                         local layer=scene.new()
--                         layer:setPosition(0,0)
--                         self:addChild(layer,20)
	
    self.isChoose = 1
--加载主界面
	self.scene = cc.uiloader:load("MainScene.csb")
					:addTo(self)
	self.jinbi = cc.uiloader:load("jinbi.csb")
					:pos(170, display.top-100)
					:scale(0.7)
					:addTo(self)
	self.zuanshi = cc.uiloader:load("zuanshi.csb")
					:pos(315, display.top-100)
					:scale(0.7)
					:addTo(self)
	self.tili = cc.uiloader:load("tili.csb")
					:pos(460, display.top-100)
					:scale(0.7)
					:addTo(self)

	self.button1 = self.scene:getChildByName("Button_1");
    self.button1:addTouchEventListener(function(psender,event)
    	if event == 2 then
    		if self.isChoose == 1 then
    			self.isChoose = 0
    			--更换图片
    			self.button1:loadTextures("item_close_btn.png", "item_close_btn.png")
    			--四个按钮
    			self.anniu = cc.uiloader:load("anniu.csb")
					:pos(self.button1:getPositionX()-100,self.button1:getPositionY()-42)
					-- :scale(0.7)
					:addTo(self)
				local buttonShenJi = self.anniu:getChildByName("Button_1")
				buttonShenJi:setPressedActionEnabled(true)--设置动画效果
				buttonShenJi:addTouchEventListener(function(psender,event)
					if event == 2 then
						print("前往升级layer")
						local layer = UpGradeLayer:new()
						layer:addTo(self,10)
					end
				end)
				local buttonBeiBao = self.anniu:getChildByName("Button_2")
				buttonBeiBao:setPressedActionEnabled(true)
				buttonBeiBao:addTouchEventListener(function(psender,event)
					if event == 2 then
						print("前往背包layer")
						local layer = BackPackLayer:new()
						layer:addTo(self,10)
					end
				end)
				local buttonZhuangBei = self.anniu:getChildByName("Button_3")
				buttonZhuangBei:setPressedActionEnabled(true)
				buttonZhuangBei:addTouchEventListener(function(psender,event)
					if event == 2 then
						print("前往装备layer")
						local layer = EquipmentLayer:new()
						layer:addTo(self,10)
					end
				end)
				local buttonShangDian = self.anniu:getChildByName("Button_4")
				buttonShangDian:setPressedActionEnabled(true)
				buttonShangDian:addTouchEventListener(function(psender,event)
					if event == 2 then
						print("前往商店layer")
						local layer = require("app.GameScenes.ShopLayer"):new()
						layer:addTo(self,10)
					end
				end)
    			-- print("出现四个按钮")
			elseif self.isChoose == 0 then
				self.isChoose = 1
				self.button1:loadTextures("item_open_btn.png", "item_open_btn.png")
				--删除四个按钮
				self.anniu:removeFromParent()
				print("出现一个按钮")	
    		end
    	end
    end)

	self.button2 = self.scene:getChildByName("Button_2")
	self.button2:addTouchEventListener(function(psender,event)
		if event == 2 then
			-- print("dsadfas")
			--加载挑战界面
			self.tiaozhan = cc.uiloader:load("tiaozhan.csb")
					:pos(10, 30)
					:addTo(self)
			--隐藏金币，钻石，挑战
			self.button2:setVisible(false)
			self.button3:setVisible(false)--超值礼包
			self.jinbi:setVisible(false)
			self.zuanshi:setVisible(false)

			local tuchu = self.tiaozhan:getChildByName("Button_2")
			tuchu:addTouchEventListener(function(psender,event)
				if event == 2 then
					print("退出")
					self.button2:setVisible(true)
					self.button3:setVisible(true)
					self.jinbi:setVisible(true)
					self.zuanshi:setVisible(true)

					self.tiaozhan:removeFromParent()
					self.lv1:removeFromParent()
				end
			end)
			local zhandou = self.tiaozhan:getChildByName("Button_3")
			zhandou:addTouchEventListener(function(psender,event)
				if event == 2 then
					print("挑战")

					--写一个 londing 界面
					-- local scene = LodingScene.new()
					local scene = GameScene.new()
					-- local turn = cc.TransitionPageTurn:create(1, scene, false)
					cc.Director:getInstance():replaceScene(scene)
				end
			end)

			--添加列表
			local beijing = self.tiaozhan:getChildByName("Image_1")
			local bound2 = beijing:getBoundingBox()

			-- dump(bound2)
			self.lv1 = ccui.ListView:create()
			self.lv1:setContentSize(cc.size(bound2.width-5, bound2.height-10))
			self.lv1:setPosition(cc.p(bound2.x+15,bound2.y+25))
			self.lv1:setGravity(6)
			self.lv1:setDirection(3)
			self:addChild(self.lv1,10)
			self.lv1:setBounceEnabled(true);
			for i=1,#SaveData.guanqia do
				for j=1,#SaveData.guanqia[i] do
					local c1 = cc.uiloader:load("checkpoint.csb")
					c1:getChildByName("Text_1"):setString(SaveData.guanqia[i][j].name)
					-- c1:setPosition(cc.p(30,30))
					local content --= cc.uiloader:load("checkpoint.csb")
					content = ccui.Button:create("img/ui/mapSelect/anniu_rad.png","img/ui/mapSelect/anniu_radover.png")
					content:setScale9Enabled(true)
					content:setContentSize(cc.size(bound2.width-5, 60))
				    content:setAnchorPoint(cc.p(0, 0))
				    content:setPressedActionEnabled(true)
				    content:addTouchEventListener(function(psender,event)
				        if event == 2 then
				            print("第几关" ..i .. "fuben "..j)
				            --进入失败页面
				            ShenJiData.GuanKa = i
				            ShenJiData.FuBen = j
				            -- self:removeFromParent()
				        end
				    end)
				    if SaveData.guanqia[i][j].lock == 0 then
				    	content:setTouchEnabled(false)
				    end
				    content:addChild(c1)
					self.lv1:pushBackCustomItem(content);
				end
			end
		-- 	self.lv1=cc.ui.UIListView.new{
		-- 			bgColor = cc.c4b(200, 200, 200, 120),
		-- 			-- bg="xinxi-di1.png",
		-- 			bgScale9=true,
		-- 			viewRect=cc.rect(10, 130, 220.5, 470),
		-- 			direction=cc.ui.UIScrollView.DIRECTION_VERTICAL,
		-- 		}
		-- 		-- :onTouch(handler(self, self.touchListener))
		-- 		:addTo(self)
		-- 		-- lv:setAnchorPoint(0,1)
		-- 	for i=1,5 do
		-- 		local item=self.lv1:newItem()
		-- 		local content
		-- 		content = cc.uiloader:load("checkpoint.csb")
		-- 		content:setScale(0.65)
		-- 		-- content=cc.ui.UILabel.new({text="item"..i,
		-- 		-- 	size=20,
		-- 		-- 	align=cc.ui.TEXT_ALIGN_CENTER,
		-- 		-- 	color=display.COLOR_RED})
		-- 		item:addContent(content)
		-- 		item:setItemSize(220.5, 61.6)
		-- 		self.lv1:addItem(item)
		-- 	end
		--    	self.lv1:reload()
		end
	end)

	self.button3 = self.scene:getChildByName("Button_3")
	self.button3:addTouchEventListener(function(psender,event)
		if event == 2 then
			print("超值礼包")
		end
	end)
	self:myListView()
	
end

function MainScene:myListView()

	selectHero = SaveData.selectHero
	print("···" .. #selectHero)
	heroLabel = HeroData.hero
	local b = ccui.Scale9Sprite:create("xinxi-di1.png")
	b:setAnchorPoint(cc.p(0,0))
	b:setContentSize(cc.size(120, 420))
	b:setPosition(cc.p(760,200))
	b:addTo(self)

	self.lv = ccui.ListView:create()
	self.lv:setContentSize(cc.size(120, 400))
	self.lv:setPosition(cc.p(765,210))
	self.lv:setGravity(6)
	self.lv:setDirection(3)
	self:addChild(self.lv)
	self.lv:setBounceEnabled(true)

	for i=1, #selectHero do
		local content
		if i == 1 then 
			print("gkflgkl;kgl;f")
			content = ccui.Button:create("img/icon/role/"..heroLabel[4].iconName..".png","img/icon/role/"..heroLabel[4].iconName..".png")
		elseif i == 2 then
			content = ccui.Button:create("img/icon/role/"..heroLabel[6].iconName..".png","img/icon/role/"..heroLabel[6].iconName..".png")
		elseif i == 3 then
			content = ccui.Button:create("img/icon/role/"..heroLabel[3].iconName..".png","img/icon/role/"..heroLabel[3].iconName..".png")
		elseif i == 4 then
			content = ccui.Button:create("img/icon/role/"..heroLabel[2].iconName..".png","img/icon/role/"..heroLabel[2].iconName..".png")
		end
		
		local c1 = cc.uiloader:load("duizhang.csb")
		local image = c1:getChildByName("Image_1")
		c1:setPosition(cc.p(60,40))
		content:setPosition(cc.p(display.cx-140, display.cy))
	  
		if selectHero[i].zhiwei == 1 or selectHero[i].zhiwei == 2 then
			image:setVisible(false)
			content:setPressedActionEnabled(true)
		    content:addTouchEventListener(function(psender,event)
	        if event == 2 then
	            print("失败" ..i)
	            ss=i
	            local HeroList=  require("app.GameScenes.HeroList")    
                local layer=HeroList.new()
                self:addChild(layer,10)

	        end
	    end)
		
		else
				image:setVisible(true)
		end
		if i==1 then
			else
			 local duizhang=c1:getChildByName("Text_1")
		     duizhang:setString("副手")	
		end
		
	    content:addChild(c1)
		self.lv:pushBackCustomItem(content);
	end


	-- self.lv=cc.ui.UIListView.new{
	-- 		-- bgColor = cc.c4b(200, 200, 200, 120),
	-- 		bg="xinxi-di1.png",
	-- 		bgScale9=true,
	-- 		viewRect=cc.rect(765, 210, 120, 400),
	-- 		direction=cc.ui.UIScrollView.DIRECTION_VERTICAL,
	-- 	}
	-- 	:onTouch(handler(self, self.touchListener))
	-- 	:addTo(self)

	-- for i=1,20 do
	-- 	local item=self.lv:newItem()
	-- 	local content
	-- 	content = cc.uiloader:load("duizhang.csb")
	-- 	-- content=cc.ui.UILabel.new({text="item"..i,
	-- 	-- 	size=20,
	-- 	-- 	align=cc.ui.TEXT_ALIGN_CENTER,
	-- 	-- 	color=display.COLOR_RED})
	-- 	item:addContent(content)
	-- 	item:setItemSize(120, 130)
	-- 	self.lv:addItem(item)
	-- end
 --   	self.lv:reload()
end
--list 触摸
function MainScene:touchListener(event)
	local listView=event.listView
	if "moved"==event.name then
		self.bListViewMove = true
	elseif "ended"==event.name then
		self.bListViewMove = false
	else
		print("event name:" .. event.name)
	end
end
function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene


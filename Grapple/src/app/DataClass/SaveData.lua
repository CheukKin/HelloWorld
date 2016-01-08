--
-- Author: ZDL
-- Date: 2015-11-25 20:53:09
--
module("SaveData", package.seeall)

--英雄数据
--[[
选择了那个英雄
英雄当前的等级
英雄当前的装备
拥有的装备
所拥有的金币
上次退出游戏时的体力和时间

--]]

yingyue = true

guanqia = {}
-- guanqia[1] = {}
-- guanqia[1][1] = {lock = 1,name = "恶魔城-1"}
-- guanqia[1][2] = {lock = 1,name = "恶魔城-2"}
-- guanqia[2] = {}
-- guanqia[2][1] = {lock = 0,name = "德克之心-1"}
-- guanqia[2][2] = {lock = 0,name = "德克之心-2"}
-- guanqia[3] = {}
-- guanqia[3][1] = {lock = 0,name = "浮空大陆-1"}
-- guanqia[3][2] = {lock = 0,name = "浮空大陆-2"}
-- guanqia[4] = {}
-- guanqia[4][1] = {lock = 0,name = "赤雨十三街-1"}
-- guanqia[4][2] = {lock = 0,name = "赤雨十三街-2"}

selectHero = {
	-- {zhiwei = 1 , id = 6,level = 1, jinyan = 5,yifu = 0,wuqi = 0,kuzi = 0,shoutao = 0,xianglian = 0,xiezi = 0},
	-- {zhiwei = 2 , id = 5,level = 5, jinyan = 12,yifu = 0,wuqi = 0,kuzi = 0,shoutao = 0,xianglian = 0,xiezi = 0}
}
--isShei->对应 id
haveZhuangbei = {
	-- {id = 10001,isZhuangBei = 1,isShei = 5,isLeiXing = 1},
	-- {id = 10002,isZhuangBei = 1,isShei = 6,isLeiXing = 1},
	-- {id = 10003,isZhuangBei = 0,isShei = 0,isLeiXing = 1}
}

haveSuiPian = {
	-- {id = 10013,isLeiXing = 1},
	-- {id = 10014,isLeiXing = 1}
}

haveJingBi = {jinbi = 1,zhuangshi = 1}


function getHaveHero( ... )
	-- body
end
--装备数据

--通关数据


--使用
-- if #PublicData.SCENETABLE==0 then
-- 	local docpath = cc.FileUtils:getInstance():getWritablePath().."hero.txt"
-- 	if cc.FileUtils:getInstance():isFileExist(docpath)==false then
-- 		local str = json.encode(Data.SCENE)
-- 		ModifyData.writeToDoc(str)
-- 		PublicData.SCENETABLE = Data.SCENE
-- 	else
-- 		local str = ModifyData.readFromDoc()
-- 		PublicData.SCENETABLE = json.decode(str)
-- 	end
-- end


--写入沙盒路径
function writeheroToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."hero.txt"
    local f = assert(io.open(docpath, 'w'))
    f:write(str)
    f:close()
end

--从沙盒路径下读出
function readheroFromDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."hero.txt"
 	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
  	return str
end


--关卡
--写入沙盒路径
function writeguankaToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."guanka.txt"
    local f = assert(io.open(docpath, 'w'))
    f:write(str)
    f:close()
end

--从沙盒路径下读出
function readguankaFromDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."guanka.txt"
 	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
  	return str
end

--装备
--写入沙盒路径
function writezhuangbeiToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."zhuangbei.txt"
    local f = assert(io.open(docpath, 'w'))
    f:write(str)
    f:close()
end

--从沙盒路径下读出
function readzhuangbeiFromDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."zhuangbei.txt"
 	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
  	return str
end


--碎片
--写入沙盒路径
function writesuipianToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."suipian.txt"
    local f = assert(io.open(docpath, 'w'))
    f:write(str)
    f:close()
end

--从沙盒路径下读出
function readsuipianFromDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."suipian.txt"
 	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
  	return str
end






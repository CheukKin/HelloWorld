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
selectHero = {
	duizhang = {id = 3,level = 1,yifu = 0,wuqi = 0,kuzi = 0,shoutao = 0,xianglian = 0,xiezi = 0},
	chengyuan1 = {id = 6,level = 1,yifu = 0,wuqi = 0,kuzi = 0,shoutao = 0,xianglian = 0,xiezi = 0},
}

haveZhuangbei = {
	{id = ,isZhuangBei = ,isShei = ,isLeiXing = },
	{}
}

haveJingBi = {jinbi = ,zhuangshi = }


function getHaveHero( ... )
	-- body
end
--装备数据

--通关数据


--使用
-- if #PublicData.SCENETABLE==0 then
-- 	local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
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
function writeToDoc(str)
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
    local f = assert(io.open(docpath, 'w'))
    f:write(str)
    f:close()
end

--从沙盒路径下读出
function readFromDoc()
	local docpath = cc.FileUtils:getInstance():getWritablePath().."data.txt"
	-- local f = assert(io.open(docpath, 'r'))
 --  	local str = f:read("*all")
 --  	f:close()
 	local str = cc.FileUtils:getInstance():getStringFromFile(docpath)
  	return str
end
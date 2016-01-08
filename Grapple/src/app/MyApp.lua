
require("config")
require("cocos.init")
require("framework.init")
scheduler = require("framework.scheduler")
-- ResManager = require("app.DataClass.ResManager")
EquipmentLayer = require("app.scenes.EquipmentLayer")
BackPackLayer = require("app.scenes.BackPackLayer")
local MyApp = class("MyApp", cc.mvc.AppBase)
GameScene = require("app.GameScenes.GameScene")
require("app.DataClass.TMXData")
require("app.CharacterClass.Determine")
TouchTunshi = require("app.GameScenes.TouchTunshi")
ZanTingLayer = require("app.GameScenes.ZanTingLayer")
WinORFai = require("app.GameScenes.WinORFai")
UpGradeLayer = require("app.scenes.UpGradeLayer")
require("app.DataClass.hero")
require("app.DataClass.ShenJiData")
require("app.DataClass.SaveData")
LodingScene = require("app.scenes.LodingScene")
ShengLi = require("app.GameScenes.ShengLi")
MainScene = require("app.scenes.MainScene")
StartGame = require("app.scenes.StartGame")
require("app.DataClass.ResManager")
-- Load = require("app.GameScenes.Load")

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    -- ccui.Button:create();

    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/comm/")
    cc.FileUtils:getInstance():addSearchPath("res/role/")
    cc.FileUtils:getInstance():addSearchPath("res/image/")
    cc.FileUtils:getInstance():addSearchPath("res/image/UI/")
    cc.FileUtils:getInstance():addSearchPath("res/image/UI/battleUI/")
    cc.FileUtils:getInstance():addSearchPath("res/icon/skill/")
    cc.FileUtils:getInstance():addSearchPath("res/ssss")
    cc.FileUtils:getInstance():addSearchPath("res/SHOP")
    self:enterScene("Load")
end

return MyApp

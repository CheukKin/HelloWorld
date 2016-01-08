QualityFormat = require("etc.QualityFormat")
EquipFormat = require("etc.EquipFormat")
--format.lua
--公式表

-- function initRoleAttr(lv, star, data )
--     local attr = {}
--     if data.objType ~= 1 then
--         return nil
--     end
--     trace1("--------------传递到format中实例化的角色数据为: %o", data)
--     --发挥度
--     local abi = data.AbilityValue or 1
--     --等级 
--     attr.lv = data.Level or lv
--     --星级
--     attr.star = star or 1

--     --力量
--     local force = ( data.InitialForce + data.ForceDevelopment * math.pow(1.5, star - 1) * attr.lv ) * abi
--     --体质
--     local constitution = ( data.InitialConstitution + data.ConstitutionDevelopment * math.pow(1.5, star - 1) * attr.lv ) * abi
--     --敏捷
--     local agility = ( data.InitialAgility	+ data.AgilityDevelopment * math.pow(1.5, star - 1) * attr.lv ) * abi
--     --智力
--     local intelligence = ( data.InitialIntelligence + data.IntelligenceDevelopment * math.pow(1.5, star - 1) * attr.lv ) * abi
--     --专注
--     local focus = ( data.InitialFocus + data.FocusDevelopment * math.pow(1.5, star - 1)* attr.lv ) * abi

--     --力量
--     attr.force = force
--     --体质
--     attr.constitution = constitution
--     --敏捷
--     attr.agility = agility
--     --智力
--     attr.intelligence = intelligence
--     --专注
--     attr.focus = focus

--     --HP
--     attr.HP = data.InitialBlood + math.floor(constitution/5)*50 + (constitution- math.floor(constitution/5))*10
--     attr.MaxHP = attr.HP
--     --MP
--     attr.MP = data.InitialMagic
--     --单位时间魔法恢复值
--     attr.timeRecMP = data.TimeRecoveryMagic
--     --魔法上限值
--     attr.MaxMP = data.MagicUpperLimit
--     --物攻
--     attr.phyAtk = data.InitialPhysicalAttack + math.floor(force/5)*5 + (force - math.floor(force/5))*1
--     --魔攻
--     attr.magAtk = data.InitialMagicAttack + math.floor(intelligence/5)*5+(intelligence- math.floor(intelligence/5))*1
--     --物防
--     attr.phyDef = data.InitialPhysicalDefense + math.floor(force/5)*2.5 + (force- math.floor(force/5))*0.5
--     --魔防
--     attr.magDef = data.InitialMagicDefense + math.floor(intelligence/5)*2.5+(intelligence- math.floor(intelligence/5))*0.5
--     --命中
--     attr.hit = data.InitialHit + math.floor(focus/5)*10+(focus- math.floor(focus/5))*2
--     --闪避
--     attr.dodge = data.InitialDodge + math.floor(agility/5)*5+(agility- math.floor(agility/5))*1
--     --暴击
--     attr.critical = data.InitialCritical + math.floor(focus/5)*8+(focus- math.floor(focus/5))*1.8
--     --暴抗
--     attr.criRes = data.InitialCriticalResistance + math.floor(agility/5)*8+(agility- math.floor(agility/5))*1.8
--     --暴击伤害
--     attr.criStrikes = data.InitialCriticalStrikes
--     --物穿
--     attr.phyPnt = data.PhysicalPenetration
--     --魔穿
--     attr.magPnt = data.MagicPenetration

--     return attr

-- end

function initRoleAttr(data )
local attr = {}
    if data.objType ~= 1 then
        return nil
    end
    trace1("--------------传递到format中实例化的角色数据为: %o", data)
    --发挥度
    local abi = data.AbilityValue or 1
    --id
    attr.id = data.id or 3
    --等级 
    attr.lv = data.Level or data.level or data.lv or 1
    --星级
    attr.star = data.start or 1
    --品质(星座)
    attr.quality = data.qualityLevel or 1
    --孔位(敌方直接满孔位)
    attr.hole = data.startNode or 0

    attr.skill = data.skill

    --得到星座属性
    local qualityAttr = QualityFormat:getQualityAttr( attr.id, attr.quality, attr.hole, true )
    local equipAttr = EquipFormat:calcAllEquipAttr( data.equip )
    trace1("-------------------- equipAttr %o", equipAttr)


    --一级属性
    --力量
    attr.force = ( data.InitialForce + data.ForceDevelopment * math.pow(1.5, attr.star - 1) * attr.lv + qualityAttr.FceUp) * abi
    --体质
    attr.constitution = ( data.InitialConstitution + data.ConstitutionDevelopment * math.pow(1.5, attr.star - 1) * attr.lv + qualityAttr.ConUp) * abi
    --敏捷
    attr.agility = ( data.InitialAgility   + data.AgilityDevelopment * math.pow(1.5, attr.star - 1) * attr.lv + qualityAttr.AgiUp) * abi
    --智力
    attr.intelligence = ( data.InitialIntelligence + data.IntelligenceDevelopment * math.pow(1.5, attr.star - 1) * attr.lv + qualityAttr.IntUp) * abi
    --专注
    attr.focus = ( data.InitialFocus + data.FocusDevelopment * math.pow(1.5, attr.star - 1)* attr.lv + qualityAttr.FocUp) * abi

    --二级属性
    --HP
    attr.HP = data.InitialBlood + math.floor(attr.constitution/5)*50 + (attr.constitution- math.floor(attr.constitution/5))*10 + qualityAttr.HPUp
    attr.MaxHP = attr.HP
    --MP
    attr.MP = data.InitialMagic + qualityAttr.MPUp
    --单位时间魔法恢复值
    attr.timeRecMP = data.TimeRecoveryMagic
    --魔法上限值
    attr.MaxMP = data.MagicUpperLimit
    --物攻
    attr.phyAtk = data.InitialPhysicalAttack + math.floor(attr.force/5)*5 + (attr.force - math.floor(attr.force/5))*1 + qualityAttr.STRUp
    --物防
    attr.phyDef = data.InitialPhysicalDefense + math.floor(attr.force/5)*2.5 + (attr.force- math.floor(attr.force/5))*0.5 + qualityAttr.DEFUp
    --魔攻
    attr.magAtk = data.InitialMagicAttack + math.floor(attr.intelligence/5)*5+(attr.intelligence- math.floor(attr.intelligence/5))*1 + qualityAttr.ATSUp
    --魔防
    attr.magDef = data.InitialMagicDefense + math.floor(attr.intelligence/5)*2.5+(attr.intelligence- math.floor(attr.intelligence/5))*0.5 + qualityAttr.ADFUp
    --命中
    attr.hit = data.InitialHit + math.floor(attr.focus/5)*10+(attr.focus- math.floor(attr.focus/5))*2 + qualityAttr.DEXUp
    --闪避
    attr.dodge = data.InitialDodge + math.floor(attr.agility/5)*5+(attr.agility- math.floor(attr.agility/5))*1 + qualityAttr.AGLUp
    --暴击
    attr.critical = data.InitialCritical + math.floor(attr.focus/5)*8+(attr.focus- math.floor(attr.focus/5))*1.8 + qualityAttr.CRLUp
    --暴抗
    attr.criRes = data.InitialCriticalResistance + math.floor(attr.agility/5)*8+(attr.agility- math.floor(attr.agility/5))*1.8 + qualityAttr.CRTUp
    --暴击伤害
    attr.criStrikes = data.InitialCriticalStrikes + qualityAttr.CRSUp
    --物穿
    attr.phyPnt = data.PhysicalPenetration + qualityAttr.DIGUp
    --魔穿
    attr.magPnt = data.MagicPenetration + qualityAttr.AIGUp

    return attr

end

-- --info 中有 id ，等级，星级, 星座, 孔
-- function initRoleData( info )
--     local roleData = {}
--     if info.objType ~= 1 then
--         return nil
--     end
--     --发挥度
--     local abi = info.AbilityValue or 1
--     --id
--     roleData.id = info.id or 3
--     --等级 
--     roleData.lv = info.Level or info.level or 1
--     --星级
--     roleData.star = info.start or 1
--     --品质(星座)
--     roleData.quality = info.qualityLevel or 1
--     --孔位(敌方直接满孔位)
--     roleData.hole = info.startNode or 0

--     local data = TABLE_D.getRoleData(info.id)
--     local qualityData = QualityFormat:getQualityData( roleData.id, roleData.quality, roleData.hole, true )

--     --一级属性
--     --力量
--     roleData.force = ( data.InitialForce + data.ForceDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.FceUp) * abi
--     --体质
--     roleData.constitution = ( data.InitialConstitution + data.ConstitutionDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.ConUp) * abi
--     --敏捷
--     roleData.agility = ( data.InitialAgility   + data.AgilityDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.AgiUp) * abi
--     --智力
--     roleData.intelligence = ( data.InitialIntelligence + data.IntelligenceDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.IntUp) * abi
--     --专注
--     roleData.focus = ( data.InitialFocus + data.FocusDevelopment * math.pow(1.5, roleData.star - 1)* roleData.lv + qualityData.FocUp) * abi

--     --二级属性
--     --HP
--     roleData.HP = data.InitialBlood + math.floor(roleData.constitution/5)*50 + (roleData.constitution- math.floor(roleData.constitution/5))*10 + qualityData.HPUp
--     roleData.MaxHP = roleData.HP
--     --MP
--     roleData.MP = data.InitialMagic + qualityData.MPUp
--     --单位时间魔法恢复值
--     roleData.timeRecMP = data.TimeRecoveryMagic
--     --魔法上限值
--     roleData.MaxMP = data.MagicUpperLimit
--     --物攻
--     roleData.phyAtk = data.InitialPhysicalAttack + math.floor(roleData.force/5)*5 + (roleData.force - math.floor(roleData.force/5))*1 + qualityData.STRUp
--     --物防
--     roleData.phyDef = data.InitialPhysicalDefense + math.floor(roleData.force/5)*2.5 + (roleData.force- math.floor(roleData.force/5))*0.5 + qualityData.DEFUp
--     --魔攻
--     roleData.magAtk = data.InitialMagicAttack + math.floor(roleData.intelligence/5)*5+(roleData.intelligence- math.floor(roleData.intelligence/5))*1 + qualityData.ATSUp
--     --魔防
--     roleData.magDef = data.InitialMagicDefense + math.floor(roleData.intelligence/5)*2.5+(roleData.intelligence- math.floor(roleData.intelligence/5))*0.5 + qualityData.ADFUp
--     --命中
--     roleData.hit = data.InitialHit + math.floor(roleData.focus/5)*10+(roleData.focus- math.floor(roleData.focus/5))*2 + qualityData.DEXUp
--     --闪避
--     roleData.dodge = data.InitialDodge + math.floor(roleData.agility/5)*5+(roleData.agility- math.floor(roleData.agility/5))*1 + qualityData.AGLUp
--     --暴击
--     roleData.critical = data.InitialCritical + math.floor(roleData.focus/5)*8+(roleData.focus- math.floor(roleData.focus/5))*1.8 + qualityData.CRLUp
--     --暴抗
--     roleData.criRes = data.InitialCriticalResistance + math.floor(roleData.agility/5)*8+(roleData.agility- math.floor(roleData.agility/5))*1.8 + qualityData.CRTUp
--     --暴击伤害
--     roleData.criStrikes = data.InitialCriticalStrikes + qualityData.CRSUp
--     --物穿
--     roleData.phyPnt = data.PhysicalPenetration + qualityData.DIGUp
--     --魔穿
--     roleData.magPnt = data.MagicPenetration + qualityData.AIGUp

--     return roleData
-- end

function initRoleData( data )
    local roleData = {}
    if data.objType ~= 1 then
        return nil
    end
    --发挥度
    local abi = data.AbilityValue or 1
    --id
    roleData.id = data.id or 3
    --等级 
    roleData.lv = data.Level or data.level or 1
    --星级
    roleData.star = data.start or 1
    --品质(星座)
    roleData.quality = data.qualityLevel or 1
    --孔位(敌方直接满孔位)
    roleData.hole = data.startNode or 0

    --得到星座属性
    local qualityData = QualityFormat:getQualityData( roleData.id, roleData.quality, roleData.hole, true )

    --一级属性
    --力量
    roleData.force = ( data.InitialForce + data.ForceDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.FceUp) * abi
    --体质
    roleData.constitution = ( data.InitialConstitution + data.ConstitutionDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.ConUp) * abi
    --敏捷
    roleData.agility = ( data.InitialAgility   + data.AgilityDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.AgiUp) * abi
    --智力
    roleData.intelligence = ( data.InitialIntelligence + data.IntelligenceDevelopment * math.pow(1.5, roleData.star - 1) * roleData.lv + qualityData.IntUp) * abi
    --专注
    roleData.focus = ( data.InitialFocus + data.FocusDevelopment * math.pow(1.5, roleData.star - 1)* roleData.lv + qualityData.FocUp) * abi

    --二级属性
    --HP
    roleData.HP = data.InitialBlood + math.floor(roleData.constitution/5)*50 + (roleData.constitution- math.floor(roleData.constitution/5))*10 + qualityData.HPUp
    roleData.MaxHP = roleData.HP
    --MP
    roleData.MP = data.InitialMagic + qualityData.MPUp
    --单位时间魔法恢复值
    roleData.timeRecMP = data.TimeRecoveryMagic
    --魔法上限值
    roleData.MaxMP = data.MagicUpperLimit
    --物攻
    roleData.phyAtk = data.InitialPhysicalAttack + math.floor(roleData.force/5)*5 + (roleData.force - math.floor(roleData.force/5))*1 + qualityData.STRUp
    --物防
    roleData.phyDef = data.InitialPhysicalDefense + math.floor(roleData.force/5)*2.5 + (roleData.force- math.floor(roleData.force/5))*0.5 + qualityData.DEFUp
    --魔攻
    roleData.magAtk = data.InitialMagicAttack + math.floor(roleData.intelligence/5)*5+(roleData.intelligence- math.floor(roleData.intelligence/5))*1 + qualityData.ATSUp
    --魔防
    roleData.magDef = data.InitialMagicDefense + math.floor(roleData.intelligence/5)*2.5+(roleData.intelligence- math.floor(roleData.intelligence/5))*0.5 + qualityData.ADFUp
    --命中
    roleData.hit = data.InitialHit + math.floor(roleData.focus/5)*10+(roleData.focus- math.floor(roleData.focus/5))*2 + qualityData.DEXUp
    --闪避
    roleData.dodge = data.InitialDodge + math.floor(roleData.agility/5)*5+(roleData.agility- math.floor(roleData.agility/5))*1 + qualityData.AGLUp
    --暴击
    roleData.critical = data.InitialCritical + math.floor(roleData.focus/5)*8+(roleData.focus- math.floor(roleData.focus/5))*1.8 + qualityData.CRLUp
    --暴抗
    roleData.criRes = data.InitialCriticalResistance + math.floor(roleData.agility/5)*8+(roleData.agility- math.floor(roleData.agility/5))*1.8 + qualityData.CRTUp
    --暴击伤害
    roleData.criStrikes = data.InitialCriticalStrikes + qualityData.CRSUp
    --物穿
    roleData.phyPnt = data.PhysicalPenetration + qualityData.DIGUp
    --魔穿
    roleData.magPnt = data.MagicPenetration + qualityData.AIGUp

    return roleData
end

--伤害计算(攻击方数据:atkAttr，防御方数据:defAttr，攻击类型:atkInfo)
function calcHurt(atkAttr, defAttr, atkInfo)

    --暂时配置的技能等级，到时候需要通过国都传进来
    local skillLevel = 90

    if not atkAttr or not defAttr then
        return nil, nil
    end

    if not TABLE_D.getValue("DmgCorrection_Total") then
        print("----------KeyVal 为空")
        return nil,nil
    end

    --local atkInfo = {}
    atkInfo = atkInfo or { DamageCoefficient = 1, DamageInitialValue = 0, DamageGrowthValue = 0, SkillLevelCap = 1, AtkType = 1, IfHit = 0 }

    local DmgCorrection_LeftLimit = tonumber(TABLE_D.getValue("DmgCorrection_LeftLimit"))
    local DmgCorrection_RightLimit = tonumber(TABLE_D.getValue("DmgCorrection_RightLimit"))
    local DmgCorrection_Total = tonumber(TABLE_D.getValue("DmgCorrection_Total"))
    local DmgLimit_Lowest = tonumber(TABLE_D.getValue("DmgLimit_Lowest"))
    local OtherParameter_PntTotal= tonumber(TABLE_D.getValue("OtherParameter_PntTotal"))
    local OtherParameter_CriStrikesTotal = tonumber(TABLE_D.getValue("OtherParameter_CriStrikesTotal"))

    --伤害状态[未命中Miss，普通Normal，暴击Boom]、伤害数值
    local dmgState,dmgValue

    --判断命中相关：命中范围、命中投针 (当atkInfo.IfHit 为 1 时是必中)
    if atkInfo.IfHit ~= 1 then
        local hitRange = 0.5 + 0.5 * atkAttr.lv / defAttr.lv * (atkAttr.hit / (atkAttr.hit + defAttr.dodge));
        local hitNeedle = math.random()
        --未命中情况
        if hitNeedle > hitRange then
            dmgState = DmgStateTab_Miss
            dmgValue = 0
            return dmgState, dmgValue
        end
    end
    
    --命中情况----判断物攻还是魔攻----计算伤害
    --这个是伤害修正值
    local correctionRand = math.random(DmgCorrection_LeftLimit,DmgCorrection_RightLimit) / DmgCorrection_Total
    if atkInfo.AtkType == AtkTypeTab_Phy then
        local tempPnt = OtherParameter_PntTotal - atkAttr.phyPnt
        if tempPnt > OtherParameter_PntTotal then
            tempPnt = 1
        elseif tempPnt > 0 then
            tempPnt = tempPnt / OtherParameter_PntTotal
        else
            tempPnt = 0
        end
        dmgValue = math.pow(atkAttr.phyAtk, 2)/(2 * defAttr.phyDef * tempPnt ) * correctionRand 
    elseif atkInfo.AtkType == AtkTypeTab_Mag then 
        local tempPnt = OtherParameter_PntTotal - atkAttr.magPnt
        if tempPnt > OtherParameter_PntTotal then
            tempPnt = 1
        elseif tempPnt > 0 then
            tempPnt = tempPnt / OtherParameter_PntTotal
        else
            tempPnt = 0
        end
        dmgValue = math.pow(atkAttr.magAtk, 2)/(2 * defAttr.magDef * tempPnt ) * correctionRand
    end
    --添加技能伤害
    dmgValue = dmgValue * atkInfo.DamageCoefficient + atkInfo.DamageInitialValue + atkInfo.DamageGrowthValue * math.min(skillLevel, atkInfo.SkillLevelCap, 90)

    --判断暴击相关：暴击范围、暴击投针
    local criRange = 0.1 + (atkAttr.critical / (atkAttr.critical + defAttr.criRes)) * 0.4
    local criNeedle = math.random()
    --未暴击情况
    if criNeedle > criRange then
        dmgState = DmgStateTab_Normal
        
        if dmgValue < DmgLimit_Lowest then
            dmgValue = DmgLimit_Lowest
        else
            dmgValue = math.floor(dmgValue)
        end
        return dmgState,dmgValue
    end
    --暴击
    dmgState = DmgStateTab_Boom
    dmgValue = dmgValue * atkAttr.criStrikes / OtherParameter_CriStrikesTotal
    
    if dmgValue < DmgLimit_Lowest then
            dmgValue = DmgLimit_Lowest
        else
            dmgValue = math.floor(dmgValue)
    end
    return dmgState,dmgValue

end
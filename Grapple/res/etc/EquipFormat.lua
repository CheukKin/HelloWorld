local EquipFormat = {}

function EquipFormat:calcEquipAttr( data )
	trace1("-----------装备为 %o", data)
	assert(data ~= nil and type(data) == "table" and data.itemid ~= nil and data.lv ~= nil, "data must not nil and itemid,lv must not nil")
	local exertPec = TABLE_D.getStrengthen(data.lv).ExertPecent
	local equip = TABLE_D.getEquipInfo(data.itemid)
	local equipProp = TABLE_D.getEquipProp(equip.AttrID)
	local attrName = {"FceUp", "ConUp", "AgiUp", "IntUp", "FocUp", "HPUp", "HPRecUp", "MPUp", "MPRecUp", "STRUp", "DEFUp", "ATSUp", "ADFUp", "DEXUp", "AGLUp", "CRLUp", "CRTUp", "CRSUp", "DIGUp", "AIGUp"}
	local equipAttr = {}
	for _,v in ipairs(attrName) do
		equipAttr[v] = equipProp[v] * exertPec
	end
	return equipAttr
end

function EquipFormat:calcAllEquipAttr( data )
	trace1("-----------装备表为 %o", data)
	local equipAttr = {}
	local attrName = {"FceUp", "ConUp", "AgiUp", "IntUp", "FocUp", "HPUp", "HPRecUp", "MPUp", "MPRecUp", "STRUp", "DEFUp", "ATSUp", "ADFUp", "DEXUp", "AGLUp", "CRLUp", "CRTUp", "CRSUp", "DIGUp", "AIGUp"}
	for _,v in ipairs(attrName) do
		equipAttr[v] = 0
	end
	if not data then 
		trace1("-----------if里面的装备表为 %o", data)
		print("-------装备表为导致退出")
		return equipAttr 
	end
	for _,equip in pairs(data) do
		trace1("-----------记录下equip输出为 %o", equip)
		local equipCell = self:calcEquipAttr(equip)
		for _,v in ipairs(attrName) do
			equipAttr[v] = equipAttr[v] + equipCell[v]
		end
	end
	print("------------过去了")
	return equipAttr
end

return EquipFormat
local QualityFormat = {}
--角色id，星座，孔位，是否为统计结果
function QualityFormat:getQualityAttr( id, constellation, hole, isAll )
	local isAll = isAll or false
	if hole == 0 then constellation = constellation + 1 end
	local qualityAttr = {}
	local attrName = {"FceUp", "ConUp", "AgiUp", "IntUp", "FocUp", "HPUp", "HPRecUp", "MPUp", "MPRecUp", "STRUp", "DEFUp", "ATSUp", "ADFUp", "DEXUp", "AGLUp", "CRLUp", "CRTUp", "CRSUp", "DIGUp", "AIGUp"}
	for _,v in ipairs(attrName) do
		qualityAttr[v] = 0
	end
	if isAll then
		qualityAttr.Explain = "这个是统计和"
		for i=1,constellation-1 do
			local uid = i * 100 + id *10000
			local tempData = TABLE_D.getConstellation(uid)
			for _,v in ipairs(attrName) do
				qualityAttr[v] = qualityAttr[v] + tempData[v]
			end
		end	
		for i=1,hole do
			local uid = i + constellation * 100 + id *10000
			local tempData = TABLE_D.getConstellation(uid)
			for _,v in ipairs(attrName) do
				qualityAttr[v] = qualityAttr[v] + tempData[v]
			end
		end
	else
		local uid = hole + constellation * 100 + id *10000
		qualityAttr = TABLE_D.getConstellation(uid)
	end
	return qualityAttr
end

return QualityFormat
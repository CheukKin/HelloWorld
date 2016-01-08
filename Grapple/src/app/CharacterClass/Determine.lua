--
-- Author: student
-- Date: 2015-11-23 21:19:58
--
module("Determine", package.seeall)

function ShangHai(e1,e2)
	local shanbiNUM = math.random(1,100)
	if e2.shanbi*shanbiNUM < 80 then
	 	--攻击成功
	 	e2.xueliang = e2.xueliang - ((e1.gongjili * e1.buffzhuangtai) - (e2.fangyuli * e2.buffzhuangtai))
 	else
 		--攻击失败

	end 
end
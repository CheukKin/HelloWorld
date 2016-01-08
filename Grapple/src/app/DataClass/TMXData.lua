--
-- Author: student
-- Date: 2015-11-19 21:23:16
--
module("TMXData", package.seeall)
----[[
GuanKa = {}

GuanKa[1]={}
GuanKa[1][1]={name = "data/map/gulangyuditu.tmx",guaiwu = {boShu=3,g = {1,2,1}}}
GuanKa[1][2]={name = "data/map/gulangyuditu1.tmx",guaiwu = {boShu=3,g = {3,4,3}}}

GuanKa[2]={}
GuanKa[2][1]={name = "data/map/huochezhan.tmx",guaiwu = {boShu=3,g = {2,4,2}}}
GuanKa[2][2]={name = "data/map/huochezhan2.tmx",guaiwu = {boShu=3,g = {2,2,3}}}

GuanKa[3]={}
GuanKa[3][1]={name = "data/map/shamo2.tmx",guaiwu = {boShu=3,g = {2,3,4}}}
GuanKa[3][2]={name = "data/map/shamo1.tmx",guaiwu = {boShu=4,g = {1,2,2,3}}}

GuanKa[4]={}
GuanKa[4][1]={name = "data/map/yechang1.tmx",guaiwu = {boShu=4,g = {2,3,3,4}}}
GuanKa[4][2]={name = "data/map/yechang2.tmx",guaiwu = {boShu=4,g = {2,2,3,5}}}


GuaiWu = {}

GuaiWu[1]={}
GuaiWu[1][1]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 100,fangyu = 20,gongjili = 30,shanbi = 0.2}
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 100,fangyu = 20,gongjili = 30,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 100,fangyu = 20,gongjili = 30,shanbi = 0.2}
	},
	{
		{name = "spine/sp-caotijing/",xueliang = 200,fangyu = 30,gongjili = 50,shanbi = 0.4}
	}
}
GuaiWu[1][2]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2}
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-caotijing/",xueliang = 500,fangyu = 50,gongjili = 100,shanbi = 0.5}
	}
}
GuaiWu[2]={}
GuaiWu[2][1]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-mianhuatang/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	}
}
GuaiWu[2][2]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-mianhuatang/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	}
}

GuaiWu[3]={}
GuaiWu[3][1]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-lufei/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	}
}
GuaiWu[3][2]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-lufei/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	}
}
GuaiWu[4]={}
GuaiWu[4][1]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-liandao/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	}
}
GuaiWu[4][2]={
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	},
	{
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-zuozhu/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
		{name = "spine/sp-liandao/",xueliang = 150,fangyu = 25,gongjili = 35,shanbi = 0.2},
	}
}

guanqia = {}
guanqia[1] = {}
guanqia[1][1] = {lock = 1,name = "恶魔城-1"}
guanqia[1][2] = {lock = 0,name = "恶魔城-2"}
guanqia[2] = {}
guanqia[2][1] = {lock = 0,name = "德克之心-1"}
guanqia[2][2] = {lock = 0,name = "德克之心-2"}
guanqia[3] = {}
guanqia[3][1] = {lock = 0,name = "浮空大陆-1"}
guanqia[3][2] = {lock = 0,name = "浮空大陆-2"}
guanqia[4] = {}
guanqia[4][1] = {lock = 0,name = "赤雨十三街-1"}
guanqia[4][2] = {lock = 0,name = "赤雨十三街-2"}

--]]
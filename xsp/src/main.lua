Version = "2019-09-27";
--↓↓↓↓↓通知方法↓↓↓↓↓
function println(context)
	toast(context);
	print(context);
end
--↓↓↓↓↓点击方法↓↓↓↓↓
function tap(x, y,r1,r2)
	math.randomseed(os.time());
	if r1==nil then
		r1=math.random(20);
	end
	if r2==nil then
		r2=math.random(20);
	end
	touchDown(0, x+r1, y+r2);
	mSleep(200);
	touchUp(0, x+r1, y+r2);
end
--↓↓↓↓↓等待超时重启脚本↓↓↓↓↓
function untilError(timeNow)
	--如果等于0则表示初始化等待超时脚本
	if timeNow == 0 then
		timeEnd=mTime()+600000;
	else
		if timeEnd-timeNow<=0 then
			println("脚本停止！！！！！！！！！！！！！！！！！！！");
			shutdown();
			lua_restart();
			mSleep(1000);
		end
	end
end
--↓↓↓↓↓等待黑色过场↓↓↓↓↓
function passE()
	local colord1,colord2,colord3;
	while true do
		colord1 = getColor(990, 659); --获取(100,100)的颜色值，赋值给color变量
		colord2 = getColor(1009, 682);
		if (colord1 ~= 0xffffff) then   --如果该点的颜色值等于0xffffff
			if(colord2 ~= 0xffffff) then
				break;
			end
		end
		mSleep(500);
	end
end
--↓↓↓↓↓阻塞查找颜色方法↓↓↓↓↓
function findUntil(color,degree,x1,y1,x2,y2,hdir,vdir)
	mSleep(1000);
	--等待过场
	passE();
	--执行查找
	local x,y;
	errorT = 0;
	while true do
		x, y = findColorInRegionFuzzy(color, degree, x1, y1, x2, y2, hdir, vdir)
		if x > -1 then
			break
		end
		if errorT>60 then
			println("脚本停止！".."color="..color..",degree="..degree..",x1="..x1..",y1="..y1..",x2="..x2..",y2="..y2..",hdir="..hdir..",vdir="..vdir);
			--			lua_exit();
			shutdown();
			lua_restart();
		end
		errorT=errorT+1;
		mSleep(500);
	end
	return x,y
end
--↓↓↓↓↓出现好友时点击取消方法↓↓↓↓↓
function friendsCancel()
	local friendsX, friendsY;
	friendsX, friendsY = findColorInRegionFuzzy(0x4faafb, 95, 703, 565, 714, 576, 0, 0)
	if friendsX > -1 then
		println("点击取消好友邀请");
		tap(friendsX,friendsY);
	end
end
function useSkill(useSkillP1)
	math.randomseed(os.time());
	if useSkillP1 == 2 then
		--查看第一个角色
		battleX, battleY = findColorInRegionFuzzy(0xe8e2aa, 95, 490, 601, 493, 603, 0, 0);
		if battleX > -1 then
			print("释放第一个技能");
			tap(battleX,battleY,10,10);
			mSleep(50);
			tap(battleX,battleY,10,10);
			--			mSleep(100+math.random(100));
		end
		--查看第二个角色
		battleX, battleY = findColorInRegionFuzzy(0xf2ecb3, 95, 651, 601, 654, 603, 0, 0);
		if battleX > -1 then
			print("释放第二个技能");
			tap(battleX,battleY,10,10);
			mSleep(50);
			tap(battleX,battleY,10,10);
			--			mSleep(100+math.random(100));
		end
		--查看第三个角色
		battleX, battleY = findColorInRegionFuzzy(0xf3ebb3, 95, 810, 601, 813, 603, 0, 0);
		if battleX > -1 then
			print("释放第三个技能");
			tap(battleX,battleY,10,10);
			mSleep(50);
			tap(battleX,battleY,10,10);
			--			mSleep(100+math.random(100));
		end
		--查看第四个角色
		battleX, battleY = findColorInRegionFuzzy(0xf1e7b0, 95, 966, 601, 969, 603, 0, 0);
		if battleX > -1 then
			print("释放第四个技能");
			tap(battleX,battleY,10,10);
			mSleep(50);
			tap(battleX,battleY,10,10);
			--			mSleep(100+math.random(100));
		end
		--查看第五个角色
		battleX, battleY = findColorInRegionFuzzy(0xf0e6ad, 95, 1124, 601, 1127, 603, 0, 0);
		if battleX > -1 then
			print("释放第五个技能");
			tap(battleX,battleY,10,10);
			mSleep(50);
			tap(battleX,battleY,10,10);
			--			mSleep(100+math.random(100));
		end
	end
end
--↓↓↓↓↓战斗界面通用方法↓↓↓↓↓
function battle(battleP1,battleP2)
	--[[
	battleP1表示是什么战斗
	每日任务：1
	活动任务：2
	素材任务：3
	==========
	battleP2表示是小队战还是团体战
	小队不可快速过图：11
	小队可以快速过图：12
	团体不可快速过图：21
	团体可以快速过图：22
	==========
	battleReturn = 1 当体力脚本体力不足时返回的参数
	]]--
	local battleX,battleY;
	battleReturn = 0;
	battleCount = 0;
	--先选择友军
	battleX,battleY=findUntil(0xf04a59, 95, 487, 561, 496, 567, 0, 0);
	println("选择友军支援");
	tap(battleX,battleY);
	--判断是小队战还是团体战
	--初始化超时等待函数
	untilError(0);
	while true do
		battleX, battleY = findColorInRegionFuzzy(0xef4757, 95, 1115, 602, 1120, 607, 0, 0)
		if battleX > -1 then
			println("这是小队战，不可快速过图");
			battleP2 = 11;
			tap(battleX,battleY);
			break;
		end
		battleX, battleY = findColorInRegionFuzzy(0xdfddb2, 100, 1111, 512, 1124, 538, 0, 0)
		if battleX > -1 then
			battleX, battleY = findColorInRegionFuzzy(0xb4b4b4, 95, 1116, 271, 1246, 308, 0, 0)
			if battleX > -1 then
				println("这是团体战，可以快速过图");
				battleP2 = 22;
				if battleP1 == 3 then
					println("这是素材任务，使用二队进行战斗");
					while true do
						battleX, battleY = findColorInRegionFuzzy(0xf19922, 95, 351, 312, 356, 317, 0, 0)
						if battleX > -1 then
							break;
						end
						tap(982,467);
						mSleep(1000+math.random(500));
					end
				end
				mSleep(1000+math.random(500));
				battleX, battleY = findColorInRegionFuzzy(0xb4b4b4, 95, 1116, 271, 1246, 308, 0, 0)
				tap(battleX,battleY);
				break;
			else
				println("这是团体战，不可快速过图");
				battleP2 = 21;
				battleX, battleY = findColorInRegionFuzzy(0xdfddb2, 100, 1111, 512, 1124, 538, 0, 0)
				tap(battleX,battleY);
				battleX,battleY=findUntil(0xf04959, 95, 491, 482, 500, 490, 0, 0);
				tap(battleX,battleY);
				break;
			end
		end
		mSleep(1000);
		untilError(mTime());
	end
	--等待进入到战斗界面，防止误判（快速过图无等待）
	if battleP2 ~= 22 then
		--	等待过场
		mSleep(1000);
		passE();
		battleX,battleY=findUntil(0x0063d6, 95, 658, 45, 660, 48, 0, 0);
		println("已经进入到了战斗界面");
	end
	if battleP2 == 11 then
		println("这是小队战，判断自动是否打开");
		while true do
			battleX, battleY = findColorInRegionFuzzy(0x59b2ff, 95, 54, 669, 59, 673, 0, 0);
			if battleX > -1 then
				println("自动已经打开了");
				break;
			else
				println("自动没有打开，尝试打开");
				tap(54,669);
			end
			mSleep(1000);
		end
		println("这是小队战，判断加速是否打开");
		while true do
			battleX, battleY = findColorInRegionFuzzy(0xf5f55e, 95, 274, 669, 278, 675, 0, 0);
			if battleX > -1 then
				println("加速已经打开了");
				break;
			else
				mSleep(1000);
				println("加速没有打开，尝试打开");
				tap(275,671);
			end
			mSleep(1000);
		end
	elseif battleP2 == 21 then
		println("这是团体战，判断加速是否打开");
		while true do
			battleX, battleY = findColorInRegionFuzzy(0xffff67, 95, 294, 22, 297, 25, 0, 0);
			if battleX > -1 then
				println("加速已经打开了");
				break;
			else
				println("加速没有打开，尝试打开");
				tap(295,23);
			end
			--20190829:此处额外判断一遍是否已经战斗结束了，有时候因为太快了所以没来得及判断是否开启了加速就过去了
			battleX, battleY = findColorInRegionFuzzy(0xfff513, 95, 142, 159, 145, 163, 0, 0)
			if battleX > -1 then
				println("太快了，战斗结束了");
				break;
			end
			mSleep(1000);
		end
	end
	--尝试点击结算
	while true do
		--初始化随机函数并随机等待一段时间
		math.randomseed(os.time());
		mSleep(1000+math.random(500));
		--先判断是否是快速过图，如果是的话判断体力是否充足
		if battleP2 == 22 then
			--判断是否出现体力不足
			battleX, battleY = findColorInRegionFuzzy(0x4498eb, 95, 759, 431, 764, 435, 0, 0)
			if battleX > -1 then
				println("体力不足");
				--点击取消
				println("点击取消");
				tap(battleX,battleY);
				mSleep(300+math.random(400));
				--点击返回主界面
				battleX,battleY=findUntil(0xea4858, 96, 1138, 16, 1182, 58, 0, 0);
				println("点击返回主界面");
				tap(battleX,battleY);
				mSleep(1000);
				passE();
				battleReturn=1;
				break;
			end
		end
		--开始判断各种情况
		--		--判断团体战是否加速一直打开（应对多场战斗）
		--		if battleP2 == 21 then
		--			battleX, battleY = findColorInRegionFuzzy(0xffff67, 95, 294, 22, 297, 25, 0, 0);
		--			if battleX > -1 then
		--			else
		--				println("加速没有打开，尝试打开");
		--				tap(295,23);
		--				mSleep(1000);
		--			end
		--		end
		--判断战斗是否失败
		battleX, battleY = findColorInRegionFuzzy(0x085dad, 95, 446, 466, 451, 471, 0, 0)
		if battleX > -1 then
			println("战斗失败了");
			tap(battleX,battleY);
		end
		battleX, battleY = findColorInRegionFuzzy(0xff4960, 95, 515, 415, 520, 420, 0, 0)
		if battleX > -1 then
			println("失败确认");
			tap(battleX,battleY);
		end
		--判断是否有好友邀请
		friendsCancel();
		--判断是否有抽奖，奖励等
		battleX, battleY = findColorInRegionFuzzy(0x76cb6e, 95, 881, 588, 1009, 625, 0, 0)
		if battleX > -1 then
			println("有抽奖");
			tap(battleX,battleY);
		end
		--[[
		最后判断是否已经返回到主界面了，判断依据是返回主界面的红色房子，需严格判断0xff485d, 100, 1100, 37, 1105, 40, 0, 0，
		暂时无法进行严格判断，因为每日任务的返回界面的home与其它的位置不同，改为模糊判断，需注意角色对其的影响
		需要在点击之前，但是所有判断最后
		]]--
		battleX, battleY = findColorInRegionFuzzy(0xff485d, 90, 1140, 30, 1143, 33, 0, 0);
		if battleX > -1 then
			println("已经返回到主界面了");
			break;
		end
		--对于团队战，点击释放技能
		if battleP2 == 21 then
			useSkill(2);
		end
		--最后点击（判断10次点击一次）
		if battleCount >= 3 then
			tap(1020,555,math.random(125),math.random(40));
			print("尝试点击结算");
			battleCount = 0;
		end
		battleCount = battleCount + 1;
	end
	return battleReturn;
end
function eBattle(eBattleP)
	local eBattleX,eBattleY,eBattleT;
	--	等待过场
	mSleep(1000);
	passE();
	--循环判断进入战斗
	--	while true do
	--		--判断是否有确认按钮
	--		--		eBattleX, eBattleY = findColorInRegionFuzzy(0xf04959, 95, 491, 482, 500, 490, 0, 0)
	--		--		if eBattleX > -1 then
	--		--			tap(eBattleX,eBattleY);
	--		--		end
	--		--判断是否进入战斗（战斗类型是哪种）
	--		eBattleX, eBattleY = findColorInRegionFuzzy(0x0063d6, 95, 658, 45, 660, 48, 0, 0)
	--		if eBattleX > -1 then
	--			eBattleX, eBattleY = findColorInRegionFuzzy(0xcacaca, 95, 792, 56, 796, 58, 0, 0)
	--			if eBattleX > -1 then
	--				eBattleT = 1;
	--			else
	--				eBattleT = 2;
	--			end
	--			break;
	--		end
	--		mSleep(500);
	--	end
	--等待进入到战斗界面，防止误判
	eBattleX,eBattleY=findUntil(0x0063d6, 95, 658, 45, 660, 48, 0, 0);
	println("已经进入到了战斗界面，判断战斗类型");
	--判断是否是团体作战，若不是则先查看AUTO是否开启
	while true do
		
		if ebattleT == 1 then
			println("这是小队战，判断自动是否打开");
			eBattleX, eBattleY = findColorInRegionFuzzy(0x7391b0, 95, 53, 666, 64, 673, 0, 0);
			if eBattleX > -1 then
				println("自动没有打开，尝试打开");
				tap(eBattleX,eBattleY);
			else
				eBattleX, eBattleY = findColorInRegionFuzzy(0x59b0ff, 95, 54, 668, 58, 672, 0, 0);
				if eBattleX > -1 then
					println("自动已经打开了");
					break;
				end
			end
		elseif ebattleT == 2 then
			println("这是团体战");
		end
		
		
		
		
		eBattleX, eBattleY = findColorInRegionFuzzy(0xcacaca, 95, 792, 56, 796, 58, 0, 0);
		if eBattleX > -1 then
			
		else
			println("这是团体战");
			break;
		end
		mSleep(100);
	end
	--不断点击确定的那里，直到回到主界面
	eBattleCount = 0;
	while true do
		--等待1000
		math.randomseed(os.time());
		mSleep(100+math.random(400));
		--点击（判断10次点击一次）
		if eBattleCount >= 10 then
			tap(1020,555,math.random(125),math.random(40));
			println("尝试点击结算");
			eBattleCount = 0;
		end
		--查看是否有好友邀请
		friendsCancel();
		eBattleCount = eBattleCount + 1;
		colord1 = getColor(990, 659); --获取(100,100)的颜色值，赋值给color变量
		colord2 = getColor(1009, 682);
		colord3 = getColor(5, 5);
		if (colord1 == 0xffffff) then   --如果该点的颜色值等于0xffffff
			if(colord2 == 0xffffff) then
				if (colord3 == 0x000000) then
					println("已经出去，结束战斗循环");
					break;
				end
			end
		end
		
	end
	println("等待返回到主界面");
	--循环判断是否返回主界面
	while true do
		--查看是否有抽奖
		eBattleX, eBattleY = findColorInRegionFuzzy(0x76cb6e, 95, 881, 588, 1009, 625, 0, 0)
		if eBattleX > -1 then
			println("有抽奖");
			tap(eBattleX,eBattleY);
		end
		--再判断是否返回到主界面
		eBattleX, eBattleY = findColorInRegionFuzzy(0xeeee44, 100, 0, 54, 32, 99, 0, 0)
		if eBattleX > -1 then
			break;
		end
		mSleep(500);
	end
	--	touchX,touchY=findUntil(0xeeee44, 100, 0, 54, 32, 99, 0, 0);
	println("已经回到主界面了");
end
function eventStart()
	local touchX,touchY,eStartT;
	eStartT = 0;
	--活动按钮并点击
	touchX,touchY=findUntil(0x17b4c5, 100, 236, 664, 253, 677, 0, 0);
	tap(touchX,touchY);
	--进入活动界面并点击
	if eDif == "0" then
		println("选择难度为高级");
		touchX,touchY=findUntil(0x323232, 95, 582, 442, 584, 443, 0, 0);
	elseif eDif == "1" then
		println("选择难度为超级");
		touchX,touchY=findUntil(0xa2978a, 95, 573, 304, 582, 310, 0, 0);
	end
	tap(touchX,touchY,253,40);
	battle(2,21);
	--	--进入友军界面
	--	touchX,touchY=findUntil(0xf04a59, 95, 487, 561, 496, 567, 0, 0);
	--	tap(touchX,touchY);
	--进入出击界面，由此处判断活动是小队战还是团体战
	--	while true do
	--		eBattleX, eBattleY = findColorInRegionFuzzy(0xef4757, 95, 1115, 602, 1120, 607, 0, 0)
	--		if eBattleX > -1 then
	--			println("这是小队战");
	--			eStartT = 1;
	--			tap(eBattleX,eBattleY);
	--			break;
	--		end
	--		eBattleX, eBattleY = findColorInRegionFuzzy(0xdfddb2, 100, 1111, 512, 1124, 538, 0, 0)
	--		if eBattleX > -1 then
	--			println("这是团体战");
	--			eStartT = 2;
	--			tap(eBattleX,eBattleY);
	--			touchX,touchY=findUntil(0xf04959, 95, 491, 482, 500, 490, 0, 0);
	--			tap(touchX,touchY);
	--			break;
	--		end
	--	end
	--	eBattle(eStartT);
end
function eventCheckStart()
	local eventX, eventY;
	--先判断是否有活动
	eventX, eventY = findColorInRegionFuzzy(0x1d3e48, 95, 238, 665, 241, 668, 0, 0)
	if eventX > -1 then
		println("没有活动");
	else
		--暂时更改为反向判断，判断体力那里是不是为空的黑色，因为判断颜色有可能会失误 0x059e2a, 95, 283, 703, 291, 711, 0, 0
		eventX, eventY = findColorInRegionFuzzy(0x000000, 95, 285, 705, 288, 707, 0, 0)
		if eventX > -1 then
			println("无活动体力");
		else
			println("开始活动脚本");
			while true do
				eventStart();
				--暂时更改为反向判断，判断体力那里是不是为空的黑色，因为判断颜色有可能会失误 0x059e2a, 95, 283, 703, 291, 711, 0, 0
				eventX, eventY = findColorInRegionFuzzy(0x000000, 95, 285, 705, 288, 707, 0, 0)
				if eventX > -1 then
					break;
				else
					println("活动体力还有剩余，再次进行");
				end
			end
		end
	end
	println("活动脚本执行完毕");
end
--↓↓↓↓↓普通刷素材函数↓↓↓↓↓
function nStartTO()
	local touchX,touchY;
	math.randomseed(os.time());
	--找普通图按钮
	touchX,touchY=findUntil(0xda5e4e, 95, 95, 648, 179, 690, 0, 0);
	println("点击出击按钮");
	tap(touchX,touchY);
	mSleep(300+math.random(400));
	--等待到达普通图界面，点击育成（颜色相似，必须100%相似度）
	touchX,touchY=findUntil(0x647a1c, 100, 275, 135, 435, 175, 0, 0);
	println("点击育成");
	tap(touchX,touchY);
	mSleep(300+math.random(400));
	--等待育成变成绿色，点击进化素材
	touchX,touchY=findUntil(0xc1ff4a, 95, 275, 135, 435, 175, 0, 0);
	println("点击进化素材");
	tap(570,385,math.random(615),math.random(135));
	mSleep(300+math.random(400));
	--等待右上出现黑框，点击第一个
	touchX,touchY=findUntil(0x4b1d55, 95, 991, 114, 993, 117, 0, 0);
	println("点击副本");
	--选择不同的属性副本
	if nMet == "1" then
		touchX, touchY = findColorInRegionFuzzy(0x0655de, 95, 836, 348, 840, 352, 0, 0);
		if touchX <= -1 then
			touchX = 388+math.random(501);
			touchY = 208+math.random(78);
		end
	elseif nMet == "2" then
		touchX, touchY = findColorInRegionFuzzy(0x0a8812, 95, 834, 459, 838, 463, 0, 0);
		if touchX <= -1 then
			touchX = 388+math.random(501);
			touchY = 208+math.random(78);
		end
	elseif nMet == "3" then
		touchX, touchY = findColorInRegionFuzzy(0xd2ca0c, 95, 832, 560, 835, 564, 0, 0);
		if touchX <= -1 then
			touchX = 388+math.random(501);
			touchY = 208+math.random(78);
		end
	elseif nMet == "4" then
		mSleep(1000)
		touchDown(1, 450, 340)
		mSleep(50)
		touchMove(1, 450, 330)
		mSleep(50)
		touchMove(1, 450, 320)
		mSleep(50)
		touchMove(1, 450, 310)
		mSleep(50)
		touchMove(1, 450, 300)
		mSleep(50)
		touchMove(1, 450, 290)
		mSleep(50)
		touchMove(1, 450, 280)
		mSleep(50)
		touchUp(1, 450, 240)
		mSleep(2000)
		nStartTOCount = 0;
		while true do
			touchX, touchY = findColorInRegionFuzzy(0x6352a1, 95, 445, 550, 450, 555, 0, 0);
			if touchX > -1 then
				break;
			end
			if nStartTOCount >= 10 then
				touchX = 388+math.random(501);
				touchY = 208+math.random(78);
				break;
			end
			nStartTOCount = nStartTOCount + 1;
			mSleep(1000);
		end
	else
		touchX = 388+math.random(501);
		touchY = 208+math.random(78);
	end
	tap(touchX,touchY,0,0);--第一个
	--	tap(388,418,math.random(501),math.random(78));--木
	mSleep(300+math.random(400));
end
function nStart()
	local x,y,touchX,touchY;
	nStartReturn=0;
	--初始化随机函数
	math.randomseed(os.time());
	println("执行体力脚本");
	--判断是否已经在选择难度界面了，可以节约时间
	touchX, touchY = findColorInRegionFuzzy(0x333333, 95, 511, 219, 856, 300, 0, 0)
	if touchX > -1 then
		println("已经在难度选择，判断是否在进化素材");
		--判断是否在进化素材界面，判断右边黑框，防止出现在活动难度界面
		touchX, touchY = findColorInRegionFuzzy(0x4b1d55, 95, 991, 114, 993, 117, 0, 0)
		if touchX > -1 then
			println("已经在进化素材了，直接点击即可");
		else
			println("尝试进入进化素材界面");
			nStartTO();
		end
	else
		println("尝试进入进化素材界面");
		nStartTO();
	end
	--等待进入难度选择，选择第一个
	touchX,touchY=findUntil(0x333333, 95, 511, 219, 856, 300, 0, 0);
	println("选择难度");
	tap(touchX,touchY);
	mSleep(300+math.random(400));
	nStartReturn = battle(3,22);
	
	
	
	--[[
	--选择友军支援
	touchX,touchY=findUntil(0xf04a59, 95, 487, 561, 496, 567, 0, 0);
	println("选择友军支援");
	tap(touchX,touchY);
	mSleep(300+math.random(400));
	--等待进入出击界面，点击快速过图
	touchX,touchY=findUntil(0xb4b4b4, 95, 1116, 271, 1246, 308, 0, 0);
	println("快速过图");
	tap(touchX,touchY);
	mSleep(300+math.random(400));
	--战斗
	println("战斗");
	while true do
		--等待1000
		math.randomseed(os.time());
		mSleep(1000+math.random(3000));
		--判断是否出现体力不足
		touchX, touchY = findColorInRegionFuzzy(0x4498eb, 95, 759, 431, 764, 435, 0, 0)
		if touchX > -1 then
			println("体力不足");
			--点击取消
			println("点击取消");
			tap(touchX,touchY);
			mSleep(300+math.random(400));
			--点击返回主界面
			touchX,touchY=findUntil(0xea4858, 96, 1138, 16, 1182, 58, 0, 0);
			println("点击返回主界面");
			tap(touchX,touchY);
			mSleep(1000);
			passE();
			nStartReturn=1;
			break;
		end
		--点击
		tap(1020,555,math.random(125),math.random(40));
		--查看是否有好友邀请
		friendsCancel();
		x, y = findColorInRegionFuzzy(0xeeee44, 100, 0, 54, 32, 99, 0, 0)
		if x > -1 then
			println("已经出去，结束战斗循环");
			break;
		end
		println("还在战斗循环ing");
	end
	]]--
	
	println("体力战斗脚本执行完毕");
	return nStartReturn;
end
function nCheckStart()
	while nStart()==0 do
		mSleep(500);
		println("再次执行体力脚本");
	end
	println("体力检查结束");
end
--↓↓↓↓↓对决函数↓↓↓↓↓
function dStartTO()
	--初始化变量
	local x,y,touchX,touchY;
	dStartTOReturn = 0;
	--初始化随机函数
	math.randomseed(os.time());
	--先判断是否还有对决体力
	touchX, touchY = findColorInRegionFuzzy(0x000000, 95, 439, 704, 442, 708, 0, 0)
	if touchX > -1 then
		println("没有对决体力了");
		dStartTOReturn = 1;
	else
		println("有对决体力");
		touchX,touchY=findUntil(0xce7523, 95, 390, 665, 395, 670, 0, 0);
		println("点击对决界面");
		tap(touchX,touchY);
		--		touchX,touchY=findUntil(0xef455d, 95, 932, 578, 938, 584, 0, 0);
		--		println("进入到对决界面");
		while true do
			--判断对决是否可用
			touchX, touchY = findColorInRegionFuzzy(0x77232a, 95, 930, 578, 935, 580, 0, 0)
			if touchX > -1 then
				println("对决暂时不可用");
				dStartTOReturn = 2;
				break;
			end
			touchX, touchY = findColorInRegionFuzzy(0xef455d, 95, 932, 578, 938, 584, 0, 0)
			if touchX > -1 then
				println("进入到对决界面");
				dStartTOReturn = 0;
				break;
			end
		end
	end
	return dStartTOReturn;
end
function dBattle()
	local dBattleX,dBattleY;
	--等待过场
	mSleep(1000);
	passE();
	--等待进入到战斗界面，防止误判
	dBattleX,dBattleY=findUntil(0x0063d6, 95, 658, 45, 660, 48, 0, 0);
	println("已经进入到了战斗界面");
	--不断点击确定的那里，直到回到主界面
	dBattleCount = 0;
	while true do
		--等待1000
		math.randomseed(os.time());
		mSleep(100+math.random(400));
		--点击（判断10次点击一次）
		if dBattleCount >= 20 then
			tap(575,595,math.random(120),math.random(35));
			println("尝试点击结算");
			dBattleCount = 0;
		end
		dBattleCount = dBattleCount + 1;
		colord1 = getColor(990, 659); --获取(100,100)的颜色值，赋值给color变量
		colord2 = getColor(1009, 682);
		colord3 = getColor(5, 5);
		if (colord1 == 0xffffff) then   --如果该点的颜色值等于0xffffff
			if(colord2 == 0xffffff) then
				if (colord3 == 0x000000) then
					println("已经出去，结束战斗循环");
					break;
				end
			end
		end
	end
end
function dSelectBattle()
	--初始化变量
	local x,y,touchX,touchY;
	dSelectBattleReturn = 0;
	while true do
		randomD = 0;
		--初始化随机函数
		math.randomseed(os.time());
		--等待进入对决选择界面
		mSleep(1000+math.random(3000));
		passE();
		while true do
			touchX, touchY = findColorInRegionFuzzy(0x297722, 95, 545, 646, 561, 657, 0, 0)
			if touchX > -1 then
				println("出现结算界面");
				dSelectBattleReturn = 1;
				break;
			end
			touchX, touchY = findColorInRegionFuzzy(0xe1d09f, 95, 69, 610, 74, 615, 0, 0)
			if touchX > -1 then
				println("进入到对决选择界面");
				break;
			end
			println("等待判断是否继续对决");
			mSleep(100+math.random(300));
		end
		if dSelectBattleReturn ==1 then
			break;
		end
		while true do
			--随机点击五个中的一个
			randomD = math.random(5) - 1;
			tap(710,129+randomD*111,math.random(50),math.random(20));
			println("随机点击第 "..randomD.." 个");
			mSleep(1000+math.random(3000));
			println("查看是否进入对决出击界面");
			touchX, touchY = findColorInRegionFuzzy(0xb01334, 95, 985, 542, 990, 547, 0, 0)
			if touchX > -1 then
				println("进入到对决出击界面");
				mSleep(1000+math.random(3000));
				tap(touchX,touchY);
				break;
			end
		end
		dBattle();
	end
	println("不断点击，直到返回对决界面");
	while true do
		tap(touchX,touchY);
		mSleep(1000+math.random(3000));
		x, y = findColorInRegionFuzzy(0xef455d, 95, 932, 578, 938, 584, 0, 0)
		if x > -1 then
			println("已经回到对决主界面了");
			break;
		end
	end
end
function dStart()
	--初始化变量
	local x,y,touchX,touchY;
	dStartReturn=0;
	--初始化随机函数
	math.randomseed(os.time());
	println("执行对决脚本");
	--判断是否已经在对决界面里面了，可以节约时间    0xef455d, 95, 932, 578, 938, 584, 0, 0
	--	touchX, touchY = findColorInRegionFuzzy(0xef455d, 95, 932, 578, 938, 584, 0, 0)
	--	if touchX > -1 then
	--		println("已经在对决界面里面了");
	--	else
	--		println("可能不在对决界面里面");
	--		dStartReturn = dStartTO();
	--	end
	--先进入对决界面
	dStartReturn = dStartTO();
	--开始执行战斗脚本
	while true do
		--等待1000
		math.randomseed(os.time());
		mSleep(1000+math.random(3000));
		--先判断是否还有体力
		if dStartReturn == 1 then
			println("体力不足且在主界面");
			--			dTF = "0";
			break;
		elseif dStartReturn == 2 then
			dTF = "1";
			touchX,touchY=findUntil(0xea4858, 96, 1138, 16, 1182, 58, 0, 0);
			println("点击返回主界面");
			tap(touchX,touchY);
			mSleep(1000);
			passE();
			dStartReturn = 1;
			break;
		elseif dStartReturn == 0 then
			--判断左上角的体力是否充足
			touchX, touchY = findColorInRegionFuzzy(0x360011, 95, 705, 50, 710, 55, 0, 0)
			if touchX > -1 then
				println("无对决体力，返回主界面并结束对决函数");
				touchX,touchY=findUntil(0xea4858, 96, 1138, 16, 1182, 58, 0, 0);
				println("点击返回主界面");
				tap(touchX,touchY);
				mSleep(1000);
				passE();
				dStartReturn = 1;
				break;
			else
				println("有对决体力，开始对决");
			end
		end
		--开始点击参战进入战斗
		touchX,touchY=findUntil(0xef455d, 95, 932, 578, 938, 584, 0, 0);
		println("点击参战");
		tap(touchX,touchY,math.random(100),math.random(20));
		--		touchX,touchY=findUntil(0xfd4959, 95, 475, 456, 483, 462, 0, 0);
		--		println("点击确定");
		--		tap(touchX,touchY,math.random(100),math.random(20));
		while true do
			touchX, touchY = findColorInRegionFuzzy(0xe1d09f, 95, 69, 610, 74, 615, 0, 0)
			if touchX > -1 then
				println("进入到对决选择界面");
				break;
			else
				tap(475,456,math.random(100),math.random(20));
			end
			mSleep(1000+math.random(1000));
		end
		dSelectBattle();
	end
	println("对决脚本运行完毕");
	return dStartReturn;
end
--↓↓↓↓↓每日日常函数↓↓↓↓↓
function mStart()
	--初始化变量
	local mStartX,mStartY;
	--初始化随机函数
	math.randomseed(os.time());
	mStartX,mStartY=findUntil(0x223abe, 95, 551, 665, 554, 669, 0, 0);
	println("点击进入每日任务");
	tap(mStartX,mStartY);
	--等待进入每日任务界面，或者选择难度界面
	mStartX,mStartY=findUntil(0xff485d, 90, 1140, 30, 1143, 33, 0, 0);
	--检测是否需要选择难度
	mSleep(1000+math.random(1000));
	mStartX, mStartY = findColorInRegionFuzzy(0xff4a5d, 95, 1092, 554, 1095, 557, 0, 0)
	if mStartX > -1 then
		if mDif == "0" then
			println("选择高级难度");
			mStartX, mStartY = findColorInRegionFuzzy(0xfd475e, 95, 1092, 434, 1097, 439, 0, 0)
			tap(mStartX,mStartY,math.random(115),math.random(25));
		elseif mDif == "1" then
			println("选择超级难度");
			tap(mStartX,mStartY,math.random(115),math.random(25));
		end
		
	end
	--	0x4a4a4a, 95, 259, 594, 262, 597, 0, 0
	--等待进入到每日任务界面
	mStartX,mStartY=findUntil(0xf04353, 95, 400, 578, 403, 581, 0, 0);
	println("进入到每日任务界面");
	--循环开始进行每日任务
	while true do
		--先判断还有没有剩余的体力
		mStartX, mStartY = findColorInRegionFuzzy(0x4a4a4a, 95, 350, 593, 353, 596, 0, 0)
		if mStartX > -1 then
			println("体力不足");
			mStartX,mStartY=findUntil(0xff485d, 90, 1140, 30, 1143, 33, 0, 0);
			println("返回主界面");
			tap(mStartX,mStartY);
			mSleep(1000);
			passE();
			break;
		end
		mStartX,mStartY=findUntil(0xf04353, 95, 400, 578, 403, 581, 0, 0);
		println("开始每日任务");
		tap(mStartX,mStartY,math.random(275),math.random(35));
		mSleep(1000+math.random(1000));
		battle(1,1);
		mSleep(2000+math.random(3000));
	end
end
function mCheckStart()
	--初始化变量
	local mCheckStartX,mCheckStartY;
	--初始化随机函数
	math.randomseed(os.time());
	println("执行每日任务脚本");
	--先判断有没有每日体力，反相判断，判断是否为黑色
	mCheckStartX, mCheckStartY = findColorInRegionFuzzy(0x000000, 95, 592, 704, 595, 707, 0, 0)
	if mCheckStartX > -1 then
		println("每日体力为空");
	else
		mStart();
	end
	println("每日任务脚本执行完毕");
end
--↓↓↓↓↓关闭软件函数↓↓↓↓↓
function shutdown()
	closeApp("jp.co.dmm.dmmlabo.himegari");
	println("关闭游戏");
end
--↓↓↓↓↓启动软件并到主界面函数↓↓↓↓↓
function startGame()
	local touchX,touchY;
	runApp("jp.co.dmm.dmmlabo.himegari");
	init("0", 1); --以当前应用 Home 键在右边初始化
	println("启动游戏");
	--初始化超时变量
	startGameCount = 0;
	--初始化返回参数
	startGameReturn = true;
	--不断地循环判断并点击，直到进入到主界面为止
	while true do
		math.randomseed(os.time());
		touchX, touchY = findColorInRegionFuzzy(0xcd133d, 95, 624, 360, 631, 369, 0, 0)
		if touchX > -1 then
			println("进入到开始界面，点击");
			tap(touchX,touchY);
		end
		touchX, touchY = findColorInRegionFuzzy(0x5bbc54, 95, 961, 657, 1142, 696, 0, 0)
		if touchX > -1 then
			println("进入到登录奖励，点击");
			tap(touchX,touchY);
		end
		touchX, touchY = findColorInRegionFuzzy(0x51b74a, 95, 547, 537, 733, 582, 0, 0)
		if touchX > -1 then
			println("进入到援军报告，点击");
			tap(touchX,touchY);
		end
		touchX, touchY = findColorInRegionFuzzy(0xeec078, 95, 1123, 13, 1126, 16, 0, 0)
		if touchX > -1 then
			println("进入到公告或邮箱，点击");
			tap(touchX+10,touchY+10);
		end
		touchX, touchY = findColorInRegionFuzzy(0xe25150, 95, 1163, 32, 1168, 39, 0, 0)
		if touchX > -1 then
			println("进入到推荐内容界面");
			tap(touchX+10,touchY+10);
		end
		touchX, touchY = findColorInRegionFuzzy(0xeeee44, 100, 0, 54, 32, 99, 0, 0)
		if touchX > -1 then
			println("进入到游戏界面");
			break;
		end
		touchX, touchY = findColorInRegionFuzzy(0xa9a690, 100, 688, 341, 691, 344, 0, 0)
		if touchX > -1 then
			println("游戏维护，关闭");
			startGameReturn = false;
			break;
		end
		touchX, touchY = findColorInRegionFuzzy(0x777465, 95, 733, 311, 736, 314, 0, 0)
		if touchX > -1 then
			println("需要下载游戏最新版本，关闭");
			startGameReturn = false;
			break;
		end		
		mSleep(500+math.random(500));
		if startGameCount >= 300 then
			println("进入游戏超时，尝试重启脚本");
			shutdown();
			lua_restart();
		end
		startGameCount = startGameCount + 1;
	end
	mSleep(5000+math.random(5000));
	return startGameReturn;
end
--↓↓↓↓↓↓判断软件是否在前台，是否已经启动↓↓↓↓↓↓↓
function determineRun()
	determineRunReturn=0;
	flag = appIsRunning("jp.co.dmm.dmmlabo.himegari");
	if flag ~= 0 then
		determineRunReturn = 1;
	else
		determineRunReturn = 0;
	end
	isfront = isFrontApp("jp.co.dmm.dmmlabo.himegari"); --更新前台状态
	if isfront == 1 then
		determineRunReturn = 1;
	else
		determineRunReturn = 0
	end
	return determineRunReturn;
end
--↓↓↓↓↓↓↓启动ab函数↓↓↓↓↓↓↓
function abInit()
	_ab=require("ab");
	_ab:start();
end
--↓↓↓↓↓↓↓主要运行函数↓↓↓↓↓↓↓
function mainFunction()
	--启动游戏，如果返回参数为false则代表游戏正在维护，直接跳过其余所有步骤
	if startGame() then
		--运行活动脚本
		if eTF == "0" then
			eventCheckStart();
		end
		--运行体力脚本
		if nTF == "0" then
			math.randomseed(os.time());
			mSleep(3000+math.random(5000));
			nCheckStart();
		end
		--运行对决脚本
		if dTF == "0" then
			math.randomseed(os.time());
			mSleep(3000+math.random(5000));
			dStart();
		end
		if mTF == "0" then
			math.randomseed(os.time());
			mSleep(3000+math.random(5000));
			mCheckStart();
		end
	end
end
--↓↓↓↓↓↓启动函数↓↓↓↓↓↓↓
function main()
	while true do
		shutdown();
		abInit();
		math.randomseed(os.time());
		secondTime=3600*1000+math.random(3600000);
		t =  mTime() + secondTime - 3600000;
		println("脚本将在"..(os.date("%H时%M分%S秒",t/1000)).."时启动");
		mSleep(secondTime);
		mainFunction();
	end
end
function firstStart()
	ret,results = showUI("ui.json");
	nTF=results["RadioGroup1"];
	dTF=results["RadioGroup2"];
	eDif=results["RadioGroup3"];
	nMet=results["RadioGroup4"];
	eTF=results["RadioGroup5"];
	mTF=results["RadioGroup6"];
	mDif=results["RadioGroup7"];
	math.randomseed(os.time());
	local firstTime=results["Edit1"];
	println("脚本将在"..firstTime.."分钟后启动");
	println("脚本版本："..Version);
	mSleep(firstTime*60*1000);
	mainFunction();
	main();
end
--↓↓↓↓↓运行脚本↓↓↓↓↓
firstStart();
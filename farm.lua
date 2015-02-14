-----------------------
-- 苗植え
-----------------------
function farm()
	
	turtle.digDown()
	
	if selectSeed() then
		turtle.placeDown()
		return true
	end
	
	return false
end

-----------------------
-- 種選択
-----------------------
function selectSeed()
	
	seedStackSt = 5
	seedStackEd = 8
	
	for i = seedStackSt, seedStackEd do
		if turtle.getItemCount(i) > 0 then
			turtle.select(i)
			return true
		end
		
	end

	return false
end

-----------------------
-- 前進
-----------------------
function forward()

	turtle.forward()
	
	if flgReverced then
		posY = posY - 1
	else
		posY = posY + 1
	end
end

-----------------------
-- 反転
-----------------------
function turn()
	
	if flgReverced then
		turtle.turnLeft()
		
		turtle.forward()
		posX = posX + 1
		
		turtle.turnLeft()
		
		flgReverced = false
	else
		turtle.turnRight()
		
		turtle.forward()
		posX = posX + 1
		
		turtle.turnRight()
		
		flgReverced = true
	end
	
	-- print(posX)
	-- print(posY)
	
end

-----------------------
-- 開始位置へ復帰
-----------------------
function gotoStartPos()
	
	if flgReverced then
		while posY > 1 do
			forward()
		end
		
		turtle.turnRight()
	else
		turtle.turnLeft();
	end
	
	while posX > 1 do
		turtle.forward()
		posX = posX - 1
	end

	turtle.turnRight()
	turtle.back()
	turtle.down()
	
end
-----------------------
-- メイン
-----------------------
args = {...}

if #args ~= 2 then
	print("param invalid")
	return
end

-- 田んぼのサイズ
fieldSizeX = args[1]
fieldSizeY = args[2]

-- 前後退判定フラグ
flgReverced = false

-- 現在地
posX = 1
posY = 0

turtle.up()
forward()

abnormal = false
for x = 1, fieldSizeX do
	for y = 1, fieldSizeY do
		if y > 1 then
			forward()
		end
		
		if farm() == false then
			abnormal = true
			break
		end
	end
	
	if abnormal then
		break
	end
	
	turn()
end

-- 開始位置復帰
gotoStartPos()

if abnormal then
	print("abnormal end!")
end


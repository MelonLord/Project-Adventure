require "props"
require "terrain"
require "gui"

function love.load()
	Load = 0
	Loaded = false
	W = 1200
	H = 700
	
	TimeOfDay = 8
	
	--Base
	----------
	love.window.setMode(W,H,{fsaa = 0})
	function math.round(n, deci) deci = 10 ^(deci or 0) return math.floor(n*deci+ 0.49)/deci end
	function math.dist(x1,y1, x2,y2) return ((x2-x1)^ 2+(y2-y1)^ 2)^ 0.5 end
	
	--Camera
	----------
	Camera = {}
	Camera.x = 0
	Camera.y = 0
	Camera.Mx = 0
	Camera.My = 0
	Camera.Overwrite = false
	function Camera:set()
		love.graphics.push()
		love.graphics.translate(-self.x, -self.y)
	end
	function Camera:unset()
		love.graphics.pop()
	end
	
	--Lighting
	----------
	LightSources = {}
	Lights = function()
		if #LightSources ~= 0 then
			for i,k in pairs(LightSources) do
				Camera:set()
				love.graphics.setColor( 0, 0, 0, 255 - LightSources[i][5]*5 )
				love.graphics.circle("fill",LightSources[i][1]+LightSources[i][3],LightSources[i][2]+LightSources[i][4],LightSources[i][5]+math.random())
				love.graphics.setColor( 255, 255, 255, 255 )
				Camera:unset()
			end
		else
			love.graphics.circle("fill",0,0,1)
		end
	end
	
	--Testing
	----------
	Props.Active[1] = Props:New(Props.Types.Player,10,8)
	Props.Active[1].Facing = 3
	Props.Active[1].State = 3
	PlayerID = Props.Active[1].ID
	PlayerMob = Props.Active[1]
	--Props.Active[1].MoveCue = {{10,20},{8,6},{9,9}}
	--Props.Active[2] = Props:New(Props.Types.Tree,9,9)
	Props.Active[2] = Props:New(Props.Types.Torch,9.3,7.2)
	Props.Active[3] = Props:New(Props.Types.Tree,13,12)
	Props.Active[4] = Props:New(Props.Types.Torch,9,7)
	Props.Active[5] = Props:New(Props.Types.House1_0,5,15)
	Props.Active[6] = Props:New(Props.Types.House1_3,4,15)
	Props.Active[7] = Props:New(Props.Types.House1_4,3,15)
	Props.Active[8] = Props:New(Props.Types.House1_1,5,14)
	Props.Active[9] = Props:New(Props.Types.House1_2,5,13)
	--Props.Active[5] = Props:New(Props.Types.Torch,11,7)
	Props.Active[2].State = 2
	Props.Active[2].Lum = 30
	--Props.Active[5].State = 2
	--Gui.Active[1] = Gui:New("Test",1,love.graphics.newImage("bin/Terrain/Grass/grass1.png"),30,30,1,1,255,function() return nil end,{})
end

function love.keypressed( key, isrepeat )
	local dir = 1
	local move = false
	if key == "w" then
		dir = 4
		move = true
	elseif key == "s" then
		dir = 2
		move = true
	elseif key == "d" then
		dir = 1
		move = true
	elseif key == "a" then
		dir = 3
		move = true
	end
	if move then
		PlayerMob.Direction = dir
		PlayerMob.Moving = true
		PlayerMob.State = 4 + dir
	end
	
end

function love.keyreleased( key )
	local move = false
	local stop = true
	if key == "w" then
		move = true
		if love.keyboard.isDown("d") then
			dir = 1
			stop = false
		elseif love.keyboard.isDown("a") then
			dir = 3
			stop = false
		elseif love.keyboard.isDown("s") then
			dir = 2
			stop = false
		end
	elseif key == "s" then
		move = true
		if love.keyboard.isDown("d") then
			dir = 1
			stop = false
		elseif love.keyboard.isDown("a") then
			dir = 3
			stop = false
		elseif love.keyboard.isDown("w") then
			dir = 4
			stop = false
		end
	elseif key == "d" then
		move = true
		if love.keyboard.isDown("w") then
			dir = 4
			stop = false
		elseif love.keyboard.isDown("s") then
			dir = 2
			stop = false
		elseif love.keyboard.isDown("a") then
			dir = 3
			stop = false
		end
	elseif key == "a" then
		move = true
		if love.keyboard.isDown("w") then
			dir = 4
			stop = false
		elseif love.keyboard.isDown("s") then
			dir = 2
			stop = false
		elseif love.keyboard.isDown("d") then
			dir = 1
			stop = false
		end
	end
	if move and stop then
		PlayerMob.Moving = false
		PlayerMob.State = PlayerMob.Direction
	elseif move and not stop then
		PlayerMob.Direction = dir
		PlayerMob.Moving = true
		PlayerMob.State = 4 + dir
	end
end

function love.update(dt)
	
	--Lighting
	----------
	if Loaded then
	TimeOfDay = TimeOfDay + 0.0001
	if TimeOfDay > 24 then
		TimeOfDay = 0
	end
	
	--Camera
	----------
	Camera.x = math.floor(PlayerMob.Sx - (love.window.getWidth()/2))
	Camera.y = math.floor(PlayerMob.Sy - (love.window.getHeight()/2))
	--[[if love.keyboard.isDown("w","up") then
		Camera.y = Camera.y - 5 - Camera.My
		if not (Camera.My > 10) then
			Camera.My = Camera.My + 0.1
		end
		if Camera.y < -((GridSize*BlockDepth)-(BlockDepth*5)) then
			Camera.y = -((GridSize*BlockDepth)-(BlockDepth*5))
		end
	elseif love.keyboard.isDown("s","down") then
		Camera.y = Camera.y + 5 + Camera.My
		if not (Camera.My > 10) then
			Camera.My = Camera.My + 0.1
		end
		if Camera.y > ((GridSize*BlockDepth)-(BlockDepth*5)) then
			Camera.y = ((GridSize*BlockDepth)-(BlockDepth*5))
		end
	else
		Camera.My = 0
	end
	if love.keyboard.isDown("a","left") then
		Camera.x = Camera.x - 5 - Camera.Mx
		if not (Camera.Mx > 10) then
			Camera.Mx = Camera.Mx + 0.1
		end
		if Camera.x < -((GridSize*BlockWidth)-(BlockWidth*5)) then
			Camera.x = -((GridSize*BlockWidth)-(BlockWidth*5))
		end
	elseif love.keyboard.isDown("d","right") then
		Camera.x = Camera.x + 5 + Camera.Mx
		if not (Camera.Mx > 10) then
			Camera.Mx = Camera.Mx + 0.1
		end
		if Camera.x > ((GridSize*BlockWidth)-(BlockWidth*5)) then
			Camera.x = ((GridSize*BlockWidth)-(BlockWidth*5))
		end
	else
		Camera.Mx = 0
	end	]]
	
	--Elements
	----------
	if #Props.Active ~= 0 then
		Props:Update(dt)
	end
	if # Gui.Active ~= 0 then
    	Gui:Update(dt)
    end
		
	else
		Load = Load + dt
		if Load > 3 then
			Loaded = true
		end
	end
end



function love.draw()
	--Garbage Collection
	----------
	LightSources = {}
	
	----------
	Camera:set()
	love.graphics.setBackgroundColor(0,200,255)
	
			  
	--Props
	----------
	Chunks = {{1,1,{}}}
	Grid[1][1][4] = true

for i = 1,#Props.Active do
	State = 1
	if Props.Active[i].State > #Props.Active[i].States then
		Props.Active[i].State = 1
	else
		State = Props.Active[i].State
	end
	local Px = Props.Active[i].Position.x
	local Py = Props.Active[i].Position.y
	local Slant = 0
	if Grid[math.round(Px)][math.round(Py)][3] ~= 1 then
		if Grid[math.round(Px)][math.round(Py)][3] == 6 then
			Slant = 1-((Py+0.5) - math.round(Py))
		elseif Grid[math.round(Px)][math.round(Py)][3] == 7 then
			Slant = (Px+0.5) - math.round(Px)
		elseif Grid[math.round(Px)][math.round(Py)][3] == 8 then
			Slant = (Py+0.5) - math.round(Py)
		elseif Grid[math.round(Px)][math.round(Py)][3] == 9 then
			Slant = 1-((Px+0.5) - math.round(Px))
								
		elseif Grid[math.round(Px)][math.round(Py)][3] == 10 then
			Slant = (1-((Px+0.5) - math.round(Px)))+(1-((Py+0.5) - math.round(Py)))
			if Slant > 1 then
				Slant = 1
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 12 then
			Slant = ((Py+0.5) - math.round(Py) + (Px+0.5) - math.round(Px))
			if Slant > 1 then
				Slant = 1
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 11 then
			Slant = ((Px+0.5) - math.round(Px))+(1-((Py+0.5) - math.round(Py)))
			if Slant > 1 then
				Slant = 1
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 13 then
			Slant = ((Py+0.5) - math.round(Py))+(1-((Px+0.5) - math.round(Px)))
			if Slant > 1 then
				Slant = 1
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 2 then
			Slant = (1-((Px+0.5) - math.round(Px) ))+(1-((Py+0.5) - math.round(Py)))-1
			if Slant < 0 then
				Slant = 0
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 3 then
			Slant = ((Px+0.5) - math.round(Px))+(1-((Py+0.5) - math.round(Py)))-1
			if Slant < 0 then
				Slant = 0
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 4 then
			Slant = ((Py+0.5) - math.round(Py) + (Px+0.5) - math.round(Px))-1
			if Slant < 0 then
				Slant = 0
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 5 then
			Slant = ((Py+0.5) - math.round(Py))+(1-((Px+0.5) - math.round(Px)))-1
			if Slant < 0 then
				Slant = 0
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 14 then
			Slant = ((Py+0.5) - math.round(Py) + (Px+0.5) - math.round(Px))
			if Slant > 1 then
				Slant = (1-((Px+0.5) - math.round(Px)))+(1-((Py+0.5) - math.round(Py)))
			end
		elseif Grid[math.round(Px)][math.round(Py)][3] == 15 then
			Slant = ((Py+0.5) - math.round(Py))+(1-((Px+0.5) - math.round(Px)))
			if Slant > 1 then
				Slant = ((Px+0.5) - math.round(Px))+(1-((Py+0.5) - math.round(Py)))
			end
		end
	end
	if Props.Active[i].State ~= Props.Active[i].LastState then
		Props.Active[i].AnimStage = 1
	end
	Px = Px + Props.Active[i].XOffset
	Py = Py + Props.Active[i].YOffset
	Props.Active[i].LastState = Props.Active[i].State
	local Sx = GridCenter[1] + ((Px-Py) * (BlockWidth/2) - ((Props.Active[i].Width - BlockWidth)/2))
	local Sy = GridCenter[2] + ((Py+Px) * (BlockDepth/2)) - (BlockDepth * (GridSizey/2)) - (BlockHeight/3*(Grid[math.round(Px)][math.round(Py)][2])) - ((Props.Active[i].Height - BlockHeight/3)) + (Slant*(BlockHeight/3))
						
	if Props.Active[i].Moving == false then
		Props.Active[i].Sx = math.floor(Sx)
		Props.Active[i].Sy = math.floor(Sy)
	else
		Props.Active[i].Sx = Sx
		Props.Active[i].Sy = Sy
	end
	Props.Active[i].Slant = Slant
	if Props.Active[i].Lum > 0 then
		LightSources[#LightSources+1] = {Sx,Sy,Props.Active[i].Width/2,Props.Active[i].Height/2,Props.Active[i].Lum}
	end
	local e = false
	for c = 1,#Chunks do
		if Chunks[c][1] == math.round(Props.Active[i].Position.x+Props.Active[i].XOffset) and Chunks[c][2] == math.round(Props.Active[i].Position.y+Props.Active[i].YOffset) then
			Chunks[c][3][#Chunks[c][3]+1] = Props.Active[i]
			e = true
		end
	end
	if not e then
		Chunks[#Chunks+1] = {math.round(Props.Active[i].Position.x+Props.Active[i].XOffset),math.round(Props.Active[i].Position.y+Props.Active[i].YOffset),{Props.Active[i]}}
		Grid[math.round(Props.Active[i].Position.x+Props.Active[i].XOffset)][math.round(Props.Active[i].Position.y+Props.Active[i].YOffset)][4] = true
	end
end
table.sort(Chunks,function(a,b) return 
	(GridCenter[2] + ((a[2]+a[1]) * (BlockDepth/2)) - (BlockDepth * (GridSizey/2)) - (BlockHeight/3*Grid[a[1]][a[2]][2]))<(GridCenter[2] + ((b[2]+b[1]) * (BlockDepth/2)) - (BlockDepth * (GridSizey/2)) - (BlockHeight/3*Grid[b[1]][b[2]][2])) 
end)
for i = 1,#Chunks do
	table.sort(Chunks[i][3],function(a,b) return a.Sy<b.Sy end)
end
--TileDraw
----------
for x=1,GridSizex do
	for y=1,GridSizey do
		if Grid[x][y][2] > 0 then
			for i = 0,(Grid[x][y][2]-1) do
				love.graphics.draw(Tileset[Grid[x][y][1]][1],
				  GridCenter[1] + ((x-y) * (BlockWidth/2)),
				  GridCenter[2] + ((y+x) * (BlockDepth/2)) - (BlockDepth * (GridSizey/2)) - (BlockHeight/3*i))
			end
		end
		love.graphics.draw(Tileset[Grid[x][y][1]][Grid[x][y][3]],
		  GridCenter[1] + ((x-y) * (BlockWidth/2)),
		  GridCenter[2] + ((y+x) * (BlockDepth/2)) - (BlockDepth * (GridSizey/2)) - (BlockHeight/3*Grid[x][y][2]))
		if Grid[x][y][4] == true then
			for i = 1,#Chunks do
				if Chunks[i][1] == x and Chunks[i][2] == y then
					for c = 1,#Chunks[i][3] do
						love.graphics.draw(Chunks[i][3][c].Sprite,Chunks[i][3][c].States[Chunks[i][3][c].State][Chunks[i][3][c].AnimStage],Chunks[i][3][c].Sx,Chunks[i][3][c].Sy+Chunks[i][3][c].ErrorOffset)
					end
				end
			end
		end
	end
end
	Camera:unset()
	
--Lighting
----------
	love.graphics.setInvertedStencil(Lights)
	love.graphics.setColor(30,10,0,100+math.cos(((math.pi*2)/24) * TimeOfDay)*100)
	love.graphics.rectangle("fill",0,0,W,H)
	love.graphics.setStencil()
	love.graphics.setColor(255,255,255,255)
	
	
--UIDraw
----------
	if #Gui.Active > 0 then
		for i = 1,#Gui.Active do
        	love.graphics.push()
        	love.graphics.scale(Gui.Active[i].Sx,Gui.Active[i].Sy)
        	love.graphics.draw(Gui.Active[i].Sprite,Gui.Active[i].x,Gui.Active[i].y)
       		love.graphics.pop()
        end
    end
	
	love.graphics.print(love.timer.getFPS(),0,0)
	love.graphics.print(Props.Active[9].Sy,0,20)
	
end
	
EditMode = false
Edit = {}
Edit.TileType = 1
Edit.TileMode = 1
Edit.TileHeight = 0
Edit.LastPosition = {-1,-1}
Edit.LastTile = nil

Edit.PropType = 1
Edit.Snap = true
Edit.PropNum = 1

Edit.Shift = false
Edit.Control = false
Edit.Fx = -1
Edit.Fy = -1

Edit.Image = {}
Edit.Image.Grid = love.graphics.newImage("bin/Gui/Grid.png")
Edit.Image.Prop = love.graphics.newImage("bin/Gui/Prop.png")
Edit.Image.SnapOn = love.graphics.newImage("bin/Gui/SnapOn.png")
Edit.Image.SnapOff = love.graphics.newImage("bin/Gui/SnapOff.png")

Edit.Mode = "Grid"
Edit.G = {}

Edit.PropList = {}

for k,_ in pairs(Props.Types) do
	Edit.PropList[#Edit.PropList+1] = k
end	

function Edit.setMode(Sx,Sy)
	EditMode = true
	Props.Active = {}
	for y = 1,Sy do
		Edit.G[y] = {}
		for x = 1,Sx do
			Edit.G[y][x] = {1,0,1,false} --{type,hieght,angle,propsOn}
		end
	end
	GridSizex = Sx
	GridSizey = Sy
	Grid = Edit.G
	Gui.Active = {}
	Gui.Active[1] = Gui:New("Save",1,love.graphics.newImage("bin/Gui/Save.png"),1,1,1,1,128,62,255,function() return nil end,{},function() 
		local data = nil
		if not love.filesystem.isFile("NewLevel.lua") then
			local file = love.filesystem.newFile("NewLevel.lua")
		end
		data = "L = {}\nL.Props = {\n Props:New(Props.Types.Blank,1,1),\n"
		
		for i = 1,#Props.Active do
			data = data .. "Props:New(Props.Types." .. Props.Active[i].Name .. "," .. Props.Active[i].Position.x .. "," .. Props.Active[i].Position.y .. ")"
			if i ~= #Props.Active then
				data = data .. ", \n"
			end
		end
		data = data .. "\n}\nL.Grid = {\n"
		for y = 1,GridSizey do
			data = data .. "{"
			for x = 1,GridSizex do
				data = data .. "{"..Grid[y][x][1]..","..Grid[y][x][2]..","..Grid[y][x][3]..",".."false}"
				if x ~= GridSizex then
					data = data..","
				end
			end
			data = data .. "}"
			if y ~= GridSizey then
				data = data..",\n"
			end
		end
		data = data .. "\n}"
		love.filesystem.write("NewLevel.lua",data)
	end)
	Gui.Active[2] = Gui:New("Load",1,love.graphics.newImage("bin/Gui/Load.png"),130,1,1,1,128,62,255,function() return nil end,{},function()
		require("NewLevel")
		Grid = L.Grid
		Props.Active = L.Props
		Edit.PropNum = #L.Props + 1
	end)
	Gui.Active[3] = Gui:New("Mode",1,Edit.Image.Grid,260,1,1,1,128,62,255,function() return nil end,{},function()
		if Edit.Mode == "Prop" then
			Edit.Mode = "Grid"
			Gui.Active[3].Sprite = Edit.Image.Grid
		elseif Edit.Mode == "Grid" then
			Edit.Mode = "Prop"
			Gui.Active[3].Sprite = Edit.Image.Prop
		end
	end)
	Gui.Active[4] = Gui:New("Snap",1,Edit.Image.SnapOn,390,1,1,1,128,62,255,function() return nil end,{},function()
		if Edit.Snap then
			Edit.Snap = false
			Gui.Active[4].Sprite = Edit.Image.SnapOff
		else
			Edit.Snap = true
			Gui.Active[4].Sprite = Edit.Image.SnapOn
		end
	end)
end

function Edit.update(dt)
	local Mx = love.mouse.getX()
	local My = love.mouse.getY()
	
		XpY = ((My+Camera.y) + (BlockDepth * (GridSizex/2)) + (BlockHeight/3*1) - (GridCenter[2]))/(BlockDepth/2)
		XmY = ((Mx+Camera.x)-GridCenter[1])/(BlockWidth/2)
		Py = ((XpY-XmY)/2)-0.5
		Px = (XmY+((XpY-XmY)/2))-1.5
		Gx = math.round(Px)
		Gy = math.round(Py)
		D = GridSizey - Gx 
		if Gy > Gx then
			D = GridSizey - Gy
		end
		Fx = Px 
		Fy = Py 
		if Gx > 0 and Gx <= GridSizex and Gy > 0 and Gy <= GridSizey then
			if Grid[Gx][Gy][2] > 0 then
				Fx = Px + 0.5
				Fy = Py + 0.5
			end
			for i = 1,D do
				if Gx + i <= GridSizex and Gy + i <= GridSizey then
					if Grid[Gx+i][Gy+i][2] == i+1 then
						Fx = i+Px
						Fy = i+Py
					elseif Grid[Gx+i][Gy+i][2] == i then
						if Px-Gx > 0 and Py-Gy > 0 then
							Fx = i+Px-0.5
							Fy = i+Py-0.5
						end
					elseif Grid[Gx+i-1][Gy+i][2] == i then
						if Px-Gx < 0 and Py-Gy > 0 then
							Fx = i+Px-0.5
							Fy = i+Py-0.5
						end
					elseif Grid[Gx+i][Gy+i-1][2] == i then
						if Px-Gx > 0 and Py-Gy < 0 then
							Fx = i+Px-0.5
							Fy = i+Py-0.5 
						end
					end
				end
			end
		end
	
	if Edit.Mode == "Grid" then
		Fx = math.floor(Fx)
		Fy = math.floor(Fy)
		if Fx > 0 and Fx <= GridSizex and Fy > 0 and Fy <= GridSizey then
			if Fx ~= Edit.LastPosition[1] or Fy ~= Edit.LastPosition[2] then
				if Edit.LastTile then
					Grid[Edit.LastPosition[1]][Edit.LastPosition[2]] = Edit.LastTile
				end
				Edit.LastTile = Grid[Fx][Fy]
				Edit.LastPosition = {Fx,Fy}
			end
			Grid[Fx][Fy] = {Edit.TileType,Edit.TileHeight,Edit.TileMode,false}
		else
			if Edit.LastTile then
				Grid[Edit.LastPosition[1]][Edit.LastPosition[2]] = Edit.LastTile
			end
			--Edit.LastTile = nil
		end
		Edit.Fx = Fx
		Edit.Fy = Fy
	elseif Edit.Mode == "Prop" then
		if Edit.Snap then
			Fx = math.round(Fx)
			Fy = math.round(Fy)
		end
		if Fx > 0.51 and Fx + Props.Types[Edit.PropList[Edit.PropNum]][7][1] <= GridSizex+0.5 and Fy > 0.51 and Fy + Props.Types[Edit.PropList[Edit.PropNum]][7][2] <= GridSizey+0.5 then
			Props.Active[Edit.PropNum] = Props:New(Props.Types[Edit.PropList[Edit.PropType]],Fx,Fy)
		else
			Props.Active[Edit.PropNum] = Props:New(Props.Types.Blank,1,1)
		end
		Edit.Fx = Fx
		Edit.Fy = Fy
	end
end

function Edit.keypressed( key , isrepeat )
	if key == "rshift" or key == "lshift" then
		Edit.Shift = true
	elseif key == "rctrl" or key == "lctrl" then
		Edit.Control = true
	end
end

function Edit.keyreleased( key )
	if key == "rshift" or key == "lshift" then
		Edit.Shift = false
	elseif key == "rctrl" or key == "lctrl" then
		Edit.Control = false
	end
end

function Edit.mousepressed(x,y,Button)
	if Button == "l" then
		local clk = false
		for i = 1,#Gui.Active do
			if x > Gui.Active[i].x and x < (Gui.Active[i].x+Gui.Active[i].ScaleX) then
				if y > Gui.Active[i].y and y < (Gui.Active[i].y+Gui.Active[i].ScaleY) then
					Gui.Active[i].OnClick()
					clk = true
				end
			end
		end
		if not clk then
			if Edit.Fx > 0 and Edit.Fx <= GridSizex and Edit.Fy > 0 and Edit.Fy <= GridSizey then
				if Edit.Mode == "Grid" then
					Edit.LastTile = nil
				elseif Edit.Mode == "Prop" then
					Edit.PropNum = #Props.Active+1
				end
			end
		end
	elseif Button == "r" then
		if Edit.Fx > 0 and Edit.Fx <= GridSizex and Edit.Fy > 0 and Edit.Fy <= GridSizey then
			if Edit.Mode == "Prop" then
				local NewProps = {}
				for i = 1,#Props.Active do
					if not (x > Props.Active[i].Sx and x < (Props.Active[i].Sx+Props.Active[i].Width)) then
						if not (y > Props.Active[i].Sy and y < (Props.Active[i].Sy+Props.Active[i].Height)) then
							NewProps[#NewProps+1] = Props.Active[i]
						end
					end
				end
				Props.Active = NewProps
				Edit.PropNum = #NewProps+1
			end
		end
	elseif Button == "wu" then
		if Edit.Fx > 0 and Edit.Fx <= GridSizex and Edit.Fy > 0 and Edit.Fy <= GridSizey then
			if Edit.Mode == "Grid" then
				if Edit.Shift and not Edit.Control then
					if Edit.TileType == #Tileset then
						Edit.TileType = 1
					else
						Edit.TileType = Edit.TileType + 1
					end
				elseif Edit.Control and not Edit.Shift then
					if Edit.TileMode == 16 then
						Edit.TileMode = 1
					else
						Edit.TileMode = Edit.TileMode + 1
					end 
				else
					Edit.TileHeight = Edit.TileHeight + 1
					love.mouse.setY = y + BlockDepth
				end
			elseif Edit.Mode == "Prop" then
				if Edit.PropType == #Edit.PropList then
					Edit.PropType = 1
				else
					Edit.PropType = Edit.PropType + 1
				end
			end
		end	
	elseif Button == "wd" then
		if Edit.Fx > 0 and Edit.Fx <= GridSizex and Edit.Fy > 0 and Edit.Fy <= GridSizey then
			if Edit.Mode == "Grid" then
				if Edit.Shift and not Edit.Control then
					if Edit.TileType == 1 then
						Edit.TileType = #Tileset
					else
						Edit.TileType = Edit.TileType - 1
					end
				elseif Edit.Control and not Edit.Shift then
					if Edit.TileMode == 1 then
						Edit.TileMode = 16
					else
						Edit.TileMode = Edit.TileMode - 1
					end 
				else
					Edit.TileHeight = Edit.TileHeight - 1
					love.mouse.setY = y - BlockDepth
				end
			elseif Edit.Mode == "Prop" then
				if Edit.PropType == 1 then
					Edit.PropType = #Edit.PropList
				else
					Edit.PropType = Edit.PropType - 1
				end
			end
		end	
	end		
end

	




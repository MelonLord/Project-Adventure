	Levels = {}
	require "levels/town1"
	require "levels/field1"
	--Resources
	----------
	-- 1=Raised,2=SlantTo0,3=SlantFrom0,4=Lowered
	SideIdentifier = {
		{1,1,1,1},{2,1,1,2},{3,2,1,1},{1,3,3,1},{1,1,2,3},
		{4,2,1,2},{3,4,3,1},{1,2,4,2},{3,1,3,4},
		{4,2,2,4},{4,4,3,2},{3,4,4,3},{2,3,4,4},
		{3,2,2,3},{2,3,3,2},{1,1,1,1}
	}
	
	--{Default,Up,Right,Down,Left,UpRight,DownRight,DownLeft,UpLeft,Top3,Right3,Bottom3,Left3,RightLeft,UpDown,Under}
	Tileset = {
		{
	love.graphics.newImage("bin/Terrain/Grass/grass1.png"),love.graphics.newImage("bin/Terrain/Grass/grass2.png"),love.graphics.newImage("bin/Terrain/Grass/grass3.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass4.png"),love.graphics.newImage("bin/Terrain/Grass/grass5.png"),love.graphics.newImage("bin/Terrain/Grass/grass6.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass7.png"),love.graphics.newImage("bin/Terrain/Grass/grass8.png"),love.graphics.newImage("bin/Terrain/Grass/grass9.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass10.png"),love.graphics.newImage("bin/Terrain/Grass/grass11.png"),love.graphics.newImage("bin/Terrain/Grass/grass12.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass13.png"),love.graphics.newImage("bin/Terrain/Grass/grass14.png"),love.graphics.newImage("bin/Terrain/Grass/grass15.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass16.png")
		}
	}
	
	--Grid
	----------
	BlockWidth  = Tileset[1][1]:getWidth()
	BlockHeight = Tileset[1][1]:getHeight()
	BlockDepth = (BlockHeight/3)*2
	GridSizex = 16
	GridSizey = 16
	GridCenter = {Tileset[1][1]:getWidth()*GridSizex/2,Tileset[1][1]:getHeight()*GridSizey/2}
	Grid = town1.Grid
	
	
	--Level Change
	-----------
	function ChangeLevel(l,Px,Py) --Enum Enterfrom "y+","y-","x+","x-","n"
		local NewProps = l.Props
		for i = 2,#Props.Active do
			if Props.Active[i] ~= PlayerMob then
				Props.Active[i].Name = "REMOVE"
			end
		end
		NewProps[#NewProps+1] = PlayerMob
		PlayerPort.x = Px
		PlayerPort.y = Py
		Level = l
		Skip = true
	end

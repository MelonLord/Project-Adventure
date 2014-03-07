	
	--Resources
	----------
	--{Default,Up,Right,Down,Left,UpRight,DownRight,DownLeft,UpLeft,Top3,Right3,Bottom3,Left3,All}
	Tileset = {
		{
	love.graphics.newImage("bin/Terrain/Grass/grass1.png"),love.graphics.newImage("bin/Terrain/Grass/grass2.png"),love.graphics.newImage("bin/Terrain/Grass/grass3.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass4.png"),love.graphics.newImage("bin/Terrain/Grass/grass5.png"),love.graphics.newImage("bin/Terrain/Grass/grass6.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass7.png"),love.graphics.newImage("bin/Terrain/Grass/grass8.png"),love.graphics.newImage("bin/Terrain/Grass/grass9.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass10.png"),love.graphics.newImage("bin/Terrain/Grass/grass11.png"),love.graphics.newImage("bin/Terrain/Grass/grass12.png"),
	love.graphics.newImage("bin/Terrain/Grass/grass13.png"),love.graphics.newImage("bin/Terrain/Grass/grass14.png"),love.graphics.newImage("bin/Terrain/Grass/grass15.png")
		}
	}
	
	--Grid
	----------
	BlockWidth  = Tileset[1][1]:getWidth()
	BlockHeight = Tileset[1][1]:getHeight()
	BlockDepth = (BlockHeight/3)*2
	GridSizex = 20
	GridSizey = 20
	GridCenter = {Tileset[1][1]:getWidth()*GridSizex/2,Tileset[1][1]:getHeight()*GridSizey/2}
	Grid = {}
	for x = 1,GridSizex do
		Grid[x] = {}
		for y = 1,GridSizey do
			Grid[x][y] = {1,0,1,false} --{type,hieght,angle,propsOn}
		end
	end
	Grid[10][13] = {1,1,1}
	Grid[10][16] = {1,2,13}
	
	Levels = {}
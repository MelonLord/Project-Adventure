Props.Types.Town1_House1 = {"Town1_House1",200,love.graphics.newImage("bin/Terrain/Props/Arrow1.png"),
{{love.graphics.newQuad(0,0,64,32,256,32)},
{love.graphics.newQuad(0,0,64,32,256,32),
love.graphics.newQuad(64,0,64,32,256,32),
love.graphics.newQuad(128,0,64,32,256,32),
love.graphics.newQuad(192,0,64,32,256,32)}},
256,32,{-0.5,0.2},1,0.3,0,0,
function() return nil end,
function(dt,self)
	if math.dist(PlayerMob.Position.x,PlayerMob.Position.y,self.Position.x,self.Position.y) < 1.5 then
		self.State = 2
	else
		self.State = 1
	end
end,
function() return nil end,
function(id)
	for i = 1,#Props.Active do 
		if Props.Active[i].ID == id then 
			Props.Active[i].OnRemove()
			Props:Remove(i) 
		end 
	end
end,
function(prop,self) return nil end,
function(prop)
	if prop == PlayerMob then
		ChangeLevel(house1,9,10)
	end
end,
true,false,{},32}

Props.Types.House1_Town1 = {"House1_Town1",200,love.graphics.newImage("bin/Terrain/Props/Arrow3.png"),
{{love.graphics.newQuad(0,0,64,32,256,32)},
{love.graphics.newQuad(0,0,64,32,256,32),
love.graphics.newQuad(64,0,64,32,256,32),
love.graphics.newQuad(128,0,64,32,256,32),
love.graphics.newQuad(192,0,64,32,256,32)}},
256,32,{-.5,-1},1,0.3,0,0,
function() return nil end,
function(dt,self)
	if math.dist(PlayerMob.Position.x,PlayerMob.Position.y,self.Position.x,self.Position.y) < 1.5 then
		self.State = 2
	else
		self.State = 1
	end
end,
function() return nil end,
function(id)
	for i = 1,#Props.Active do 
		if Props.Active[i].ID == id then 
			Props.Active[i].OnRemove()
			Props:Remove(i) 
		end 
	end
end,
function(prop,self) return nil end,
function(prop)
	if prop == PlayerMob then
		ChangeLevel(town1,3,5)
	end
end,
true,false,{},32}
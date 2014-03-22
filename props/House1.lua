	Props.Types.House1_0 = {"House1_0",200,love.graphics.newImage("bin/Terrain/Props/House1_0.png"),
	{{love.graphics.newQuad(0,0,64,176,64,176)}},64,176,{1.49,1.49},12,12,0,0,
		function() return nil end,
		function() return nil end,
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
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House1_3 = {"House1_3",200,love.graphics.newImage("bin/Terrain/Props/House1_-1.png"),
	{{love.graphics.newQuad(0,0,64,160,64,160)}},64,160,{1.49,1.49},0,0,0,0,
	function() return nil end,
		function() return nil end,
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
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House1_4 = {"House1_4",200,love.graphics.newImage("bin/Terrain/Props/House1_-2.png"),
	{{love.graphics.newQuad(0,0,74,145,74,145)}},74,144,{1.49,1.49},0,0,0,0,
	function() return nil end,
		function() return nil end,
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
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House1_1 = {"House1_1",200,love.graphics.newImage("bin/Terrain/Props/House1_1.png"),
	{{love.graphics.newQuad(0,0,64,160,64,160)}},64,160,{1.49,1.49},0,0,0,0,
	function() return nil end,
		function() return nil end,
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
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House1_2 = {"House1_2",200,love.graphics.newImage("bin/Terrain/Props/House1_2.png"),
	{{love.graphics.newQuad(0,0,74,144,74,144)}},74,144,{1.49,1.49},0,0,0,0,
	function() return nil end,
		function() return nil end,
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
		function(prop) return nil end,
		true,false,{},0
	}
	Props.Types.Shop1_0 = {"Shop1_0",200,love.graphics.newImage("bin/Terrain/Props/Shop1_0.png"),
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
	
	Props.Types.Shop1_3 = {"Shop1_3",200,love.graphics.newImage("bin/Terrain/Props/Shop1_-1.png"),
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
	
	Props.Types.Shop1_4 = {"Shop1_4",200,love.graphics.newImage("bin/Terrain/Props/Shop1_-2.png"),
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
	
	Props.Types.Shop1_1 = {"Shop1_1",200,love.graphics.newImage("bin/Terrain/Props/Shop1_1.png"),
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
	
	Props.Types.Shop1_2 = {"Shop1_2",200,love.graphics.newImage("bin/Terrain/Props/Shop1_2.png"),
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
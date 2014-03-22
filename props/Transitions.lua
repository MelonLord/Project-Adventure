	Props.Types.Town1_Field1 = {"Town1_Field1",200,love.graphics.newImage("bin/Terrain/Props/grassfade2.png"),
	{{love.graphics.newQuad(0,0,128,48,128,48)}},128,48,{-0.4,0},0.5,1,0,0,
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
		function(prop)
			if prop == PlayerMob then
				ChangeLevel(field1,1.5,12)
			end
		end,
		true,false,{},32
	}
	
	Props.Types.Field1_Town1 = {"Field1_Town1",200,love.graphics.newImage("bin/Terrain/Props/grassfade4.png"),
	{{love.graphics.newQuad(0,0,128,48,128,48)}},128,48,{0.4,0},0.5,1,0,0,
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
		function(prop)
			if prop == PlayerMob then
				ChangeLevel(town1,15.5,12)
			end
		end,
		true,false,{},32
	}
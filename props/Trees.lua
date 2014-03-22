	Props.Types.Trees1 = {"Trees1",200,love.graphics.newImage("bin/Terrain/Props/Trees1.png"),
	{{love.graphics.newQuad(0,0,96,128,96,128)}},96,128,{0.49,0.49},4,4,0,0,
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
	Quad = {
		{love.graphics.newQuad(0,0,9,42,45,42)},
		{
			love.graphics.newQuad(9,0,9,42,45,42),
			love.graphics.newQuad(18,0,9,42,45,42),
			love.graphics.newQuad(27,0,9,42,45,42),
			love.graphics.newQuad(36,0,9,42,45,42)
		}
	}
	
	Props.Types.Torch = {"Torch",10,love.graphics.newImage("bin/Terrain/Props/Torch.png"),Quad,9,42,{0,0},1,1,0,0,
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
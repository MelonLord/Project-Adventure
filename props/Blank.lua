	Props.Types.Blank = {"Blank",-1,love.graphics.newImage(love.image.newImageData(1,1)),{{NewQuad(0,0,1,1,1,1)}},1,1,{0,0},0,0,0,0,
		function() return nil end,
		function() return nil end,
		function() return nil end,
		function(id,self)
			for i = 1,#Props.Active do 
				if Props.Active[i].ID == id then 
					Props.Active[i].OnRemove()
					Props:Remove(i) 
				end 
			end
		end,
		function(prop,self) return nil end,
		function(prop) return nil end,
		false,false,{},0
	}
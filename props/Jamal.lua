	Props.Types.Jamal = {"Jamal",20,love.graphics.newImage("bin/Sprites/Jamal.png"),
	{{NewQuad(1,1,24,50,25,49)}},25,50,{0,0},0.5,0.5,4,30,
		function() 
			local t = {}
			t[1] = {"t",{{"Jamal",1,{},"Hi, My name is Jamal"},{"Jamal",1,{},"I'm Blind and it's my birthday."},{"Jamal",1,{},"Isn't that sad?"}}}
			Scene.setMode(t,{})
		end,
		function(dt, jamal) return nil end,
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
		true,true,{},0
	}
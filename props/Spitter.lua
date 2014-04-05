	
	BaseSprite = love.graphics.newImage("bin/Sprites/Spitter.png")
	Quad = {
		{NewQuad(1,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(1,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(1,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(1,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{
			NewQuad(1,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(31,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(61,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(91,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(121,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(181,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(211,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(241,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(271,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{
			NewQuad(1,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(31,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(61,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(91,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(121,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(181,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(211,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(241,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(271,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{
			NewQuad(1,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(31,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(61,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(91,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(121,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(181,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(211,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(241,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(271,33,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{
			NewQuad(1,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(31,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(61,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(91,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(121,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(181,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(211,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(241,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(271,1,28,31,BaseSprite:getWidth(),BaseSprite:getHeight())
		}
	}
	Props.Types.Spitter = {"Spitter",2,BaseSprite,Quad,30,32,{0,0},0.2,0.2,0,0,
		function() return nil end,
		function(dt,self)
			self.Vars.AnimTimer = self.Vars.AnimTimer + dt 
			if self.Vars.AnimTimer > 3.5 then
				if self.Vars.AnimTimer > 4.2 then
					self.Vars.AnimTimer = 0
					self.Vars.Anim = false
					Props.Inactive[#Props.Inactive+1] = Props:New(Props.Types.Seed,self.Position.x,self.Position.y)
					if self.Direction == 1 or self.Direction == 3 then
						Props.Inactive[#Props.Inactive].Position.x = self.Position.x + 0.5
						Props.Inactive[#Props.Inactive].Direction = 2
					elseif self.Direction == 2 or self.Direction == 4 then
						Props.Inactive[#Props.Inactive].Position.y = self.Position.y + 0.5
						Props.Inactive[#Props.Inactive].Direction = 3
					end
					Props.Inactive[#Props.Inactive].Moving = true
				end
				if self.Vars.Anim == false and self.Vars.AnimTimer > 3.5 then
					self.PreviousState = {self.Direction,true,1}
					self.State = self.Direction + 4
					self.AnimLoop = false
					self.Vars.Anim = true
				end
				--Props.Active[#Props.Active+1] = seed
			end		
		end,
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
		true,true,{AnimTimer = 0,Anim = false},0
	}
	
	Props.Types.Seed = {"Seed",20,love.graphics.newImage("bin/Sprites/Objects/Seed.png"),{{love.graphics.newQuad(0,0,6,6,6,6)}},6,46,{0,0},0.5,0.5,15,0,
		function() return nil end,
		function(dt,self) return nil end,
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
		function(prop,s)
			if prop == PlayerMob then
				Props:Damage(prop,s,1)
			end
			s.Name = "REMOVE"
		end,
		true,true,{},20
	}
	
	BaseSprite = love.graphics.newImage("bin/Sprites/Template.png")
	Quad = {
		{NewQuad(0,0,25,45,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(25,0,25,45,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(50,0,25,45,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(75,0,25,45,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{
			NewQuad(1,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(26,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(51,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(76,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(101,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(126,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(176,61,23,44,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{
			NewQuad(1,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(26,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(51,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(76,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(101,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(126,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(176,106,23,44,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{
			NewQuad(1,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(26,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(51,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(76,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(101,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(126,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(176,151,23,44,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{
			NewQuad(1,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(26,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(51,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(76,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(101,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(126,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(151,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight()),
			NewQuad(176,196,23,44,BaseSprite:getWidth(),BaseSprite:getHeight())
		},
		{NewQuad(0,241,50,44,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(50,241,50,44,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(100,241,50,44,BaseSprite:getWidth(),BaseSprite:getHeight())},
		{NewQuad(150,241,50,44,BaseSprite:getWidth(),BaseSprite:getHeight())}
	}	Props.Types.Player = {"Player",12,BaseSprite,Quad,25,45,{0,0},0.5,0.5,8,0,
		function() return nil end,
		function(dt, self) 
			if self.Vars.Attacking > 0 then
				local dx = 0
				local dy = 0
				if self.Vars.Attacking == 1 then
					dy = -1
				elseif self.Vars.Attacking == 2 then
					dx = 1
				elseif self.Vars.Attacking == 3 then
					dy = 1
				elseif self.Vars.Attacking == 4 then
					dx = -1
				end
				for i = 1,#Props.Active do
					if Props.Active[i] ~= self then
						if Props.Active[i].Position.x+((Props.Active[i].TakesUpx/2)/4) > self.Position.x - 0.35 + 0.3*dx and Props.Active[i].Position.x+((Props.Active[i].TakesUpx/2)/4) < self.Position.x + 0.35 + 0.3*dx then
							if Props.Active[i].Position.y+((Props.Active[i].TakesUpy/2)/4) > self.Position.y - 0.35 + 0.3*dy and Props.Active[i].Position.y+((Props.Active[i].TakesUpy/2)/4) < self.Position.y + 0.35 + 0.3*dy then
								local Atd = false
								for c = 1,#self.Vars.Attacked do
									if self.Vars.Attacked[c] == i then
										Atd = true
									end
								end
								if not Atd then
									Props:Damage(Props.Active[i],self,1)
									self.Vars.Attacked[#self.Vars.Attacked+1] = i
								end
							end
						end
					end
				end
				if self.State < 9 then
					if love.keyboard.isDown("w") then
						self.Moving = true
						self.Direction = 4
						self.State = 8
					elseif love.keyboard.isDown("s") then
						self.Moving = true
						self.Direction = 2
						self.State = 6
					elseif love.keyboard.isDown("d") then
						self.Moving = true
						self.Direction = 1
						self.State = 5
					elseif love.keyboard.isDown("a") then
						self.Moving = true
						self.Direction = 3
						self.State = 7
					end
					self.Vars.Attacking = 0
					self.Vars.Attacked = {}
				end
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
		function(prop,s)
			local prev = 0
			for i = 4,s.MaxHp,4 do
				local h = s.Hp - prev
				if h > 0 and h < 5  then
					UI.Hearts[(i/4)].Sprite = UI.HIco[h]
				elseif h > 4 then
					UI.Hearts[(i/4)].Sprite = UI.HIco[4]
				else
					UI.Hearts[(i/4)].Sprite = UI.HIco[5]
				end
				prev = i
			end	
		end,
		function(prop,self)
			if love.keyboard.isDown("w") then
				self.Moving = true
				self.Direction = 4
				self.State = 8
			elseif love.keyboard.isDown("s") then
				self.Moving = true
				self.Direction = 2
				self.State = 6
			elseif love.keyboard.isDown("d") then
				self.Moving = true
				self.Direction = 1
				self.State = 5
			elseif love.keyboard.isDown("a") then
				self.Moving = true
				self.Direction = 3
				self.State = 7
			end
		end,
		true,true,{Attackng = 0,Attacked = {}},0
	}
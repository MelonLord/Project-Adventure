	--Props
	----------
	Props = {}
	Props.Active = {}
	Props.Types = {}
	
	ID = 0
	
	OldGrid = {0,0,1}
	NewGrid = {0,0,1}
	SideLeaving = 1
	SideEntering = 1
	
	function Props:Remove(Id)
		Props.Active[Id].Name = "REMOVE"
	end
	function Props:Damage(id,dealer,n)
		Props.Active[id].Hp = Props.Active[id].Hp-n
		Props.Active[id]:OnDamaged(dealer)
	end
	function Props:Update(dt)
		NewList = {}
		for i = 1,#Props.Active do
			--Garbage Cleaning
			----------
			if Props.Active[i].Hp <= 0 then
				Props.Active[i].OnDeath()	
			end
			
			if Props.Active[i].Name ~= "REMOVE" then
				NewList[#NewList + 1] = Props.Active[i]
			end
			
			if not EditMode then
				Props.Active[i]:Update(dt,Props.Active[i])-- Unique update
			end
			
			--Movement
			----------
			
			
			if Props.Active[i].Moving == true and Props.Active[i].CanMove == true then
				local dx = 0
				local dy = 0
				if Props.Active[i].Direction == 1 then
					dy = -1
				elseif Props.Active[i].Direction == 2 then
					dx = 1
				elseif Props.Active[i].Direction == 3 then
					dy = 1
				elseif Props.Active[i].Direction == 4 then
					dx = -1
				else
					Props.Active[i].Direction = 1
					dy = 1
				end
					
				Newx = Props.Active[i].Position.x + (((dt/3)*Props.Active[i].Spd)*dx)
				Newy = Props.Active[i].Position.y + (((dt/3)*Props.Active[i].Spd)*dy)
				
				for c = 1,#Props.Active do
					if Props.Active[c].ID ~= Props.Active[i].ID and Props.Active[c].CanCollide == true then
						--if math.dist(Newx,Newy,Props.Active[c].Position.x,Props.Active[c].Position.y) < Props.Active[c].TakesUp/4 then
						if Newx < (Props.Active[c].Position.x+(((Props.Active[c].TakesUpx/2)/4)+(Props.Active[i].TakesUpx/2))) and Newx > (Props.Active[c].Position.x-(((Props.Active[c].TakesUpx/2)/4)+(Props.Active[i].TakesUpx/2))) then
							if Newy < (Props.Active[c].Position.y+(((Props.Active[c].TakesUpy/2)/4)+(Props.Active[i].TakesUpy/2))) and Newy > (Props.Active[c].Position.y-(((Props.Active[c].TakesUpy/2)/4)+(Props.Active[i].TakesUpy/2))) then
								Newx = Props.Active[i].Position.x
								Newy = Props.Active[i].Position.y
								Props.Active[i].Moving = false
								Props.Active[i]:OnTouched(Props.Active[c])
								Props.Active[c]:OnTouched(Props.Active[i])
							end
						end
					end
				end
				
				if math.round(Newx) > math.round(Props.Active[i].Position.x)or math.round(Newx) < math.round(Props.Active[i].Position.x) or math.round(Newy) < math.round(Props.Active[i].Position.y) or math.round(Newy) > math.round(Props.Active[i].Position.y) then
					OldGrid = Grid[math.round(Props.Active[i].Position.x)][math.round(Props.Active[i].Position.y)]	
					if math.round(Newx) > math.round(Props.Active[i].Position.x) then
						NewGrid = Grid[math.round(Newx)][math.round(Props.Active[i].Position.y)]
						SideLeaving = 2
						SideEntering = 4
					elseif math.round(Newx) < math.round(Props.Active[i].Position.x) then
						NewGrid = Grid[math.round(Newx)][math.round(Props.Active[i].Position.y)]
						SideLeaving = 4
						SideEntering = 2 
					elseif math.round(Newy) < math.round(Props.Active[i].Position.y) then
						NewGrid = Grid[math.round(Props.Active[i].Position.x)][math.round(Newy)]
						SideLeaving = 1
						SideEntering = 3
					elseif math.round(Newy) > math.round(Props.Active[i].Position.y) then
						NewGrid = Grid[math.round(Props.Active[i].Position.x)][math.round(Newy)]
						SideLeaving = 3
						SideEntering = 1
					end
					if OldGrid[2] == NewGrid[2]+1 then
						if SideIdentifier[OldGrid[3]][SideLeaving] ~= 4 or SideIdentifier[NewGrid[3]][SideEntering] ~= 1 then
							Newx = Props.Active[i].Position.x
							Newy = Props.Active[i].Position.y
							Props.Active[i].Moving = false
						end
					elseif OldGrid[2] == NewGrid[2]-1 then
						if SideIdentifier[OldGrid[3]][SideLeaving] ~= 1 or SideIdentifier[NewGrid[3]][SideEntering] ~= 4 then
							Newx = Props.Active[i].Position.x
							Newy = Props.Active[i].Position.y
							Props.Active[i].Moving = false
						end
					elseif NewGrid[2] == OldGrid[2] then
						if SideIdentifier[OldGrid[3]][SideLeaving] ~= SideIdentifier[NewGrid[3]][SideEntering] then
							Newx = Props.Active[i].Position.x
							Newy = Props.Active[i].Position.y
							Props.Active[i].Moving = false
						end
					else
						Newx = Props.Active[i].Position.x
						Newy = Props.Active[i].Position.y
						Props.Active[i].Moving = false
					end
				end
				Props.Active[i].Position.x = Newx
				Props.Active[i].Position.y = Newy
			end
			
			
			--Animation
			----------
			Props.Active[i].LastUpdate = Props.Active[i].LastUpdate+dt
			if Props.Active[i].LastUpdate > 0.1*Props.Active[i].AnimSpeed then
				Props.Active[i].AnimStage = Props.Active[i].AnimStage+1
				if Props.Active[i].AnimStage > #Props.Active[i].States[Props.Active[i].State] then
					if Props.Active[i].AnimLoop then
						Props.Active[i].AnimStage = 1
					else
						Props.Active[i].State = Props.Active[i].PreviousState[1]
						Props.Active[i].AnimLoop = Props.Active[i].PreviousState[2]
						Props.Active[i].AnimSpeed = Props.Active[i].PreviousState[3]
						Props.Active[i].AnimStage = 1
					end
				end
				local _,_,w = Props.Active[i].States[Props.Active[i].State][1]:getViewport()
				if w ~= Props.Active[i].Width then
					Props.Active[i].Width = w
				end
				Props.Active[i].LastUpdate = 0
			end
		end
		if Skip then
			local m = false
			if love.keyboard.isDown("w") or love.keyboard.isDown("s") or love.keyboard.isDown("d") or love.keyboard.isDown("a") then
				m = true
			end
			NewList = Level.Props
			NewList[#NewList+1] = Props:New(Props.Types.Player,PlayerPort.x,PlayerPort.y)
			NewList[#NewList].Moving = m
			NewList[#NewList].Direction = PlayerMob.Direction
			if m then
				NewList[#NewList].State = PlayerMob.Direction + 4
			else
				NewList[#NewList].State = PlayerMob.Direction
			end
			Grid = Level.Grid
			--Level = {Props = {}, Grid = {}}
			PlayerPort = {x = 1,y = 1}
			PlayerMob.Name = "REMOVE"
			PlayerMob = NewList[#NewList]
			Skip = false
		end
		Props.Active = NewList
		
	end
				
	--New Props
	----------
	function Props:New(PropType,x,y)
		--1Name,2Hp,3Sprite,4Quads,5Width,6Height,7Yoffset,8Spacex,9Spacey,10Spd,11Lum,12DefaultAction,13UpdateFunction,14OnRemove,15OnDeath,16OnDamage,17OnTouch,18CanCollide,19CanMove,20Extra,21BetweenPixelBug
		Prop = {}
		Prop.Name = PropType[1]
		Prop.Hp = PropType[2]
		Prop.MaxHp = PropType[2]
		Prop.Spd = PropType[10]
		Prop.Lum = PropType[11]
		
		function Prop:Update(dt,P) PropType[13](dt,P) end
		function Prop:DefaultAction() PropType[12]() end
		
		Prop.Vars = PropType[20]
		
		Prop.Width = PropType[5]
		Prop.Height = PropType[6]
		Prop.Position = {}
		Prop.Position.x = x
		Prop.Position.y = y
		Prop.Sx = 0 --Literal Position
		Prop.Sy = 0
		Prop.YOffset = PropType[7][2]
		Prop.XOffset = PropType[7][1]
		Prop.ErrorOffset = PropType[21]
		Prop.TakesUpx = PropType[8]
		Prop.TakesUpy = PropType[9]
		
		Prop.Sprite = PropType[3]
		Prop.States = PropType[4]-- Quads are set as Quad = {{state1},{state2},{state3-1,state3-2,state3-3}}
		Prop.State = 1
		Prop.LastState = 1
		Prop.AnimStage = 1
		Prop.LastUpdate = 0
		Prop.AnimLoop = true
		Prop.AnimSpeed = 1
		Prop.PreviousState = {1,true,1}
		
		--Prop.MoveCue = {}
		Prop.Direction = 1
		Prop.Moving = false
		
		Prop.ID = 1
		ID = ID + 1
		Prop.ID = ID

		Prop.i = #Props.Active+1
		
		Prop.Event = {}
		function Prop:OnRemove() PropType[14]() end
		function Prop:OnDeath() PropType[15]() end
		--[[
		function()
			for i = 1,#Props.Active do 
				if Props.Active[i].ID == id then 
					Props.Active[i].OnRemove()
					Props:Remove(i) 
				end 
			end
		end]]
		function Prop:OnDamaged(prop) PropType[16](prop) end
		function Prop:OnTouched(prop) PropType[17](prop) end
		
		Prop.CanCollide = PropType[18]
		Prop.Touched = false
		Prop.CanMove = PropType[19]
		
		return Prop
	end
	
--Prop Types
----------
	NewQuad = love.graphics.newQuad
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
	}
--1Name,2Hp,3Sprite,4Quads,5Width,6Height,7Yoffset,8Spacex,9Spacey,10Spd,11Lum,12DefaultAction,13UpdateFunction,14OnRemove,15OnDeath,16OnDamage,17OnTouch,18CanCollide,19CanMove,20Extra,21BetweenPixelBug
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
		function(prop) return nil end,
		function(prop) return nil end,
		false,false,{},0
	}
	
	Props.Types.Player = {"Player",20,BaseSprite,Quad,25,45,{0,0},0.5,0.5,8,0,
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
									Props:Damage(i,self,5)
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,true,{Attackng = 0,Attacked = {}},0
	}
	
	Props.Types.Jamal = {"Jamal",20,love.graphics.newImage("bin/Sprites/Jamal.png"),
	{{NewQuad(1,1,24,50,25,49)}},25,50,{0,0},0.5,0.5,4,30,
		function() 
			local t = {}
			t[1] = {"t",{{"Jamal",1,{},"Hi, My name is Jamal"},{"Jamal",1,{},"I'm Blind and it's my birthday."},{"Jamal",1,{},"Isn't that sad?"}}}
			Scene.setMode(t,{})
		end,
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,true,{},0
	}
	
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
		function(prop) return nil end,
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
		function(prop) return nil end,
		function(prop)
			if prop == PlayerMob then
				ChangeLevel(town1,15.5,12)
			end
		end,
		true,false,{},32
	}
	
	Props.Types.Tree = {"Tree",200,love.graphics.newImage("bin/Terrain/Props/Tree1.png"),
	{{love.graphics.newQuad(0,0,130,185,130,185)}},100,180,{0,0},4,4,0,0,
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
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
		function(prop) return nil end,
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
		function(prop) return nil end,
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
		function(prop) return nil end,
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
		function(prop) return nil end,
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House2_0 = {"House2_0",200,love.graphics.newImage("bin/Terrain/Props/House2_0.png"),
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House2_3 = {"House2_3",200,love.graphics.newImage("bin/Terrain/Props/House2_-1.png"),
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House2_4 = {"House2_4",200,love.graphics.newImage("bin/Terrain/Props/House2_-2.png"),
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House2_1 = {"House2_1",200,love.graphics.newImage("bin/Terrain/Props/House2_1.png"),
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
	Props.Types.House2_2 = {"House2_2",200,love.graphics.newImage("bin/Terrain/Props/House2_2.png"),
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
	
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}

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
		function(prop) return nil end,
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
		function(prop) return nil end,
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
		function(prop) return nil end,
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
		function(prop) return nil end,
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
		function(prop) return nil end,
		function(prop) return nil end,
		true,false,{},0
	}
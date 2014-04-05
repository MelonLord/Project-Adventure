	--Props
	----------
	NewQuad = love.graphics.newQuad
	
	Props = {}
	Props.Active = {}
	Props.Types = {}
	Props.Inactive = {}
	
	ID = 0
	
	OldGrid = {0,0,1}
	NewGrid = {0,0,1}
	SideLeaving = 1
	SideEntering = 1
	
	function Props:Remove(Id)
		Props.Active[Id].Name = "REMOVE"
	end
	function Props:Damage(prop,dealer,n)
		prop.Hp = prop.Hp-n
		prop:OnDamaged(dealer,prop)
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
								s1 = Props.Active[i]
								s2 = Props.Active[c]
								Props.Active[i]:OnTouched(Props.Active[c],s1)
								Props.Active[c]:OnTouched(Props.Active[i],s2)
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
			NewList[#NewList].AnimSpeed = PlayerMob.AnimSpeed
			NewList[#NewList].Moving = m
			NewList[#NewList].Direction = PlayerMob.Direction
			NewList[#NewList].Hp = PlayerMob.Hp
			NewList[#NewList].MaxHp = PlayerMob.MaxHp
			if m then
				NewList[#NewList].State = PlayerMob.Direction + 4
			else
				NewList[#NewList].State = PlayerMob.Direction
			end
			Grid = Level.Grid
			BackgroundColor = Level.Background
			--Level = {Props = {}, Grid = {}}
			PlayerPort = {x = 1,y = 1}
			PlayerMob.Name = "REMOVE"
			PlayerMob = NewList[#NewList]
			Skip = false
		end
		Props.Active = NewList
		for i = 1,#Props.Inactive do
			table.insert(Props.Active,Props.Inactive[i])
		end
		Props.Inactive = {}
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
		function Prop:OnDamaged(prop,self) PropType[16](prop,self) end
		function Prop:OnTouched(prop,self) PropType[17](prop,self) end
		
		Prop.CanCollide = PropType[18]
		Prop.Touched = false
		Prop.CanMove = PropType[19]
		
		return Prop
	end
	
--Prop Types
----------
	
--1Name,2Hp,3Sprite,4Quads,5Width,6Height,7Yoffset,8Spacex,9Spacey,10Spd,11Lum,12DefaultAction,
--13UpdateFunction,14OnRemove,15OnDeath,16OnDamage,17OnTouch,18CanCollide,19CanMove,20Extra,21BetweenPixelBug


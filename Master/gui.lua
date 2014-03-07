	Gui = {}
	Gui.Active = {}

	function Gui:Remove(i)
		Gui.Active[i].Name = "REMOVE"
	end

	function Gui:Update(dt)
		NewList = {}
    	for i = 1,#Gui.Active do
      		if Gui.Active[i].Name ~= "REMOVE" then
          	  NewList[#NewList + 1] = Gui.Active[i]
        	end
        	Gui.Active[i].Update()
    	end
 	end

	function Gui:New(Name,Type,Sprite,x,y,sx,sy,Alpha,Update,Extra)
		Prop = {}
    	Prop.Name = Name
    	Prop.Type = Type
    	Prop.Sprite = Sprite
    	Prop.x = x
    	Prop.y = y
    	Prop.Sx = sx
    	Prop.Sy = sy
    	Prop.Alpha = Alpha
    	--Prop.OnClick = OnClick
    	Prop.Update = Update
    	Prop.Var = ExtraVariables
   		return Prop
	end
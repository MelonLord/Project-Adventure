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
    	Gui.Active = NewList
 	end

	function Gui:New(Name,Type,Sprite,x,y,sx,sy,w,h,Alpha,Update,Extra,OnClick)
		Prop = {}
    	Prop.Name = Name
    	Prop.Type = Type
    	Prop.Sprite = Sprite
    	Prop.x = x
    	Prop.y = y
    	Prop.Sx = sx or 1
    	Prop.Sy = sy or 1
    	Prop.ScaleX = w or 1
    	Prop.ScaleY = h or 1

    	Prop.Alpha = Alpha or 255
    	Prop.OnClick = OnClick or (function() return nil end)
    	Prop.Update = Update or (function() return nil end)
    	Prop.Var = Extra or {}
   		return Prop
	end
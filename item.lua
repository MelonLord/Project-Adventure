Items = {}
Items.Has = {}
Items.All = {}
Items.Active = {"Sword","Blank"}

--1Name,2Sprite,3HasAmmo,4UseFunction
function Items:New(Name,Sprite,HasAmmo,UseFunction,UpdateFunction)
	prop = {}
	prop.Name = Name
	prop.Sprite = Sprite
	prop.HasAmmo = HasAmmo
	prop.Ammo = 0
	function prop:UseFunction(self) UseFunction(self) end
	function prop:Update(self,dt,dx,dy) UpdateFunction(self,dt,dx,dy) end
	return prop
end

Items.All["Blank"] = Items:New("Blank",love.graphics.newImage(love.image.newImageData(45,45)),false,function(self) return nil end,function(self) PlayerMob.Vars.Attacking = 0 end)
Items.All["Sword"] = Items:New("Sword",love.graphics.newImage("bin/Gui/Items/SwordIco.png"),false,function(s)
	PlayerMob.Vars.Attacking = PlayerMob.Direction
	PlayerMob.State = 8 + PlayerMob.Direction
	PlayerMob.Width = 50
	PlayerMob.PreviousState = {PlayerMob.Direction,true,PlayerMob.AnimSpeed}
	PlayerMob.Moving = false
	PlayerMob.AnimLoop = false
	PlayerMob.AnimSpeed = 5
end,
function(s,dt,dx,dy)
	local self = PlayerMob
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
end)
Items.Has[1] = Items.All["Blank"]
Items.Has[2] = Items.All["Sword"]
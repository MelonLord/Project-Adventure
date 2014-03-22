
SceneMode = false
Scene = {}
Scene.CurrentScene = {}
Scene.Actors = {}
Scene.Timer = 0
Scene.Frame = 1
Scene.Step = 1
Scene.Speed = 1
Scene.Guis = {}

Scene.Textbox = love.graphics.newImage("bin/Gui/Textbox.png")
Scene.Arrow = love.graphics.newImage("bin/Gui/Arrow.png")
Scene.Print = ""

function Scene.setMode(current,actors)
	Scene.CurrentScene = current
	Scene.Actors = actors
	Scene.Timer = 0
	Scene.Frame = 1
	Scene.Step = 1
	SceneMode = true
end

function Scene.update(dt)
	if SceneMode then
		Scene.Timer = Scene.Timer + dt
		if not (Scene.Step > #Scene.CurrentScene) then
			if Scene.CurrentScene[Scene.Step][1] == "t" then
				if not (Scene.Frame > #Scene.CurrentScene[Scene.Step][2]) then
					if Scene.Timer == dt then
						Scene.Guis[1] = Gui:New("TextBox",1,Scene.Textbox,(love.window.getWidth()-800)/2,love.window.getHeight()-40-100,1,1,Scene.Textbox:getWidth(),Scene.Textbox:getHeight())
						Gui.Active[#Gui.Active+1] = Scene.Guis[1]
						Scene.Guis[2] = Gui:New("Text",2,Scene.Print,(love.window.getWidth()-760)/2,love.window.getHeight()-10-100,760)
						Scene.Guis[3] = Gui:New("Name",2,Scene.CurrentScene[Scene.Step][2][Scene.Frame][1],(love.window.getWidth()-780)/2,love.window.getHeight()-35-100,600)
						Scene.Guis[4] = Gui:New("Arrow",1,Scene.Arrow,(love.window.getWidth()+800)/2,love.window.getHeight()-40,1,1,Scene.Arrow:getWidth(),Scene.Arrow:getHeight(),0)
						Gui.Active[#Gui.Active+1] = Scene.Guis[2]
						Gui.Active[#Gui.Active+1] = Scene.Guis[3]
						Gui.Active[#Gui.Active+1] = Scene.Guis[4]
					end
					if not (math.round((Scene.Timer*Scene.Speed)*30) > string.len(Scene.CurrentScene[Scene.Step][2][Scene.Frame][4])) then
						Scene.Print = string.sub(Scene.CurrentScene[Scene.Step][2][Scene.Frame][4],1,math.round((Scene.Timer*Scene.Speed)*30))
					else 
						Scene.Guis[4].Alpha = 255
						if love.keyboard.isDown("z") then
							Scene.Frame = Scene.Frame + 1
							Scene.Guis[4].Alpha = 0
							Scene.Timer = 0
							for i = 1,#Scene.Guis do
								Scene.Guis[i].Name = "REMOVE"
							end
						end
					end
					Scene.Guis[2].Sprite = Scene.Print
				else
					Scene.Step = Scene.Step + 1
				end
			end
		else 
			SceneMode = false
		end
	end
end

--Format
---------
--Textbox = "t",table textboxes ({string talking,enum boxtype,soundtable --Not implemented ,string text},)
--Actor Movment = "m"
--Actor Animation = "a"
--New Actor = "n"
--Remove Actor = "r"
--Level change = "l"
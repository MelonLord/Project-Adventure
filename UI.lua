Gui.Active[#Gui.Active+1] = Gui:New("Bar",1,love.graphics.newImage("bin/Gui/Bar.png"),0,0,1,0.6)
Gui.Active[#Gui.Active+1] = Gui:New("Health",2,"Health",20,15,100)
Gui.Active[#Gui.Active+1] = Gui:New("Item1",2,"Item 1",450,5,100)
Gui.Active[#Gui.Active+1] = Gui:New("Item2",2,"Item 2",530,5,100)

UI = {}
UI.HIco = {}
UI.HIco[4] = love.graphics.newImage("bin/Gui/HeartFull.png")
UI.HIco[3] = love.graphics.newImage("bin/Gui/Heart3_4.png")
UI.HIco[2] = love.graphics.newImage("bin/Gui/Heart1_2.png")
UI.HIco[1] = love.graphics.newImage("bin/Gui/Heart1_4.png")
UI.HIco[5] = love.graphics.newImage("bin/Gui/HeartEmpty.png")
UI.HIco[6] = love.graphics.newImage(love.image.newImageData(1,1))

UI.ItemBox = love.graphics.newImage("bin/Gui/ItemBox.png")

UI.Hearts = {}
UI.Hearts[1] = Gui:New("Heart1",1,UI.HIco[4],20,30,1,1)
UI.Hearts[2] = Gui:New("Heart2",1,UI.HIco[4],60,30,1,1)
UI.Hearts[3] = Gui:New("Heart3",1,UI.HIco[4],100,30,1,1)
UI.Hearts[4] = Gui:New("Heart4",1,UI.HIco[6],140,30,1,1)
UI.Hearts[5] = Gui:New("Heart5",1,UI.HIco[6],180,30,1,1)
UI.Hearts[6] = Gui:New("Heart6",1,UI.HIco[6],220,30,1,1)
UI.Hearts[7] = Gui:New("Heart7",1,UI.HIco[6],260,30,1,1)
UI.Hearts[8] = Gui:New("Heart8",1,UI.HIco[6],300,30,1,1)
UI.Hearts[9] = Gui:New("Heart9",1,UI.HIco[6],340,30,1,1)
UI.Hearts[10] = Gui:New("Heart10",1,UI.HIco[6],380,30,1,1)
UI.Hearts[11] = Gui:New("Heart11",1,UI.HIco[6],420,30,1,1)
UI.Hearts[12] = Gui:New("Heart12",1,UI.HIco[6],460,30,1,1)

UI.Items = {}
UI.Items["ItemBox1"] = Gui:New("ItemBox1",1,UI.ItemBox,920,44,0.5,0.5)
UI.Items["ItemBox2"] = Gui:New("ItemBox2",1,UI.ItemBox,1080,44,0.5,0.5)


Gui.Active[#Gui.Active+1] = UI.Hearts[1]
Gui.Active[#Gui.Active+1] = UI.Hearts[2]
Gui.Active[#Gui.Active+1] = UI.Hearts[3]
Gui.Active[#Gui.Active+1] = UI.Hearts[4]
Gui.Active[#Gui.Active+1] = UI.Hearts[5]
Gui.Active[#Gui.Active+1] = UI.Hearts[6]
Gui.Active[#Gui.Active+1] = UI.Hearts[7]
Gui.Active[#Gui.Active+1] = UI.Hearts[8]
Gui.Active[#Gui.Active+1] = UI.Hearts[9]
Gui.Active[#Gui.Active+1] = UI.Hearts[10]
Gui.Active[#Gui.Active+1] = UI.Hearts[11]
Gui.Active[#Gui.Active+1] = UI.Hearts[12]

Gui.Active[#Gui.Active+1] = UI.Items["ItemBox1"]
Gui.Active[#Gui.Active+1] = UI.Items["ItemBox2"]
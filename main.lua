io.stdout:setvbuf('no')

ADMIN = true

local title = "Welcome to the Neco-arc World"
local message = "choose a window"
local buttons = {"Bread", "Fight", "Date", "Platform2", "Platform", "Stats", "Pet", escapebutton = 7, enterbutton = 1}

local pressedbutton = love.window.showMessageBox(title, message, buttons, info)
local app = buttons[pressedbutton]

screen = {width,height} --🖼️
screen.width, screen.height = love.window.getDesktopDimensions()
window = {width,height} --🖼️
window.x,window.y = love.window.getPosition()
mouse = {x,y} --🖱️

Class = require"libs/hump.class"
Timer = require"libs/hump.timer" --⏱️
--flux = require"libs/flux" --↗️
anim8 = require "libs/anim8" --🎞️
--InputField = require"libs/InputField" --📄
--field = InputField("Initial text.") --📄
Konami = require"libs/konami" --🗝️
Konami.setWaitTime(1.5)
--premi 6 9 del tastierino numerico 69 volte
Konami.newCode({"kp6", "kp9", "kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6", "kp9","kp6"}, function() love.system.openURL("https://www.reddit.com/user/Cring3_Crimson") end)
require"libs/text_anim" --💬 
require"font"
require"audio" --🎵
wf = require"libs/windfield"
local data = {}
require"Fight"
require"Platform"
require"Platform2"

function check_aabb(ax, ay, aw, ah, bx, by, bw, bh)
	if ax < bx + bw and
	 ax + aw > bx and
	  ay < by + bh and
	   by < ay + ah then
		return true --se b è dentro a
	else
		return false 
	end
end

function union(a, b)
    local result = {}
    for k,v in pairs(a) do
        table.insert( result, v )
    end
    for k,v in pairs(b) do
        table.insert( result, v )
    end
    return result
end

choise = Class{
	init = function(self,text,x,y,route)
		self.text = text
		self.x = x
		self.y = y
		self.font = font.verdana
		self.width = self.font:getWidth(text)
		self.height = self.font:getHeight(text)
		self.bool = false
		self.route = route
	end,
}
choises = {}

local text
local route = "0"
function love.load() --💾
	--imgs
	quad = love.graphics.newImage("assets/quad.png")
	quad2 = love.graphics.newImage("assets/quad2.png")
	Transition = {bool=false,bool2=false,alpha=0}
	--loading
	loading = {grid,animation,frames="12",duration=0.6}
	loading.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 0, 1664)
    loading.animation = anim8.newAnimation(loading.grid('1-'..loading.frames..'',1), 0.10)
	--font and text
	font:load() --💾
	audio:load() --💾🎵
	--start
	if app == "Pet" then
		love.window.setTitle("Hi, I'm Neco-arc") --🖼️
		love.window.setIcon(love.image.newImageData("assets/icon.png"))
		love.window.setMode(400, 600)
		window.width,window.height = love.window.getMode()
		love.window.setPosition(screen.width-window.width, screen.height-window.height) --🖼️

		local RandomMusic = love.math.random(1,2) --🎵
    	audio.music[RandomMusic]:play()

		Neco = {x,y,X,Y,width,height,scale,hp=100,maxHp=100,hunger=50,full=100,lv=0,xp=0,maxXp=100,love=0,friendship=0}
		Neco.scale = 0.5
		Neco.width = 512*Neco.scale
		Neco.height = 768*Neco.scale
		Neco.x = (window.width/2)-(Neco.width/2)
		Neco.y = (window.height/2)-(Neco.height/2)
		Neco.r = 0
		NecoImg = love.graphics.newQuad(1536, 128, Neco.width/Neco.scale, Neco.height/Neco.scale, quad)

	elseif app == "Fight" then
		Fight.load() --💾

	elseif app == "Stats" then
		love.window.setTitle("statistics") --🖼️
		love.window.setIcon(love.image.newImageData("assets/jar.png"))
		love.window.setMode(300, 200, {resizable=true})
		window.width,window.height = love.window.getMode()
		love.window.setPosition(screen.width-window.width, 0) --🖼️
		Neco = {hp,maxHp,hunger,lv,xp,maxXp,love,friendship}
		Bars = {hp={x,y,width,height,text={font,width,height}},xp={x,y,width,height,text={font,width,height}},hunger={x,y,width,height,text={text,color={r,g,b},font,width,height}}}
	
	elseif app == "Platform" then
		Platform.load() --💾

	elseif app == "Platform2" then
		Platform2.load() --💾

	elseif app == "Date" then
		love.window.setTitle("Cafè") --🖼️
		love.window.setIcon(love.image.newImageData("assets/Neco_Cafe.png"))
		love.window.setMode(900, 600)
		window.width,window.height = love.window.getMode()
		location = "Cafe"
		--route
			route = "1"
		--imges
			Cafe = love.graphics.newImage("assets/Neco_Cafe.png")
			Table = love.graphics.newImage("assets/table.png")
			scale = window.width/Cafe:getWidth()
			McDonald = love.graphics.newImage("assets/Neco_McDonald.png")
			McDonaldTable = love.graphics.newImage("assets/Neco_McDonaldTable.png")
			Neco = {img, x=window.width*0.3, y=window.height*0.3, scale=1.5}
			Neco.img = love.graphics.newImage("assets/necoSpritesSingle/5_000_005.png")
		--textbox
			text_anim:load("Are you SummyUwU69?",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
		--answers
			Timer.after(1, function()
				animText = true
				Timer.after(2, function()
					table.insert(choises,choise("Yes",window.width*0.65,window.height*0.55,"1.1"))
					Timer.after(1, function() if route == "1" then
						table.insert(choises,choise("No",window.width*0.65,window.height*0.6,"1.2")) end
						Timer.after(2, function() if route == "1" then
							table.insert(choises,choise("Actually I'm SummyUwU420",window.width*0.65,window.height*0.65,"1.3")) end
						end)
					end)
				end)
			end)
	elseif app == "Bread" then
		love.window.setTitle("Bread") --🖼️
		love.window.setIcon(love.image.newImageData("assets/bread.png"))
		love.window.setMode(160, 135)
		window.width,window.height = love.window.getMode()
		love.window.setPosition(50, 50) --🖼️
		breadImg = love.graphics.newImage("assets/bread.png")
		bread = {bool=true, x, y, width, height, scale = 0.3}
		bread.width = breadImg:getWidth()*bread.scale
		bread.height = breadImg:getHeight()*bread.scale
	end
end

local booleriana = false
function love.update(dt) --🔁
	window.x,window.y = love.window.getPosition() --🖼️
	mouse.x,mouse.y = love.mouse.getPosition() --🖱️
	Timer.update(dt) --🔁
	Konami.update(dt) --🔁
	loading.animation:update(dt) --🔁
	if animText then
		text_anim:update(dt) --💬🔁
	end
	if app == "Pet" then
		Neco.X = Neco.x+window.x
		Neco.Y = Neco.y+window.y

		Timer.every(0.5, function()
			if Neco.hunger > 0 then
				Neco.hunger = Neco.hunger-0.00005
			end
		end)
		if Neco.hunger > 100 then
			Neco.hunger = 100
		end
		--Write
		love.filesystem.write("NecoHp.txt", Neco.hp)
		love.filesystem.write("NecoMaxHp.txt", Neco.maxHp)
		love.filesystem.write("NecoHunger.txt", Neco.hunger)
		love.filesystem.write("NecoFull.txt", Neco.full)
		love.filesystem.write("NecoLv.txt", Neco.lv)
		love.filesystem.write("NecoXp.txt", Neco.xp)
		love.filesystem.write("NecoMaxXp.txt", Neco.maxXp)
		love.filesystem.write("NecoLove.txt", Neco.love)
		love.filesystem.write("NecoFriendship.txt", Neco.friendship)
		--Read
		if love.filesystem.getInfo("BreadX.txt") and love.filesystem.getInfo("BreadY.txt") then
	        data.bread = {x=love.filesystem.read("BreadX.txt"),y=love.filesystem.read("BreadY.txt")}
	        --string to number
	        if type(data.bread.x) == "string" then
	        	data.bread.x = tonumber(data.bread.x)
	        end
	        if type(data.bread.y) == "string" then
	        	data.bread.y = tonumber(data.bread.y)
	        end
	        --check
	        if data.bread.x and data.bread.y then
		        if check_aabb(Neco.X, Neco.Y, Neco.width, Neco.height, data.bread.x, data.bread.y, 1, 1) then
					Neco.hunger = Neco.hunger + 40
					love.filesystem.write("BreadEaten.txt", 1)
					love.filesystem.write("BreadX.txt", -50)
					love.filesystem.write("BreadY.txt", -50)
				end
			end
		end

	elseif app == "Fight" then
		Fight.update(dt) --🔁

	elseif app == "Stats" then
		Bars.hp.x = window.width*0.1
		Bars.hp.y = window.height*0.1
		Bars.hp.width = window.width*0.8
		Bars.hp.height = window.height*0.2

		Bars.xp.x = window.width*0.1
		Bars.xp.y = window.height*0.4
		Bars.xp.width = window.width*0.8
		Bars.xp.height = window.height*0.2

		Bars.hunger.x = window.width*0.1
		Bars.hunger.y = window.height*0.7
		Bars.hunger.width = window.width*0.8
		Bars.hunger.height = window.height*0.2

		Bars.hp.text.font = love.graphics.getFont()
		Bars.hp.text.width = Bars.hp.text.font:getWidth("HP: 100/100")
		Bars.hp.text.height = Bars.hp.text.font:getHeight("HP: 100/100")

		Bars.xp.text.font = love.graphics.getFont()
		Bars.xp.text.width = Bars.xp.text.font:getWidth("LEVEL: 100")
		Bars.xp.text.height = Bars.xp.text.font:getHeight("LEVEL: 100")
		if Neco.hunger then
			if Neco.hunger > 100 then --🎨
				Bars.hunger.text.text = "Gonna explode"
				Bars.hunger.text.color.r = 0.7
				Bars.hunger.text.color.g = 0.7
				Bars.hunger.text.color.b = 0.2
			elseif Neco.hunger > 90 then
				Bars.hunger.text.text = "I'm full"
				Bars.hunger.text.color.r = 0.5
				Bars.hunger.text.color.g = 0.8
				Bars.hunger.text.color.b = 0.2
			elseif Neco.hunger > 70 then
				Bars.hunger.text.text = "I'm fine"
				Bars.hunger.text.color.r = 0.5
				Bars.hunger.text.color.g = 0.7
				Bars.hunger.text.color.b = 0.7
			elseif Neco.hunger > 40 then
				Bars.hunger.text.text = "Do you have any bread?"
				Bars.hunger.text.color.r = 0.4
				Bars.hunger.text.color.g = 0.7
				Bars.hunger.text.color.b = 0.7
			elseif Neco.hunger > 20 then
				Bars.hunger.text.text = "I'm starving"
				Bars.hunger.text.color.r = 0.7
				Bars.hunger.text.color.g = 0.8
				Bars.hunger.text.color.b = 0.8
			elseif Neco.hunger > 10 then
				Bars.hunger.text.text = "Bro I'm diyng"
				Bars.hunger.text.color.r = 1
				Bars.hunger.text.color.g = 0.5
				Bars.hunger.text.color.b = 0.5
			elseif Neco.hunger > 5 then
				Bars.hunger.text.text = "NEED FOOD NOW"
				Bars.hunger.text.color.r = 1
				Bars.hunger.text.color.g = 0
				Bars.hunger.text.color.b = 0
			else
				Bars.hunger.text.text = "Man I'm dead"
				Bars.hunger.text.color.r = 0.5
				Bars.hunger.text.color.g = 0.5
				Bars.hunger.text.color.b = 0.5
			end
			Bars.hunger.text.font = love.graphics.getFont()
			Bars.hunger.text.width = Bars.hunger.text.font:getWidth(Bars.hunger.text.text)
			Bars.hunger.text.height = Bars.hunger.text.font:getHeight(Bars.hunger.text.text)
		end

		--Read
		if love.filesystem.getInfo("NecoFriendship.txt") and love.filesystem.getInfo("NecoLv.txt") then
			if type((love.filesystem.read("NecoHp.txt"))) == "number" then
				Neco.hp = (love.filesystem.read("NecoHp.txt"))
			elseif type((love.filesystem.read("NecoHp.txt"))) == "string" then
				Neco.hp = tonumber((love.filesystem.read("NecoHp.txt")))
			end
			if type((love.filesystem.read("NecoMaxHp.txt"))) == "number" then
				Neco.maxHp = (love.filesystem.read("NecoMaxHp.txt"))
			elseif type((love.filesystem.read("NecoMaxHp.txt"))) == "string" then
				Neco.maxHp = tonumber((love.filesystem.read("NecoMaxHp.txt")))
			end
			if type((love.filesystem.read("NecoHunger.txt"))) == "number" then
				Neco.hunger = (love.filesystem.read("NecoHunger.txt"))
			elseif type((love.filesystem.read("NecoHunger.txt"))) == "string" then
				Neco.hunger = tonumber((love.filesystem.read("NecoHunger.txt")))
			end
			if type((love.filesystem.read("NecoFull.txt"))) == "number" then
				Neco.full = (love.filesystem.read("NecoFull.txt"))
			elseif type((love.filesystem.read("NecoFull.txt"))) == "string" then
				Neco.full = tonumber((love.filesystem.read("NecoFull.txt")))
			end
			if type((love.filesystem.read("NecoLv.txt"))) == "number" then
				Neco.lv = (love.filesystem.read("NecoLv.txt"))
			elseif type((love.filesystem.read("NecoLv.txt"))) == "string" then
				Neco.lv = tonumber((love.filesystem.read("NecoLv.txt")))
			end
			if type((love.filesystem.read("NecoXp.txt"))) == "number" then
				Neco.xp = (love.filesystem.read("NecoXp.txt"))
			elseif type((love.filesystem.read("NecoXp.txt"))) == "string" then
				Neco.xp = tonumber((love.filesystem.read("NecoXp.txt")))
			end
			if type((love.filesystem.read("NecoMaxXp.txt"))) == "number" then
				Neco.maxXp = (love.filesystem.read("NecoMaxXp.txt"))
			elseif type((love.filesystem.read("NecoMaxXp.txt"))) == "string" then
				Neco.maxXp = tonumber((love.filesystem.read("NecoMaxXp.txt")))
			end
			if type((love.filesystem.read("NecoLove.txt"))) == "number" then
				Neco.love = (love.filesystem.read("NecoLove.txt"))
			elseif type((love.filesystem.read("NecoLove.txt"))) == "string" then
				Neco.love = tonumber((love.filesystem.read("NecoLove.txt")))
			end
			if type((love.filesystem.read("NecoFriendship.txt"))) == "number" then
				Neco.friendship = (love.filesystem.read("NecoFriendship.txt"))
			elseif type((love.filesystem.read("NecoFriendship.txt"))) == "string" then
				Neco.friendship = tonumber((love.filesystem.read("NecoFriendship.txt")))
			end
		end

	elseif app == "Platform" then
		Platform.update(dt) --🔁

	elseif app == "Platform2" then
		Platform2.update(dt) --🔁

	elseif app == "Date" then
		--update texts
		for c, choise in ipairs(choises) do
			if check_aabb(choise.x, choise.y, choise.width, choise.height, mouse.x, mouse.y, 1, 1) then
				choise.bool = true
			else
				choise.bool = false
			end
		end

		if location == "Cafe" then
			--step by step story
			if route == "1.1" then --Cafe
				--route
				route = "1.1a"
				--empty table
				choises = {}
				--textbox
				text_anim:load("You don't look like your profile picture",50, window.height-90, 1, 1, 0.08, 0, 0) --💬💾
				--answers
				Timer.after(4, function()
					table.insert(choises,choise("I cut my beard",window.width*0.65,window.height*0.55,"1.1.1"))
					Timer.after(2, function() if route == "1.1a" then
						table.insert(choises,choise("It's an old photo",window.width*0.65,window.height*0.6,"1.1.2")) end
						Timer.after(2, function() if route == "1.1a" then
							table.insert(choises,choise("Shut up and get in the van",window.width*0.65,window.height*0.65,"1.1.3")) end
						end)
					end)
				end)
			elseif route == "1.1.1" then --"I cut my beard"
				route = "1.1.1a"
				choises = {}
				text_anim:load("I think you should have keep it, beard is friking cool!",50, window.height-90, 1, 1, 0.08, 0, 0) --💬💾
				Timer.after(6, function()
					table.insert(choises,choise("so where yours?",window.width*0.65,window.height*0.55,"1.1.1.1"))
					Timer.after(2, function() if route == "1.1.1a" then
						table.insert(choises,choise("moustaches are better",window.width*0.65,window.height*0.6,"1.1.1.2")) end
					end)
				end)
			elseif route == "1.1.1.1" then --"so where yours?"
				route = "1.1.1.1a"
				choises = {}
				---NECO GET DOMINATED
			elseif route == "1.1.1.2" then --"moustaches are better"
				route = "1.1.1.2a"
				choises = {}
				text_anim:load("Beard is better!",50, window.height-90, 1, 1, 0.08, 0, 0) --💬💾
				---NECO GET ANGRY
				Timer.after(2, function()
					table.insert(choises,choise("you are right",window.width*0.65,window.height*0.55,"1.1.1.2.1"))
					Timer.after(1, function() if route == "1.1.1.2a" then
						table.insert(choises,choise("Men have Moustaches!",window.width*0.65,window.height*0.6,"1.1.1.2.2")) end
					end)
				end)
			elseif route == "1.1.1.2.1" then --"you are right"
				route = "1.1.1.2.1a"
				choises = {}
				---FRIENDSHIP UP
			elseif route == "1.1.1.2.2" then --"Men have Moustaches!"
				route = "1.1.1.2.2a"
				choises = {}
				---NECO GET SUPER SAYAN
				--- SHOW NECO CHAD WITH BEARD
			elseif route == "1.1.2" then --"It's an old photo"
				route = "1.1.2a"
				choises = {}
				text_anim:load("You look handsome now",50, window.height-90, 1, 1, 0.08, 0, 0) --💬💾
			elseif route == "1.1.3" then --"Shut up and get in the van"
				route = "1.1.3a"
				choises = {}
				--get in the van game
				---SUCCES "1.1.3.1"
				---Fail  "1.1.3.2"
			elseif route == "1.1.3.1" then
				route = "1.1.3.1a"
				choises = {}
				---{You sold this neco arc in the black market for 50 N-coin}
				--{Gonna catch'em all ending}
			elseif route == "1.1.3.2" then
				route = "1.1.3.2a"
				choises = {}
				---NECO CALL THE POLICE
				--- RUN AWAY
			elseif route == "1.2" then --"No"
				route = "1.2a"
				choises = {}
				text_anim:load("Oh,    my mistake",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				Timer.after(2, function()
					love.event.quit()
				end)
			elseif route == "1.3" then --"Actually I'm SummyUwU420"
				route = "1.3a"
				choises = {}
				text_anim:load("What a shame      \n it's been an hour since I come here and my online friend didn't come yet.",50, window.height-90, 1, 1, 0.05, 0, 0) --💬💾
				Timer.after(8, function()
					text_anim:load("Would you like to sit here? You can order anything",50, window.height-90, 1, 1, 0.075, 0, 0) --💬💾
					Timer.after(5, function()
						table.insert(choises,choise("Pancake",window.width*0.65,window.height*0.55,"1.3.1"))
						Timer.after(0.4, function() if route == "1.3a" then
							table.insert(choises,choise("Pilk",window.width*0.65,window.height*0.6,"1.3.2")) end
							Timer.after(0.4, function() if route == "1.3a" then
								table.insert(choises,choise("Happy Meal",window.width*0.65,window.height*0.65,"1.3.3")) end
							end)
						end)
					end)
				end)
			elseif route == "1.3.1" then --"Pancake"
				route = "1.3.1a"
				choises = {}
			elseif route == "1.3.2" then --"Pilk"
				route = "1.3.2a"
				choises = {}
				text_anim:load([[You have good taste! That's my favourite drink of all time.   
					It remember me that time I went to McDonald...
					]],50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				Timer.after(2, function() if route == "1.3.2a" then
					table.insert(choises,choise("Drink",window.width*0.65,window.height*0.6,"1.3.2.1")) end
				end)
			elseif route == "1.3.2.1" then --"Drink"
				route = "1.3.2.1a"
				choises = {}
				---FRIENDSHIP UP
			elseif route == "1.3.3" then --"Happy Meal"
				route = "1.3.3a"
				choises = {}
				text_anim:load("I'm  sorry mate, they don't have Happy Meal here",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				Timer.after(4, function() if route == "1.3.3a" then
					table.insert(choises,choise("HAPPY MEAL",window.width*0.65,window.height*0.6,"1.3.3.1")) end
				end)
			elseif route == "1.3.3.1" then --"HAPPY MEAL"
				route = "1.3.3.1a"
				choises = {}
				text_anim:load("Please chill out",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				---{Neco change expression in preoccupated}
				Timer.after(2, function() if route == "1.3.3.1a" then
					inRed = true
					table.insert(choises,choise("HAPPY MEAL",window.width*0.65,window.height*0.6,"1.3.3.1.1")) end
				end)
			elseif route == "1.3.3.1.1" then --"HAPPY MEAL"
				route = "1.3.3.1.1a"
				choises = {}
				text_anim:load("Ok fine we are going to McDonald",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				inRed = false
				Timer.after(4, function()
					Transition.bool = true 
				---{Neco change in scared}
				---{You get a menanging T-Pose}
				end)
			end
		elseif location == "McDonald" then
			if route == "1.3.3.1.1a" then
				route = "1.3.3.1.1b"
				Timer.after(1, function()
					text_anim:load("Thanks for bringing me here, I love this place",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
					Timer.after(2, function() if route == "1.3.3.1.1b" then
						table.insert(choises,choise("watch your toy",window.width*0.65,window.height*0.55,"1.3.3.1.1.1")) end
						Timer.after(3, function()
							text_anim:load("wait me here",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
							---{Neco go to the toilet"
							Timer.after(1, function()
								table.insert(choises,choise("change your toy with Neco's one",window.width*0.65,window.height*0.6,"1.3.3.1.1.2"))
								Timer.after(14, function()
									--{Neco get back screaming:}
									text_anim:load("Let's see the McToys",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
										Timer.after(2.5, function()
										if youChanged then
											route = "1.3.3.1.1.2.1"
										else
											route = "1.3.3.1.1.2.2"
										end
									end)
								end)
							end)
						end)
					end)
				end)
			elseif route == "1.3.3.1.1.1" then --"watch your toy"
				route = "1.3.3.1.1.1a"
				---{It's a girl toy from my little jackass}
			elseif route == "1.3.3.1.1.2" then --"change your toy with Neco's one"
				route = "1.3.3.1.1.2a"
				youChanged = not youChanged
				--{You can do it multiple times to get back your toy}
			elseif route == "1.3.3.1.1.2.1" then --if youChanged
				route = "1.3.3.1.1.2.1a"
				choises = {}
				text_anim:load("WoW.  That Rainbow Cum the Last JackAss I was searching for my collection!1!¹!",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
					--"You got a Pichumon from Fortnite"
			elseif route == "1.3.3.1.1.2.2" then --if not youChanged
				route = "1.3.3.1.1.2.2a"
				choises = {}
				text_anim:load("What's this? A rat?",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
					--"{You got a Rainbow Cum from My Little Jackass, I think if you find in the right place during a right event a person that know nothing about McDonald's toys it can worth in the black market 4 N-coin}
				Timer.after(14, function()
					text_anim:load("OMG it's that Rainbow Cum JackAss?!?1? Holy crap, I will give you 10- no 100 N-coin for it!",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
					Timer.after(4, function()
						table.insert(choises,choise("you can have it",window.width*0.65,window.height*0.55,"1.3.3.1.1.2.2.1"))
						Timer.after(0.5, function() if route == "1.3.3.1.1.2.2a" then
							table.insert(choises,choise("that's a deal!",window.width*0.65,window.height*0.6,"1.3.3.1.1.2.2.2")) end
							Timer.after(0.5, function() if route == "1.3.3.1.1.2.2a" then
								table.insert(choises,choise("you can give me more then this",window.width*0.65,window.height*0.6,"1.3.3.1.1.2.2.3")) end
							end)
						end)
					end)
				end)
			elseif route == "1.3.3.1.1.2.2.1" then --you can have it
				route = "1.3.3.1.1.2.2.1a"
				choises = {}
				--FRIENDSHIP UP UP UP
			elseif route == "1.3.3.1.1.2.2.2" then --that's a deal!
				route = "1.3.3.1.1.2.2.2a"
				choises = {}
				--MONEY
			elseif route == "1.3.3.1.1.2.2.3" then --you can give me more then this
				route = "1.3.3.1.1.2.2.3a"
				choises = {}
				text_anim:load("Wa- what do you want from me?",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				Timer.after(3, function() if not noMoney then
					table.insert(choises,choise("Money",window.width*0.65,window.height*0.55,"1.3.3.1.1.2.2.3.1")) end
					Timer.after(0.1, function() if route == "1.3.3.1.1.2.2.3a" then
						table.insert(choises,choise("Sex",window.width*0.65,window.height*0.6,"1.3.3.1.1.2.2.3.2")) end
					end)
				end)
			elseif route == "1.3.3.1.1.2.2.3.1" then --"Money"
				route = "1.3.3.1.1.2.2.3.1a"
				choises = {}
				---SET A PRICE
				price = 101
				--confirm
				if price <= 200 then
					route = "1.3.3.1.1.2.2.3.1.1"
				else
					route = "1.3.3.1.1.2.2.3.1.2"
				end
			elseif route == "1.3.3.1.1.2.2.3.1.1" then --If ok
				route = "1.3.3.1.1.2.2.3.1.1a"
				--{Temmie shop face here}
				text_anim:load("mh-mmmm Neco really want that toy",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				Timer.after(3, function()
					text_anim:load("fine, I accept",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				end)
				--{You get <money> N-coin and may the toy}
			elseif route == "1.3.3.1.1.2.2.3.1.2" then --if too high
				route = "1.3.3.1.1.2.2.3.1.2a"
				--{-3 friendship}
				text_anim:load("WHAT? I can't handle this price! There is a chance you give me that toy?",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				Timer.after(3, function()
					route = "1.3.3.1.1.2.2.3"
					noMoney = true
				end)
			elseif route == "1.3.3.1.1.2.2.3.2" then --"Sex"
				route = "1.3.3.1.1.2.2.3.2a"
				choises = {}
				text_anim:load("Yare Yare... If that's what you want...",50, window.height-90, 1, 1, 0.1, 0, 0) --💬💾
				--{Inser bait meme with ending}
				--{Show statistics}
			end
		end

		if Transition.bool and not Transition.bool2 then
			Transition.alpha = Transition.alpha+1*dt
			if Transition.alpha >= 1 then
				Transition.bool2 = true
				Transition.bool = false
				location = "McDonald"
				scale = window.width/McDonald:getWidth()
				youChanged = false
			end
		elseif Transition.bool2 and not Transition.bool then
			Transition.alpha = Transition.alpha-1*dt
			if Transition.alpha <= 1 then
				Transition.bool = false
				Transition.bool2 = false
			end
		end
	elseif app == "Bread" then
		bread.x = window.x
		bread.y = window.y
		--Write
		love.filesystem.write("BreadX.txt", bread.x)
		love.filesystem.write("BreadY.txt", bread.y)
		--Read
		if love.filesystem.getInfo("BreadEaten.txt") then
			if love.filesystem.read("BreadEaten.txt") == "1" then
				love.event.quit()
				love.filesystem.write("BreadEaten.txt", 0)
			end
		end
	end
end

function love.draw() --✏️
	if app == "Pet" then
		love.graphics.draw(quad, NecoImg, Neco.x, Neco.y, Neco.r, Neco.scale, Neco.scale)

	elseif app == "Fight" then
		Fight.draw() --✏️

	elseif app == "Stats" then
		--hp
		love.graphics.rectangle("line", Bars.hp.x, Bars.hp.y, Bars.hp.width, Bars.hp.height)
		--xp
		love.graphics.rectangle("line", Bars.xp.x, Bars.xp.y, Bars.xp.width, Bars.xp.height)
		--hunger
		love.graphics.rectangle("line", Bars.hunger.x, Bars.hunger.y, Bars.hunger.width, Bars.hunger.height)

		if Neco.hp and Neco.maxHp and Neco.xp and Neco.maxXp and Neco.hunger and Neco.full and Neco.lv then
			--hp
			love.graphics.rectangle("fill", Bars.hp.x, Bars.hp.y, Bars.hp.width*(Neco.hp/Neco.maxHp), Bars.hp.height)
			--xp
			love.graphics.rectangle("fill", Bars.xp.x, Bars.xp.y, Bars.xp.width*(Neco.xp/Neco.maxXp), Bars.xp.height)
			--hunger
			love.graphics.rectangle("fill", Bars.hunger.x, Bars.hunger.y, Bars.hunger.width*(Neco.hunger/Neco.full), Bars.hunger.height)

			--hp
			if Bars.hp.text.height then
				love.graphics.setColor(love.math.colorFromBytes(150/(Neco.hp/Neco.maxHp),155*(3*Neco.hp/Neco.maxHp),5)) --🎨
				love.graphics.print("HP: "..Neco.hp.."/"..Neco.maxHp.."", Bars.hp.x+Bars.hp.width/2-Bars.hp.text.width/2, Bars.hp.y+Bars.hp.height/2-Bars.hp.text.height/2)
			end
			--xp
			if Bars.xp.text.height then
				love.graphics.setColor(1,0.5+Neco.xp/200,0.5+Neco.xp/200) --🎨
				love.graphics.print("LEVEL: "..Neco.lv, Bars.xp.x+Bars.xp.width/2-Bars.xp.text.width/2, Bars.xp.y+Bars.xp.height/2-Bars.xp.text.height/2)
			end
			--hunger
			if Bars.hunger.text.color.b then
				love.graphics.setColor(Bars.hunger.text.color.r,Bars.hunger.text.color.g,Bars.hunger.text.color.b) --🎨
				love.graphics.print(Bars.hunger.text.text, Bars.hunger.x+Bars.hunger.width/2-Bars.hunger.text.width/2, Bars.hunger.y+Bars.hunger.height/2-Bars.hunger.text.height/2)
			end
		end
		love.graphics.setColor(1,1,1)

	elseif app == "Platform" then
		Platform.draw() --✏️

	elseif app == "Platform2" then
		Platform2.draw() --✏️

	elseif app == "Date" then
		--Transition
		if Transition.alpha > 0 then
			love.graphics.setColor(0,0,0,Transition.alpha)
			love.graphics.rectangle("fill", 0,0, window.width, window.height)
			love.graphics.setColor(1,1,1,1)
		end
		--location
		if location == "Cafe" then
			--location
			love.graphics.setFont(font.verdana)
			love.graphics.draw(Cafe,0,0,0,scale,scale)
			love.graphics.draw(Neco.img, Neco.x, Neco.y, 0, Neco.scale, Neco.scale)
			love.graphics.draw(Table,0,0,0,scale,scale)
			--font and text
			text_anim:draw() --💬✏️
			for c, choise in ipairs(choises) do
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("fill", choise.x, choise.y, choise.width, choise.height)
				love.graphics.setColor(1,1,1)
				love.graphics.rectangle("line", choise.x, choise.y, choise.width, choise.height, 5)
				if inRed then
					love.graphics.setColor(0.95,0,0)
				elseif choise.bool then
					love.graphics.setColor(0,0.5,1)
				else
					love.graphics.setColor(1,1,0)
				end
				love.graphics.print(choise.text, choise.x, choise.y)
			end
		elseif location == "McDonald" then
			--location
			love.graphics.setFont(font.verdana)
			love.graphics.draw(McDonald,0,0-90,0,scale,scale)
			love.graphics.draw(Neco.img, Neco.x, Neco.y, 0, Neco.scale, Neco.scale)
			love.graphics.draw(McDonaldTable,0,0-90,0,scale,scale)
			--font and text
			text_anim:draw() --💬✏️
			for c, choise in ipairs(choises) do
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("fill", choise.x, choise.y, choise.width, choise.height)
				love.graphics.setColor(1,1,1)
				love.graphics.rectangle("line", choise.x, choise.y, choise.width, choise.height, 5)
				if inRed then
					love.graphics.setColor(0.95,0,0)
				elseif choise.bool then
					love.graphics.setColor(0,0.5,1)
				else
					love.graphics.setColor(1,1,0)
				end
				love.graphics.print(choise.text, choise.x, choise.y)
			end
		end

		if ADMIN then
			love.graphics.setColor(1,1,1)
			love.graphics.print(route, 125, 10, 0, 1.5, 1.5)
		end
	elseif app == "Bread" then
		love.graphics.draw(breadImg,0,0,0,bread.scale,bread.scale)
	end
	if ADMIN then
		love.graphics.setColor(1,1,1)
		love.graphics.print(app, 10, 10, 0, 1.5, 1.5)
	end
end

function love.keypressed(key, scancode, isRepeat) --⌨️
	Konami.keypressed(key)

	if app == "Fight" then
		Fight.keypressed(key, scancode, isRepeat) --⌨️

	elseif app == "Platform" then
		Platform.keypressed(key, scancode, isRepeat) --⌨️

	elseif app == "Platform2" then
		Platform2.keypressed(key, scancode, isRepeat) --⌨️
	end

	if key == "escape" then
		love.event.quit()
	end

	if key == "tab" then
		ADMIN = not ADMIN
	end
end

function love.keyreleased(key) --⌨️
	if app == "Fight" then
		Fight.keyreleased(key) --⌨️

	elseif app == "Platform" then
		Platform.keyreleased(key) --⌨️

	end
end

function love.mousepressed(x, y, button) --🖱️
	if app == "Date" then
		for c, choise in ipairs(choises) do
			if choise.bool then
				route = choise.route
			end
		end
	end
end

function love.mousereleased(x, y, button) --🖱️
end

function love.mousemoved(x, y, dx, dy) --🖱️
end

function love.wheelmoved(dx, dy) --🖱️
end

function love.textinput(text) --⌨️📄
end
Platform2 = {}
local data = {neco={x,y}}

function Platform2.load() --💾
	love.window.setTitle("Platform2") --🖼️
	love.window.setIcon(love.image.newImageData("assets/icon3.png"))
	love.window.setMode(400, 300)
	window.width,window.height = love.window.getMode()
	love.window.setPosition(0, screen.height/2-window.height/2) --🖼️
	love.window.requestAttention(true)
	text_anim:load("    click here",0, 0, 1, 1, 0.3, 0, 0) --💬💾
	--world and terrain
	world = wf.newWorld(0,700,true)
	world:addCollisionClass('Wall')
    world:addCollisionClass('Neco')

	--Neco
	Neco_is_on_window = false
	Neco = {
		x=0,y=0,
		X=0,Y=0,
		width=128-10, height=128,
		r=0, scale=1,
		status="spleeping", direction="right",
		speed=5000,
	}

	local Random = {
		x = love.math.random(0,window.width),
		y = love.math.random(window.height/2,window.height)
	} 
	--wall
	Wall = {
		collider,
		x=Random.x,y=Random.y,
		width=window.width-Random.x,height=window.height-Random.y
	}
	Wall.collider = world:newRectangleCollider(Wall.x, Wall.y, Wall.width, Wall.height)
	Wall.collider:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
	Wall.collider:setCollisionClass('Wall')

	--imgs
	quad = love.graphics.newImage("assets/quad.png")
	quad2 = love.graphics.newImage("assets/quad2.png")
		--loading
	loading = {grid,animation,frames="12",duration=0.6}
	loading.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 0, 1664)
    loading.animation = anim8.newAnimation(loading.grid('1-'..loading.frames..'',1), 0.10)
    	--standing
    NecoStandingImg = love.graphics.newQuad(0, 0, 128, 128, quad)
    NecoStandingLImg = love.graphics.newQuad(1408, 512, 128, 128, quad2)
    	--sleeping
    sleeping = {grid,animation,frames="6",duration=0.6}
    sleeping.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 640, 128)
    sleeping.animation = anim8.newAnimation(sleeping.grid('1-'..sleeping.frames..'',1), 0.65)
    	--waking
    waking = {grid,animation,frames="3",duration=0.6}
    waking.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 256, 128)
    waking.animation = anim8.newAnimation(waking.grid('1-'..waking.frames..'',1), 0.5, 'pauseAtEnd')
    	--goingSleep
    goingSleep = {grid,animation,frames="3",duration=0.6}
    goingSleep.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 0, 128)
    goingSleep.animation = anim8.newAnimation(goingSleep.grid('1-'..goingSleep.frames..'',1), goingSleep.duration)
    	--walking
    walking = {grid,animation,frames="8",duration=0.25}
    walking.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 128, 0)
    walking.animation = anim8.newAnimation(walking.grid('1-'..walking.frames..'',1), walking.duration)
    walking.animationL = walking.animation:clone():flipH()
end

function Platform2.update(dt) --🔁
	focus = love.window.hasMouseFocus()

	--Wall
	Wall.X = window.x+Wall.x
	Wall.Y = window.y+Wall.y
	sleeping.animation:update(dt) --🔁
	waking.animation:update(dt) --🔁
	goingSleep.animation:update(dt) --🔁
	walking.animation:update(dt) --🔁
	walking.animationL:update(dt) --🔁

	--Write
	love.filesystem.write("WallX.txt", Wall.X)
	love.filesystem.write("WallY.txt", Wall.Y)
	love.filesystem.write("WallWidth.txt", Wall.width)
	love.filesystem.write("WallHeight.txt", Wall.height)
	--Read
	if love.filesystem.getInfo("NecoX.txt") and ((love.filesystem.read("NecoX.txt"))) ~= nil and Neco.x and window.x then
		data.neco.x = ((love.filesystem.read("NecoX.txt")))
		if type(data.neco.x) == "number" then
			Neco.x = data.neco.x - window.x
		elseif type(data.neco.x) == "string" then
			Neco.x = tonumber(data.neco.x) - window.x
		end
	end
	if love.filesystem.getInfo("NecoY.txt") and ((love.filesystem.read("NecoY.txt"))) ~= nil and Neco.y and window.y then
		data.neco.y = ((love.filesystem.read("NecoY.txt")))
		if type(data.neco.y) == "number" then
			Neco.y = data.neco.y - window.y
		elseif type(data.neco.y) == "string" then
			Neco.y = tonumber(data.neco.y) - window.y
		end
	end
end

function Platform2.draw() --✏️
	if Neco.status == "standing" then
		if Neco.direction == "right" then
			love.graphics.draw(quad, NecoStandingImg, Neco.x, Neco.y)
		elseif Neco.direction == "left" then
			love.graphics.draw(quad2, NecoStandingLImg, Neco.x, Neco.y)
		end
	elseif Neco.status == "spleeping" then
		sleeping.animation:draw(quad, Neco.x, Neco.y)
	elseif Neco.status == "waking" then
		waking.animation:draw(quad, Neco.x, Neco.y)
	elseif Neco.status == "goingSleep" then
		goingSleep.animation:draw(quad, Neco.x, Neco.y)
	elseif Neco.status == "walking" then
		if Neco.direction == "right" then
			walking.animation:draw(quad2, Neco.x, Neco.y)
		elseif Neco.direction == "left" then
			walking.animationL:draw(quad2, Neco.x, Neco.y)
		end
	end

	if ADMIN then
		world:draw()
		if focus then
			love.graphics.print("FOCUS", 100,100)
		end
	end
end

function Platform2.keypressed(key, scancode, isRepeat) --⌨️
	if key == "escape" then --exit
		love.event.quit()
	end
end

--function Platform2.keyreleased(key) --⌨️
--end
--
--function Platform2.mousepressed(x, y, button) --🖱️
--end
--
--function Platform2.mousereleased(x, y, button) --🖱️
--end
--
--function Platform2.mousemoved(x, y, dx, dy) --🖱️
--end
--
--function Platform2.wheelmoved(dx, dy) --🖱️
--end
--
--function Platform2.textinput(text) --⌨️📄
--end
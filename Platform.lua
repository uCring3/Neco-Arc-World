Platform = {}
local data = {wall={x,t,width,height}}
local controller = {}

function Platform.load() --💾
	love.window.setTitle("Platform") --🖼️
	love.window.setIcon(love.image.newImageData("assets/icon3.png"))
	love.window.setMode(800, 600)
	window.width,window.height = love.window.getMode()
	love.window.setPosition(screen.width-window.width, screen.height/2-window.height/2) --🖼️
	love.window.requestAttention(true)
	text_anim:load("    click here",0, 0, 1, 1, 0.3, 0, 0) --💬💾

	--world and terrain
	world = wf.newWorld(0,700,true)
	world:addCollisionClass('Ground')
	world:addCollisionClass('Wall')
    world:addCollisionClass('Neco')
	Terrain = {x=0,y=window.height*0.7,width=window.width,height=window.height*0.3}

	--Neco
	Neco = {
		x,y,
		X,Y,
		width=128-10, height=128,
		r=0, scale=1,
		status="spleeping", direction="right",
		speed=5000,
		--ll={ider, x,y, width=70,height=110, vx,vy},
	}
	--Necollider
	Necoll = {
		x=(Terrain.x+Terrain.width/2)+25,
		y=(Terrain.y-Neco.height)+10,
		width=70,
		height=110
	}
	Necoll.ider = world:newBSGRectangleCollider(Necoll.x, Necoll.y, Necoll.width, Necoll.height, 10)
	Necoll.ider:setCollisionClass('Neco')
	Necoll.ider:setFixedRotation(true)
	Necoll.ider.is_on_ground = false

	--ground
	Walls = {}

	Walls[1] = {
		collider,
		x=0,y=Necoll.y+Necoll.height,
		width=window.width,height=window.height
	}
	Walls[1].collider = world:newRectangleCollider(Walls[1].x, Walls[1].y, Walls[1].width, Walls[1].height)
	Walls[1].collider:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
	Walls[1].collider:setCollisionClass('Ground')

	Walls[2] = {
		collider,
		x=0,y=0,
		width=0,height=0
	}
	-- from the one way platformer example of windfield
    -- in this case, if is touching a platform, then is on the ground
    -- This only works if there is in first place a collision 
    --local function custom_collision(collider_1, collider_2, contact)        
    --    if collider_1.collision_class == 'Neco' and collider_2.collision_class == 'Ground' then
    --          Necoll.ider.is_on_ground = true
    --    end
    --end
    
    --Necoll.ider:setPreSolve(custom_collision)

	--imgs
	quad = love.graphics.newImage("assets/quad.png")
	quad2 = love.graphics.newImage("assets/quad2.png")
	controller = {img=love.graphics.newImage("assets/controller.png"),x,y,width,height,scale=0.5}
	controller.width = controller.img:getWidth()*controller.scale
	controller.height = controller.img:getHeight()*controller.scale
	controller.x = window.width/2 -controller.width/2
	controller.y = window.height*0.1
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

	--first Coord
	Necoll.ider.vx, Necoll.ider.vy = Necoll.ider:getLinearVelocity()
	Neco.x = Necoll.ider:getX()-(Neco.width/2)
	Neco.y = Necoll.ider:getY()-(Neco.height/2)
	Neco.X = Neco.x+window.x
	Neco.Y = Neco.y+window.y

	if Neco.status == "waked" or Neco.status == "walking" or Neco.status == "standing" then
		if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
			Neco.status = "walking"
			Necoll.ider:setLinearVelocity(300,Necoll.ider.vy)
		elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then
			Neco.status = "walking"
			Necoll.ider:setLinearVelocity(-300,Necoll.ider.vy)
		else
			Neco.status = "standing"
		end
	end
end

function Platform.update(dt) --🔁
	text_anim:update(dt) --💬🔁
	focus = love.window.hasMouseFocus()
	keyfocus = love.window.hasFocus()
	if keyfocus then
		text_anim:load("    click here",controller.x, controller.y+controller.height, 1, 1, 0.3, 0, 0) --💬
	end
		world:update(dt)
		Necoll.ider.vx, Necoll.ider.vy = Necoll.ider:getLinearVelocity()
		Neco.x = Necoll.ider:getX()-(Neco.width/2)
		Neco.y = Necoll.ider:getY()-(Neco.height/2)
		Neco.X = Neco.x+window.x
		Neco.Y = Neco.y+window.y
		for w,wall in ipairs(Walls) do
			if wall.x and wall.y and wall.width then
				if check_aabb(Neco.x+25, Neco.y+Neco.height-5, Neco.width-50, 1, wall.x, wall.y, wall.width, 10) then
					Necoll.ider.is_on_ground = true
				end
			end
		end
	
		if Neco.status == "waked" or Neco.status == "walking" or Neco.status == "standing" then
			if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
				Neco.status = "walking"
				Necoll.ider:setLinearVelocity(300,Necoll.ider.vy)
			elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then
				Neco.status = "walking"
				Necoll.ider:setLinearVelocity(-300,Necoll.ider.vy)
			else
				Neco.status = "standing"
			end
		end
	sleeping.animation:update(dt) --🔁
	waking.animation:update(dt) --🔁
	goingSleep.animation:update(dt) --🔁
	walking.animation:update(dt) --🔁
	walking.animationL:update(dt) --🔁

	--Write
	love.filesystem.write("NecoX.txt", Neco.X)
	love.filesystem.write("NecoY.txt", Neco.Y)
	--Read
	if love.filesystem.getInfo("WallX.txt") then
		if love.filesystem.read("WallX.txt") ~= nil and Walls[2].x and window.x then
			data.wall.x = ((love.filesystem.read("WallX.txt")))
			if type(data.wall.x) == "number" then
				Walls[2].x = data.wall.x - window.x
			elseif type(data.wall.x) == "string" then
				Walls[2].x = tonumber(data.wall.x) - window.x
			end
		end
	end
	if love.filesystem.getInfo("WallY.txt") then
		if love.filesystem.read("WallY.txt") ~= nil and Walls[2].y and window.y ~= nil then
			data.wall.y = ((love.filesystem.read("WallY.txt")))
			if type(data.wall.y) == "number" then
				Walls[2].y = data.wall.y - window.y
			elseif type(data.wall.y) == "string" then
				Walls[2].y = tonumber(data.wall.y) - window.y
			end
		end
	end
	if love.filesystem.getInfo("WallWidth.txt") then
		if love.filesystem.read("WallWidth.txt") ~= nil and Walls[2].width then
			data.wall.width = ((love.filesystem.read("WallWidth.txt")))
			if type(data.wall.width) == "number" then
				Walls[2].width = data.wall.width
			elseif type(data.wall.width) == "string" then
				Walls[2].width = tonumber(data.wall.width)
			end
		end
	end
	if love.filesystem.getInfo("WallHeight.txt") then
		if love.filesystem.read("WallHeight.txt") ~= nil and Walls[2].height then
			data.wall.height = ((love.filesystem.read("WallHeight.txt")))
			if type(data.wall.height) == "number" then
				Walls[2].height = data.wall.height
			elseif type(data.wall.height) == "string" then
				Walls[2].height = tonumber(data.wall.height)
			end
		end
	end

	if Walls[2].x and Walls[2].y and Walls[2].width and Walls[2].height and Walls[2].collider == nil then
		Walls[2].collider = world:newRectangleCollider(Walls[2].x, Walls[2].y, Walls[2].width, Walls[2].height)
		Walls[2].collider:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
		Walls[2].collider:setCollisionClass('Wall')
	end

	if Walls[2].collider and Walls[2].x and Walls[2].y and Walls[2].width and Walls[2].height then
		Walls[2].collider:setX(Walls[2].x)
		Walls[2].collider:setY(Walls[2].y)
		--Walls[2].collider:setW(Walls[2].width)  SET WIDTH AND HEIGHT
		--Walls[2].collider:setH(Walls[2].height)
	end
end

function Platform.draw() --✏️
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

	if not keyfocus then
		love.graphics.print("TURN ON THE CONTROLLER", controller.x-35, controller.y-15)
		love.graphics.draw(controller.img, controller.x, controller.y, 0, controller.scale, controller.scale)
		text_anim:draw() --💬✏️
	end

	if ADMIN then
		world:draw()
		if focus then
			love.graphics.print("FOCUS", 100,100)
		end
		if keyfocus then
			love.graphics.print("KEYFOCUS", 100,120)
		end
		love.graphics.setColor(0,1,0)
		love.graphics.rectangle("line", Neco.x+25, Neco.y+Neco.height-5, Neco.width-50, 1)
		for w,wall in ipairs(Walls) do
			if wall.x and wall.width then
				love.graphics.rectangle("line", wall.x, wall.y, wall.width, 10)
			end
		end
		if Necoll.ider.is_on_ground then
			love.graphics.print("Neco is_on_ground", 150,20)
		else
			love.graphics.print("Neco is_(not)_on_ground", 150,20)
		end
		love.graphics.circle("fill", Necoll.ider:getX(), Necoll.ider:getY()+Necoll.height/2, 5)
	end	
end

function Platform.keypressed(key, scancode, isRepeat) --⌨️
	if key == "escape" then --exit
		love.event.quit()
	end
	if key == "w" and Neco.status == "spleeping" then --wake
		waking.animation:gotoFrame(1)
		waking.animation:resume()
		Neco.status = "waking"
		Timer.after((waking.frames*waking.duration), function() --⏱️
			Neco.status = "waked"
		end)
	elseif key == "s" and Neco.status ~= "spleeping" then --sleep
		Neco.status = "goingSleep"
		goingSleep.animation:gotoFrame(1)
		goingSleep.animation:resume()
		Timer.after((goingSleep.frames*goingSleep.duration), function() --⏱️
			Neco.status = "spleeping"
		end)
	elseif key == "d" then
		Walls[2].collider:destroy()
		Walls[2].collider = nil
	end
	--change direction
	if key == "right" or key == "d" then
		Neco.direction = "right"
	elseif key == "left" or key == "a" then
		Neco.direction = "left"
	end
	if Neco.status == "waked" or Neco.status == "walking" or Neco.status == "standing" then
		if (key == "up" or key =="w") and Necoll.ider.is_on_ground then --jump
			Necoll.ider:applyLinearImpulse(0, -5500)
			Necoll.ider.is_on_ground = false
		end
	end
end

function Platform.keyreleased(key) --⌨️
	if key == 'right' or key == 'left' or key == 'a' or key == 'd' then
        Necoll.ider.vx, Necoll.ider.vy = Necoll.ider:getLinearVelocity()
        Necoll.ider:setLinearVelocity(0,Necoll.ider.vy)
    end
end

--function Platform.mousepressed(x, y, button) --🖱️
--	--text_anim:load("click here",10, 10, 1, 1, 0.2, 0, 0) --💬
--end
--
--function Platform.mousereleased(x, y, button) --🖱️
--end
--
--function Platform.mousemoved(x, y, dx, dy) --🖱️
--end
--
--function Platform.wheelmoved(dx, dy) --🖱️
--end
--
--function Platform.textinput(text) --⌨️📄
--end
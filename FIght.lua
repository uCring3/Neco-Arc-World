Fight = {}

function Fight.load() --💾
	Neco = Class{
		init = function(self,img,x,y,width,height,speed,speedATK,rangeATK,attackStyle,ATK,MaxHP,player,dead,extra)
			self.img = img
			self.x = x
			self.y = y
			self.width = width
			self.height = height
			self.speed = speed
			self.speedATK = speedATK
			self.countDown = speedATK
			self.rangeATK = rangeATK
			self.attackStyle = attackStyle
			self.ATK = ATK
			self.MaxHP = MaxHP
			self.HP = MaxHP
			self.player = player
			self.alert = false
			self.dead = dead
			self.extra = extra
			self.status = "walking"
			--Necollider
			self.llider = world:newBSGRectangleCollider(x, y, width, height, 5)
			self.llider:setCollisionClass('Neco'..player)
			self.llider:setFixedRotation(true)
			self.llider:setPreSolve(function(collider_1, collider_2, contact)
				if (collider_1.collision_class == 'Neco1' or collider_1.collision_class == 'Neco2') and (collider_2.collision_class == 'Neco1' or collider_2.collision_class == 'Neco2') then
					contact:setEnabled(false)
				end
			end)
		end,
	}
	Necos1 = {}
	Necos2 = {}

	function summon(player, necotype)
		if necotype == "Neco" then
			if player == 1 then	--(self,img,x,y,width,height,speed,speedATK,rangeATK,attackStyle,ATK,MaxHP,player,dead,extra)
				table.insert(Necos1, Neco("anim",530,200,96,159,30,3,10,"single",10,30,1,false,"none"))
			elseif player == 2 then
				table.insert(Necos2, Neco("anim",30,200,96,159,30,3,10,"single",10,30,2,false,"none"))
			end
		elseif necotype == "Megumin" then
			if player == 1 then	--(self,img,x,y,width,height,speed,speedATK,rangeATK,attackStyle,ATK,MaxHP,player,dead,extra)
				table.insert(Necos1, Neco(NecoMegumin,530,200,96,159,30,10,230,"multiple",100,30,1,false,"oneshot"))
			elseif player == 2 then
				table.insert(Necos2, Neco(NecoMegumin,30,200,96,159,30,10,230,"multiple",100,30,2,false,"oneshot"))
			end
		end
	end
	love.window.setTitle("Fight") --🖼️
	love.window.setIcon(love.image.newImageData("assets/icon2.png"))
	love.window.setMode(1000, 600)
	window.width,window.height = love.window.getMode() --🖼️
	--world and terrain
	world = wf.newWorld(0,700,true)
	world:addCollisionClass('Ground')
    world:addCollisionClass('Neco1')
    world:addCollisionClass('Neco2')
	--ground
	Ground = {x=0,y=window.height*0.75,width=window.width,height=window.height*0.3}
	Ground.collider = world:newRectangleCollider(Ground.x, Ground.y, Ground.width, Ground.height)
	Ground.collider:setType('static') -- Types can be 'static', 'dynamic' or 'kinematic'. Defaults to 'dynamic'
	Ground.collider:setCollisionClass('Ground')
	--imgs
	quad = love.graphics.newImage("assets/quad.png")
	quad2 = love.graphics.newImage("assets/quad2.png")
	quad3 = love.graphics.newImage("assets/Neco quads/standing&running.png")
	NecoMegumin = love.graphics.newImage("assets/NecoMegumin.png")
		--loading
	loading = {grid,animation,frames="12",duration=0.6}
	loading.grid = anim8.newGrid(128, 128, quad:getWidth(), quad:getHeight(), 0, 1664)
    loading.animation = anim8.newAnimation(loading.grid('1-'..loading.frames..'',1), 0.10)
    	--standingR
    standingR = {grid,animation,frames="9",duration=0.1,x=0,y=0,width=96,height=158}
    standingR.grid = anim8.newGrid(standingR.width, standingR.height, quad3:getWidth(), quad3:getHeight(), standingR.x, standingR.y)
    standingR.animation = anim8.newAnimation(standingR.grid('1-'..standingR.frames..'',1), standingR.duration)
    	--standingL
	standingL = {grid,animation,frames="9",duration=0.1,x=0,y=158,width=96,height=158}
    standingL.grid = anim8.newGrid(standingL.width, standingL.height, quad3:getWidth(), quad3:getHeight(), standingL.x, standingL.y)
    standingL.animation = anim8.newAnimation(standingL.grid('1-'..standingL.frames..'',1), standingL.duration)
    	--walkingR
	walkingR = {grid,animation,frames="7",duration=0.15,x=0,y=316,width=109,height=158}
    walkingR.grid = anim8.newGrid(walkingR.width, walkingR.height, quad3:getWidth(), quad3:getHeight(), walkingR.x, walkingR.y)
    walkingR.animation = anim8.newAnimation(walkingR.grid('1-'..walkingR.frames..'',1), walkingR.duration)
    	--walkingL
	walkingL = {grid,animation,frames="7",duration=0.15,x=0,y=474,width=109,height=158}
    walkingL.grid = anim8.newGrid(walkingL.width, walkingL.height, quad3:getWidth(), quad3:getHeight(), walkingL.x, walkingL.y)
    walkingL.animation = anim8.newAnimation(walkingL.grid('1-'..walkingL.frames..'',1), walkingL.duration)
end

function Fight.update(dt) --🔁
	window.x,window.y = love.window.getPosition() --🖼️
	mouse.x,mouse.y = love.mouse.getPosition() --🖱️
	Timer.update(dt) --🔁
	Konami.update(dt) --🔁
	loading.animation:update(dt) --🔁
	world:update(dt) --🔁

	for n,neco in ipairs(union(Necos1, Necos2)) do
		if not neco.dead then
			neco.llider.vx, neco.llider.vy = neco.llider:getLinearVelocity()
			neco.x = neco.llider:getX()-neco.width/2
			neco.y = neco.llider:getY()-neco.height/2

			neco.alert = false
			if neco.player == 1 then
				for nn, nneco in ipairs(Necos2) do
					if not nneco.dead then
						if check_aabb(neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK, nneco.x, nneco.y, nneco.width, nneco.height) then
							neco.alert = true
							break
						end
					end
				end

				if neco.status == "walking" then
					neco.llider:setLinearVelocity(-neco.speed,neco.llider.vy)

				elseif neco.status == "attack" then
					for nn, nneco in ipairs(Necos2) do 
						if not nneco.dead then
							if check_aabb(neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK, nneco.x, nneco.y, nneco.width, nneco.height) then
								if neco.countDown < 0 then
									if neco.attackStyle == "multiple" then
										for nn, nneco in ipairs(Necos2) do
											if check_aabb(neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK, nneco.x, nneco.y, nneco.width, nneco.height) then
												nneco.HP = nneco.HP - neco.ATK
											end
										end
										if neco.extra == "oneshot" then
											neco.dead = true
										end
									elseif neco.attackStyle == "single" then
										nneco.HP = nneco.HP - neco.ATK
										neco.countDown = neco.speedATK
										break
									end
									neco.countDown = neco.speedATK
								end
								neco.countDown = neco.countDown - dt
							end
						end
					end
				end


			elseif neco.player == 2 then
				for nn, nneco in ipairs(Necos1) do
					if not nneco.dead then
						if check_aabb(neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK, nneco.x, nneco.y, nneco.width, nneco.height) then
							neco.alert = true
							break
						end
					end
				end

				if neco.status == "walking" then
					neco.llider:setLinearVelocity(neco.speed,neco.llider.vy)

				elseif neco.status == "attack" then
					for nn, nneco in ipairs(Necos1) do
						if not nneco.dead then
							if check_aabb(neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK, nneco.x, nneco.y, nneco.width, nneco.height) then
								if neco.countDown < 0 then
									if neco.attackStyle == "multiple" then
										for nn, nneco in ipairs(Necos2) do
											if check_aabb(neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK, nneco.x, nneco.y, nneco.width, nneco.height) then
												nneco.HP = nneco.HP - neco.ATK
											end
										end
									elseif neco.attackStyle == "single" then
										nneco.HP = nneco.HP - neco.ATK
										neco.countDown = neco.speedATK
										break
									end
									neco.countDown = neco.speedATK
								end
								neco.countDown = neco.countDown - dt
							end
						end
					end
				end
			end
			if neco.HP <= 0 then
				neco.llider:destroy()
				neco.dead = true
			end
			if neco.alert then
				neco.status = "attack"
			else
				neco.status = "walking"
			end
		end
	end
	standingR.animation:update(dt) --🔁
	standingL.animation:update(dt) --🔁
	walkingR.animation:update(dt) --🔁
	walkingL.animation:update(dt) --🔁
end

function Fight.draw() --✏️
	for n, neco in ipairs(union(Necos1, Necos2)) do
		if not neco.dead then
			if neco.img == "anim" then
				if neco.player == 1 then
					if neco.status == "standing" or neco.status == "attack" then
						standingL.animation:draw(quad3, neco.x, neco.y)
					elseif neco.status == "walking" then
						walkingL.animation:draw(quad3, neco.x, neco.y)
					end
				elseif neco.player == 2 then
					if neco.status == "standing" or neco.status == "attack" then
						standingR.animation:draw(quad3, neco.x, neco.y)
					elseif neco.status == "walking" then
						walkingR.animation:draw(quad3, neco.x, neco.y)
					end
				end
			else
				love.graphics.draw(neco.img, neco.x, neco.y)
			end
		end
		if ADMIN then
			love.graphics.setColor(.5,.5,0)
			love.graphics.rectangle("line", neco.x-neco.rangeATK/2, neco.y-neco.rangeATK/2, neco.width+neco.rangeATK, neco.height+neco.rangeATK)
			love.graphics.circle("line", neco.x, neco.y, 5)
			love.graphics.setColor(1,1,1)
			love.graphics.printf(neco.player, neco.x, neco.y-45, neco.width, "center")
			love.graphics.printf(neco.countDown, neco.x, neco.y-30, neco.width, "center")
			love.graphics.printf(neco.HP, neco.x, neco.y-15, neco.width, "center")
		end
	end

	world:draw()
end

function Fight.keypressed(key, scancode, isRepeat) --⌨️
	if key == "q" then
		summon(2, "Neco")
	elseif key == "w" then
		summon(2, "Megumin")
	elseif key == "o" then
		summon(1, "Megumin")
	elseif key == "p" then
		summon(1, "Neco")
	end
end

function Fight.keyreleased(key) --⌨️
	if key == 'right' or key == 'left' then
	    Necoll.ider.vx, Necoll.ider.vy = Necoll.ider:getLinearVelocity()
	    Necoll.ider:setLinearVelocity(0,Necoll.ider.vy)
	end
end

--function Fight.mousepressed(x, y, button) --🖱️
--end
--
--function Fight.mousereleased(x, y, button) --🖱️
--end
--
--function Fight.mousemoved(x, y, dx, dy) --🖱️
--end
--
--function Fight.wheelmoved(dx, dy) --🖱️
--end
--
--function Fight.textinput(text) --⌨️📄
--end
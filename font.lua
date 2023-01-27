font = {}

function font:load() --💾
	self.NewRodin = love.graphics.newFont("assets/fonts/FOT-NewRodin Pro DB.otf",25)
	self.TsukuMin = love.graphics.newFont("assets/fonts/FOT-TsukuMin Pro LB.otf",25)
	self.NewRodinBig = love.graphics.newFont("assets/fonts/FOT-NewRodin Pro DB.otf",75)
	self.TsukuMinBig = love.graphics.newFont("assets/fonts/FOT-TsukuMin Pro LB.otf",75)
	self.TsukuMinBigger = love.graphics.newFont("assets/fonts/FOT-TsukuMin Pro LB.otf",175)

	self.verdana = love.graphics.newFont("assets/fonts/verdana.ttf",20)
end
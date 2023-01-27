audio = {music={},sfx={}}

function audio:load() --💾
	audio.music[1] = love.audio.newSource("assets/Neco music/great-cats-village-r-neco-arcs-theme.mp3", "stream")
	audio.music[2] = love.audio.newSource("assets/Neco music/neko-arc.mp3", "stream")

	audio.sfx[1] = love.audio.newSource("assets/Neco sfx/Neco aahiii No.mp3", "static")
	audio.sfx[2] = love.audio.newSource("assets/Neco sfx/Neco agua zero damesca.mp3", "static")
	audio.sfx[3] = love.audio.newSource("assets/Neco sfx/Neco Ataranai a.mp3", "static")
	audio.sfx[4] = love.audio.newSource("assets/Neco sfx/Neco Bacagare!.mp3", "static")
	audio.sfx[5] = love.audio.newSource("assets/Neco sfx/Neco banyi quico faito.mp3", "static")
	audio.sfx[6] = love.audio.newSource("assets/Neco sfx/Neco booooocooooooon.mp3", "static")
	audio.sfx[7] = love.audio.newSource("assets/Neco sfx/Neco Braca sobe sibu.mp3", "static")
	audio.sfx[8] = love.audio.newSource("assets/Neco sfx/Neco bu buuu.mp3", "static")
	audio.sfx[9] = love.audio.newSource("assets/Neco sfx/Neco Bucoros!!!.mp3", "static")
	audio.sfx[10] = love.audio.newSource("assets/Neco sfx/Neco Carano neco caeiru.mp3", "static")
	audio.sfx[11] = love.audio.newSource("assets/Neco sfx/Neco Chaina Chainese.mp3", "static")
	audio.sfx[12] = love.audio.newSource("assets/Neco sfx/Neco cho atas callo.mp3", "static")
	audio.sfx[13] = love.audio.newSource("assets/Neco sfx/Neco come sasis.mp3", "static")
	audio.sfx[14] = love.audio.newSource("assets/Neco sfx/Neco dori dori dori.mp3", "static")
	audio.sfx[15] = love.audio.newSource("assets/Neco sfx/Neco fuero fueru.mp3", "static")
	audio.sfx[16] = love.audio.newSource("assets/Neco sfx/Neco guiningun.mp3", "static")
	audio.sfx[17] = love.audio.newSource("assets/Neco sfx/Neco haiyai na.mp3", "static")
	audio.sfx[18] = love.audio.newSource("assets/Neco sfx/Neco iiiiisAAAAA.mp3", "static")
	audio.sfx[19] = love.audio.newSource("assets/Neco sfx/Neco jooooonoooo oooo.mp3", "static")
	audio.sfx[20] = love.audio.newSource("assets/Neco sfx/Neco Juf.mp3", "static")
	audio.sfx[21] = love.audio.newSource("assets/Neco sfx/Neco la Boando des.mp3", "static")
	audio.sfx[22] = love.audio.newSource("assets/Neco sfx/Neco mhmhmh baca bacai.mp3", "static")
end
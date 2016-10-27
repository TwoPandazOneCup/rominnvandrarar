function love.load(arg)
  dofile "spelar.lua"
  dofile "fiende.lua"
  dofile "funksjonar.lua"
  dofile "definisjonar.lua"
  gameState = "playing"
  enemies_controller:spawnEnemy()
  NY_FIENDE_TIMER = 100
  NY_STOR_FIENDE_TIMER = 100
  NY_ROTERANDE_FIENDE = 100
end




function love.update(dt)
oppdaterOgSpawn(dt)




  if spelar.liv <= 0 then
    gameState = "dead"
  end

--[[
]]

  vindauge = {
    xmin = 0,
    xmax = love.graphics.getWidth(),
    ymax = love.graphics.getHeight(),
    ymin = 0
  }






  if love.keyboard.isDown(skyteKnapp) then
    spelar.fire()end

  if love.keyboard.isDown(hoppKnapp) then
    spelar.y = vindauge.ymax - 20 - spelar.hoppHogd
  else
    spelar.y = vindauge.ymax - 20 end

  if love.keyboard.isDown(vensteKnapp) and spelar.x > vindauge.xmin then
    spelar.x = spelar.x - spelar.fart * dt end

  if love.keyboard.isDown(hogreKnapp) and spelar.x + spelar.width < vindauge.xmax then
    spelar.x = spelar.x + spelar.fart * dt end



  for i,v in pairs(spelar.bullets) do
    if v.y < vindauge.ymin then
      table.remove(spelar.bullets, i) end
    v.y = v.y - spelar.bulletSpeed  end

--spawnar og flytta fiendane
  for i, v in pairs(enemies_controller.enemies) do


    for ii, vv in pairs(spelar.bullets) do
      if CheckCollision(
        v.x, v.y, v.width, v.height,
        vv.x, vv.y, vv.w, vv.h
      ) then
          table.remove(spelar.bullets, ii)
          v.liv = v.liv -1
      end
    end


      if CheckCollision(
        v.x, v.y, v.height, v.height,
        spelar.x, spelar.y, spelar.height, spelar.width
      ) then
        spelar.liv = spelar.liv -1
        table.remove(enemies_controller.enemies, i)
      end



    if v.gaarMotHogre == true then
      v.x = v.x + v.speed *dt
      if v.x >= vindauge.xmax - v.width then
        v.gaarMotHogre = false
        v.y = v.y + v.height + v.mellomrom
      end

    elseif v.gaarMotHogre == false then
      v.x = v.x - v.speed *dt
      if v.x <= vindauge.xmin + v.mellomrom then
        v.gaarMotHogre = true
        v.y = v.y + v.height + v.mellomrom
      end
    else v.y = v.y + v.speed * dt end


  if v.liv == 0 or v.y == 200 then
      table.remove(enemies_controller.enemies, i)
  end
end

  if spelar.cooldown >= 0 then spelar.cooldown = spelar.cooldown -1 end
end


function love.draw()
  if gameState == "playing" then
    love.graphics.setColor(255, 0, 0)
    for i,v in pairs(spelar.bullets) do
      love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
    end


    for i, e in pairs(enemies_controller.enemies) do
      love.graphics.setColor(e.farge)
      love.graphics.rectangle("fill", e.x, e.y, e.width, e.height) end

    love.graphics.setColor(spelar.farge)
    love.graphics.polygon("fill",
        spelar.x,spelar.y,
        spelar.x + spelar.width,spelar.y,
        spelar.x + spelar.width/2,spelar.y - spelar.height)
    love.graphics.print(spelar.liv, 50, 50)
  end
end

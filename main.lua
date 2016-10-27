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

  vindauge = {
    xmin = 0,
    xmax = love.graphics.getWidth(),
    ymax = love.graphics.getHeight(),
    ymin = 0
  }

oppdaterOgSpawn(dt)
oppdaterSpelar(dt, vindauge.ymax, vindauge.xmax)


  vindauge = {
    xmin = 0,
    xmax = love.graphics.getWidth(),
    ymax = love.graphics.getHeight(),
    ymin = 0
  }

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
          if v.roterande == nil then
            v.y = v.y + v.height + v.mellomrom
          end
      end

    elseif v.gaarMotHogre == false then
      v.x = v.x - v.speed *dt
      if v.x <= vindauge.xmin + v.mellomrom then
        v.gaarMotHogre = true
        v.y = v.y + v.height + v.mellomrom
      end
    else v.y = v.y + v.speed * dt end
    if v.roterande == true then
      v.y = v.y + v.speed * dt end


  if v.liv == 0 or v.y == 200 then
      table.remove(enemies_controller.enemies, i)
      if v.liv == 0 then
        spelar.poeng = spelar.poeng + v.poeng
      end
  end
end

end


function love.draw()
  if gameState == "playing" then

      for i,v in pairs(spelar.bullets) do
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
      end

      for i, e in pairs(enemies_controller.enemies) do
        love.graphics.setColor(e.farge)
        love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
      end

      love.graphics.setColor(spelar.farge)
      love.graphics.polygon("fill",
          spelar.x,spelar.y,
          spelar.x + spelar.width,spelar.y,
          spelar.x + spelar.width/2,spelar.y - spelar.height)
      love.graphics.print(spelar.liv, 50, 50)
      love.graphics.print(spelar.poeng, 50, 70)
      love.graphics.print(spelar.cooldown, 50, 90)

    elseif gameState == "dead" then
      love.graphics.print("du er dau trykk på r for å restarte", 50, 50) end
end

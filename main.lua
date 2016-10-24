function love.load(arg)
  dofile "spelar.lua"
  dofile "fiende.lua"
  BULLETWIDTH = 10
  gameState = "playing"
  enemies_controller:spawnEnemy()
  NY_FIENDE_TIMER = 0
end

function love.update(dt)

  if NY_FIENDE_TIMER <= 0 then
    enemies_controller:spawnEnemy()
    NY_FIENDE_TIMER = (enemy.width + enemy.mellomrom) + dt
  end

  NY_FIENDE_TIMER = NY_FIENDE_TIMER - 1


  vindauge = {
    xmin = 0,
    xmax = love.graphics.getWidth(),
    ymax = love.graphics.getHeight(),
    ymin = 0
  }




  if love.keyboard.isDown(" ") then
    spelar.y = vindauge.ymax - 20 - spelar.hoppHogd
  else
    spelar.y = vindauge.ymax - 20 end

  if love.keyboard.isDown("b") then
    spelar.fire()
  end

  if love.keyboard.isDown("a") and spelar.x > vindauge.xmin then
    spelar.x = spelar.x - spelar.fart * dt end

  if love.keyboard.isDown("d") and spelar.x + spelar.width < vindauge.xmax then
    spelar.x = spelar.x + spelar.fart * dt end

  for i,v in pairs(spelar.bullets) do
    if v.y < vindauge.ymin then
      table.remove(spelar.bullets, i) end
    v.y = v.y - spelar.bulletSpeed  end

  for i, v in pairs(enemies_controller.enemies) do
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
    end
  end

  if spelar.cooldown ~= 0 then spelar.cooldown = spelar.cooldown -2 end
end

function love.draw()
  if gameState == "playing" then
    love.graphics.setColor(255, 0, 0)
    for i,v in pairs(spelar.bullets) do
      love.graphics.rectangle("fill", v.x, v.y, BULLETWIDTH, 10)
    end


    for i, e in pairs(enemies_controller.enemies) do
      love.graphics.setColor(e.farge)
      love.graphics.rectangle("fill", e.x, e.y, e.width, e.height) end

    love.graphics.setColor(spelar.farge)
    love.graphics.polygon("fill",
        spelar.x,spelar.y,
        spelar.x + spelar.width,spelar.y,
        spelar.x + spelar.width/2,spelar.y - spelar.height)
  end
end

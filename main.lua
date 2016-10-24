function love.load(arg)
  BULLETWIDTH = 100
  gameState = "playing"

  spelar = {
    x = 100,
    y = 0,
    z = 100,
    width = 60,
    height = 60,
    fart = 500,
    hoppHogd = 200,
    cooldown = 20,
    bulletSpeed = 5,
    bullets =  {},

    fire = function()
      bullet = {
        x = spelar.x + spelar.width /2 - BULLETWIDTH / 2,
        y = spelar.y - spelar.height
        }

      if spelar.cooldown == 0 then
        table.insert(spelar.bullets, bullet)
        spelar.cooldown = 20
      end
    end
  }

end

function love.update(dt)
  vindauge = {
    xmin = 0,
    xmax = love.graphics.getWidth(),
    ymax = love.graphics.getHeight(),
    ymin = 0
  }
  if love.keyboard.isDown(" ") then
    spelar.y = vindauge.ymax - 20 - spelar.hoppHogd
  else spelar.y = vindauge.ymax - 20 end

  if love.keyboard.isDown("b") then
    spelar.fire()
  end

  if love.keyboard.isDown("a") and spelar.x > vindauge.xmin then
    spelar.x = spelar.x - spelar.fart *dt end
  if love.keyboard.isDown("d") and spelar.x + spelar.width < vindauge.xmax then
    spelar.x = spelar.x + spelar.fart *dt end

  for i,v in pairs(spelar.bullets) do
    if v.y < vindauge.ymin then
      table.remove(spelar.bullets, i) end
    v.y = v.y - spelar.bulletSpeed
  end

  if spelar.cooldown ~= 0 then spelar.cooldown = spelar.cooldown -2 end
end



function love.draw()
  if gameState == "playing" then
    love.graphics.setColor(255, 0, 0)
    for i,v in pairs(spelar.bullets) do
      love.graphics.rectangle("fill", v.x, v.y, BULLETWIDTH, 10)
    end

    love.graphics.setColor(255, 255, 255)
    --love.graphics.rectangle("fill", spelar.x, spelar.y, spelar.width, spelar.height)
    love.graphics.polygon("fill",
        spelar.x,spelar.y,
        spelar.x + spelar.width,spelar.y,
        spelar.x + spelar.width/2,spelar.y - spelar.height)
  end

end

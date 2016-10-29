function love.load(arg)
  dofile "spelar.lua"
  dofile "fiende.lua"
  dofile "funksjonar.lua"
  dofile "hovudmeny.lua"
  dofile "definisjonar.lua"
  litenfiendeBilete = love.graphics.newImage("bilete/litenfiende.png")
  storFiendeBilete = love.graphics.newImage("bilete/storFiende.png")
  vidFiendeBilete = love.graphics.newImage("bilete/vidFiende.png")
  gameState = "meny"
  menyvalg = 1
  NY_FIENDE_TIMER = 100
  NY_STOR_FIENDE_TIMER = 100
  NY_ROTERANDE_FIENDE = 100
  vanskelegHeitsGrad = 1
end

function love.update(dt)

  if love.keyboard.isDown("q") then
    love.event.quit(1) end


  vindauge = {
    xmin = 0,
    xmax = love.graphics.getWidth(),
    ymax = love.graphics.getHeight(),
    ymin = 0,
    tellar = 4
  }

  if gameState == "dead" and love.keyboard.isDown(omstartKnapp) then
    gameState = "playing"
    spelar.liv = spelar.startLiv
    spelar.poeng = 0
    enemies_controller.enemies = {}
  end



  if gameState == "playing" then

    oppdaterOgSpawn(dt)
    oppdaterSpelar(dt, vindauge.ymax, vindauge.xmax)

    for i,v in pairs(spelar.bullets) do
      if v.y < vindauge.ymin then
        table.remove(spelar.bullets, i) end
      v.y = v.y - spelar.bulletSpeed
    end

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
          v.x, v.y, v.width, v.height,
          spelar.x, spelar.y, spelar.width, spelar.height
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


    if v.liv <= 0 or v.y == 200 then
        table.remove(enemies_controller.enemies, i)
        if v.liv == 0 then
          spelar.poeng = spelar.poeng + v.poeng
        end
    end
  end

  elseif gameState == "meny" then

    if #menyObjektAr == 0 then
      for i = 1, 5 do
        table.insert(menyObjektAr , menyObjekt)
      end
    end

    for i, v in pairs(menyObjektAr) do

      function love.keyreleased(key)
        if key == oppKnapp and menyvalg > 1 then
          menyvalg = menyvalg - 1 end
        if key == nedKnapp and menyvalg < 5 then
          menyvalg = menyvalg + 1 end
        if key == skyteKnapp then
          gameState = "playing"
          vanskelegHeitsGrad = menyvalg
        end
      end




    end
  end

end
love.getVersion()
function love.draw()
  if gameState == "playing" then

      for i,v in pairs(spelar.bullets) do
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
      end

      for i, e in pairs(enemies_controller.enemies) do
        love.graphics.setColor(e.farge)
        love.graphics.draw(e.img, e.x, e.y)
      end

      love.graphics.setColor(spelar.farge)
      love.graphics.polygon("fill",
          spelar.x,spelar.y,
          spelar.x + spelar.width,spelar.y,
          spelar.x + spelar.width/2,spelar.y - spelar.height)
      love.graphics.print(spelar.liv, 50, 50)
      love.graphics.print(spelar.poeng, 50, 70)
      love.graphics.print(spelar.cooldown, 50, 90)
      love.graphics.print(vanskelegHeitsGrad, 50, 110)

      love.graphics.setBackgroundColor(255, 255, 255)

elseif gameState == "dead" then
    love.graphics.print("du er dau trykk på r for å restarte", 50, 50)

elseif gameState == "meny" then

  for i, v in pairs(menyObjektAr) do
    if i == menyvalg then
      love.graphics.setColor(v.erValdFarge)
    else
      love.graphics.setColor(v.farge)
    end
    love.graphics.rectangle("fill", v.x, v.y +  ((i - 1) * 100) , vindauge.xmax - v.x * 2, v.h)
  end


  love.graphics.setColor(255,255,255)
    love.graphics.print(menyvalg, 50, 50)
    love.graphics.print(gameState, 50, 70)
    love.graphics.print(#menyObjektAr, 50, 90)

  end
end

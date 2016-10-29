function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function oppdaterOgSpawn(dt)

  if NY_FIENDE_TIMER <= 0 then
     enemies_controller:spawnEnemy()
     NY_FIENDE_TIMER = (enemy.spawnRate) *dt
   end

   if NY_STOR_FIENDE_TIMER <= 0 then
     enemies_controller:spawnBigEnemy()
     NY_STOR_FIENDE_TIMER = (bigEnemy.spawnRate)  *dt
   end

   if NY_ROTERANDE_FIENDE <= 0 then
     enemies_controller:spawnRotatingEnemy()
     NY_ROTERANDE_FIENDE = (rotatingEnemy.spawnRate) *dt
   end

     NY_FIENDE_TIMER = NY_FIENDE_TIMER - 1
     NY_STOR_FIENDE_TIMER = NY_STOR_FIENDE_TIMER -1
     NY_ROTERANDE_FIENDE = NY_ROTERANDE_FIENDE - 1

     if spelar.cooldown < 1 then
       spelar.cooldown = spelar.cooldown - 1 end
end

function oppdaterSpelar (dt)



  if spelar.liv <= 0 then
    gameState = "dead" end

  if spelar.poeng > 1000 then
    spelar.liv = spelar.liv + 1
    spelar.poeng = 0
  end

  if spelar.cooldown > 1 then
    spelar.cooldown = spelar.cooldown - 1 end

  if love.keyboard.isDown(skyteKnapp) then
    spelar.fire() end

  if love.keyboard.isDown(menyKnapp) then
    gameState = "meny" end

  if love.keyboard.isDown(hoppKnapp) then
    spelar.y = vindauge.ymax - 20 - spelar.hoppHogd
  else
    spelar.y = vindauge.ymax - 20 end

  if love.keyboard.isDown(vensteKnapp) and spelar.x > vindauge.xmin then
    spelar.x = spelar.x - spelar.fart * dt end

  if love.keyboard.isDown(hogreKnapp) and spelar.x + spelar.width < vindauge.xmax then
    spelar.x = spelar.x + spelar.fart * dt end

end

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
end

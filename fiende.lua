enemies_controller = {}
enemies_controller.enemies = {}
function enemies_controller:spawnEnemy()
  enemy = {
    x = 1,
    y = 1,
    z = 100,
    width = 32,
    height = 32,
    speed = 400 ,
    mellomrom = 5,
    spawnRate = 1500,
    liv = 1,
    gaarMotHogre = true,
    poeng = 1,
    farge  = {255, 255, 0, 255},
    img = litenfiendeBilete,
    table.insert(self.enemies, enemy)
  }
end

function enemies_controller:spawnBigEnemy()
  bigEnemy = {
        x = love.math.random(vindauge.xmin, vindauge.xmax),
        y = 0,
        z = 100,
        width = 64,
        height = 64,
        speed = 100 ,
        mellomrom = 5,
        spawnRate = 2000,
        liv = 3,
        poeng = 3,
        gaarMotHogre = nil,
          img = storFiendeBilete,

        farge  = {255, 100, 0, 255},
      table.insert(self.enemies, bigEnemy)
    }
  end

  function enemies_controller:spawnRotatingEnemy()
      rotatingEnemy = {
            x = love.math.random(vindauge.xmin, vindauge.xmax),
            y = 0,
            z = 100,
            width = 64,
            height = 16,
            speed = 100 ,
            mellomrom = 5,
            spawnRate = 5000,
            liv = 3,
            poeng = 3,
            gaarMotHogre = true,
            roterande = true,
            roterar = true,
              img = vidFiendeBilete,
            farge  = {0, 255, 0, 255},
          table.insert(self.enemies, rotatingEnemy)
        }


end

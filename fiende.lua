enemies_controller = {}
enemies_controller.enemies = {}
function enemies_controller:spawnEnemy()
  enemy = {
    x = 1,
    y = 1,
    z = 100,
    width = 64,
    height = 64,
    speed = 100 ,
    mellomrom = 5,
    spawnRate = 100,
    liv = 1,
    gaarMotHogre = true,
    farge  = {255, 255, 0, 255},
    table.insert(self.enemies, enemy)
  }
end

function enemies_controller:spawnBigEnemy()
  bigEnemy = {
        x = love.math.random(vindauge.xmin, vindauge.xmax),
        y = 100,
        z = 100,
        width = 128,
        height = 128,
        speed = 100 ,
        mellomrom = 5,
        spawnRate = 100,
        liv = 3,
        gaarMotHogre = nil,
        farge  = {255, 100, 0, 255},
      table.insert(self.enemies, bigEnemy)
    }

end

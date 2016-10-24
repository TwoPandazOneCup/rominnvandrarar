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
    gaarMotHogre = true,
    farge  = {255, 255, 0, 255},
    table.insert(self.enemies, enemy)
  }
end

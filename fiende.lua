enemies_controller = {}
enemies_controller.enemies = {}
function enemies_controller:spawnEnemy()
  enemy = {
    x = 0,
    y = 0,
    z = 100,
    width = 60,
    height = 60,
    speed = 1 ,
    mellomrom = 5,
    table.insert(self.enemies, enemy)
  }
end

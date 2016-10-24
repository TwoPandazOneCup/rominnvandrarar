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
  farge =  { 255 ,255, 255, 255},


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

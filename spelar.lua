spelar = {
  x = 100,
  y = 0,
  z = 100,
  width = 60,
  height = 60,
  fart = 500,
  hoppHogd = 200,
  cooldown = 1,
  bulletSpeed = 5,
  bulletWidth = 5,
  startLiv = 5,
  liv = 5,
  poeng = 0,
  bullets =  {},
  farge =  { 0 ,0, 255, 255},


  fire = function()
    bullet = {
      w = spelar.bulletWidth,
      x = spelar.x + spelar.width /2 - spelar.bulletWidth / 2,
      y = spelar.y - spelar.height,
      h = 5,
      }

    if spelar.cooldown == 1 then
      table.insert(spelar.bullets, bullet)
      spelar.cooldown = 5
    end
  end
}

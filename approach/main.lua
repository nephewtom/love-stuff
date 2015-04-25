function love.load()
   player = { x=60, y=60, h=0, v=0, tx=60, ty=60 } -- horizontal, vertical, targetx, targety
   sound = love.audio.newSource("bordtransmitter.mp3", "static")
   sound:setVolume(0.5)
end

kx, ky = 0.05, 0.05

function love.update(dt)
   player.x = player.x +  player.h * (player.tx - player.x) * kx
   player.y = player.y +  player.v * (player.ty - player.y) * ky
end

function love.draw()
   love.graphics.rectangle("line", 50, 50, 700, 500)

   dx = player.tx > player.x and player.tx or player.x
   sy = 1 - math.abs((player.tx - player.x)/dx)
   dy = player.ty > player.y and player.ty or player.y
   sx = 1 - math.abs((player.ty - player.y)/dy)

   love.graphics.rectangle("fill", player.x-10*sx, player.y-10*sy, 20 * sx, 20 * sy)
--   love.graphics.rectangle("fill", player.x-10*sx, player.y, 20 * sx, 10 * sy)

   strpos = string.format("sx:%1.2f | kx:%1.2f | ky:%1.2f | x:%3d | y:%3d | tx:%3d | ty:%3d", sx, kx, ky, player.x, player.y, player.tx, player.ty)
   love.graphics.print(strpos, 450, 560)
end

function soundPlay()
   if sound:isPlaying() then
      sound:stop()
   end
   sound:play()
end


function love.keypressed(key)
   if key == 's' or key ==  "down" then
      player.ty = 540
      player.v = 1
      soundPlay()
   end
   if key == 'w' or key == "up" then
      player.ty = 60
      player.v = 1
      soundPlay()
   end
   if key == 'd' or key == "right" then
      player.tx = 740
      player.h = 1
      soundPlay()
   end
   if key == 'a' or key == "left" then
      player.tx = 60
      player.h = 1
      soundPlay()
   end
   if key == 'p' and kx < 1.0 then
      kx = kx + 0.01
   end
   if key == 'o' and kx > 0.0 then
      kx = kx - 0.01
   end
   if key == 'i' and ky < 1.0 then
      ky = ky + 0.01
   end
   if key == 'k' and ky > 0.0 then
      ky = ky - 0.01
   end



   if key == 'escape' then
      love.event.quit()
   end
end

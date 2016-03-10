local the_end = false
function love.load()
   player = {
      grid_x = 64,
      grid_y = 256 - 128 -32,
      act_x = 200,
      act_y = 200,
      speed = 10
   }
   start = { x = 64, y = 96 }
   exit = { x = 64, y = 64 }
   map = {
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
      { 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
      { 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1 },
      { 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1 },
      { 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
      { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
      { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
   }
   love.timer.sleep(0.5)

end

function love.update(dt)
   player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
   player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)

   if the_end then
      love.draw()
      love.timer.sleep(1/5000 - dt)
      --love.graphics.clear(255, 0, 0)
      love.load()
      the_end = false
   end
end

function love.draw()
   for y=1, #map do
      for x=1, #map[y] do
         if map[y][x] == 1 then
            love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
         end
      end
   end
   love.graphics.setColor(0, 255, 0)
   love.graphics.rectangle("fill", start.x, start.y, 32, 32)
   love.graphics.setColor(255, 0, 0)
   love.graphics.rectangle("fill", exit.x, exit.y, 32, 32)
   love.graphics.setColor(255, 255, 255)
   love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)

   if (player.grid_x == exit.x and player.grid_y == exit.y) then
      the_end = true
   end
end

function love.keypressed(key)
   if key == "up" then
      if testMap(0, -1) then
         player.grid_y = player.grid_y - 32
      end
   elseif key == "down" then
      if testMap(0, 1) then
         player.grid_y = player.grid_y + 32
      end
   elseif key == "left" then
      if testMap(-1, 0) then
         player.grid_x = player.grid_x - 32
      end
   elseif key == "right" then
      if testMap(1, 0) then
         player.grid_x = player.grid_x + 32
      end
   end
end

function testMap(x, y)
   if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 1 then
      return false
   end
   return true
end

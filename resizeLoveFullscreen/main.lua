function love.load()
   image = love.graphics.newImage("cake.jpg")
   imgx, imgy = 0, 0
   step = 2

   modes = love.window.getFullscreenModes()
   for i,newMode in ipairs(modes) do
      local desc = string.format("Mode %d: %dx%d", i, newMode.width, newMode.height)
      print(desc)
   end

   -- Assuming as my base resolution, i.e., the one that has rW = rH = 1.0
   currentModeIdx = 1
   displayWidth, displayHeight = modes[currentModeIdx].width, modes[currentModeIdx].height
   rW, rH = 1.0, 1.0 -- ratioWidth & ratioHeight

   love.window.setMode(displayWidth, displayHeight, {fullscreen=true, fullscreentype="normal"})
   resolution = string.format("1: %dx%d - %fx%f", displayWidth, displayHeight, rW, rH)

end

function love.draw()
   love.graphics.line(displayWidth/2, 0, displayWidth/2, displayHeight)
   love.graphics.line(0, displayHeight/2, displayWidth, displayHeight/2)

   love.graphics.setColor(0, 100, 100)
   love.graphics.rectangle('fill', displayWidth/8, displayHeight/8, displayWidth*3/8, displayHeight*3/8)

   love.graphics.setColor(255, 255, 255)
   love.graphics.draw(image, imgx*rW, imgy*rH, 0, rW, rH)
   love.graphics.print(resolution, displayWidth*5/32, displayHeight*15/32)
end

function love.update(dt)
   updateMovementKeys()
end

function updateMovementKeys()
   if right == true then
      imgx = imgx + step
   end
   if left == true then
      imgx = imgx - step
   end
   if down == true then
      imgy = imgy + step
   end
   if up == true then
      imgy = imgy - step
   end
end

function love.keypressed(key)

   if key == 'd' then
      right = true
   end
   if key == 'a' then
      left = true
   end
   if key == 's' then
      down = true
   end
   if key == 'w' then
      up = true
   end

   local newIndex = 0

   if key >= '0' and key <= '9' then
      newIndex = tonumber(key)
   end
   if key == '+' and currentModeIdx < #modes then
      newIndex = currentModeIdx + 1
   end
   if key == '-' and currentModeIdx > 1 then
      newIndex = currentModeIdx - 1
   end

   local newMode = modes[newIndex]
   if newMode ~= nill then
      print("newIndex:", newIndex)
      changeMode(newMode, newIndex)
   end

   if key == 'escape' then
      love.event.quit()
   end
end

function love.keyreleased(key)
   if key == 'd' then
      right = false
   end
   if key == 'a' then
      left = false
   end
   if key == 's' then
      down = false
   end
   if key == 'w' then
      up = false
   end
end

function changeMode(newMode, newIndex)

   ok = love.window.setMode(newMode.width, newMode.height, {fullscreen=true, fullscreentype="normal"})
   print("Change newMode:", ok)

   if ok then
      rW = (newMode.width / displayWidth) * rW
      rH = (newMode.height / displayHeight) * rH
      displayWidth, displayHeight = love.window.getDimensions()
      currentModeIdx = newIndex

      resolution = string.format("%d: %dx%d - %fx%f", currentModeIdx, displayWidth, displayHeight, rW, rH)
      -- love.window.setTitle(resolution)
      print(resolution)

   end
end

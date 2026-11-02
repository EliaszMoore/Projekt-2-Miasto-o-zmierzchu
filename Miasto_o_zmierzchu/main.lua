require("L5")
--Array to hold buildings
local buildings = {}

--Image variabels
local B1
local B2
local windowOn
local windowOff

--Setup, loads all of the images for use later and tells the function buildingGo() to generate the buildings.
function setup()
  size(1200, 600)
  frameRate(5)

  --Images can be easily changed here
  ground = loadImage('assets/background.png')

  B1 = loadImage('assets/B1d.png')
  B2 = loadImage('assets/B2d.png')

  windowOn = loadImage('assets/W1.png')
  windowOff = loadImage('assets/W2.png')
  

  -- Generates the buildings on start if activated.
  --buildingGo()
end

--Makes buildings refresh on mouse click.
function mouseClicked()
  buildings = {}
  buildingGo()
end

--Keybind "s" to save an images of the sketch
function keyTyped()
  if key == 's' then
    save('MiastoSave.png')
  end
end




--Draws the buildings and background.
function draw()
  background(ground)


  for _,build in ipairs(buildings) do
    drawBuilding(build)
    drawWindows(build)
  end

  --Position for debugging
  --fill(0)
  --text("X: "..mouseX.."  Y: "..mouseY, mouseX+5,mouseY+30)
  
end

-- Function to create the buildings and adds them to the table.
function buildingGo()
  for i=1,30 do
    local build = makeBuilding()

    table.insert(buildings, build)
  end
end

--Functions that sets the building types and holds the random variables for use later. Randomness for building type and location come from here.
function makeBuilding()


  local buildingTypes = {B1,B2}

   build = {
    x = random(-50,1250),
    y = random(240,550),
    buildingType = random(buildingTypes)
  }
  return build
end

--Draws the buildings using the vraiables from makeBuilding().
function drawBuilding(build) 
  noStroke()

image(build.buildingType, build.x, build.y)
end

--Draws the windows for each building.
function drawWindows(build)

  --Amount of light in windows can be controlled here, simply add more "off"s and "on"s to the array to increase/decrease chances of selection.
  local windowLight = {"on","off","off","off","off","off","off"}

--Calls from the image variables to determine the type of building the windows have to fit. Randomness for lights turning on and off comes from here.
  if build.buildingType== B1 then
    --Windows for building type 1
    for x = 0, 8, 1 do
      for y = 0, 6, 1 do
        push()

        light = random(windowLight)
        translate(build.x+6, build.y+23)
        if light=="on"then
          image(windowOn,x*15,y*12)
        else
          image(windowOff,x*15,y*12)
        end
        pop()
      end
    end
  else
    for x = 0, 1, 1 do
      for y = 0, 9, 1 do
        push()
        --Windows for building type 2
        light = random(windowLight)
        translate(build.x+4, build.y+22)
        if light=="on"then
          image(windowOn,x*14,y*14.5)
        else
          image(windowOff,x*14,y*14.5)
        end
        pop()
        push()
        translate(build.x+55, build.y+22)
        if light=="on"then
          image(windowOn,x*14,y*14.5)
        else
          image(windowOff,x*14,y*14.5)
        end
        pop()
      end
  end
end
end

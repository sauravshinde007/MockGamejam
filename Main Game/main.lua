-- Escape THeme Game (Mock Game Jam)

-- Top Down Game

-- 1.Player can move in all directions
-- 2.Player can shoot with directions given by the mouse
-- 3.Enemies will be spawned randomly anywhere and will follow you and decrease your health
-- 4.You can either kill enmies for high score but ultimately "ESCAPE" the world/room.
--hello world
--------------------------Start-------------------------------------------------

WINDOW_HEIGHT=750
WINDOW_WIDTH=750

--------------------------Player------------------------------------------
Player={}
Player.width=50
Player.height=50
Player.y=WINDOW_HEIGHT-Player.height
Player.x=WINDOW_WIDTH/2-Player.width/2
Player.speed=200
Player.health_width=150
Player.health_height=20

--------------------------Bullets---------------------------------------------


all_bullets={}


function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
    timer=0

    --images for the game
    player_image=love.graphics.newImage("survivor-idle_rifle_0.png")
    
end

function love.update(dt)
    
    --for bullet
    timer=timer+dt

---------------------------mouse movement for player--------------------------------------------
    --will find out mouse location
    local mouseX, mouseY = love.mouse.getPosition()

    -- Calculate the angle between the player and the mouse
    local angle = math.atan2(mouseY - Player.y, mouseX - Player.x)

    --players direction
    Player.direction=angle

    -- Calculate the player's velocity based on the angle and speed
    local velocityX = Player.speed * math.cos(angle)
    local velocityY = Player.speed * math.sin(angle)

    -- -- Handle 'W' key movement
    -- if love.keyboard.isDown('w') then
    --         Player.x = Player.x + velocityX * dt
    --         Player.y = Player.y + velocityY * dt
    -- end



    if love.keyboard.isDown("a") and Player.x>0 then
        Player.x=Player.x-Player.speed*dt
        
    end
    if love.keyboard.isDown("w") and Player.y>0 then
        Player.y=Player.y-Player.speed*dt
        
    end
    if love.keyboard.isDown("s") and Player.y<WINDOW_HEIGHT-Player.height then
        Player.y=Player.y+Player.speed*dt
        
    end
    if love.keyboard.isDown("d") and Player.x<WINDOW_WIDTH-Player.width then
        Player.x=Player.x+Player.speed*dt
        
    end

    -----------------------bullet function and movement-----------------------------------------
    -- function createbullets()
    --     local bullet={}
    --     bullet.width=5
    --     bullet.height=15
    --     bullet.x=Player.x+Player.width/2-bullet.width/2
    --     bullet.y=Player.y-bullet.height
    --     bullet.speed=500
    --     bullet.dx= bullet.speed*math.cos(angle)
    --     return bullet
        
    -- end
    -----------------------bullet creation and deletion acc to mouse-----------------------------------------------------
    if love.keyboard.isDown("space") then
          if timer>=0.1 then
           
            local bulletspeed=750

            local bullet={}
            bullet.width=5
            bullet.height=15
            bullet.x=Player.x+Player.width/2-bullet.width/2
            bullet.y=Player.y+Player.height/2-bullet.height/2
            bullet.dx= bulletspeed*math.cos(angle)
            bullet.dy= bulletspeed*math.sin(angle)

            table.insert(all_bullets,bullet)

            timer=0
        end
        


    end

    --old implementation
    -- for k, v in pairs(all_bullets) do
    --     v.y=v.y-v.speed*dt
    -- end

    -- -- to delete extra bullets
    -- for k, v in pairs(all_bullets) do
    --     if v.y<-v.height  then
    --             table.remove(all_bullets,k)  
    --     end
    -- end
    --------------------------bullet movement-----------------------------------------------------
    for k, v in pairs(all_bullets) do
        --bullet movement acc to mouse
        v.x=v.x+v.dx*dt
        v.y=v.y+v.dy*dt

        --removing extra bullets of the screen
        if v.x>WINDOW_WIDTH-v.width or v.x<0 or v.y>WINDOW_HEIGHT or v.y<-v.height  then
            table.remove(all_bullets,k)
            
        end
        
    end

end

function love.draw()

    --font for the text
    local font1=love.graphics.newFont("ARIALBD 1.TTF")
    local font2=love.graphics.newFont("Akira Expanded Demo.otf")


     
    -- love.graphics.rectangle(mode,x,y,width,height)
    -- love.graphics.setColor(1,1,1)
    -- love.graphics.rectangle("fill",Player.x,Player.y,Player.width,Player.height)
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
  

    --bullet
    for k, v in pairs(all_bullets) do
        -- love.graphics.circle(mode,x,y,radius)
        love.graphics.circle("fill",v.x,v.y,5)
        
    end

    --player drawing

    local centerX = Player.x + player_image:getWidth() / 2
    local centerY = Player.y + player_image:getHeight() / 2

    love.graphics.setColor(1,1,1)
    love.graphics.draw(player_image,centerX,centerY,Player.direction,0.4,0.4,player_image:getWidth()/2,player_image:getHeight()/2)
    love.graphics.rectangle("fill",Player.x,Player.y,Player.width,Player.height)

    --to make players health
    -- love.graphics.setFont(font1)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(font2)
    love.graphics.print("Player's Health",30,30,0,1.1,1.1)
    -- love.graphics.print(text,x,y,r,sx,sy,ox,oy)

    --player health bar
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("fill",30,50,Player.health_width,Player.health_height)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",30,50,150,20)

    --no of bullets generated
    love.graphics.setColor(0,1,0)
    love.graphics.print(#all_bullets,15,15)
    
end
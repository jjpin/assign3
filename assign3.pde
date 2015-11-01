final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState;

final int C = 0;
final int B = 1;
final int A = 2;
int enemyState;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
float fighterX;
float fighterY;
float speed = 3;

int hpX = 40;
int enemyX = -30;
int enemyY = floor(random(30,440));
int spacingX = 70;
int spacingY = 45;
int treasureX = floor(random(40,580));
int treasureY = floor(random(40,380));
int bgX = 0;

PImage fighter;
PImage hp;
PImage enemy;
PImage treasure;
PImage bg1;
PImage bg2;
PImage end1;
PImage end2;
PImage start1;
PImage start2;

void setup () {
  size(640, 480) ;
  fighterX = width/2;
  fighterY = height/2;
  
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  enemy = loadImage("img/enemy.png");
  treasure = loadImage("img/treasure.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  gameState = GAME_START;
}

void draw() {
  switch(gameState){
    case GAME_START:
      imageMode(CENTER);
      image(start2, 320, 240);
      if(mouseX > 200 && mouseX < 440){
        if(mouseY > 360 && mouseY < 420){
          image(start1, 320, 240);
          if(mousePressed){
            gameState = GAME_RUN;
            enemyState = C;
          }
        }
      }
    break;
    
    case GAME_RUN: 
      //bg
      image(bg1, bgX+320, 240);
      image(bg2, bgX-320, 240);
      image(bg1, bgX-960, 240);
      bgX += 1;
      bgX = bgX % 1280;
      
      //fighter
      image(fighter, fighterX, fighterY);
      if(upPressed){
        fighterY -= speed;
      }
      if(downPressed){
        fighterY += speed;
      }
      if(leftPressed){
        fighterX -= speed;
      }
      if(rightPressed){
        fighterX += speed;
      }    
      //boundary detection
      if(fighterX > 615){
        fighterX = 615;
      }
      if(fighterX < 25){
        fighterX = 25;
      }
      if(fighterY > 445){
        fighterY = 445;
      }
      if(fighterY < 25){
        fighterY = 25;
      }
      
      //enemy
      switch(enemyState){
        case C:
          int c = 0;
          for(c=0; c<5; c++){
            image(enemy, enemyX-c*spacingX, enemyY);
          }
          enemyX += 2;
          if(enemyX > 960){
            enemyState = B;
            enemyX = -30;
          }
        break;
        
        case B:
          if(enemyY > 190){
            enemyY = 190;
          }
          int b = 0;
          for(b=0; b<5; b++){
            image(enemy, enemyX-b*spacingX, enemyY+b*spacingY);
          }
          enemyX += 2;
          if(enemyX > 960){
            enemyState = A;
            enemyX = -30;
          }
        break;
        
        case A:
          if(enemyY > 360){
            enemyY = 360;
          }
          if(enemyY < 120){
            enemyY = 120;
          }
          int a = 0;
          for(a=0; a<5; a++){
            if(a==0){
              image(enemy, enemyX, enemyY);
            }else if(a==1){
              image(enemy, enemyX-spacingX, enemyY-spacingY);
              image(enemy, enemyX-spacingX, enemyY+spacingY);
            }else if(a==2){
              image(enemy, enemyX-a*spacingX, enemyY-a*spacingY);
              image(enemy, enemyX-a*spacingX, enemyY+a*spacingY);
            }else if(a==3){
              image(enemy, enemyX-a*spacingX, enemyY-spacingY);
              image(enemy, enemyX-a*spacingX, enemyY+spacingY);
            }else if(a == 4){
              image(enemy, enemyX-a*spacingX, enemyY);
            }
          }
          enemyX += 2;
          if(enemyX > 960){
            enemyState = C;
            enemyX = -30;
          }
        break;
      }
      
      //treasure
      image(treasure ,treasureX, treasureY);
      //get treasure
      if((int)fighterX+25 >= treasureX-20 && (int)fighterX-25 <= treasureX+20){
        if((int)fighterY+25 >= treasureY-20 && (int)fighterY-25 <= treasureY+20){
          hpX += 20;
          treasureX = floor(random(40,580));
          treasureY = floor(random(40,380));
          if(hpX > 200){
            hpX = 200;
          }
        }
      }
      
      //hp
      fill(#FF0000);
      rect(9, 3, hpX, 20);
      image(hp, 105, 15);
      if(hpX <= 0){
        gameState = GAME_OVER;
      }
    break;
    
    case GAME_OVER:
      image(end1, 320, 240);
      if(mouseX > 200 && mouseX < 440){
        if(mouseY > 300 && mouseY < 360){
          image(end2, 320, 240);
          if(mousePressed){
            hpX = 40;
            enemyX = -30;
            enemyY = floor(random(60,400));
            fighterX = width/2;
            fighterY = height/2;
            gameState = GAME_RUN;
          }
        }
      }
    break;
  }
}

void keyPressed(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}

void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
      break;
      case DOWN:
        downPressed = false;
      break;
      case LEFT:
        leftPressed = false;
      break;
      case RIGHT:
        rightPressed = false;
      break;
    }
  }
}

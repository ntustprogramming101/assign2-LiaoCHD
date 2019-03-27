PImage bg,soil,life,groundHog,soldier,cabbage,gameOver,restartHovered,restartNormal;
PImage title,startNormal,startHovered;
PImage groundhogDown,groundhogLeft,groundhogRight;
float soldierX=0;
float soldierY;
float cabbageX;
float cabbageY;
float life2X=80;
float life3X=-50;
int lifePoint=2;

float groundHogX=320;
float groundHogY=80;
float groundSpeed=80/16;

float groundhogMove=0;

float groundhogMovingDown=0;
float groundhogMovingRight=0;
float groundhogMovingLeft=0;

final int key_Right = 1;
final int key_Left = 2;
final int key_Down = 3;
final int noKey = 0;

int keyNow = noKey;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;


void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  groundHog = loadImage("img/groundhogIdle.png");
  soldier = loadImage("img/soldier.png");
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  cabbage = loadImage("img/cabbage.png");
  gameOver= loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  noStroke();
  
  soldierY = (int)random(2,6); //set soldier's Yposition as 160 or 240 or 320 or 400 
  cabbageX = (int)random(0,8);//so does cabbage
  cabbageY = (int)random(2,6);
}

void draw() {
  
// Switch Game State
switch(gameState){

// Game Start
  case GAME_START:
  
      image(title,0,0);
      image(startNormal,248,360);
      if(mouseX>=248 && mouseX<248+144){
      if(mouseY>=360&& mouseY<=360+60){
        image(startHovered,248,360);
        if (mousePressed) {
      gameState=GAME_RUN;
      } 
      }
      }
break;

// Game Run 
   case GAME_RUN:
     background(bg);
     image(life,10, 10); //The first life icon
     image(life,life2X, 10); //The second one,20 plus the width of the picture = 70
     image(life,life3X, 10); //The third one,does not exist in the beginning
     fill(124,204,25);         //color of grass
     rect(0,145,640,15);       //grass
     fill(255,255,0);//Here comes the sun
     ellipse(640-50,50,130,130);
     fill(253,184,19);
     ellipse(640-50,50,120,120);
     image(soil,0, 160);//pit the soil at the bottom 
     image(groundHog,groundHogX,groundHogY);//put the groundhog at the 5th
     image(soldier,soldierX, soldierY*80); //soldier
     soldierX = soldierX +2; // make him move forward
     if (soldierX>640) soldierX = -80; //once the soldier is out of screen,make him back
     image(cabbage,cabbageX*80, cabbageY*80); //cabbage
     

//GroundHogMove
switch(keyNow){

  //GroundHogMoveRight
  case (key_Right):
  groundhogMovingRight=1;
  groundhogMove+=1;
  groundSpeed=80/16;
  groundHogX+=groundSpeed;
  groundHog = loadImage("img/groundhogRight.png");
        if(groundhogMove==16){
          groundHog = loadImage("img/groundhogIdle.png");
          groundSpeed=0;
          groundhogMove=0;
          groundhogMovingRight=0;
          keyNow=noKey;
         }
         break;

 //GroundHogMoveLeft
  case (key_Left):
  groundhogMovingLeft=1;
  groundhogMove+=1;
  groundSpeed=-80/16;
  groundHogX+=groundSpeed;
  groundHog = loadImage("img/groundhogLeft.png");
        if(groundhogMove==16){
          groundHog = loadImage("img/groundhogIdle.png");
          groundSpeed=0;
          groundhogMove=0;
          groundhogMovingLeft=0;
          keyNow=noKey;
         }
         break;
         
 //GroundHogMoveDown
  case (key_Down):
  groundhogMovingDown=1;
  groundhogMove+=1;
  groundSpeed=80/16;
  groundHogY+=groundSpeed;
  groundHog = loadImage("img/groundhogDown.png");
        if(groundhogMove==16){
          groundHog = loadImage("img/groundhogIdle.png");
          groundSpeed=0;
          groundhogMove=0;
          groundhogMovingDown=0;
          keyNow=noKey;
         }
         break;
         
  case (noKey):
         break;
}

// AABB collision with soldier
if(groundHogX<soldierX+80 && groundHogY+80>soldierY*80 && groundHogX+80>soldierX && groundHogY<soldierY*80+80){
          groundHog = loadImage("img/groundhogIdle.png");
          groundSpeed=0;
          groundhogMove=0;
          groundhogMovingDown=0;
          groundhogMovingRight=0;
          groundhogMovingLeft=0;
          keyNow=noKey;
          groundHogX=320;
          groundHogY=80;//back to the beginning
        switch(lifePoint){
          case 1:
           gameState=GAME_LOSE;
          break;
          case 2:
          lifePoint-=1;
          life2X=-50;
          break;
          case 3:
          lifePoint-=1;
          life3X=-50;
          break;
        }
}

// AABB collision with cabbage
if(groundHogX<cabbageX*80+80 && groundHogY+80>cabbageY*80 && groundHogX+80>cabbageX*80 && groundHogY<cabbageY*80+80){
    cabbageX=-80;//disappear
        switch(lifePoint){
          case 1:
          lifePoint+=1;
          life2X=80;
          break;
          case 2:
          lifePoint+=1;
          life3X=150;
          break;
        }}  
break;
 
// Game Lose 
 case GAME_LOSE:
 image(gameOver,0,0);
      image(restartNormal,248,360);
      if(mouseX>=248 && mouseX<248+144){
      if(mouseY>=360&& mouseY<=360+60){
        image(restartHovered,248,360);
        if (mousePressed) {
      lifePoint=2;//reset
      life2X=80;
      soldierX=0;
      soldierY = (int)random(2,6); //set soldier's Yposition as 160 or 240 or 320 or 400 
      cabbageX = (int)random(0,8);//so does cabbage
      cabbageY = (int)random(2,6);
      
      gameState=GAME_RUN;
         } 
         }
         }
break;   
}
}


void keyPressed(){
if(keyCode==DOWN && groundhogMovingLeft==0 && groundhogMovingRight==0 && gameState==GAME_RUN){
if(groundHogY + 80 < height)keyNow=key_Down;
}
else if(keyCode==LEFT && groundhogMovingDown==0 && groundhogMovingRight==0 && gameState==GAME_RUN){
if(groundHogX > 0)keyNow=key_Left;
}
else if(keyCode==RIGHT && groundhogMovingDown==0 && groundhogMovingLeft==0 && gameState==GAME_RUN){
if(groundHogX + 80 < width)keyNow=key_Right;
}
}

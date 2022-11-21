PImage water; //image of water
PImage boatLeft; //image of a boat facing left
PImage boatRight; //image of a boat facing right
PImage boatForward; //image of a boat facing forward
PImage pirates; //image of a pirate ship
PImage cannonball; //image a of cannonball
PImage rock; //image of a rock
int rockY=500; //y-coordinate of rocks
int rockSize=80; //size of the rocks
int boatX=320; //x-coordinate of the player
int boatY=600; //y-coordinate of the player
int boatSize=70; //size of the player
int boatSpeed=5; //speed of the player
int playerCannonballX; //x-coordinate of the player's cannonball
float playerCannonballY; //y-coordinate of hte player's cannonball
int cannonSize=10; //size of the cannonballs
float cannonSpeed=0.1; //speed of the cannonballs
float playerCannonStop=-100; //y-coordinate for the player's cannonball to stop
float pirateCannonStop=800; //y-coordinate for the pirate cannonballs to stop
int score; //score of the player
int pirateSpeed; //speed of the pirates
boolean left; //boolean for if the player moves left
boolean right; //boolean for if the player moves right
boolean playerShoot; //boolean for player shooting a cannonball
boolean gameStart; //boolean for starting the game
boolean pirateShoot; //boolean for pirates shooting cannonballs
boolean pirateDirection; //boolean for changing the direction the pirates move
boolean gameOver; //boolean for ending the game

int[] pirateX = {100,150,200,250,300,350,400,450,500,550}; //array with length of 10 for x-coordinates of pirates
int[] pirateY = {100,160,220,280,340}; //array with length of 5 for y-coordinates of pirates
int[] rockX = {50,225,400,575}; //array with length of 4 for x-coordinates of rocks
boolean[] pirateCollision = new boolean[50]; //array with length of 50 for if the player cannonball collides with pirates
boolean[] cannonCollision = new boolean[50]; //array with length of 50 for if pirate cannonballs collide with the player
PVector[] pirateShips = new PVector[50]; //PVector to store x and y-coordinates of pirates
PVector[] pirateCannonballs = new PVector[50]; //PVector to store x and y-coordinates of pirate cannonballs

void setup() {
  size(700,700); //size of the run window
boatLeft=loadImage("boatLeft.png");
boatRight=loadImage("boatRight.png");
boatForward=loadImage("boatForward.png");
pirates=loadImage("pirateForward.png");
cannonball=loadImage("canonball.png");
rock=loadImage("rock.png");
water=loadImage("water.jpg");
createPirates(); //sets up x and y coordinates for pirate ships
createPirateCannonballs(); //sets up x and y coordinates for pirate cannonballs
}

void draw() {
  startScreen(); //draws the start screen
  endScreen(); //ends the game
  if(gameStart==true && gameOver==false && score<5000) { //if the game has started and has not ended
  image(water,0,0,width,height); //water background
  player(); //draws the player
  playerCannonball(); //draws player cannonball
  collisionDetection(); //enables collision detection between pirate ships and the player cannonball
  pirates(); //draws the pirates
  piratesMove(); //enables pirate movement
  pirateCannonballs(); //draws pirate cannonballs
  rocks(); //draws rock barriers
  scoring(); //enables player score
  }
}

void startScreen() {
  if(gameStart==false) { //if the game hasn't started
  background(0); //black background
  fill(255); //white fill colour for text
  textSize(70); //text size of 70
  text("PIRATE PILLAGERS",50,height/2); //text that says, "PIRATE PILLAGERS"
  textSize(30); //text size of 30
  text("PRESS 'ENTER' TO PLAY",200,400); // text that says, "PRESS 'ENTER' TO PLAY"
  image(pirates,250,455,boatSize-10,boatSize); //draws a pirate
  textSize(20); //text size of 20
  text("= 100 POINTS",330,500); //text that says, "= 100 POINTS"
  }
}

void player() {
  if(left==true) {image(boatLeft,boatX,boatY,boatSize,boatSize);} //if the player moves left, draw a boat facing left
  if(right==true) {image(boatRight,boatX,boatY,boatSize,boatSize);} //if the player moves right, draw a boat facing right
  if(right==false&&left==false) {image(boatForward,boatX,boatY,boatSize-10,boatSize);} //if the player hasn't moved, draw a boat facing forward
}

void createPirates() {
  int counter=0; //counter has an initial value of 0
  for(int x=0;x<pirateX.length;x++) { //x variable has an initial value of 0, must be less than the length of pirateX array, and increases by increments of 1
    for(int y=0;y<pirateY.length;y++) { //y variable has an initial value of 0, must be less than the length of pirateY array, and increases by increments of 1
      if(counter<pirateShips.length) { //if counter is less than the length of pirateShips array
          pirateShips[counter]=new PVector(pirateX[x],pirateY[y]); //PVector for x and y-cooridinates of pirate ships
          counter++; //counter increases by one
        }
      }
    }
  }

void pirates() {
  for(int index=0;index<pirateShips.length;index++) { //index variable has an initial value of 0, must be less than the length of pirateShips array, and increases by increments of 1
    if(pirateCollision[index]==false) { //if a cannonball has not hit the pirate
      image(pirates,pirateShips[index].x,pirateShips[index].y,boatSize-10,boatSize); //draws images of pirate ships
    }
  }
}
      
void piratesMove() {
  for(int index=0;index<pirateShips.length;index++) { //index variable has an initial value of 0, must be less than the length of pirateShips array, and increases by increments of 1
    pirateShips[index].x+=pirateSpeed; //pirate ships move
    if(pirateShips[49].x>600) {pirateDirection=true;} //if the 49th x-coordinate in pirateShips PVector is greater than 600, pirate ships move to the left
    if(pirateShips[49].x<500) {pirateDirection=false;} //if the 49th x-coordinate in pirateShips PVector is less than 500, pirate ships move to the right
    if(pirateDirection==true) {//if pirates are moving to the left
    {pirateSpeed=-3;} //pirates move to the left at a rate of 3 pixels
    if(score>900) {pirateSpeed=-4;} //if the player's score is greater than 900, pirates move to the left at a rate of 4 pixels
    if(score>1900) {pirateSpeed=-5;} //if the player's score is greater than 1900, pirates move to the left at a rate of 5 pixels
    if(score>2900) {pirateSpeed=-6;} //if the player's score is greater than 2900, pirates move to the left at a rate of 6 pixels
    if(score>3900) {pirateSpeed=-7;} //if the player's score is greater than 3900, pirates move to the left at a rate of 7 pixels
    if(score==4900) {pirateSpeed=-8;} //if the player's score is equal to 4900, pirates move to the left at a rate of 8 pixels
    }
      else {
        pirateSpeed=3; //pirates move to the right at a rate of 3 pixels
        if(score>900) {pirateSpeed=4;} //if the player's score is greater than 900, pirates move to the right at a rate of 4 pixels
        if(score>1900) {pirateSpeed=5;} //if the player's score is greater than 1900, pirates move to the right at a rate of 5 pixels
        if(score>2900) {pirateSpeed=6;} //if the player's score is greater than 2900, pirates move to the right at a rate of 6 pixels
        if(score>3900) {pirateSpeed=7;} //if the player's score is greater than 3900, pirates move to the right at a rate of 7 pixels
        if(score==4900) {pirateSpeed=8;} //if the player's score is equal to 4900, pirates move to the right at a rate of 8 pixels
    }
  }
}

void createPirateCannonballs() {
  for(int index=0;index<pirateCannonballs.length;index++) { //index variable has an initial value of 0, must be less than the length of pirateCannonballs array, and increases by increments of 1
          pirateCannonballs[index]=new PVector(pirateX[int(random(10))],int(pirateY[int(random(5))]));  //PVector for x and y-coordinates of pirateCannonballs
  }
}

void playerCannonball() {
  if(playerShoot==true) { //if playerShoot boolean is true
  image(cannonball,playerCannonballX,playerCannonballY,cannonSize,cannonSize); //draws a cannonball
  playerCannonballY=lerp(playerCannonballY,playerCannonStop,cannonSpeed); //moves the player cannonball
  }
}

void pirateCannonballs() {
  for(int index=0;index<pirateCannonballs.length;index++) { ////index variable has an initial value of 0, must be less than the length of pirateCannonballs array, and increases by increments of 1
    pirateCannonballs[index].y=lerp(pirateCannonballs[index].y,pirateCannonStop,cannonSpeed/2); //moves the pirate cannonballs
    image(cannonball,pirateCannonballs[0].x,pirateCannonballs[0].y,cannonSize,cannonSize);  //draws cannonballs
    if(pirateCannonballs[index].y>700) { //if y-coordinate of pirate cannonball is greater than 700
      pirateCannonballs[index].x=pirateX[int(random(10))]; //randomizes pirate cannonball x-coordinates
      pirateCannonballs[index].y=pirateY[int(random(5))]; //randomizes pirate cannonball y-coordinates
    }
  }
}

void collisionDetection() {
  for(int index=0;index<pirateShips.length;index++) { //index variable has an initial value of 0, must be less than the length of pirateShips array, and increases by increments of 1
  if(dist(pirateShips[index].x,pirateShips[index].y,playerCannonballX,playerCannonballY)<boatSize/2+cannonSize/2 && pirateCollision[index]==false) { //if a pirate ship and a player cannonball collide
    pirateCollision[index]=true; //pirate collision index is true
    playerShoot=false; //player is not shooting
    score+=100; //score increases by 100
    playerCannonballY=boatY+20; //y-coordinate of player cannonball is equal to the y-coordinate of the player plus 20
    }
  }
}

void rocks() {
  for(int index1=0;index1<rockX.length;index1++) { //index1 variable has an initial value of 0, must be less than the length of rockX array, and increases by increments of 1
  image(rock,rockX[0],rockY,rockSize*2,rockSize);
  image(rock,rockX[1],rockY,rockSize*2,rockSize);
  image(rock,rockX[2],rockY,rockSize*2,rockSize);
  image(rock,rockX[3],rockY,rockSize*2,rockSize);
    if(dist(rockX[index1]+20,rockY,playerCannonballX,playerCannonballY)<cannonSize/2+rockSize/2) { //if a rock and a player cannonball collide
      playerShoot=false; //player is not shooting
}
for(int index2=0;index2<pirateCannonballs.length;index2++) { //index2 variable has an initial value of 0, must be less than the length of pirateCannonballs array, and increases by increments of 1
  if(dist(rockX[index1]+20,rockY+10,pirateCannonballs[index2].x,pirateCannonballs[index2].y)<cannonSize/2+rockSize/2) { //if a rock and a pirate cannonball collide
    cannonCollision[index2]=true; //cannon collision is true
    pirateCannonballs[index2].y=800; //y-coordinate of pirate cannonballs is 800
      }
    }
  }
}

void scoring() {
  textSize(20); //text size of 20
  fill(255); //white fill colour for text
  text("SCORE:",50,50); //text that says, "SCORE:"
  text(score,125,50); //text that displays the player's score
}

void endScreen() {
    for(int index=0;index<pirateCannonballs.length;index++) { //index variable has an initial value of 0, must be less than the length of pirateCannonballs array, and increases by increments of 1
    if(dist(boatX+35,boatY+35,pirateCannonballs[0].x,pirateCannonballs[0].y)<boatSize/2) { //if the player and a pirate cannonball collides
      gameOver=true; //the game is over
    }
  }
  if(score==5000 || gameOver==true) { //if the player's score is equal to 5000 or the player has been hit
  background(0); //black background
  fill(255); //white fill colour for text
  if(score==5000) { //if the player's score is equal to 5000
    textSize(70); //text size of 70
    text("YOU WIN",200,height/2); //text that says, "YOU WIN"
  }
  if(gameOver==true) { //if the player has been hit
    textSize(70); //text size of 70
    text("GAME OVER",160,height/2); //text that says, "GAME OVER"
  }
 }
}

void keyPressed() {
  if(key==CODED) { //detects special keys
    if(keyCode==LEFT) { //if pressing the left arrow key
      boatX-=boatSpeed; //player moves to the left at a rate of 5 pixels
      left=true; //player is moving to the left
      right=false; //player is not moving to the right
    }
    if(keyCode==RIGHT) { //if pressing the right arrow key
      boatX+=boatSpeed; //player moves to the right at a rate of 5 pixels
      right=true; //player is moving to the right
      left=false; //player is not moving to the left
    }       
      }
  if(key==' ') { //if the spacebar is pressed
    playerCannonballX=boatX+20; //x-coordinate of player cannonball is equal to player x-coordinate plus 20
    playerCannonballY=boatY+20; //y-coordinate of player cannonball is equal to player y-coordinate plus 20
    playerShoot=true; //player is shooting
  }
      if(key==ENTER) { //if enter is pressed
     for(int index=0;index<pirateCollision.length;index++) { //index variable has an initial value of 0, must be less than the length of pirateCollision array, and increases by increments of 1
       gameStart=true; //the game has started
        left=false; //player is not moving to the left
        right=false; //player is not moving to the right
    }
  }
}

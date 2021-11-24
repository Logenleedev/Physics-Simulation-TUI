

int gravity = 10;
float mass = 30;
float positionY = 100;
float velocityY = 0;
float timeStep = 0.28;
float k = 7;

void setup() {
  size(700, 700);
  
}



void draw() {
  float anchorX = width/2;
  float anchorY = height/2;
  
  background(255, 255, 255);
  
   // FORCE CALCULATIONS
  float springForceY = -k*(positionY - anchorY);
  float forceY = springForceY + mass * gravity;
  float accelerationY = forceY/mass;
  velocityY = velocityY + accelerationY * timeStep;
  positionY = positionY + velocityY * timeStep;
    
     // DRAW SPRING-MASS
  rectMode(CENTER);
  ellipseMode(CENTER);
  rect(anchorX, anchorY, 35, 35);
  line(anchorX, anchorY, anchorX, positionY);
  ellipse(anchorX, positionY, 20, 20);
  
}

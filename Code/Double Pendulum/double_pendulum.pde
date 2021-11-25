float r1 = 200;
float r2 = 200;
float m1 = 40;
float m2 = 40;
float a1 = PI/2; // angle formed by first pendulum and normal - angle1
float a2 = PI/2; //angle formed by second pendulum and normal - angle2
float a1_v = 0; //angular velocity of pendulum1
float a2_v = 0; //angular velocity of pendulum2
float timeStep = 0.7;
float g = 1;

float px2 = -1; // previous position of second pendulum sphere - x offset
float py2 = -1; // previos position of second pendulum sphere - y offset

PGraphics canvas;

void setup() {
  size(1000, 1000);
  canvas = createGraphics(1000, 1000);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  
  
}



void draw() {
  
  // numerators are moduled 
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*r2+a1_v*a1_v*r1*cos(a1-a2);
  float den = r1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a1_a = (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*r1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v*a2_v*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a2_a = (num1*(num2+num3+num4)) / den;

  
  image(canvas, 0, 0);
  stroke(0);
  strokeWeight(2);
  
  translate(500, 110);
  
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);
  
  
  
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);
  
  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);
  
  a1_v += a1_a * timeStep;
  a2_v += a2_a * timeStep;
  a1 += a1_v * timeStep;
  a2 += a2_v * timeStep;
  
  // as momentum increases  , slowly pendulum comes to rest
   //a1_v *= 0.6; // for drag
   //a2_v *= 0.6; // for drag
  
  canvas.beginDraw();
  canvas.translate(500, 110);
  if(frameCount > 1){
    canvas.line(px2, py2, x2, y2);
  }
  canvas.strokeWeight(4);
  canvas.stroke(0);
  canvas.endDraw();
 
  px2 = x2;
  py2 = y2;
}

import java.lang.*;
import java.util.*;
import java.lang.Math;
import java.util.ArrayList;

ArrayList<Float> hist_x = new ArrayList<>();
ArrayList<Float> hist_y = new ArrayList<>();

double gravitationalConstant = 6.67408 * Math.pow(10, -11);
double earthSunDistanceMeters = 1.496 * Math.pow(10, 11);
double earthAngularVelocityMetersPerSecond = 1.990986 *  Math.pow(10, -7);
double massOfTheSunKg = 4.5 * Math.pow(10, 30);



double state_massOfTheSun = massOfTheSunKg;
boolean state_paused = true;

float pixelsInOneEarthSunDistancePerPixel = 150;
double scaleFactor = 748000000;

int numberOfCalculationsPerFrame = 2;
// The length of the time increment, in seconds.
float deltaT = 3600 * 24 / numberOfCalculationsPerFrame;

float state_distance_value = (float)earthSunDistanceMeters;
float state_distance_speed = 0F;
float state_angle_value = PI/6;
float state_angle_speed = (float)earthAngularVelocityMetersPerSecond;

double initialConditions_angle_value = Math.PI / 6;


void setup() {
  size(1000,1000);
  
}

void draw() {
  background(255);
  stroke(0);

  fill(255, 200, 50);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, 45, 45);
  
  
  // The earth rotates around the sun  
  calculateNewPosition();
  double scaledistance = scaledDistance();
  double x_coord = calculateEarthPosition_x((float)scaledistance, state_angle_value); 
  double y_coord = calculateEarthPosition_y((float)scaledistance, state_angle_value);
  
  stop_function((float)x_coord, (float)y_coord, width/2, height/2, 25, 45);
  
  hist_x.add((float)x_coord);
  hist_y.add((float)y_coord);
  for(int i = 0; i < hist_x.size(); i++){
    fill(0,0,0);
    ellipse(hist_x.get(i), hist_y.get(i), 2, 2);
  }
  fill(50, 200, 255);
  ellipse((float)x_coord, (float)y_coord, 25, 25);
  
 
}

void stop_function(float earth_x, float earth_y, float sun_x, float sun_y, int d_earth, int d_sun){
  double distance = Math.sqrt((earth_x - sun_x) * (earth_x - sun_x)  + (earth_y - sun_y) * (earth_y - sun_y));
  System.out.println(distance);
  if (distance < (d_earth/2+d_sun/2)){
    noLoop();
  }
}
// Calculate r double dots

double calculateDistanceAcceleration(float x, float y, double Constant, double SunKg) {  
      return (x * Math.pow(y, 2) -
        (Constant * SunKg) / Math.pow(x, 2));
}

// Calculate theta double dots

double calculateAngleAcceleration(float x, float y, float z) {
 
      return -2.0 * x * y / z;
}

float newValue(float currentValue, float delta, float derivative) {
  return currentValue + delta * derivative;
}


// The distance that is used for drawing on screen
double scaledDistance() {
      return state_distance_value / scaleFactor;
} 
// Calculates position of the Earth
void calculateNewPosition() {
// Calculate new distance
  double distanceAcceleration = calculateDistanceAcceleration(state_distance_value, state_angle_speed, gravitationalConstant, massOfTheSunKg); 
  state_distance_speed = newValue(state_distance_speed, deltaT, (float)distanceAcceleration);
  state_distance_value = newValue(state_distance_value, deltaT, (float)state_distance_speed);

// Calculate new angle
  double angleAcceleration = calculateAngleAcceleration(state_distance_speed, state_angle_speed, state_distance_value);
  state_angle_speed = newValue(state_angle_speed, deltaT, (float)angleAcceleration);
  state_angle_value = newValue(state_angle_value, deltaT, (float)state_angle_speed);

  if (state_angle_value > 2 * Math.PI) {
    state_angle_value = (float)(state_angle_value % (2 * Math.PI));
  }
}

double calculateEarthPosition_x(float distance, float angle) {
      double middleX = (float)Math.floor(width / 2);
      double centerX = Math.cos(angle) * distance + middleX;
      return centerX;
      
}

double calculateEarthPosition_y(float distance, float angle) {
      double middleY = (float)Math.floor(height / 2);
      double centerY = Math.sin(-angle) * distance + middleY;
      return centerY;

}

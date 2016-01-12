color cRed = #FF6464;
color cAmber = #FFBD67;
color cYellow = #F8FE85;
color cGreen = #5BE7A9;
color[] colors = {cRed, cAmber, cYellow};
//define frequency of one revolution per second
float fps = 30;
float revs = 2 * PI / fps;

void setup(){
  size(500,500);
  noStroke();
  frameRate(fps);
}

void draw(){
  background(cGreen);
  int triangles;
  //foreground triangles
  triangles = 16;
  int sections = 6;
  //for loops nested such that 3d effect is preserved
  for(int i = 1; i < triangles + 1; i++) {
    for(int section = 0; section < sections; section++){
      
      //add rotation over time, plus offset each triangle slightly
  
      //initial angle
      float angle = section*2*PI/sections;
      
      //rotate to next position in circle
      float omega = periodicSigmoid(2*PI/sections, 0.4, 2*fps);
      angle += omega;
      
      //gives organic movement
      //so that it bounces after each sigmoid
      //want a damped simple harmonic motion
      //lasts two periods
      //starts at 1 period (time of sigmoid jump)
      float t = (frameCount+fps) % (2*fps);
      angle += PI/9 * exp(-t*0.1) * sin(2 * t * revs + i/(2*PI));
      fill(colors[i % 3]);
      
      //triangles at front bop more
      //simulates 3d movement or something
      
      //start point as rotated about centre
      //but travel towards centre as they tower up
      float x = 0.5 * width + width*0.1*cos(angle)/i;
      //add more movement
      //similar function to other organic movement
      x -= 5 * (i * exp(-t*0.1) * sin(0.5 * t * revs + i/(2*PI)) );
      
      
      float y = 0.5 * height + height*0.1*sin(angle)/i;
      //double frequency to get all 3 corners in animation bop
      y -= 5 * ( i * exp(-t*0.1) * sin(2 * t * revs + i/(2*PI)) );
      symmTriangle(x, y, angle, height/(2*i), width/(2*i));
    }
  }
  
  
  //save
  //saveLoop(2*fps);
}


//draw an isocolese triangle using the line of symmetry and width
void symmTriangle(float x1, float y1, float angle, float height_, float width_){
  //x1 and y1 are base points
  
  //create variables for the two base corners left and right positions
  float xl, xr, yl, yr;
  
  //create variables for peak position
  float xp, yp;
  
  //calculate peak position
  xp = x1 + height_ * cos(angle);
  yp = y1 + height_ * sin(angle);
  
  //calculate left corner
  xl = x1 + width_/2 * cos(angle - PI/2);
  yl = y1 + width_/2 * sin(angle - PI/2);
  
  //calculate right corner
  xr = x1 + width_/2 * cos(angle + PI/2);
  yr = y1 + width_/2 * sin(angle + PI/2);
  
  triangle(xl, yl, xr, yr, xp, yp);
}

void saveLoop(float frames){
  if (frameCount < frames) {
    saveFrame("frame-###.gif");
  }
}

//this is a magical function that I once sat down with pen and paper and worked out
//alas I cannot remember what I did
//it transitions smoothly from 0 to magnitude as a sigmoid
//higher transitionSpeed increases the speed from 0 to magnitude
//period is the time between jumps
float periodicSigmoid(float magnitude, float transitionSpeed, float period) {
  float x;
  x = magnitude;
  x /= (1+exp(-transitionSpeed*((frameCount%period)-period/2)));
  return x;
}
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
  float height_;
  float width_;
  //foreground triangles
  //yes there are many
  triangles = 55;
  int sections = 16;
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
      angle += PI/9 * exp(-t*0.1) * sin(2 * t * revs + i/(4*PI));
      fill(colors[i % 3]);
      
      //start point as rotated about centre
      //but travel outerwards as they tower up
      float x = 0.5 * width + width*0.1*cos(angle)*sqrt(i);
      float y = 0.5 * height + height*0.1*sin(angle)*sqrt(i);
      
      //fairly impirical height and width by experimentation
      //rapidly going small, shifted so to avoid big gaps around i= 0-5 range
      //make height and width pulsate
      //draws traingles at 90 degree angle to lines of symmetry
      //they flap around like flags
      //or at 180 degrees for explosions
      height_ = 0.9*height * sin(1 * t * revs + i/(4*PI))/(2*sqrt(i+5));
      width_ = 1.1*width/(2*sqrt(i+5)) + 50 *  cos(0.5 * t * revs);
      symmTriangle(x, y, (angle+PI), height_, width_);
    }
  }
  
  
  //save
  saveLoop(2*fps);
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
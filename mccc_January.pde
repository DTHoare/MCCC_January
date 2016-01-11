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
  triangles = 12;
  for(int i = 1; i < triangles + 1; i++) {
    //rotate counter clockwise 90 degrees
    //add rotation over time, plus offset each triangle slightly
    //gives organic movement
    float angle = PI/2 + PI/4 * sin(0.5 * frameCount * revs + i/(2*PI));
    fill(colors[i % 3]);
    //triangles at front bop more
    //simulates 3d movement or something
    float x = 0.5 * width + 10 * (i * sin(frameCount * revs) );
    //force one of the integers to a float to get float arithmetic
    //double frequency to get all 3 corners in animation bop
    float y = 0.3 * height + 10 * ( i * sin(0.5*frameCount * revs) );
    symmTriangle(x, y, angle, width/i, width/i);
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
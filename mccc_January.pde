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
  //background triangles
  int triangles = 6;
  for(int i = 1; i < triangles + 1; i++) {
    float angle = 3/2 * PI;
    fill(colors[i % 3]);
    float x = width / (i * sin(frameCount * revs) );
    float y = height / (i * sin(frameCount * revs) );
    symmTriangle(x, y, angle, width/i, width/i);
  }
  //spinning triangles
  triangles = 6;
  for(int i = 0; i < triangles; i++){
    //2 * PI / frameRate = 1 rev/s
    float angle = frameCount * revs + i * 2 * PI/6;
    fill(colors[i % 3]);
    symmTriangle(width/2, height/2, angle, width/2 / (i+1), width/2 / (i+1));
  }
  
  //save
  //saveLoop(fps);
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
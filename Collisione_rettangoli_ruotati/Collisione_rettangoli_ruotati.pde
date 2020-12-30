float x1, y1, dX1=200, dY1=200, r1=0;  //rettangolo 1
float x2=436, y2=256, dX2=243, dY2=68, r2=0;  //rettangolo 2
boolean collisione = false;
color si = color(255, 0 ,0);
color no = color(255, 255 ,255);

void setup() {
  size(800, 800);
  rectMode(CENTER);
}

void draw() {
  x1 = mouseX;
  y1 = mouseY;
  
  if(keyPressed) {
    if(key == 'a')
    r1+=0.01;
  }
  
  if((x1+dX1/2) >= (x2-dX2/2) && (x1-dX1/2 ) <=  (x2+dX2/2) &&
     (y1+dY1/2) >= (y2-dY2/2) && (y1-dY1/2 ) <=  y2+dY2/2) {
    collisione = true;
    fill(si);
     }
  else {
    collisione = false;
    fill(no);
  }
  
  println(collisione);
  
  background(155);
  //rettangolo 1
  translate(x1,y1);
  rotate(-r1);
  rect(0, 0, dX1, dY1);
  resetMatrix();
  //rettangolo2
  translate(x2,y2);
  rotate(r2);
  rect(0, 0, dX2, dY2);
  resetMatrix();
  
  noFill();
  line(x1 - cos(r1)*dX1/2 - sin(r1)*dY1/2 ,y1,x1,y1);
}
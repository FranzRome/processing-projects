float pX=100, pY=100, vX, vY, vMax=50, acc=1, raggio=15, rotazione=0, vRotazione=4;
int r,g,b;

void setup(){
  size(800,800);
  noStroke();
  background(0);
}

void draw(){
  if(keyPressed){
    if(key == 'w'){
      vY-=acc;
    }
    if(key == 's'){
      vY+=acc;
    }
    if(key == 'a'){
      vX-=acc;
    }
    if(key == 'd'){
      vX+=acc;
    }
  }
  vX=constrain(vX,-vMax,vMax);
  vY=constrain(vY,-vMax,vMax);
  
  
  pX+=vX;
  pY+=vY;
  
 
  
  if(pX<0+raggio || pX>width-raggio){
    vX*=-1;
  }
   if(pY<0+raggio || pY>height-raggio){
    vY*=-1;
  }
  
  rotazione+=vRotazione;
  
  fill(0,0,0,10);
  rect(0,0,width,height);
  
  translate(pX,pY);
  rotate(radians(rotazione));
  r = round(127.5*(1+cos(radians(rotazione))));
  g = round(127.5*(1+cos(radians(rotazione+120))));
  b = round(127.5*(1+cos(radians(rotazione+240))));
  fill(r,g,b);
  ellipse(0,0,raggio*2,raggio*2);
  ellipse(-raggio*2,-raggio*2,raggio*2,raggio*2);
  ellipse(raggio*2,-raggio*2,raggio*2,raggio*2);
  ellipse(-raggio*2,raggio*2,raggio*2,raggio*2);
  ellipse(raggio*2,raggio*2,raggio*2,raggio*2);
  
  resetMatrix();
}
float pX=100, pY=200, velocityX=0, velocityY=0, acc=1;

void setup(){
  size(800, 800);
  noStroke();
}

void draw(){
  if(keyPressed){
    if(key == 'w'){
      velocityY -= acc;
    }
    if(key == 's'){
      velocityY += acc;
    }
    if(key == 'a'){
      velocityX -= acc;
    }
    if(key == 'd'){
      velocityX += acc;
    }
  }
  
  pX+=velocityX;
  pY+=velocityY;
  
  if(pX > width){
    velocityX*=-1;
  }
  if(pX < 0){
    velocityX*=-1;
  }
  if(pY > height){
    velocityY*=-1;
  }
  if(pY < 0){
    velocityY*=-1;
  }
  
  //background(120,120,120);
  fill(0,10);
  rect(0,0,width,height);
  fill(0,255,255,100);
  ellipse(pX,pY,30,30);
  ellipse(pX,pY+40,30,30);
  ellipse(pX,pY-40,30,30);
  ellipse(pX+40,pY,30,30);
  ellipse(pX-40,pY,30,30);
  
  
}
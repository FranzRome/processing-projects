float pX1,pY1,raggio1,velocita1; //cerchio 1
float pX2,pY2,raggio2; //cerchio 2
int punti;

void setup(){
  size(600,600);
  velocita1=2;
  
  /*pX2 = width/2;
  pY2 = height/2;*/
  genera();
  raggio2 = 30;
  raggio1 = 60;
  
  punti=0;
  
  textSize(24);
}

void draw(){
  if(mouseX>pX1){
    pX1+=velocita1;
  }
  else if(mouseX < pX1){
    pX1-=velocita1;
  }
  if(mouseY>pY1){
    pY1+=velocita1;
  }
  else if(mouseY < pY1){
    pY1-=velocita1;
  }
  //pX1 = mouseX;
  //pY1 = mouseY;
  
  if(distanzaQuadrata(pX1,pX2,pY1,pY2)<raggioQuadrato(raggio1, raggio2)){
    println("collisione!!");
    fill(250,0,0);
    punti++;
    genera();
  }
  else{
    println("");
    fill(255);
  }
  
  background(120);
  ellipse(pX1, pY1, raggio1*2, raggio1*2);
  ellipse(pX2, pY2, raggio2*2, raggio2*2);
  text("Punti: " + punti, 40, 40);
  
}

float distanzaQuadrata(float x1, float x2, float y1, float y2){
  float result = pow(x1-x2,2) + pow(y1-y2,2);
  return result;
}

float raggioQuadrato(float r1, float r2){
  return pow(r1+r2,2);
}

void genera(){
  pX2 = random(0,width);
  pY2 = random(0,height);
}
float posizioneX1, posizioneY1, dimensioneX1, dimensioneY1;  //box1
float posizioneX2, posizioneY2, dimensioneX2, dimensioneY2;  //box2
boolean flag;

//da usare per le collisioni dei box con rectMode(CORNER)
boolean collisioneCorner(float pX1, float pY1, float dX1, float dY1, float pX2, float pY2, float dX2, float dY2) {
  boolean collide = false;
  
    if(pX1 < pX2 + dX2 &&
       pX1 + dX1 > pX2 &&
       pY1 < pY2 + dY2 &&
       dY1 + pY1 > pY2) {
      collide = true;
    }
    return collide;
}

//da usare per le collisioni dei box con rectMode(CENTER)
boolean collisioneCenter(float pX1, float pY1, float dX1, float dY1, float pX2, float pY2, float dX2, float dY2) {
  boolean collide = false;
  
    if(pX1 < pX2 + dX2/2 &&
       pX1 + dX1/2 > pX2 &&
       pY1 < pY2 + dY2/2 &&
       dY1/2 + pY1 > pY2) {
      collide = true;
    }
    return collide;
}

void posiziona()
{
  posizioneX1 = mouseX;
  posizioneY1 = mouseY;
}

void disegna()
{
  background(120);
  rectMode(CORNER);
  rect(posizioneX1, posizioneY1, dimensioneX1, dimensioneY1);
  rect(posizioneX2, posizioneY2, dimensioneX2, dimensioneY2);
}

void setup()
{
  posizioneX1 = 0;
  posizioneY1 = 0;
  dimensioneX1 = 250;
  dimensioneY1 = 250;
  posizioneX2 = 400;
  posizioneY2 = 400;
  dimensioneX2 = 200;
  dimensioneY2 = 200;
  size(800, 800);
}

void draw()
{  
  posiziona();
  disegna();
  flag = collisioneCorner(posizioneX1, posizioneY1, dimensioneX1, dimensioneY1, posizioneX2, posizioneY2, dimensioneX2, dimensioneY2);
  println(flag);
}
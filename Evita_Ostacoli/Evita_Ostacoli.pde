float v;   //velocità
float y;   //ofset y dello sfondo
int m;  //millisecondi
int dist;   //distanza percorsa
int dimfx, dimfy;  //dimensioni della finestra
int px,py;  //posizioni giocatore
int dimx, dimy;  //dimensioni giocatore
int pxo [] = new int[10];  //posizione x ostacoli
int pyo []  =new int[10];  //posizione y ostacoli

void setup()
{
   dimfx=600;
   dimfy=900;
   size(dimfx,dimfy);
   v=1;
   dist=0; 
   y=0;
   dimx=50;
   dimy=80;
   px=dimfx/2-dimx/2;
   py=dimfy-dimy;
}

void draw()
{
   background(40);
   if(keyPressed==true)
   {
      if(key=='a'  && px>0)
      {
         px-=5;
      }
      if(key=='d' && px+dimx<dimfx)
      {
         px+=5;
      }
   }
   m=millis();
   dist+=v*m/10000;
   y+=v;
   noStroke();
   fill(255);
   rect(dimfx/2-5,-320+y,10,80);
   rect(dimfx/2-5,-160+y,10,80);
   rect(dimfx/2-5,0+y,10,80);
   rect(dimfx/2-5,160+y,10,80);
   rect(dimfx/2-5,320+y,10,80);
   rect(dimfx/2-5,480+y,10,80);
   rect(dimfx/2-5,640+y,10,80);
   rect(dimfx/2-5,800+y,10,80);
   if(y>320)
   {
     y=0;
   }
   
   stroke(0);
   fill(0,100,200);
   rect(px,py,dimx,dimy);
   println("distanza:",dist);
}


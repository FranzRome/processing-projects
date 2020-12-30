int dimfx, dimfy;  //dimensioni finestra
int dimrx, dimry;
float vx, vy, vmax;
float px, py;
int r=255,g=0,b=0;  //rosso verde blu
int x=0;   //passi
int var=5;  //variazione del colore

void setup()
{
   dimfx=800;
   dimfy=800;
   px=dimfx/2;
   py=dimfy/2;
   vx=0;
   vy=0;
   vmax=30;
   dimrx=50;
   dimry=50;
   size(dimfx,dimfy);
}

void draw()
{
 
   if(px>dimfx)
   {
      px=0; 
   }
   if(px<0)
   {
      px=dimfx;
   }
   if(py>dimfy)
   {
      py=0; 
   }
   if(py<0)
   {
      py=dimfy;
   }
  
   if(vx>0.6  || vx<-0.6)
   {
      px+=vx;
   }
   if(vy>0.6 || vy<-0.6)
   {
   py+=vy;
   }
   
   //controllo pressione dei tasti
   if(keyPressed==true)
   {
      if(key=='w'  && vy>-vmax)
      {
         vy-=0.6;
      }
      if(key=='a' && vx>-vmax)
      {
         vx-=0.6;
      }
      if(key=='s' && vy<vmax)
      {
         vy+=0.6;
      }
      if(key=='d' && vx<vmax)
      {
         vx+=0.6;
      }   
   }
   
     if(vy<0)
     {
        vy+=0.4;
     }
     if(vx<0)
     {
        vx+=0.4;
     }
     if(vy>0)
     {
        vy-=0.4;
     }
     if(vx>0)
     {
        vx-=0.4;
     }
     //vengono cambiati i colori in modo graduale
   if(x>=1530)
   {
      x=0;
      r=255;
      g=0;
      b=0;
   }
   if(x>=0 && x<=255)
   {
      g+=var; 
   }
   if(x>=256 && x<=510)
   {
      r-=var;
   }
   if(x>=511 && x<=765)
   {
      b+=var; 
   }
   if(x>=766 && x<=1020)
   {
      g-=var; 
   }
   if(x>=1021 && x<=1275)
   {
      r+=var;
   }
   if(x>=1276 && x<=1530)
   {
      b-=var; 
   }
   x+=var;
   
   background(125);
   fill(r, g, b);
  rect(px,py,dimrx,dimry);
   
   println("px:", px, "py:", py,"vx:" , vx, "vy:",vy);
}

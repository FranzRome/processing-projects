int dimfx =1000, dimfy=800;  //dimensioni finestra
int dimrx, dimry;  //fimensioni rettangolo
float vx, vy, vmax;  //velocità rettangolo
float acc, dec;  //accelerazione e decelerazione
float px, py;  //posizioni rettangolo
int dir, precDir;  //direzione e direzione precedente
int c;  //contatore che tiene conto di quando deve cambiare direzione
int min, max;  //valore minimo e massimo di c
int r=255,g=0,b=0;  //rosso verde blu
int x=0;   //passi
int var;  //variazione del colore

void setup()
{
   dimfx=1000;
   dimfy=800;
   px=dimfx/2;
   py=dimfy/2;
   dimrx=60;
   dimry=60;
   vx=0;
   vy=0;
   acc=4.3;
   dec=2.7;
   vmax=20;
   c = 0;
   min=20;
   max=40;
   precDir = 0;
   var=5;
   frameRate(60);
   strokeWeight(3);
}

void settings()
{ 
   size(dimfx,dimfy);
}

void draw()
{
  /*
      dir = 0; // SU
      dir = 1; // Sx
      dir = 2; // Giu'
      dir = 3; //  Dx
   */   
     
      //viene cambiata la direzione a caso
      if(c <= 0)
      {
        dir = int(random(0,4));
        while (dir%2 == precDir) // impedise che la nuova direzione sia UGUALE o OPPOSTA alla precedente
        //while ( abs(dir - precDir) == 2)  // impedise che la nuova direzione sia OPPOSTA alla precedente
        {
           dir = int(random(0,4));
        }
        
        precDir = dir;
        c = int(random(min,max));
      } else
        c--;
      
      
      //viene aumentata la velocità in base all'accelerazione
      if(dir == 0  && vy>-vmax) {
         vy-=acc;
      }
      if(dir == 1 && vx>-vmax)
      {
         vx-=acc;
      }
      if(dir == 2 && vy<vmax)
      {
         vy+=acc;
      }
      if(dir == 3 && vx<vmax)
      {
         vx+=acc;
      }   

     //decelerazione costante
     if(vy<0)
     {
        vy+=dec;
     }
     if(vx<0)
     {
        vx+=dec;
     }
     if(vy>0)
     {
        vy-=dec;
     }
     if(vx>0)
     {
        vx-=dec;
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
   
   //se il rettangolo tocca un bordo appare dalla parte opposta
   if(px<0)
   {
      px=dimfx;
   }
    if(py<0)
   {
      py=dimfy;
   }
   
   //la posizione viene cambiata in base alla velocità
   if(vx>0.6  || vx<-0.6)
   {
      px+=vx;
   }
   if(vy>0.6 || vy<-0.6)
   {
   py+=vy;
   }
   
   //se il rettangolo tocca un bordo appare dalla parte opposta
    if(px>dimfx)
   {
      px=0; 
   }
   if(py>dimfy)
   {
      py=0; 
   }
  
   
  fill(r, g, b);
  rect(px,py,dimrx,dimry);
   
  println("px:", px, "py:", py,"vx:" , vx, "vy:",vy, "dir:",dir,"precDir:", precDir);
}
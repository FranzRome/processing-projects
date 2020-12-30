int x=0;  //passi sull'asse x
int y=0;  //passi per variazione del colore
int r,g,b;
int var=5;  //velocità variazione colore
int dimx=1000, dimy=400;  //dimensioni della finestra
float amp=100;  //ampiezza sinusoide
float freq=6;  //frequenza sinusoide

void settings()
{
  size(dimx,dimy);
}  
  

void draw()
{
   background(170);
   x=0;
   while(x<dimx)
   {
      //point(x,200+amp*sin(freq*x*3.14));
      stroke(r,g,b);
      line(x,0,x,(200+amp*sin(freq*x*3.14)));
      //point(x,200+200*-1*cos(x*10));
      x++;
   }
   
   if(y>=1530)
   {
      y=0;
      r=255;
      g=0;
      b=0;
   }
   if(y>=0 && y<=255)
   {
      g+=var; 
   }
   if(y>=256 && y<=510)
   {
      r-=var;
   }
   if(y>=511 && y<=765)
   {
      b+=var; 
   }
   if(y>=766 && y<=1020)
   {
      g-=var; 
   }
   if(y>=1021 && y<=1275)
   {
      r+=var;
   }
   if(y>=1276 && y<=1530)
   {
      b-=var; 
   }
   y+=var;

   //controllo sui tasti premuti
   if(keyPressed)
   {
      if (amp<200 && key == 'w')
      { 
         amp++;
      }
      if (amp>0 && key == 's')
      { 
         amp--;
      }
      if (freq<80 && key == 'd')
      { 
         freq+=2;
      }
      if (freq>0 && key == 'a')
      { 
      freq-=2;
      }
 }
  println("ampiezza: "+amp*2+" frequenza: "+freq, "y:",y,"r:",r,"g:",g,"b:",b);
}
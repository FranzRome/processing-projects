int r=255,g=0,b=0;  //rosso verde blu
int x=0;   //passi
int dx=40,dy=40;  //dimensione di ogni cella
int i=24, c=32;  //righe e colonne
int var=5;  //variazione del colore

void setup()
{
  frameRate(40);
  size(dx*c,dy*i);
}

void draw()
{
   //vengono disegnate le celle colorate
   for(i=0;i<dy;i++)
   { 
      for(c=0;c<dx;c++)
      {
         fill(r,g,b);
         rect(c*dx,i*dy,dx,dy);
      }
   }
   
   //vengono cambiati i colori in modo graduale
   if(x>=1530)
   {
      x=0;
      r=255;
      g=0;
      b=0;
      var+=5;
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
   println("x:",x,"r:",r,"g:",g,"b:",b);
}

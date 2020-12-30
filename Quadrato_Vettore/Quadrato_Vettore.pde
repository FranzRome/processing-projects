int px, py;
int dimrx, dimry;
int nrect=100;
int [] prx= new int[nrect];  //posizioni x dei rettangoli
int [] pry= new int[nrect];  //posizioni x dei rettangoli
float [] vx= new float[nrect];  //velocità x dei rettangoli 
float [] vy= new float[nrect];  //velocità y dei rettangoli
boolean [] collisione= new boolean[nrect];
int pmx, pmy;  //posizioni del mouse
int dimfx, dimfy;
int i;
int r=255,g=0,b=0;
int x=0;
int var=1;

void settings()
{
   dimfx=800;
   dimfy=600;
   size(dimfx, dimfy);
   dimrx= 30;
   dimry= 30;
   
   for(i=0; i<nrect; i++)
   {
      prx[i]= int(random(0, dimfx-dimrx));
      pry[i]= int(random(0, dimfy-dimry));
   }
   
   for(i=0; i<nrect; i++)
   {
      collisione[i]= false;
   }
}

void draw()
{
  fill(255,55);
  rect(0,0,dimfx,dimfy);
  pmx= pmouseX;
  pmy= pmouseY;
  
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
  
  for(i=0; i<nrect; i++)
  {
     if(pmouseX>prx[i] && pmouseX<prx[i]+dimrx && pmouseY>pry[i] && pmouseY<pry[i]+dimry)
     {
        vx[i]= random(-10,10);
        vy[i]= random(-10,10);
     }
      
     if(prx[i]<0 || prx[i]+dimrx>dimfx)
     {
        vx[i]=vx[i]*-1;
     }
     if(pry[i]<0 || pry[i]+dimry>dimfy)
     {
        vy[i]=vy[i]*-1;
     }
     
     prx[i]+= vx[i];
     pry[i]+= vy[i];
     
     fill(r,g,b);
     rect(prx[i], pry[i], dimrx, dimry);
  }
   println("x:",x,"r",r,"g:",g,"b:",b);
}
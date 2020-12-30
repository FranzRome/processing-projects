float x=0;
int dimx=1000;
int amp=100;
int freq=6;

void setup()
{
  size(dimx,400);
}  
  

void draw()
{
background(250);
x=0;
while(x<dimx)
{
 point(x,200+amp*sin(freq*x*3.14));
 //point(x,200+200*-1*cos(x*10));
 x++;

}

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
  if (freq<20 && key == 'd')
  { 

    freq+=2;
  }
  if (freq>0 && key == 'a')
  { 

    freq-=2;
  }
  println("ampiezza: "+amp*2+" frequenza: "+freq);
 }  
}



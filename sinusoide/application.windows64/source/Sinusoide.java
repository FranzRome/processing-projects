import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Sinusoide extends PApplet {

float x=0;
int dimx=1000;
int amp=100;
int freq=6;

public void setup()
{
  size(dimx,400);
}  
  

public void draw()
{
background(250);
x=0;
while(x<dimx)
{
 point(x,200+amp*sin(freq*x*3.14f));
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


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Sinusoide" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

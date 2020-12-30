int r=255,g,b,spessore;

void setup(){
  size(800,800);
  rectMode(CENTER);
}

void draw(){
  //background(120);
  if(keyPressed){
    if(key=='z'){
      r=255;
      g=0;
      b=0;
    }
    if(key=='x'){
      r=0;
      g=255;
      b=0;
    }
    if(key=='c'){
      r=0;
      g=0;
      b=255;
    }
    if(key=='q'){
      spessore++;
      strokeWeight(spessore);
    }
    if(key=='a' && spessore>1){
      spessore--;
      strokeWeight(spessore);
    }
  }
  
  stroke(r,g,b);
  line(mouseX,mouseY,pmouseX,pmouseY);
  //rect(mouseX,mouseY,50,100);
}
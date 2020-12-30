int min = 100000;
int max = 999999;
int number;
float changeTime = 2;
float timer = changeTime;
String answer = "";
boolean waitingAnswer;

void settings(){
  //fullScreen();
  size(600,600);
}

void setup(){
  textSize(48);
  fill(0,0,0);
  stroke(0,0,0);
  strokeWeight(3);
  textAlign(CENTER,CENTER);
}

void draw(){
  //time update
  Time.update(millis());
  println(Time.deltaTime + "  " + Time.time + "  " + timer + "  " + waitingAnswer + "  " + answer + "  " + number);
  
  //timer decrase
  timer -= Time.deltaTime;
  
  //timer control
  if(timer <= 0){
    background(0,150,255);
    waitingAnswer=true;
    }
    if(waitingAnswer == false){
    line(width/2, 0, width/2, height);
    text(number, width/2, height/2);
  }
}

void keyPressed() {
  if(keyCode == ESC){
    System.exit(0);
  }else if(waitingAnswer){
    answer += key;
    if(answer.length() == 6){
      if(answer == "" + number){
        background(0,255,0);
        try{
        Thread.sleep(2000);
        }
        catch(Exception e){
          
        }
      }
      
      answer = "";
      waitingAnswer = false;
      number = round(random(min,max));  //new number
      timer = changeTime;  //timer reset
    }
  }
}
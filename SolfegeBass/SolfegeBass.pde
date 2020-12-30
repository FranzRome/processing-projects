// CONSTS
// List of possible answers
final String[] ANSWERS = {/*"mi", "fa",*/ "sol", "la", "si", "do", "re", "mi", "fa", "sol", "la", "si", "do" , "re", "mi", "fa", "sol", "la", "si", "do"};
//final String[][] HINTS = {{"A => C4", "S => D4", "D => E4", "F => F4", "G => G4", "H => A4", "J => B4"}
final float MIN_ANSWER_TIME = 2.0f;
final float MAX_ANSWER_TIME = 10f;
final float MIN_WAIT_TIME = 0.4f;
final float MAX_WAIT_TIME = 1.0f;
final int FIRST_NOTE_OFFSET = 11;
final int PENTAGRAM_LOWER_LIMIT = 6;
final int PENTAGRAM_UPPER_LIMIT = 14;

// Number associated to the question to the answer
int questionNumber;
// Number associated with the previous question to the answer
int pQuestionquestionNumber;
// Time limit to answer a question
float answerTime;
float answerTimer;
float answerTimeDecrease;
float answerTimeIncrease;
// Time delay between one question and another
float waitTime;
float waitTimer;
float waitTimeDecrease;
float waitTimeIncrease;
// Answer of the player
String myAnswer;
// Stats
int correctCount;
int wrongCount;
float correctPercentage;
// Flags
//boolean isKeyReleased;
boolean isPaused;
// Font
PFont font;
// Colors
color normalColor;
color correctColor;
color wrongColor;
color bgColor;
color pentagramColor;
color noteColor;
// Color lerp
color colorA;
color colorB;
float colorLerpTime;
float colorLerpTimer;
// Pentagram parameters
PVector pentagramPosition;
float pentagramLength;
float pentagramSeparation;
float pentagramThickness;
// Images
PImage bass;

void settings() {
  // Set window size
  fullScreen();
  //size(800, 450);
  //size(450, 800);
}

void setup() {
  // Initialize environment vars
  frameRate(30);
  strokeWeight(3);
  stroke(50);
  noFill();
  
  // Initialize internal vars
  questionNumber = 0;
  pQuestionquestionNumber = 0;
  answerTime = MAX_ANSWER_TIME;
  answerTimer = answerTime;
  answerTimeDecrease = 0.125f;
  answerTimeIncrease = 0.2f;
  waitTime = MAX_WAIT_TIME;
  waitTimeDecrease = 0.1f;
  waitTimeIncrease = 0.1f;
  waitTimer = 0f;
  myAnswer = "";
  isPaused = true;
  normalColor = color(0, 140, 210);
  correctColor = color(0, 180, 0);
  wrongColor = color(170, 0, 0);
  bgColor = normalColor;
  pentagramColor = color(50, 50, 50);
  noteColor = color(70,70,70);
  colorLerpTime = 0.25f;
  colorLerpTimer = colorLerpTime;
  
  // Font setup
  font = createFont("Verdana", 30);
  
  // Pentagram setup
  pentagramPosition = new PVector(width/2, height/2);
  pentagramLength = width/1.6;
  pentagramSeparation = height/50;
  pentagramThickness = height/350;
  // Image setup
  imageMode(CENTER);
  bass = loadImage("ChiaveBasso.png");
  // Initialize Time class
  Time.setup();
}

void draw() {
  Time.update(millis());

  float deltaTime = Time.deltaTime;
  if (!isPaused) {
    if (waitTimer > 0f) {
      waitTimer -= deltaTime;
      if (waitTimer <= 0) {
        waitTimer = 0f;
        generateQuestion();
        resetAnswerTimer();
        resetColorLerpTimer(bgColor, normalColor);
      }
    } else if (answerTimer > 0f) {
      answerTimer -= deltaTime;
      if (answerTimer <= 0) {
        answerTimer = 0f;
        checkAnswer();
        resetWaitTimer();
      }
    }
    // Color lerp update
    if (colorLerpTimer < colorLerpTime) {
      colorLerpTimer += deltaTime;
      if (colorLerpTimer > colorLerpTime) {
        colorLerpTimer = colorLerpTime;
      }

      float uv = colorLerpTimer / colorLerpTime;
      float r = lerp(red(colorA), red(colorB), uv);
      float g =  lerp(green(colorA), green(colorB), uv);
      float b =  lerp(blue(colorA), blue(colorB), uv);
      
      bgColor = color(round(r),round(g),round(b));
    }
    //println(colorLerpTimer);
  }

  graphicRender();
}

void keyTyped() {
  if (!isPaused && /*isKeyReleased &&*/ waitTimer <= 0)
  {
    //println("Pressed " + (int)key);
    if (key == 10)  // Enter
    {
      checkAnswer();
    } else if (key == 8)  // Backspace
    {
      // Erase the last typed character
      if (myAnswer.length() > 0)myAnswer = myAnswer.substring(0, myAnswer.length()-1);
    } else // Any other key
    {
      // Add the pressed key to the answer string
      myAnswer = myAnswer + key;
    }
  }
  if (key == 32)  // Spacebar
  {
    if(isPaused){
    isPaused = false;
    generateQuestion();
    }
    else {
     isPaused = true;
    }
  }
}

void init() {
  
}

void generateQuestion() {
  questionNumber = (int)random(0, ANSWERS.length);
  //println(questionNumber + "  " + ANSWERS[questionNumber]);
  if (questionNumber == pQuestionquestionNumber)
  {
    generateQuestion();
  }
  pQuestionquestionNumber = questionNumber;

  myAnswer = "";
  //bgColor = normalColor;
}

void checkAnswer() {
  String correctAnswer = ANSWERS[questionNumber];
  //println(correctAnswer);
  
  if (myAnswer.trim().toLowerCase().equals(correctAnswer.trim()))
  {
    updateStats(true);
    myAnswer = "Correct ^.^";
    decreaseWaitTime();
    decreaseAnswerTime();
    resetColorLerpTimer(bgColor, correctColor);
  } else
  {
    updateStats(false);
    myAnswer = "Wrong *_*, " + ANSWERS[questionNumber];
    increaseWaitTime();
    increaseAnswerTime();
    resetColorLerpTimer(bgColor, wrongColor);
  } 

  resetWaitTimer();
  resetAnswerTimer();
}

void updateStats(boolean isCorrect)
{
  if (isCorrect) {
    correctCount++;
  } else {
    wrongCount++;
  }

  correctPercentage= (100*(float)correctCount/(correctCount + wrongCount));
}

void decreaseWaitTime() {
  waitTime -= waitTimeDecrease;

  if (waitTime < MIN_WAIT_TIME)
  {
    waitTime = MIN_WAIT_TIME;
  }
}

void increaseWaitTime() {
  waitTime += waitTimeIncrease;

  if (waitTime > MAX_WAIT_TIME)
  {
    waitTime = MAX_WAIT_TIME;
  }
}

void decreaseAnswerTime() {
  answerTime -= answerTimeDecrease;

  if (answerTime < MIN_WAIT_TIME)
  {
    answerTime = MIN_WAIT_TIME;
  }
}

void increaseAnswerTime() {
  answerTime += answerTimeIncrease;

  if (answerTime > MAX_ANSWER_TIME)
  {
    answerTime = MAX_ANSWER_TIME;
  }
}

void resetAnswerTimer() {
  answerTimer = answerTime;
}

void resetWaitTimer() {
  waitTimer = waitTime;
}

void resetColorLerpTimer(color a, color b) {
  colorA = a;
  colorB = b;
  colorLerpTimer = 0;
}

void graphicRender() {
  // Set background color
  background(bgColor);

  // Draw stats
  textFont(font, width/40);
  textAlign(CENTER);
  text("Correct: " + correctCount, width/4, height/12);
  text("Wrong: " + wrongCount, width/2, height/12);
  text("Percent: " + roundDecimals(correctPercentage, 2) + "%", width/1.25, height/12);

  // Draw Question and answer
  textFont(font, width/20);
  //text(questionNumber + 1, width/2, height/3);
  text("Your answer:", width/2, height/1.5);
  PVector notePosition = new PVector(pentagramPosition.x,
                                     pentagramPosition.y + ((FIRST_NOTE_OFFSET - questionNumber) * pentagramSeparation/2));
  
  // Draw pentagram
  pentagram(pentagramPosition, pentagramLength, pentagramSeparation, pentagramThickness, pentagramColor);
  // Draw additional lines
  if(questionNumber < PENTAGRAM_LOWER_LIMIT || questionNumber > PENTAGRAM_UPPER_LIMIT) {
    additionalLines(pentagramPosition, notePosition, pentagramSeparation, 100, pentagramThickness, pentagramColor);
  }
  
  // Draw note
  note(notePosition,
       pentagramSeparation/1.5,
       pentagramThickness,
       pentagramColor,
       noteColor);
  if (isPaused)text("Press 'Space' to start!", width/2, height/1.33);
  else text(myAnswer, width/2, height/1.33);
  line(width/4, height/1.28, width - width/4, height/1.28);

  // Draw timers
  textFont(font, width/60);
  textAlign(LEFT);
  text("Answer time: " + roundDecimals(answerTime, 1), width/4, height/1.1);
  text("Answer timer: " + roundDecimals(answerTimer, 1), width/4, height/1.05);
  text("Wait time: " + roundDecimals(waitTime, 1), width/1.7, height/1.1);
  text("Wait timer: " + roundDecimals(waitTimer, 1), width/1.7, height/1.05);
}

void pentagram(PVector position, float length, float separation, float thickness, color c) {
  stroke(c);
  strokeWeight(thickness);
  line(position.x - length/2, position.y - separation*2, position.x + length/2, position.y - separation*2);
  line(position.x - length/2, position.y - separation, position.x + length/2, position.y - separation);
  line(position.x - length/2, position.y, position.x + length/2, position.y);
  line(position.x - length/2, position.y + separation, position.x + length/2, position.y + separation);
  line(position.x - length/2, position.y + separation*2, position.x + length/2, position.y + separation*2);
  image(bass, position.x - length/2, position.y, width/26, height/12);
}

void additionalLines(PVector startPosition, PVector finalPosition , float separation, float length, float thickness, color c) {
  stroke(c);
  strokeWeight(thickness);
  float distance = finalPosition.y - startPosition.y;
  float absDistance = abs(distance);
  int i = 0;
  while(i <= absDistance)
  {
    float pY = startPosition.y + i * (distance/absDistance);
    i+= separation;
    line(startPosition.x - length/2, pY, startPosition.x + length/2, pY);
  }
}

void note(PVector position, float diameter, float thickness, /*boolean even,*/ color lineC, color noteC) {
  stroke(noteC);
  strokeWeight(thickness);
  ellipse(position.x, position.y, diameter, diameter);
  /*if(!even){
    stroke(lineC);
    line(pX - diameter * 1.2, pY, pX + diameter * 1.2, pY);
  }*/
}

float roundDecimals(float f, int dec)
{
  return Math.round(f*pow(10, dec))/pow(10, dec);
}
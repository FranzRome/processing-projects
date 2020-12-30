import java.util.*;

// Array of possible answers
final String[] ANSWERS = {
                           /*1-10*/"the", "noe","amo", "re", "leo", "ciao", "oca", "ufo", "boa", "tazza",
                           /*11-20*/"tetti", "donna", "dama", "toro", "tela", "doccia", "tacco", "tuffo", "topo", "naso",
                           /*21-30*/"nido", "nonno", "gnomo", "nero", "anello", "noce", "nuca", "nave", "nube", "mazza",
                           /*31-40*/"moto", "mano", "mamma", "muro", "mela", "micio", "mucca", "muffa", "mappa", "rosa",
                           /*41-50*/"rete", "rana", "ramo", "orrore", "rullo", "roccia", "orca", "riva", "arpa", "lessi",
                           /*51-60*/"letto", "luna", "lama", "lara", "lilli", "laccio", "lacca", "lava", "lupo", "gesso",
                           /*61-70*/"citta", "cena", "cima", "cero", "uccello", "ciuccio", "giacca", "ciuffo", "cip", "casa",
                           /*71-80*/"chiodo", "cono", "gomma", "carro", "cuccia", "colla", "cocco", "chiave", "coppa", "vaso"      
                         };
// List of committed errors
List<Integer> errors;
// Number associated with the question to the answer
int questionNumber;
// Number associated with the previous question to the answer
int pQuestionquestionNumber;
// Time limit to answer a question
float answerTime;
float answerTimer;
final float MIN_ANSWER_TIME = 2.0f;
final float MAX_ANSWER_TIME = 8f;
float answerTimeDecrease;
float answerTimeIncrease;
// Time delay between one question and another
float waitTime;
float waitTimer;
final float MIN_WAIT_TIME = 1.5f;
final float MAX_WAIT_TIME = 2.5f;
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
// Color lerp
color colorA;
color colorB;
float colorLerpTime;
float colorLerpTimer;

void settings() {
  // Set window size
  fullScreen();
  //size(800, 450);
  //size(450, 800);
}

void setup() {
  // Initialize internal vars
  errors = new ArrayList<Integer>();
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
  //isKeyReleased=true;
  isPaused = true;
  normalColor = color(0, 140, 210);
  correctColor = color(0, 180, 0);
  wrongColor = color(170, 0, 0);
  bgColor = normalColor;
  colorLerpTime = 0.25f;
  colorLerpTimer = colorLerpTime;
  
  //int seed = year() + month() + day() + hour() + minute() + second();
  // Initialize environment vars
  //randomSeed(seed);
  frameRate(30);
  strokeWeight(3);
  stroke(50);
  //printArray(PFont.list());
  font = createFont("Verdana", 30);

  // Initialize Time class
  Time.setup();
  // Generate first question
  //generateQuestion();
}

void draw() {
  Time.update(millis());

  float deltaTime = Time.deltaTime;
  if (!isPaused)
  {
    if (waitTimer > 0f)
    {
      waitTimer -= deltaTime;
      if (waitTimer <= 0)
      {
        waitTimer = 0f;
        generateQuestion();
        resetAnswerTimer();
        resetColorLerpTimer(bgColor, normalColor);
      }
    } else if (answerTimer > 0f)
    {
      answerTimer -= deltaTime;
      if (answerTimer <= 0)
      {
        answerTimer = 0f;
        checkAnswer();
        resetWaitTimer();
      }
    }
    // Color lerp update
    if (colorLerpTimer < colorLerpTime)
    {
      colorLerpTimer += deltaTime;
      if (colorLerpTimer > colorLerpTime)
      {
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
  if (key == 32 && isPaused)  // Spacebar
  {
    isPaused = false;
    generateQuestion();
  }
}

void generateQuestion() {
  questionNumber = (int)random(0, ANSWERS.length);
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
  println(correctAnswer);
  
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

// Adds the error's index
void addError(int error) {
    if(errors.contains(error)) {
      return;
    }
  else {
    errors.add(error);
  }
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
  textFont(font, width/16);
  text(questionNumber + 1, width/2, height/3);
  text("Your answer:", width/2, height/1.75);
  if (isPaused)text("Press 'Space' to start!", width/2, height/1.33);
  text(myAnswer, width/2, height/1.33);
  line(width/4, height/1.28, width - width/4, height/1.28);

  // Draw timers
  textFont(font, width/60);
  textAlign(LEFT);
  text("Answer time: " + roundDecimals(answerTime, 1), width/4, height/1.1);
  text("Answer timer: " + roundDecimals(answerTimer, 1), width/4, height/1.05);
  text("Wait time: " + roundDecimals(waitTime, 1), width/1.7, height/1.1);
  text("Wait timer: " + roundDecimals(waitTimer, 1), width/1.7, height/1.05);
}

float roundDecimals(float f, int dec)
{
  return Math.round(f*pow(10, dec))/pow(10, dec);
}
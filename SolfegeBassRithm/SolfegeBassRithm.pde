import processing.sound.*;

// CONSTS
// List of possible answers
final String[] ANSWERS = {/*"mi", "fa",*/ "sol", "la", "si", "do", "re", "mi", "fa", "sol", "la", "si", "do" , "re", "mi", "fa", "sol", "la", "si", "do"};
final String HINTS = "A --> Si2\n" +
                     "S --> Do3\n" +
                     "D --> Re3\n" +
                     "F --> Mi3\n" +
                     "G --> Fa3\n" +
                     " H --> Sol3\n" +
                     "J --> La3\n" +
                     "K --> Si3\n" +
                     "L --> Do4";
final float MIN_ANSWER_TIME = 2.0f;
final float MAX_ANSWER_TIME = 10f;
final float MIN_WAIT_TIME = 0.4f;
final float MAX_WAIT_TIME = 1.0f;
final int FIRST_NOTE_OFFSET = 11;
final int PENTAGRAM_LOWER_LIMIT = 6;
final int PENTAGRAM_UPPER_LIMIT = 14;
final int BPM  = 60;
final float TIMINGERRORPERCENT = 0.5;

//Notes
Note[][] notes;
// Notes index
int notesGroupIndex;
int noteIndex;
// Timing
float noteTiming;
float timing;
// Answer of the player
Tone myAnswer;
// Answer of the program
String answer;
// Stats
int correctCount;
int wrongCount;
float correctPercentage;
float timingAccuracy;
// Flags
boolean firstNote;
boolean isPaused;
// Font
PFont font;
// Colors
color normalColor;
color correctColor;
color wrongColor;
color bgColor;
color noteColor;
// Color lerp
color colorA;
color colorB;
float colorLerpTime;
float colorLerpTimer;

Pentagram pentagram;

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
  
  notes = new Note[][] {{new Note(Tone.DO3, RithmFigure.SEMIBREVE), new Note(Tone.RE3, RithmFigure.SEMIMINIMA), new Note(Tone.MI3, RithmFigure.SEMIMINIMA), new Note(Tone.FA3, RithmFigure.SEMIMINIMA)},
                        {new Note(Tone.DO3, RithmFigure.SEMIMINIMA), new Note(Tone.DO3, RithmFigure.MINIMA), new Note(Tone.DO3, RithmFigure.SEMIMINIMA)}};
  notesGroupIndex = 0;
  noteIndex = 0;
  noteTiming = noteTiming();
  
  // Initialize internal vars
  answer = "";
  isPaused = true;
  normalColor = color(0, 140, 210);
  correctColor = color(0, 180, 0);
  wrongColor = color(170, 0, 0);
  bgColor = normalColor;
  noteColor = color(70,70,70);
  colorLerpTime = 0.25f;
  colorLerpTimer = colorLerpTime;
  
  // Font setup
  font = createFont("Verdana", 30);
  
  // Pentagram setup
  pentagram = new Pentagram(new PVector(width/2, height/2), width/1.6, height/50, height/350, color(50, 50, 50));
  
  // Image setup
  imageMode(CENTER);
  // Initialize Time class
  Time.setup();
}

void draw() {
  Time.update(millis());

  float deltaTime = Time.deltaTime;
  float maxTiming = maxTiming();
  if (!isPaused) {
    if (timing < maxTiming) {
      timing += deltaTime;
      if (timing >= maxTiming) {
        timing = 0f;
        checkAnswer();
        nextNote();
        resetColorLerpTimer(bgColor, normalColor);
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
  }

  graphicRender();
}

void keyTyped() {
   if (key == 32)  // Spacebar
  {
    if(isPaused){
    isPaused = false;
    //generateQuestion();
    }
    else {
     isPaused = true;
    }
  }
  else if (!isPaused) {
    if (key == 'a') {
      myAnswer = Tone.SI2;
    }
    else if (key == 's') {
      myAnswer = Tone.DO3;
    }
    else if (key == 'd') {
      myAnswer = Tone.RE3;
    }
    else if (key == 'f') {
      myAnswer = Tone.MI3;
    }
    else if (key == 'g') {
      myAnswer = Tone.FA3;
    }
    else if (key == 'h') {
      myAnswer = Tone.SOL3;
    }
    else if (key == 'j') {
      myAnswer = Tone.LA3;
    }
      checkAnswer();
  }
}

/*void generateQuestion() {
  questionNumber = (int)random(0, ANSWERS.length);
  //println(questionNumber + "  " + ANSWERS[questionNumber]);
  if (questionNumber == pQuestionquestionNumber)
  {
    generateQuestion();
  }
  pQuestionquestionNumber = questionNumber;

  myAnswer = "";
  //bgColor = normalColor;
}*/

float roundDecimals(float f, int dec)
{
  return Math.round(f*pow(10, dec))/pow(10, dec);
}

float  noteTiming(){
  return noteTiming + notes[notesGroupIndex][noteIndex].rithmFigure.getRithm()*60/BPM;
}

float maxTiming(){
  return noteTiming + noteTiming * TIMINGERRORPERCENT;
}

void checkAnswer() {
  if(myAnswer != null) {
  
    Tone correctAnswer = notes[notesGroupIndex][noteIndex].tone;

    if (myAnswer.equals(correctAnswer) && timing >= noteTiming - noteTiming*TIMINGERRORPERCENT && timing <= noteTiming + noteTiming*TIMINGERRORPERCENT)
    {
      updateStats(true);
      answer = "Correct ^.^";
      resetColorLerpTimer(bgColor, correctColor);
    } else
    {
      updateStats(false);
      answer = "Wrong *_*, " + correctAnswer.getName();
      resetColorLerpTimer(bgColor, wrongColor);
    } 
  }
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

void nextNote() {
  if(noteIndex < notes[notesGroupIndex].length - 1){
    timing -= notes[notesGroupIndex][noteIndex].rithmFigure.getRithm();
    noteIndex++;
    firstNote = false;
  }
  else if(notesGroupIndex < notes.length - 1)
  {
    notesGroupIndex++;
    noteIndex = 0;
    timing = 0;
    firstNote = true;
  }
  else{
    notesGroupIndex= 0;
    noteIndex = 0;
    timing = 0;
    firstNote = true;
  }
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
  String t = myAnswer!=null ? myAnswer.getName(): "";
  text(t, width/2, height/8);
  //text(questionNumber + 1, width/2, height/3);
  text("Your answer:", width/2, height/1.5);
  // Draw pentagram
  pentagram.render();
  // Draw notes
  renderNotes(25);
  renderHints();
  //pentagram.additionalLines(notePosition);
  // Draw additional lines
  /*if(questionNumber < PENTAGRAM_LOWER_LIMIT || questionNumber > PENTAGRAM_UPPER_LIMIT) {
    additionalLines(pentagramPosition, notePosition, pentagramSeparation, 100, pentagramThickness, pentagramColor);
  }*/
  
  // Draw note
  /*note(notePosition,
       pentagramSeparation/1.5,
       pentagramThickness,
       pentagramColor,
       noteColor);*/
  if (isPaused)text("Press 'Space' to start!", width/2, height/1.33);
  else text(answer, width/2, height/1.33);
  line(width/4, height/1.28, width - width/4, height/1.28);

  // Draw timers
  textFont(font, width/60);
  textAlign(LEFT);
  /*text("Answer time: " + roundDecimals(answerTime, 1), width/4, height/1.1);
  text("Answer timer: " + roundDecimals(answerTimer, 1), width/4, height/1.05);
  text("Wait time: " + roundDecimals(waitTime, 1), width/1.7, height/1.1);
  text("Wait timer: " + roundDecimals(waitTimer, 1), width/1.7, height/1.05);*/
}

void renderNotes(int spacing){
  PVector position = new PVector(pentagram.position.x - pentagram.length/2.5,0);
  
  for(int i=0; i < notes[notesGroupIndex].length; i++){
    Note pNote =  notes[notesGroupIndex][i!=0? i-1 : 0];
    Note note =  notes[notesGroupIndex][i];
   position = position.add(new PVector((spacing * note.rithmFigure.getRithm() * i + spacing * note.rithmFigure.getRithm()) , 0));
   position.y =  pentagram.position.y + (note.tone.getId() * pentagram.separation/2);
   note.render(position);
  }
}

void renderHints(){
  textFont(font, width/50);
  text(HINTS, 150, 250);
}

void renderTimingLine(){
  
}
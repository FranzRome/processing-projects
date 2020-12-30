int numeroCelle = 3;
char [][] griglia = new char[numeroCelle][numeroCelle];
int distanzaLinee = 100;
int distanzaBordi = 260;
int dimFinestra = 0;
int turno = 1;
String testoVittoria="";
color coloreVittoria = color(0,0,0);

NeuralNetwork ia;

void settings() {
  dimFinestra = numeroCelle*distanzaLinee+distanzaBordi*2;
  size((int)dimFinestra, (int)dimFinestra);
}

void setup() {
  for(int i=0; i<numeroCelle; i++) {
    for(int j=0; j<numeroCelle; j++) {
      griglia[i][j] = ' ';
    }
  }
  
  int[] layers = {9,6,3};
  
  ia = new NeuralNetwork(layers);
  
  println(ia);
  
  textAlign(CENTER, CENTER);
  textSize(42);
  
  frameRate(60);
}

void draw() {
  // Azione IA
  if(turno == 2){
    muoviIA();
  }
  
  // Settaggi rendering
  background(170,170,170);
  strokeWeight(3);
  stroke(0);
  
  // Disegno griglia
  for(int i=0; i<numeroCelle-1; i++) {
    line(distanzaBordi,(1+i)*distanzaLinee+distanzaBordi, width - distanzaBordi,(1+i)*distanzaLinee+distanzaBordi);
    line((1+i)*distanzaLinee+distanzaBordi, distanzaBordi, (1+i)*distanzaLinee+distanzaBordi, height - distanzaBordi);
  }
  
  // Disegno cerchi e croci
  for(int i=0; i<numeroCelle; i++) {
    for(int j=0; j<numeroCelle; j++) {
      if(griglia[i][j] == 'X')
        croce(j*distanzaLinee+distanzaBordi+distanzaLinee/2, i*distanzaLinee+distanzaBordi+distanzaLinee/2, distanzaLinee-distanzaLinee/6);
        
      if(griglia[i][j] == 'O')
        cerchio(j*distanzaLinee+distanzaBordi+distanzaLinee/2, i*distanzaLinee+distanzaBordi+distanzaLinee/2, distanzaLinee-distanzaLinee/6);  
    }
  }
  
  aiRender(60,50,70);
  
  fill(coloreVittoria);
  text(testoVittoria, width/2, height/2);
  
  // println(mappaGriglia(mouseX, mouseY));
}  // draw()

void mouseClicked() {
  PVector indiciGriglia = mappaGriglia(mouseX, mouseY);
  if(testoVittoria == "") {
    clickGriglia((int)indiciGriglia.x, (int)indiciGriglia.y);
   }
   
   controllaVittoria();
 }


void croce(float x, float y, float diametro) {
  strokeWeight(2);
  stroke(255,0,0);
  line(x-diametro/2, y-diametro/2, x+diametro/2, y+diametro/2);
  line(x+diametro/2, y-diametro/2, x-diametro/2, y+diametro/2);
}  //croce()

void cerchio(float x, float y, float diametro) {
  noFill();
  strokeWeight(2);
  stroke(0,0,255);
  ellipse(x,y,diametro,diametro);
}  //cerchio()

void controllaVittoria() {
  if(griglia[0][0] == 'X' && griglia[1][0] == 'X' && griglia[2][0] == 'X' ||
     griglia[0][1] == 'X' && griglia[1][1] == 'X' && griglia[2][1] == 'X' ||
     griglia[0][2] == 'X' && griglia[1][2] == 'X' && griglia[2][2] == 'X' ||
     griglia[0][0] == 'X' && griglia[0][1] == 'X' && griglia[0][2] == 'X' ||
     griglia[1][0] == 'X' && griglia[1][1] == 'X' && griglia[1][2] == 'X' ||
     griglia[2][0] == 'X' && griglia[2][1] == 'X' && griglia[2][2] == 'X' ||
     griglia[0][0] == 'X' && griglia[1][1] == 'X' && griglia[2][2] == 'X' ||
     griglia[0][2] == 'X' && griglia[1][1] == 'X' && griglia[2][0] == 'X') {
       testoVittoria = "LE CROCI HANNO VINTO!";
       coloreVittoria = color(200,0,0);
     }
     
else if(griglia[0][0] == 'O' && griglia[1][0] == 'O' && griglia[2][0] == 'O' ||
        griglia[0][1] == 'O' && griglia[1][1] == 'O' && griglia[2][1] == 'O' ||
        griglia[0][2] == 'O' && griglia[1][2] == 'O' && griglia[2][2] == 'O' ||
        griglia[0][0] == 'O' && griglia[0][1] == 'O' && griglia[0][2] == 'O' ||
        griglia[1][0] == 'O' && griglia[1][1] == 'O' && griglia[1][2] == 'O' ||
        griglia[2][0] == 'O' && griglia[2][1] == 'O' && griglia[2][2] == 'O' ||
        griglia[0][0] == 'O' && griglia[1][1] == 'O' && griglia[2][2] == 'O' ||
        griglia[0][2] == 'O' && griglia[1][1] == 'O' && griglia[2][0] == 'O') {
          testoVittoria = "I CERCHI HANNO VINTO!";
          coloreVittoria = color(0,0,200);
     }
else if(griglia[0][0] != ' ' && griglia[0][1] != ' ' && griglia[0][2] != ' ' &&
        griglia[1][0] != ' ' && griglia[1][1] != ' ' && griglia[1][2] != ' ' &&
        griglia[2][0] != ' ' && griglia[2][1] != ' ' && griglia[2][2] != ' ' ) {
          testoVittoria = "NESSUNO HA VINTO";
          coloreVittoria = color(230,230,230);
        }
} //controllaVittoria()

PVector mappaGriglia(float x, float y){
  /*
   * In result vector x is row index
   * and y is column index
   */
  PVector result = new PVector((round(y) - distanzaBordi) / distanzaLinee,
                           (round(x) - distanzaBordi)/ distanzaLinee);
  result.x = constrain(result.x, 0, griglia.length - 1);
  result.y = constrain(result.y, 0, griglia[0].length - 1);
  return result;
}

void clickGriglia(int i, int j){
  
  //println("i:" + i + " j:" + j);
  
  if(griglia[i][j] == ' ') {
    if(turno == 1) {
      griglia[i][j] = 'X';
      turno = 2;
    }
    else if(turno == 2) {
      griglia[i][j] = 'O';
      turno = 1;
    }
  }
}

void muoviIA(){
  float[]input = new float[griglia.length * griglia[0].length];
  for(int i=0; i<input.length; i++){
    input[i] = float(griglia[0][0]);
  }
  
  float results[]= ia.feedForward(input);
  //clickGriglia(j*distanzaLinee, i*distanzaLinee);
  
  println("Input layer:");
  for(int i=0; i<input.length; i++){
    print(input[i] + (i != input.length -1 ? "," : "\n"));
  }
  
  println("Muovo IA " + round(results[0]) + "  " + round(results[1]) + "\n");
  
  clickGriglia(round(results[0]), round(results[1]));
  
  //println("Mutazione");
}

void aiRender(int x, int y, int dist){
  noFill();
  stroke(0);
  
  for(int i=0; i<ia.neurons.length; i++) {
    textSize(9);
    textAlign(CENTER);
    text((i==0 ? "Input" : (i < ia.neurons.length - 1 ? "Hidden" :"Output")),
          x - 40,  y + dist*i);
    for(int j=0; j<ia.neurons[i].length; j++) {
      ellipse(x + dist*j, y + dist*i, dist/2, dist/2);
      textSize(12);
      text(ia.neurons[i][j], x + dist*j,  y + dist*i);
    }
  }
  
  strokeWeight(0.3);
  
  for(int i=0; i<ia.layers.length - 1; i++) {
    for(int j=0; j<ia.neurons[i].length; j++) {
      for(int k=0; k<ia.neurons[i + 1].length; k++) {
        float weight = ia.weights[i][j][k];
        int red = round(map(weight, 1, -1, 0, 255));;
        int green = round(map(weight, -1, 1, 0, 255));
        stroke(red, green, 0);
        line(x + dist*j, y + dist*i, x + dist*(k), y + dist*(i+1));
        
      }
    }
  }
      
}

class Nemico {
  float posizioneX, posizioneY;
  float dimensioneX = 60, dimensioneY = 40;
  float angolo;
  float targetX, targetY;
  float distanzaX, distanzaY, distanza, distanzaMin = random(80,1000); 
  float velocita = random(2,5), accelerazione = random(0.01, 0.04);
  
  Collisore collisore = new Collisore(posizioneX-dimensioneX/2, posizioneY-dimensioneY/2, dimensioneX, dimensioneY);
  
  Nemico(float x, float y) {
    posizioneX = x;
    posizioneY = y;
  }//costruttore

  //prende una posizione target e calcola la distanza da esso
  void calcolaTarget() {
    targetX = mouseX;
    targetY = mouseY;
  
    distanzaX = targetX - posizioneX;
    distanzaY = targetY - posizioneY;
    distanza = sqrt(sq(distanzaX)+sq(distanzaY));
  }//calcolaTarget

  //ruota verso la posizione target
  void punta() {
    angolo = atan2(distanzaY,distanzaX);
  }//punta


  /*si avvicina alla posizione target
  con una velocità costante*/
  void seguiA() {
      if(abs(distanza) > distanzaMin) {
      posizioneX += cos(angolo) * velocita;
      }
      if(abs(distanza) > distanzaMin) {
      posizioneY += sin(angolo) * velocita;
      }

 
  }//seguiA
  
  /*si avvicina alla posizione target con velocità 
  direttamente proporzionale alla distanza*/
  void seguiB() {
    if(abs(distanza) > distanzaMin) {
    posizioneX += distanzaX * accelerazione;
    }//if
    if(abs(distanza) > distanzaMin) {
    posizioneY += distanzaY * accelerazione;
    }//if
  }//segui

  //rappresenta l'oggetto
  void disegna() {
    translate(posizioneX, posizioneY);
    rotate(angolo);
    rectMode(CENTER);
    fill(255,0,0);
    rect(0,0,dimensioneX, dimensioneY);
    stroke(0);
    line(0,0,60,0);
    resetMatrix();
  }//disegna
}//Nemico
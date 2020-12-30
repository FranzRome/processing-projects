class Nemico {
  float posizioneX, posizioneY;
  float angolo;
  float targetX, targetY;
  float distanzaX, distanzaY; 
  float accelerazione; 
  
  Nemico(pX, pY) {
    posizioneX = pX;
    posizioneY = pY;
  }//costruttore

  void calcolaTarget() {
    targetX = mouseX;
    targetY = mouseY;
  
    distanzaX = (targetX - posizioneX);
    distanzaY = (targetY - posizioneY);
  }//calcolaTarget

  void punta() {
    angolo = atan(distanzaY/distanzaX);
  }//punta

  void segui() {
    posizioneX += distanzaX*accelerazione;
    posizioneY += distanzaY*accelerazione;
  }//segui

  void disegna() {
    translate(posizioneX, posizioneY);
    rotate(angolo);
    rectMode(CENTER);
    rect(0,0,50,30);
    resetMatrix();
  }//disegna
}//Nemico


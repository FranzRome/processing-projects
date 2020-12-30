class Tempo() {
  float precedente = millis();
  
  //questa funzione va chiamata una volta all'inizio del draw
  float deltaTempo() {
    float tempo=millis();
    float result= (tempo-precedente)/1000;
    precedente = tempo;
    return result;
  }//deltaTempo
}//Tempo

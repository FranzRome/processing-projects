int nCelle = 4;
int distCelle = 6;
int dimCelle = 40;
Cella[] celle = new Cella[nCelle];

void setup(){
  size(nCelle*dimCelle+(nCelle+1)*distCelle, dimCelle+distCelle*2);
  for(int i=0; i<nCelle; i++)
  {
    celle[i] = new Cella(i*dimCelle+(i+1)*distCelle, distCelle, dimCelle, dimCelle, 0);
    celle[i].animazione.setValore(celle[i].pX);
  }
  celle[0].valore = 2;
}

void draw(){
  background(50);
  
  for(int i=0; i<nCelle; i++)
  {
    celle[i].pX = celle[i].animazione.anima();
    celle[i].disegna();
  }
  
  println(celle[1].pX);  
}

void keyPressed(){
  if(key == 'd')
  {
    println("d");
    for(int i=0; i<nCelle-1; i++)
    {
      if(celle[i].valore > 0 && celle[i+1].valore == 0)
      {
        Cella c = new Cella(celle[i].pX,
                            celle[i].pY,
                            celle[i].dX,
                            celle[i].dY,
                            celle[i].valore); 
        celle[i] = celle[i+1];
        celle[i+1] = c;
      } //if
      celle[i].animazione.setta(celle[i].pX, i*dimCelle+(i+1)*distCelle, 1);
    } //for
  } //if
  
  if(key == 'a')
  {
    println("a");
    celle[0].animazione.setta(0, 100, 1);
  }
}

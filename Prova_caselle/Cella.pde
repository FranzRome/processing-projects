class Cella{
  private float pX, pY;  //posizioni
  private float dX, dY;  //dimensioni
  private int valore;  //numero contenuto nella casella
  Animazione animazione = new Animazione();
  
  public Cella(float pX, float pY, float dX, float dY, int valore){
    this.pX = pX;
    this.pY = pY;
    this.dX = dX;
    this.dY = dY;
    this.valore = valore;
  }
  
 public void disegna()
  {
    if(valore>0)
    {
      switch(valore)
      {
       case 2:
        fill(238,228,218);
           break;
               
             case 4:
               fill(237,224,200);
                   break;
            
                 case 8:
                   fill(242,177,121);
                   break;
               
                 case 16:
                   fill(254,149,99);
                   break;
            
                 case 32:
                   fill(246,124,95);
                   break;
               
                 case 64:
                   fill(246,94,59);
                   break;

              }  //switch
                             
              if(valore>=128)
              {
                fill(237,207,114);
              }  //if

      noStroke();
      rect(pX, pY, dX, dY);
    
      if(valore<=4)
      {
        fill(119, 110, 101);
      }  //if
      else
      {
        fill(249, 246, 242);
      }  //else
    textSize(dY/2);
    textAlign(CENTER,CENTER);
    text(valore, pX+dX/2, pY+dY/2);
    }
  }
  
  void setPosizione(int pX, int pY)
  {
    this.pX = pX;
    this.pY = pY;
  }
  
  void setValore(int valore)
  {
    this.valore = valore;
  }
}

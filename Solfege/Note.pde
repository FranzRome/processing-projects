public enum Note {
  DO(1, "Do"), RE(2, "Re"), MI(3, "Mi"), FA(4, "Fa"), SOL(5, "Sol"), LA(6, "La"), SI(7, "Si");
  
  public Note(Tone tone, RithmFigure rithmFigure){
    this.tone = tone;
    this.rithmFigure = rithmFigure;
    image = loadImage(rithmFigure.getImage());
  }
}
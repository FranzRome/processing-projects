public enum RhythmicFigure{
  SEMIBREVE(4, "Semibreve.png"), MINIMA(2, "Minima.png"), SEMIMINIMA(1, "Semiminima.png"), CROMA(0.5, "Croma.png"), BISCROMA(0.25, "Biscroma.png");
  
  private float timeFraction;
  private String imageName;
  private Note note;
  
  private RhythmicFigure(float timeFraction, String imageName){
    this.timeFraction = timeFraction;
    this.imageName = imageName;
    this.note = note;
  }
  
  public float getTimeFraction(){
    return timeFraction;
  }
  
  public String getImageName(){
    return imageName;
  }
  
  
    
  public void render(PVector position){
    translate(0, 0);
    image(imageName, position.x, position.y);
    resetMatrix();
  }
}

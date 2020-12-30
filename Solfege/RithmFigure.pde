public enum RithmFigure{
  SEMIBREVE(4, "Semibreve.png"), MINIMA(2, "Minima.png"), SEMIMINIMA(1, "Semiminima.png"), CROMA(0.5, "Croma.png"), BISCROMA(0.25, "Biscroma.png");
  
  private float timeFraction;
  private String imageName;
  private Note note
  
  private RithmFigure(float rithm, String imageName){
    this.rithm = rithm;
    this.image = image;
    this.verticalOffset = verticalOffset;
  }
  
  public float getRithm(){
    return rithm;
  }
  
  public String getImage(){
    return image;
  }
  
  public int getVerticalOffset(){
    return verticalOffset;
  }
  
    
  public void render(PVector position){
    resetMatrix();
    translate(0, -rithmFigure.getVerticalOffset());
    image(image, position.x, position.y);
    resetMatrix();
  }
}
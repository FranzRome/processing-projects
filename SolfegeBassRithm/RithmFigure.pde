public enum RithmFigure{
  SEMIBREVE(4, "Semibreve.png", 0), MINIMA(2, "Minima.png", 15), SEMIMINIMA(1, "Semiminima.png", 15), CROMA(0.5, "Croma.png", 15);
  
  private float rithm;
  private String image;
  private int verticalOffset;
  
  private RithmFigure(float rithm, String image, int verticalOffset){
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
}
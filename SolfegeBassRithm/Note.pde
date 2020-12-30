public class Note {
  Tone tone;
  RithmFigure rithmFigure;
  PImage image;
  
  public Note(Tone tone, RithmFigure rithmFigure){
    this.tone = tone;
    this.rithmFigure = rithmFigure;
    image = loadImage(rithmFigure.getImage());
  }
  
  public void render(PVector position){
    resetMatrix();
    translate(0, -rithmFigure.getVerticalOffset());
    image(image, position.x, position.y);
    resetMatrix();
  }
}
public class Pentagram {
  PVector position;
  float length;
  float separation;
  float thickness;
  color c;
  PImage bass;
  
  public Pentagram(PVector position, float length, float separation, float thickness, color c){
    this.position = position;
    this.length = length;
    this.separation = separation;
    this.thickness = thickness;
    this.c = c;
    this.bass = loadImage("ChiaveBasso.png");
  }
  
  void render() {
    stroke(c);
    strokeWeight(thickness);
    line(position.x - length/2, position.y - separation*2, position.x + length/2, position.y - separation*2);
    line(position.x - length/2, position.y - separation, position.x + length/2, position.y - separation);
    line(position.x - length/2, position.y, position.x + length/2, position.y);
    line(position.x - length/2, position.y + separation, position.x + length/2, position.y + separation);
    line(position.x - length/2, position.y + separation*2, position.x + length/2, position.y + separation*2);
    image(bass, position.x - length/2, position.y, width/26, height/12);
  }
  
  void additionalLines(PVector finalPosition) {
  stroke(c);
  strokeWeight(thickness);
  float distance = finalPosition.y - position.y;
  float absDistance = abs(distance);
  int i = 0;
  while(i <= absDistance)
  {
    float pY = position.y + i * (distance/absDistance);
    i+= separation;
    line(position.x - length/24, pY, position.x + length/24, pY);
  }
}
}
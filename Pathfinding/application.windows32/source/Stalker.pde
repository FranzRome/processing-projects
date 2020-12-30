class Stalker {
  private PVector position;
  private PVector size;
  
  public Stalker(){
    this.position = new PVector(0,0);
    this.size = new PVector(100, 100);
  }
  
  public Stalker(PVector position){
    this.position = position;
    this.size = new PVector(100, 100);
  }
  
  public Stalker(PVector position, PVector size){
    this.position = position;
    this.size = size;
  }
  
  public PVector getPosition(){
    return position;
  }
  
  public void move(PVector target, float speed){
    float angle = atan2(target.y-position.y, target.x-position.x);
    PVector movement = new PVector(cos(angle),sin(angle));
    movement.mult(speed);
    position.add(movement.div(frameRate));
  }
  
  public void show(){
      fill(255,150,0);
      ellipse(position.x, position.y, size.x, size.y);
  }
}
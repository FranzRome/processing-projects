class Tile{
  public TVector index;
  private int size;
  private PVector position;
  private boolean walkable;
  //private int id;
  
  //private final int SIZE = 100;
  
  public Tile(){
    index = new TVector(0,0);
    this.size = 100;
    this.position = new PVector(0,0);
    
    this.walkable = true;
  }
  
  public Tile(TVector index, int size){
    this.index = index;
    this.size = size;
    this.position = new PVector(index.x * size, index.y * size);
    
    this.walkable = true;
  }
  
  /*public Tile(PVector position){
    this.position = position;
    this.size = new PVector(100, 100);
    this.walkable = true;
  }*/
  
 /* public Tile(PVector position, PVector size, boolean walkable){
    this.position = position;
    this.size = size;
    this.walkable = walkable;
    this.id = id;
  }*/
  
  public PVector getPosition(){
    return this.position;
  }
  
  public int getSize(){
    return this.size;
  }
  
  public boolean getWalkable(){
    return this.walkable;
  }
  
  /*public int getId(){
    return this.id;
  }*/
  
  public void setWalkable(boolean walkable){
    this.walkable = walkable;
  }
  
  public void show(){
    if(walkable)
      fill(255);
    else
      fill(80);
    rect(position.x, position.y, size, size);
  }
  
  
  @Override
  public String toString() {
    return "Tile(index["+index.x+","+index.y+"] position["+position.x+","+position.y+"] walkable["+walkable+"])";
  }
}
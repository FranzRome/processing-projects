class PathTile{
  private Tile tile;
  private PathTile parent;
  private int g=0; // costo per raggiungere la tile dalla posizione corrente
  private int h=0 ;// costo o distanza dalla tile alla destinazione
  
  
  public PathTile(Tile tile){
    this.tile = tile;
  }
  
  public PathTile(Tile tile, int g){
    this.tile = tile;
    this.g = g;
  }
  
  public PathTile(Tile tile, int g, int h){
    this.tile = tile;
    this.g = g;
    this.h = h;
  }
  
   public PathTile(Tile tile , PathTile parent, int g, int h){
    this.tile = tile;
    this.parent = parent;
    this.g = g;
    this.h = h;
  } 
  
  public PathTile getParent(){
    return this.parent;
  }
  
  public int getG() {
    return this.g;
  }
  
  public int getH() {
    return this.h;
  }
  
  public int getF() {
    return this.g + this.h;
  }
  
  public Tile getTile(){
    return this.tile;
  }
  
  public void setParent(PathTile parent){
    this.parent = parent;
  }
  
  public void setG(int g){
    this.g = g;
  }
  
   public void setH(int h){
    this.h = h;
  }
  
   @Override
  public String toString() {
    return "PathTile(" + tile.toString() + " g[" + g + "] h[" + h + "] f[" + this.getF() + "])";
  }
}
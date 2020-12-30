import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.ArrayList; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pathfinding extends PApplet {

 //<>//

//variabili griglia di caselle
final int COLUMNS = 16;
final int ROWS = 16;
final int TILE_SIZE = 60;
Tile[][] tiles = new Tile[COLUMNS][ROWS];

//liste
ArrayList<PathTile> openList = new ArrayList<PathTile>();
ArrayList<PathTile> closedList = new ArrayList<PathTile>();
ArrayList<PathTile> pathList = new ArrayList<PathTile>();

//inseguitore
Stalker stalker = new Stalker(new PVector(TILE_SIZE/2, TILE_SIZE/2), new PVector(40, 40));

//variabili di debug
int depth = 0;
final int MAX_DEPTH = 500;
boolean debugOn=false;
boolean move = false;

public void settings() {
  //fullScreen();
  size(COLUMNS*TILE_SIZE, ROWS*TILE_SIZE);  //dimensione finestra
}

public void setup() {
  //inizializzazione tiles  NOTABENE: non vengono utilizzati indici convenzionali[RIGA][COLONNA] ma bens\u00ec [COLONNA(x)][RIGA(y)]
  for (int y=0; y<ROWS; y++) {
    for (int x=0; x<COLUMNS; x++) {
      tiles[x][y] = new Tile(new TVector(x, y), TILE_SIZE);
    }

    frameRate(60);  //impostazione tetto frame per econdo
  }


  //showTiles();
  if (debugOn) println ("START PROGRAM");
  //calculatePath(tiles[0][6].getPosition(), tiles[11][6].getPosition());
}


//chiamata molte volte in un secondo fino a che il programma non viene chiuso
public void draw() {
  if (move) {
    calculatePath(stalker.position, new PVector(mouseX, mouseY));  //calcolo percorso migliore
    PVector stalkerDestination = new PVector(stalker.position.x, stalker.position.y);  //vettore che indica la destinazione di stalker inizializzato alla sua posizione
    if (pathList.size() > 1) {
      stalkerDestination = new PVector(pathList.get(pathList.size()-2).getTile().getPosition().x, pathList.get(pathList.size()-2).getTile().getPosition().y);
      stalkerDestination.add(TILE_SIZE/2, TILE_SIZE/2, 0);
      stalker.move(stalkerDestination, 200);
    }else if (pathList.size() > 0) {
      stalkerDestination = new PVector(pathList.get(pathList.size()-1).getTile().getPosition().x, pathList.get(pathList.size()-1).getTile().getPosition().y);
      stalkerDestination.add(TILE_SIZE/2, TILE_SIZE/2, 0);
      stalker.move(stalkerDestination, 200);
    }

    
  }
  
  showTiles();
  showOpenList();
  showClosedList();
  showPathList();
  stalker.show();
}

public void mousePressed() {
  TVector index = findTileIndex(new PVector(mouseX, mouseY));
  if (tiles[index.x][index.y].walkable == false)
    tiles[index.x][index.y].walkable = true;
  else
    tiles[index.x][index.y].walkable = false;
  //println(distance(new PVector(mouseX, mouseY), new PVector(0, 0)));
  //println(findTileIndex(new PVector(mouseX, mouseY)));
}

public void keyPressed(){
  if(key == 'm'){
    if(!move){
      move = true;
    } else{
      move = false;
    }
  }
}

// costo/distanza tra 2 tile passando il loro indice nella matrice
public int indexDistance(TVector a, TVector b) {
  int distanceX = abs((a.x - b.x));
  int distanceY = abs((a.y - b.y));
  return distanceX + distanceY;
}

//distanza degli indici tra due tile passando 2 punti sullo schermo
public int distance(PVector a, PVector b) {
  int distanceX = floor(a.x - b.x)/TILE_SIZE;
  int distanceY = floor(a.y - b.y)/TILE_SIZE;
  return distanceX + distanceY;
}

//restituisce la tile che contiene il punto a
public Tile findTile(PVector a) {
  for (int i=0; i<ROWS; i++) {
    for (int j=0; j<COLUMNS; j++) {
      if (a.x >= tiles[i][j].position.x && a.x < tiles[i][j].position.x + tiles[i][j].size  &&
        a.y >= tiles[i][j].position.y && a.y <= tiles[i][j].position.y + tiles[i][j].size)
        return tiles[i][j];
    }
  }
  return null;
}

//indice della tile che contiene il punto a
public TVector findTileIndex(PVector a) {
  return new TVector(floor(a.x/TILE_SIZE), floor(a.y/TILE_SIZE));
}


public boolean tileValid(int x, int y) {
  return (x>=0 && x<COLUMNS && y>=0 && y<ROWS && tiles[x][y].walkable && !isInClosedList(tiles[x][y].index));
}
public boolean tileValid(TVector index) {
  //  return(index.x>=0 && index.x<COLUMNS && index.y>=0 && index.y<ROWS && tiles[index.x][index.y].walkable && !isInClosedList(index));
  return tileValid(index.x, index.y);
}

//prende due punti nella finestra come parametri e li traduce in indici che passa a calculatePathIterativo/Ricorsivo
public void calculatePath(PVector a, PVector b) { 
  //ripulisco le liste
  TVector indexA= new TVector ((int)findTileIndex(a).x, (int)findTileIndex(a).y);
  TVector indexB= new TVector ((int)findTileIndex(b).x, (int)findTileIndex(b).y);
  pathList = new ArrayList<PathTile>();
  openList = new ArrayList<PathTile>();
  closedList = new ArrayList<PathTile>();

  depth = 0;
  //calculatePathIterativo (indexA, indexB);
  calculatePathRicorsivo (indexA, indexB, 0);
}



public void calculatePathIterativo(TVector a, TVector b) {     

  if (debugOn) println ("calculatePathIterativo(" + a + ", " + b +")");

  if (! tiles[b.x][b.y].getWalkable()) {
    return;
  }

  // inserisce il tile iniziale in openList
  PathTile current = new PathTile(tiles[a.x][a.y], 0, indexDistance(a, b));
  openList.add(current);

  TVector aIndex = new TVector();
  TVector currentIndex;
  PathTile npt;

  while (openList.size() > 0) {
    current = findBestFPtile(openList);
    if (debugOn) println ("current = " + current);
    currentIndex = current.getTile().index;

    // toglie la tile dalla open list e lo inserisce nella clooed list
    openList.remove (current);
    closedList.add (current);  

    // se il tile destinazione e' nella closed list --> calcola il percorso a ritroso ed esce
    if (isInClosedList(b)) {
      //println("la tile contente il punto b e'in closedList");
      makePathList(b);
      return;
    }



    // considera le tile adiacenti alla current (anche diagonali)
    for (int ix=-1; ix<=1; ix++) {
      for (int iy=-1; iy<=1; iy++) {

        aIndex.x = currentIndex.x+ix;
        aIndex.y = currentIndex.y+iy;


        if (!(ix==0 && iy==0) && tileValid(aIndex)) {
          npt = getFromOpenList(aIndex);
          if ( npt != null) {
            if (npt.getG() > current.getG() + 1) {
              npt.setG(current.getG() + 1);
              npt.setParent(current);
            }
          } else {
            npt = new PathTile(tiles[currentIndex.x+ix][currentIndex.y+iy], current.getG() + 1, indexDistance(aIndex, b));
            npt.setParent(current);
            openList.add(npt);
            if (debugOn) println("pt messa in openlist " + npt);
          }
        }
      }
      debugOpenList();
    }
  }
}  //  calculatePathIterativo()




public void calculatePathRicorsivo(TVector a, TVector b, int g) {     

  if (debugOn) println ("calculateIndexPath(" + a + ", " + b + ", " + g + ")");

  depth++;
  if (depth > MAX_DEPTH || !tiles[b.x][b.y].getWalkable()) {
    //println ("uscita per superamento MAX_DEPTH");
    return;
  }

  PathTile apt = getFromOpenList(a);
  if (apt != null) {
    openList.remove (apt);
    if (debugOn) println("pt trovata in openList e rimossa: " + apt);
  } else {
    apt = new PathTile(tiles[a.x][a.y], g, indexDistance(a, b));
    if (debugOn) println("Creata nuova pt: " + apt);
  }

  closedList.add(apt);
  if (debugOn) println("pt messa in closed list: " + apt);

  if (isInClosedList(b)) {
    //println("la tile contente il punto b e'in closedList");
    makePathList(b);
    return;
  }

  TVector aIndex = new TVector();


  
  //tiles adiacenti a quella messa in closedList (no diagonali)
  for (int i=-1; i<=1; i+=2) {

    aIndex.x = a.x+i;
    aIndex.y = a.y;
    if (tileValid(aIndex)) {
      PathTile npt = getFromOpenList(aIndex);
      if ( npt != null) {
        if (npt.getG() > apt.getG() + 1) {
          npt.setG(apt.getG() + 1);
          npt.setParent(apt);
        }
      } else {
        npt = new PathTile(tiles[a.x+i][a.y], apt.getG() + 1, indexDistance(aIndex, b));
        npt.setParent(apt);
        openList.add(npt);
        if (debugOn) println("pt messa in openlist " + npt);
      }
    }

    aIndex.x = a.x;
    aIndex.y = a.y+i;
    if (tileValid(aIndex)) {
      PathTile npt = getFromOpenList(aIndex);
      if ( npt != null) {
        if (npt.getG() > apt.getG() + 1) {
          npt.setG(apt.getG() + 1);
          npt.setParent(apt);
        }
      } else {
        npt = new PathTile(tiles[a.x][a.y+i], apt.getG() + 1, indexDistance(aIndex, b));
        npt.setParent(apt);
        openList.add(npt);
        if (debugOn) println("pt messa in openlist " + npt);
      }
    }
    debugOpenList();
  }
  
  if (isOpenListEmpty()) {
    return;
  }

  calculatePathRicorsivo(findBestNextTile(openList), b, apt.g);
}  // calculatePathRicorsivo()

public TVector findBestNextTile (ArrayList<PathTile> aList) {

  PathTile minTile = aList.get(0);

  for (PathTile tile : aList) {
    if (tile.getF() < minTile.getF()) {

      minTile = tile;
    } else if (tile.getF() == minTile.getF() && tile.getH() < minTile.getH()) {
      minTile = tile;
    }
  }
  return minTile.getTile().index;
}  // findBestNextTile()


public PathTile findBestFPtile (ArrayList<PathTile> aList) {

  PathTile minTile = aList.get(0);

  for (PathTile tile : aList) {
    if (tile.getF() < minTile.getF()) {

      minTile = tile;
    } else if (tile.getF() == minTile.getF() && tile.getH() < minTile.getH()) {
      minTile = tile;
    }
  }
  return minTile;
}  // findBestFPtile()

public boolean isOpenListEmpty() {
  return (openList.size() == 0);
}

public boolean isInOpenList(TVector index) {
  boolean result;
  PathTile p = getFromOpenList(index);
  result = (p != null);
  if (debugOn) print ("IsInOpenList("+index+")="+result);
  return (result);
}  // isInOpenList()

public boolean isInClosedList(TVector index) {
  boolean result;
  PathTile p = getFromClosedList(index);
  result = (p != null);
  if (debugOn) print ("IsInClosedList("+index+")="+result);
  return (result);
}  // isInClosedList()


public PathTile  getFromOpenList(TVector index) {
  return getFromList (openList, index);
}  // getFromOpenList()

public PathTile  getFromClosedList(TVector index) {
  return getFromList (closedList, index);
}  // getFromOpenList()

public PathTile  getFromList(ArrayList<PathTile> l, TVector index) {
  for (PathTile p : l) {
    Tile t = p.getTile();
    if (t.index.x == index.x && t.index.y == index.y)
      return p;
  }
  return null;
}  // getFromList()

public void makePathList(TVector index) {
  PathTile startPt = getFromClosedList(index);

  pathList.add(startPt);
  PathTile ptParent = startPt.getParent();
  while (ptParent != null) {
    pathList.add(ptParent);
    ptParent = ptParent.getParent();
  }
}

//--------------------------------------------
//funzioni per la visualizzazione
//--------------------------------------------
public void showTiles() {
  for (int y=0; y<ROWS; y++) {
    for (int x=0; x<COLUMNS; x++) {
      tiles[x][y].show();
    }
  }
}

public void showOpenList() {
  textAlign(CENTER, CENTER);
  for (PathTile pathTile : openList) { 
    PVector position = pathTile.tile.position;
    translate(position.x, position.y);
    fill(0, 255, 0);
    rect(0, 0, TILE_SIZE, TILE_SIZE);
    fill(0);
    text(pathTile.getG(), 10, TILE_SIZE-10);
    text(pathTile.getH(), TILE_SIZE-10, TILE_SIZE-10);
    text(pathTile.getTile().index.toString(), TILE_SIZE/2, 5);
    resetMatrix();
  }
}

public void showClosedList() {
  textAlign(CENTER, CENTER);
  for (PathTile pathTile : closedList) {
    PVector position = pathTile.tile.position;
    translate(position.x, position.y);
    fill(255, 0, 0);
    rect(0, 0, TILE_SIZE, TILE_SIZE);
    fill(0);
    text(pathTile.getG(), 10, TILE_SIZE-10);
    text(pathTile.getH(), TILE_SIZE-10, TILE_SIZE-10);
    text(pathTile.getTile().index.toString(), TILE_SIZE/2, 10);
    resetMatrix();
  }
}

public void showPathList() {
  fill(255, 0, 0);
  for (PathTile pathTile : pathList) {
    PVector position = pathTile.tile.position;
    translate(position.x, position.y);
    fill(0, 150, 255);
    rect(0, 0, TILE_SIZE, TILE_SIZE);
    fill(0);
    resetMatrix();
  }
}


//--------------------------------------------
// funzioni di debug
//--------------------------------------------
public void debugClosedList() {
  if (debugOn) {
    print ("closedList "); 
    debugList(closedList); 
    println("");
  }
}  // debugClosedList()

public void debugOpenList() {
  if (debugOn) {
    print ("openList "); 
    debugList(openList); 
    println("");
  }
}  // debugOpenList()

public void debugList (ArrayList<PathTile> pt) {
  for (PathTile pathTile : pt) {
    TVector t = pathTile.getTile().index;
    print ("["+t.x +"," +t.y + "] ");
  }
}  // debugList()
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
public class TVector{
      public int x;
      public int y;
      
      public TVector () {
         this.x=0;
         this.y=0;
      }
      
      public TVector (int x, int y) {
         this.x= x;
         this.y= y;
      }
      
      @Override
      public String toString(){
        return  x +", " + y ;
      }
}
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Pathfinding" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

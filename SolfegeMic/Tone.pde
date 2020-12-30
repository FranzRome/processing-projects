public enum Tone{
  int id;
  String name;
  
  private Tone(int id, String name){
    this.id = id;
    this.name = name;
  }
  
  public int getId(){
    return id;
  }
  
  public String getName(){
    return name;
  }
}

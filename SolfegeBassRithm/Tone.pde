public enum Tone{
  DO4(-6, "Do"), SI3(-5, "Si"), LA3(-4, "La"), SOL3(-3, "Sol"), FA3(-2, "Fa"), MI3(-1, "Mi"), RE3(0, "Re"), DO3(1, "Do"), SI2(2, "Si");
  
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
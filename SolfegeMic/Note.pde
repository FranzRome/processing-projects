public enum Note {
  DO(1, "Do"), RE(2,"Re"), MI(3,"Mi"), FA(4,"Fa"), SOL(5,"Sol"), LA(6,"La"), SI(7,"Si");
  
  private int id;
  private String name;
  
  private Note(int id, String name){
    this.id = id;
    this.name = name;
  }
}

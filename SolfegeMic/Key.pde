public class Key{
  private int octave;
  private Note note;
  
  public Key(int octave, Note note){
    this.octave = octave;
    this.note = note;
  }
  
  public String toString(){
    return "" + octave + note;
  }
}

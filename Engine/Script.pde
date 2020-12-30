public class Script extends Component {
  public String file;

  public Script(GameObject gameObject) {
    super(gameObject);
    Scripts.scripts.add(this);
  }

  void update() {
  }
}
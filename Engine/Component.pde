abstract class Component{
  //fields
  protected GameObject gameObject; //the GameObject that the Component instance is attached to
  protected PVector position;


  //constructors
  public Component(GameObject gameObject) {
    this.gameObject = gameObject;
    this.position = gameObject.position;
  }

  //methods
  public abstract void update();
  public void onCollide(SphereCollider other) {
  }
}
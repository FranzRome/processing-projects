public abstract  class GameObject implements java.io.Serializable {
  //fields
  protected String name;
  protected PVector position = new PVector();
  protected float rotation;
  protected PVector size = new PVector();
  protected ArrayList<Component> components = new ArrayList<Component>();
  //protected HashMap<String, Component> components = new HashMap <String, Component>();

  //constructors
  public GameObject() {
  }

  public GameObject(String name, float x, float y, float rotation) {
    this.name = name;
    this.position.set(x, y);
    this.rotation = radians(rotation);
  }

  //getters
  public float getX() {
    return this.position.x;
  }

  public float getY() {
    return this.position.y;
  }

  public float getRotation() {
    return this.rotation;
  }

  //setters
  public void setX(float x) {
    this.position.x = x;
  }

  public void setY(float y) {
    this.position.y = y;
  }

  public void setRotation(float rotation) {
    this.rotation = rotation;
  }

  //methods
  public void move(PVector movement) {
    this.position.add(movement);
  }

  public void turn(float rotation) {
    this.rotation += radians(rotation);
  }

  public void start() {
    position = new PVector(0, 0);
    rotation = 0;
  }

  public PVector forward() { 
    return new PVector(cos(rotation), sin(rotation));
  }

  public PVector backward() { 
    return new PVector(cos(rotation), sin(rotation)).mult(-1);
  }
  
  public void lookAt(PVector position) {
    float distanceX = position.x - this.position.x;
    float distanceY = position.y - this.position.y;
    this.rotation = atan2(distanceY, distanceX);
  }

  public void onCollide(SphereCollider other) {
    for (Component component : components)
      component.onCollide(other);
  }


  public Component getComponent(Class<? extends Component> type) {
    for (Component component : components) {
      if (component.getClass() == type) 
        return component;
    }
    return null;
  }
  
  /*public void addComponent(Class<? extends Component> type) {
   if(getComponent(type) != null)
   components.add(new type(this));
   }*/
}//GameObject
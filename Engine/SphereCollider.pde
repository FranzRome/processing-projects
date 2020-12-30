public class SphereCollider extends Component {

  private float radius;
  private boolean show;
  private boolean collided;


  public float getRadius() {
    return radius;
  }

  public SphereCollider(GameObject gameObject, float radius, boolean show) {
    super(gameObject);
    this.radius = radius;
    this.show = show;
    Physics.colliders.add(this);
  }

  public void update() {
  }
  
  public void show() {
    float x = position.x*width/World.x;  //pixel position based on World.x
    float y = (position.y *height/World.y) * -1 +height; //pixel position based on World.x
    float mappedRadius = radius*width/World.x;


    ellipseMode(CENTER);
    translate(x, y);
    noFill();
    stroke(0, 255, 0, 200);
    strokeWeight(2);
    ellipse(0, 0, mappedRadius*2, mappedRadius*2);
    resetMatrix();
    
    if (World.wrapped) {
      if (x < width/2)
        translate(x + width, y);
      else
        translate(x - width, y);

      rotate(-gameObject.rotation);
      ellipse(0, 0, mappedRadius*2, mappedRadius*2);
      resetMatrix();

      if (y < height/2)
        translate(x, y + height);
      else
        translate(x, y  - height);

      rotate(-gameObject.rotation);
      ellipse(0, 0, mappedRadius*2, mappedRadius*2);
      resetMatrix();
    }
  }

  public boolean intersects(SphereCollider other) {
    float dX = position.x - other.position.x;
    float dY = position.y - other.position.y;

    float sumRadius = radius + other.radius;
    float sqrRadius = sumRadius * sumRadius;

    float distSqr = (dX * dX) + (dY * dY);

    if (distSqr <= sqrRadius)
    {
      for (Component component : gameObject.components)
        component.onCollide(other);
      return true;
    }
    return false;
  }
}
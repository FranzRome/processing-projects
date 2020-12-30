public class RigidBody extends Component {
  //fields
  private PVector speed = new PVector();
  private float maxSpeed;
  private float angularSpeed;
  private float maxAngularSpeed;
  private float mass;
  private float dispersion;
  private boolean useGravity;

  //constructors
  public RigidBody(GameObject gameObject) {
    super(gameObject);
    this.maxSpeed = 10;
    this.maxAngularSpeed = 360;
    this.useGravity = true;
  }

  public RigidBody(GameObject gameObject, float maxSpeed, float maxAngularSpeed, float mass, float dispersion, boolean useGravity) { 
    super(gameObject);
    this.maxSpeed = maxSpeed;
    this.maxAngularSpeed = maxAngularSpeed;
    this.mass = mass;
    this.dispersion = dispersion;
    this.useGravity = useGravity;
    Physics.rigidBodies.add(this);
  }
  
  //getters
  public PVector getSpeed() {
    return this.speed;
  }
  
  //setters
  public void setSpeed(PVector speed) {
    this.speed = speed;
  }

  //methods
  public void accelerate(PVector acceleration) {
    //add speed
    this.speed.x +=  acceleration.x * Time.deltaTime;
    this.speed.y +=  acceleration.y * Time.deltaTime;

    //limit speed to maxSpeed
    this.speed.limit(maxSpeed);
  }
  
  public void addForce(PVector force) {
    accelerate(force.div(mass));
  }

  public void turn(float acceleration) {
    this.angularSpeed += acceleration * Time.deltaTime;

    angularSpeed = constrain(angularSpeed, -maxAngularSpeed, maxAngularSpeed);
  }

  public void update() {
    if (useGravity)
      accelerate(new PVector(0, -World.gravity));

    gameObject.position.x += speed.x * Time.deltaTime;
    gameObject.position.y += speed.y * Time.deltaTime;
    gameObject.rotation += angularSpeed * Time.deltaTime;
    
    
    
  }
  
  public void onCollide(SphereCollider other) {
    //float distanceX = (gameObject.position.x - other.gameObject.position.x);
    //float distanceY = (gameObject.position.y - other.gameObject.position.y);
    
    //float angle = atan2(distanceY, distanceX);
    
    //float targetX = gameObject.position.x + cos(angle) * bounce;
    //float targetY = gameObject.position.y + sin(angle) * bounce;
    
    //float sx = (targetX - other.gameObject.position.x) ;
    //float sy = (targetY - other.gameObject.position.y) ;
    
   
    float massOther = 1;
    PVector speedOther = new PVector(0,0);
    RigidBody otherBody = (RigidBody)other.gameObject.getComponent(RigidBody.class);
    
    
    if(otherBody != null) {
      println("otherBody != null");
      speedOther = otherBody.getSpeed();
      massOther = otherBody.mass;
    }
    
    println("prima:" + gameObject.name + ": " + speed.x + " " + speed.y + "  " + other.gameObject.name + ": " + speedOther.x + " " + speedOther.y);
    
    float massDiff = mass - massOther;
    float massSum = mass + massOther;
    
    PVector mySpeed = new PVector(speed.x, speed.y);
 
    //this speed set
    speed.x = ((massDiff*mySpeed.x + 2*massOther*speedOther.x) / massSum);
    speed.y = ((massDiff*mySpeed.y + 2*massOther*speedOther.y) / massSum);
    
    //other speed set
    speedOther.x = ((-massDiff*speedOther.x + 2*mass*mySpeed.x) / massSum);
    speedOther.y = ((-massDiff*speedOther.y + 2*mass*mySpeed.y) / massSum);
    
    println("dopo: " +gameObject.name + ": " + speed.x + " " + speed.y + "  " + other.gameObject.name + ": " + speedOther.x + " " + speedOther.y); //<>//
    //System.exit(0);
     
    this.update();
    
    if(otherBody != null)
    otherBody.update();
  }
}
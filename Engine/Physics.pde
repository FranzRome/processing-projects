//this class contain all physics component in the scene
public static class Physics {
  static ArrayList<SphereCollider> colliders = new ArrayList<SphereCollider>();
  static ArrayList<RigidBody> rigidBodies = new ArrayList<RigidBody>();

  public static void update() { //<>//
    for (SphereCollider collider1 : colliders) {
      for (SphereCollider collider2 : colliders) {
        if(collider1.equals(collider2) == false && !collider1.collided && !collider2.collided) {
          intersects(collider1, collider2);
        }
      }
    }
    
    for(SphereCollider collider : colliders)
      collider.collided = false;

    for (RigidBody rigidBody : rigidBodies) {
      rigidBody.update();
    }
  }
  
  public static boolean intersects(SphereCollider collider1, SphereCollider collider2) {
    float dX = collider1.position.x - collider2.position.x;
    float dY = collider1.position.y - collider2.position.y;
    float distSqr = (dX * dX) + (dY * dY);

    float sumRadius = collider1.radius + collider2.radius;
    float sqrRadius = sumRadius * sumRadius;


    if (distSqr <= sqrRadius)
    {
      //for (Component component : collider1.gameObject.components)
        //component.onCollide(collider2);
        
      //for (Component component : collider2.gameObject.components)
        //component.onCollide(collider1);
      collider1.collided = true;
      collider2.collided = true;
      elasticCollide((RigidBody)collider1.gameObject.getComponent(RigidBody.class),
                     (RigidBody)collider2.gameObject.getComponent(RigidBody.class));
      return true;
    }
    return false;
  }
  
  public static void elasticCollide(RigidBody body1, RigidBody body2) {
    //float distanceX = (gameObject.position.x - other.gameObject.position.x);
    //float distanceY = (gameObject.position.y - other.gameObject.position.y);
    
    //float angle = atan2(distanceY, distanceX);
    
    //float targetX = gameObject.position.x + cos(angle) * bounce;
    //float targetY = gameObject.position.y + sin(angle) * bounce;
    
    //float sx = (targetX - other.gameObject.position.x) ;
    //float sy = (targetY - other.gameObject.position.y) ;
    
   
    //float massOther = 1;
    //PVector speedOther = new PVector(0,0);
    //RigidBody otherBody = (RigidBody)other.gameObject.getComponent(RigidBody.class);
    
    
    //if(otherBody != null) {
     // println("otherBody != null");
     // speedOther = otherBody.getSpeed();
     // massOther = otherBody.mass;
    //}
    
    println("prima:" + body1.gameObject.name + ": " + body1.speed.x + " " + body1.speed.y + "  " + body2.gameObject.name + ": " + body2.speed.x + " " + body2.speed.y);
    
    float massDiff = body1.mass - body2.mass;
    float massSum = body1.mass + body2.mass;
    
    PVector startSpeed = new PVector(body1.speed.x, body1.speed.y);  //body1 starting speed
 
    //body1 speed set
    body1.speed.x = ((massDiff*startSpeed.x + 2*body2.mass*body2.speed.x) / massSum);
    body1.speed.y = ((massDiff*startSpeed.y + 2*body2.mass*body2.speed.y) / massSum);
    body1.speed.mult(body1.dispersion);
    
    //body2 speed set
    body2.speed.x = ((-massDiff*body2.speed.x + 2*body1.mass*startSpeed.x) / massSum);
    body2.speed.y = ((-massDiff*body2.speed.y + 2*body1.mass*startSpeed.y) / massSum);
    body2.speed.mult(body2.dispersion);
    
    println("dopo: " +body1.gameObject.name + ": " + body1.speed.x + " " + body1.speed.y + "  " + body2.gameObject.name + ": " + body2.speed.x + " " + body2.speed.y);
    //System.exit(0);
     
    //this.update();
    
    //if(otherBody != null)
    //otherBody.update();
  }
}
class SpaceShipControl extends Script{
  
  public SpaceShipControl(GameObject gameObject){
    super(gameObject);
  }
  
  public void update() {
  if (gameObject.position.x > World.x )
      gameObject.position.x = 0;

    if (gameObject.position.x < 0 )
      gameObject.position.x = World.x;

    if (gameObject.position.y > World.y )
      gameObject.position.y = 0;

    if (gameObject.position.y < 0 )
      gameObject.position.y = World.y;

    if (Input.getKey('w')) {
      ((RigidBody)gameObject.getComponent(RigidBody.class)).accelerate(gameObject.forward().mult(400));
    }
    if (Input.getKey('a')) {
      ((RigidBody)gameObject.getComponent(RigidBody.class)).turn(8);
    }
    if (Input.getKey('s')) {
      ((RigidBody)gameObject.getComponent(RigidBody.class)).accelerate(gameObject.backward().mult(400));
    }
    if (Input.getKey('d')) {
      ((RigidBody)gameObject.getComponent(RigidBody.class)).turn(-8);
    }
    if (Input.getKey(' ')) {
      ((RigidBody)gameObject.getComponent(RigidBody.class)).speed = new PVector(0, 0);
    }
    if (Input.getKey('q')) {
      Time.timeScale = 0.1;
    }
    if (Input.getKey('e')) {
      Time.timeScale =+ 1;
    }
    if (Input.getKey('r')) {
      UtilitySerialization.salvaObj(gameObject.position.x, "prova.TXT");
    }

    gameObject.lookAt(new PVector(mouseX, mouseY));
    
    println("Rotation"+ gameObject.rotation + " Speed" + ((RigidBody)gameObject.getComponent(RigidBody.class)).speed + " Angular Speed:" +((RigidBody)gameObject.getComponent(RigidBody.class)).angularSpeed);
  }
}
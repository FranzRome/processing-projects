class BallControl extends Script{
  
  public BallControl(GameObject gameObject){
    super(gameObject);
  }
  
  public void update() {
  if(World.wrapped) {  
  if (gameObject.position.x > World.x )
      gameObject.position.x = 0;

    if (gameObject.position.x < 0 )
      gameObject.position.x = World.x;

    if (gameObject.position.y > World.y )
      gameObject.position.y = 0;

    if (gameObject.position.y < 0 )
      gameObject.position.y = World.y;
  }
      
      if(Input.getKey('a'))
        ((RigidBody)gameObject.getComponent(RigidBody.class)).addForce(new PVector(-200,0));
      if(Input.getKey('d'))
        ((RigidBody)gameObject.getComponent(RigidBody.class)).addForce(new PVector(200,0));
      if(Input.getKey('s'))
        ((RigidBody)gameObject.getComponent(RigidBody.class)).addForce(new PVector(0,-200));
      if(Input.getKey('w'))
        ((RigidBody)gameObject.getComponent(RigidBody.class)).addForce(new PVector(0,200));
      if(Input.getKey('e'))
        System.exit(0);
        
      if(Input.getKey('0'))
        Time.timeScale = 1;
      else if(Input.getKey('9'))
        Time.timeScale = 0.9;
      else if(Input.getKey('8'))
        Time.timeScale = 0.8;
      else if(Input.getKey('7'))
        Time.timeScale = 0.7;
      else if(Input.getKey('6'))
        Time.timeScale = 0.6;
      else if(Input.getKey('5'))
        Time.timeScale = 0.5;
      else if(Input.getKey('4'))
        Time.timeScale = 0.4;
      else if(Input.getKey('3'))
        Time.timeScale = 0.3;
      else if(Input.getKey('2'))
        Time.timeScale = 0.2;
      else if(Input.getKey('1'))
        Time.timeScale = 0.1;
      else if(Input.getKey(' '))
        Time.timeScale = 0;
       else if(Input.getKey('q'))
        Time.timeScale -= 0.1 * Time.unscaledDeltaTime;
        
        //gameObject.lookAt(new PVector(mouseX,mouseY));
      }
  }
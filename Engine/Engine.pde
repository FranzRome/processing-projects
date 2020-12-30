ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

void settings() {
  //fullScreen();
  size(800, 800);
}

void setup() {
  frameRate(30);
  //SpaceShip navetta = new SpaceShip("navetta", 50 ,50, 0);
  //gameObjects.add(navetta);
  
  Ball palla1 = new Ball("Palla1", 10, 50, 0, 2);
  ((RigidBody)palla1.getComponent(RigidBody.class)).speed.x = 30;
  gameObjects.add(palla1);
  
  Ball palla2 = new Ball("Palla2", 90, 50, 0, 1);
  ((RigidBody)palla2.getComponent(RigidBody.class)).speed.x = -30;
  //gameObjects.add(palla2);

  //gameObjects.add(new Ball("Palla2", 40.5, 85, 0, 1));
  //gameObjects.add(new Ball("Palla3", 72, 85, 0, 1));
  
  //gameObjects.add(new StaticBall("Palla", 8, 10, 0));
  //gameObjects.add(new StaticBall("Palla", 24, 10, 0));
  //gameObjects.add(new StaticBall("Palla", 40, 10, 0));
  //gameObjects.add(new StaticBall("Palla", 56, 10, 0));
  //gameObjects.add(new StaticBall("Palla", 72, 10, 0));
  //gameObjects.add(new StaticBall("Palla", 88, 10, 0));
  //gameObjects.add(new StaticBall("Palla", 104, 10, 0));

  for (GameObject gameObject : gameObjects)
    gameObject.start();
}

void draw() {
  //set background
  background(0);

  //time update
  Time.update(millis());
  
  //components update
  Scripts.update();
  Physics.update();
  Rendering.update();
  println(frameRate);
  
  if(keyPressed){
    if(key=='+'){
      World.gravity++;
    }
    if(key=='-'){
      World.gravity--;
    }
  }
}//draw

void keyTyped() { //<>//
  if (key != CODED && !Input.getKey(key)) {
    Input.pressedKeys.add(key);
  }
}

void keyReleased() {
  if (key != CODED) {
    Input.pressedKeys.remove(Input.pressedKeys.indexOf(key));
  }
}
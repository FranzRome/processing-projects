class Ball extends GameObject {
  public Ball() {
  }

  public Ball(String name, float x, float y, float rotation, float mass) {
    super(name, x, y, rotation);
    components.add(new BallControl(this));
    components.add(new SphereCollider(this, 8, true));
    components.add(new RigidBody(this, 200, 1, mass, 0.9, true));
    components.add(new Sprite(this, "ball.png", true));
  }

  public void start() {
  }
}
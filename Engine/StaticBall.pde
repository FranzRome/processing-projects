class StaticBall extends GameObject {
  public StaticBall() {
  }

  public StaticBall(String name, float x, float y, float rotation) {
    super(name, x, y, rotation);
    components.add(new SphereCollider(this, 8, true));
    components.add(new Sprite(this, "ball.png", false));
  }

  public void start() {
  }
}
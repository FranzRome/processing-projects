class SpaceShip extends GameObject {
  public SpaceShip() {
  }

  public SpaceShip(String name, float x, float y, float rotation) {
    super(name, x, y, rotation);
    components.add(new SphereCollider(this, 15, true));
    components.add(new RigidBody(this, 800, 10, 1, 0.9, false));
    components.add(new SpaceShipControl(this));
    components.add(new Sprite(this, "spaceship.png", false));
  }

  public void start() {
  }
}
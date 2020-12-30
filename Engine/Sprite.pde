public class Sprite extends Component {
  //fields
  PImage sprite;
  boolean axis;

  //constructors
  public Sprite(GameObject gameObject, String image) {
    super(gameObject);
    sprite = loadImage(image);
    Rendering.sprites.add(this);
  }

  public Sprite(GameObject gameObject, String image, boolean axis) {
    super(gameObject);
    sprite = loadImage(image);
    this.axis = axis;
    Rendering.sprites.add(this);
  }

  //methods
  public void update() {
    float x = gameObject.position.x*width/World.x;  //pixel position based on World.x
    float y = (gameObject.position.y *height/World.y) * -1 +height; //pixel position based on World.x
    /* EXAMPLE: World.x = 100
     *           World.y = 100
     *           window width = 1000
     *           window heifht = 1000
     *          gameObject.position.x = 20
     *          gameObject.position.y = 50
     *         
     *          result: x = 200
     *                  y = 500       
     */

    imageMode(CENTER);
    translate(x, y);
    rotate(-gameObject.rotation);
    image(sprite, 0, 0);
    resetMatrix();

    if (World.wrapped) {
      if (x < width/2)
        translate(x + width, y);
      else
        translate(x - width, y);

      rotate(-gameObject.rotation);
      image(sprite, 0, 0);
      resetMatrix();

      if (y < height/2)
        translate(x, y + height);
      else
        translate(x, y  - height);

      rotate(-gameObject.rotation);
      image(sprite, 0, 0);
      resetMatrix();
    }

    if (axis) {
      ellipseMode(CENTER);
      noStroke();
      fill(255, 0, 0);
      translate(x, y);
      rotate(-gameObject.rotation);
      ellipse(0, 0, 20, 20);
      strokeWeight(2);
      stroke(255, 0, 0);
      line(0, 0, 60, 0);
      stroke(0, 255, 0);
      line(0, 0, 0, -60);
      resetMatrix();
    }
  }
}
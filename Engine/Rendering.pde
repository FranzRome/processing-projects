public static class Rendering { //<>//
  static ArrayList<Sprite> sprites = new ArrayList<Sprite>();

  public static void update() {
    for (Sprite sprite : sprites)
      sprite.update();
      
      for (SphereCollider collider : Physics.colliders)
       if(collider.show)
          collider.show();
  }
}
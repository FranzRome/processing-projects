public static class World {
  static float x = 100;  //virtual space width
  static float y = 100;  //virtual space height
  static float gravity = 0;
  static boolean wrapped = true;
  
  public static void setWorldSize(float wX, float wY) {
    x = wX;
    y = wY;
  }
}
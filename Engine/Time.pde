public static class Time {
  static float pTime;
  static float time;
  static float unscaledTime;
  static float deltaTime;
  static float unscaledDeltaTime;
  static float timeScale = 1;

  public static void update(float t) {
    unscaledTime = t/1000;
    unscaledDeltaTime = unscaledTime - pTime;
    deltaTime = timeScale * unscaledDeltaTime;  
    time += deltaTime;
    pTime = unscaledTime;
  }
}
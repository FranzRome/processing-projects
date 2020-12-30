public static class Time {
  public static float pTime;
  public static float time;
  public static float unscaledTime;
  public static float deltaTime;
  public static float unscaledDeltaTime;
  public static float timeScale;
  
  public static void setup() {
    pTime = 0f;
    time = 0f;
    unscaledTime = 0f;
    deltaTime = 0f;
    unscaledDeltaTime = 0f;
    timeScale = 1f;
  }
  
  public static void update(float t) {
    unscaledTime = t/1000;
    unscaledDeltaTime = unscaledTime - pTime;
    deltaTime = timeScale * unscaledDeltaTime;
    time += deltaTime;
    pTime = unscaledTime;
  }
}
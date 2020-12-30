public static class Time {  
  static float pTime;  //time of last frame
  static float time;  //time of current frame scaled with timescale
  static float unscaledTime;  //time of current frame
  static float deltaTime;  //time between current frame and last frame scaled with timescale
  static float unscaledDeltaTime;  //time between current frame and last frame
  static float timeScale = 1;

  public static void update(float t) {
    unscaledTime = t/1000;
    unscaledDeltaTime = unscaledTime - pTime;
    deltaTime = timeScale * unscaledDeltaTime;  
    time += deltaTime;
    pTime = unscaledTime;
  }
}
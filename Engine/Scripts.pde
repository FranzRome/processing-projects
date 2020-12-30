public static class Scripts {
  static ArrayList<Script> scripts = new ArrayList<Script>();

  public static void update() {
    for (Script script : scripts) {
      script.update();
    }
  }
}
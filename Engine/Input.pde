public static class Input {
  static ArrayList<Character> pressedKeys = new ArrayList<Character>();

  public static boolean getKey(Character k) {
    for (Character pressedKey : pressedKeys) {
      if (k == pressedKey)
        return true;
    }
    return false;
  }
}
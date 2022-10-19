class Singleton {
  static String? accessToken;
  static final Singleton _singleton = Singleton._internal();
  Singleton._internal();

  factory Singleton() {
    return _singleton;
  }
}

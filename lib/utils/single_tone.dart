class Singleton {
  static String? accessToken;
  static num? uid;
  static final Singleton _singleton = Singleton._internal();
  Singleton._internal();

  factory Singleton() {
    return _singleton;
  }
}

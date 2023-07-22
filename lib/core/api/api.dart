class Api {
  static String get url => 'https://hackathon.unisains.com/api';

  static Map<String, String> headers() {
    return {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
  }

  static Map<String, String> headersToken(String token) {
    return {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}

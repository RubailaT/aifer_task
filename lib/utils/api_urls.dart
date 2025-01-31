String clientId = "IOEr-0x37uQYmVsiSGxhuNPlwRgjCXBGeN76sM9cmFY";

class ApiUrls {
  static const String baseUrl = "https://api.unsplash.com";

  static String getImageList({int page = 1}) {
    return '$baseUrl/photos/?page=$page&client_id=$clientId';
  }
}

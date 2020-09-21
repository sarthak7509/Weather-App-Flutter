import 'dart:io';

class AdMobService {

  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return "{your andoid app Id}";
    }
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return "{your android banner id}";
    }
  }

}

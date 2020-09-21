import 'dart:io';

class AdMobService {

  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-5580729396347961~7818326487";
    }
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-5580729396347961/3108925289";
    }
  }

}
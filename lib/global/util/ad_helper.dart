import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

final AdRequest request =
    AdRequest(keywords: <String>['foo', 'bar'], contentUrl: 'http://foo.com/bar.html', nonPersonalizedAds: true);
Map<String, String> adUnitId = kReleaseMode
    ? {"aos": "ca-app-pub-2713562828985788/6593677327", "ios": "ca-app-pub-2713562828985788/4705880580"}
    : {'aos': 'ca-app-pub-3940256099942544/3419835294', 'ios': 'ca-app-pub-3940256099942544/5662855259'};

InterstitialAd? _interstitialAd;
int _numInterstitialLoadAttempts = 0;
void createInterstitialAd() {
  InterstitialAd.load(
    adUnitId: Platform.isAndroid
        ? adUnitId['aos'] ?? 'ca-app-pub-3940256099942544/3419835294'
        : adUnitId['ios'] ?? 'ca-app-pub-3940256099942544/5662855259',
    request: request,
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        print('$ad loaded');
        _interstitialAd = ad;
        _numInterstitialLoadAttempts = 0;
        _interstitialAd!.setImmersiveMode(true);
      },
      onAdFailedToLoad: (LoadAdError error) {
        print('InterstitialAd failed to load: $error.');
        _numInterstitialLoadAttempts += 1;
        _interstitialAd = null;
        if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
          createInterstitialAd();
        }
      },
    ),
  );
}

Future<void> showInterstitialAd() async {
  if (_interstitialAd == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) {
      print('ad onAdShowedFullScreenContent.');
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    },
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      createInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      createInterstitialAd();
    },
  );
  await _interstitialAd!.show();
  _interstitialAd = null;
}

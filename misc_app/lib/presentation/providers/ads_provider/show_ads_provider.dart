import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/config/config.dart';

const storeKey = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checksAdsState();
  }

  void checksAdsState() async {
    state = await SharedPreferencesPlugin.getBool(storeKey) ?? true;
  }

  void removeAds() async {
    await SharedPreferencesPlugin.setBool(storeKey, false);
    state = false;
  }

  void showAds() async {
    await SharedPreferencesPlugin.setBool(storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});

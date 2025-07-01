import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:misc_app/config/plugins/admob_plugin.dart';
import 'package:misc_app/presentation/providers/ads_provider/show_ads_provider.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);

  if (!showAds) throw 'Ads estan bloqueados';

  final ad = await AdmobPlugin.loadBannerAd();

  return ad;
});

final adIntersitialProvider = FutureProvider.autoDispose<InterstitialAd>((
  ref,
) async {
  final showAds = ref.watch(showAdsProvider);

  if (!showAds) throw 'Ads estan bloqueados';

  final ad = await AdmobPlugin.loadIntersitialAd();

  return ad;
});

final adRewardedProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);

  if (!showAds) throw 'Ads estan bloqueados';

  final ad = await AdmobPlugin.loadRewardedAd();

  return ad;
});

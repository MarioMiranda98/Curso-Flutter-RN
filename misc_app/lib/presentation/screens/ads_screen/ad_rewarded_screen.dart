import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/ads_provider/ad_mob_points_provider.dart';
import 'package:misc_app/presentation/providers/ads_provider/ad_mob_providers.dart';

class AdRewardedScreen extends ConsumerWidget {
  const AdRewardedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adPoints = ref.watch(adPointsProvider);
    final $adRewardProvider = ref.watch(adRewardedProvider);

    ref.listen(adRewardedProvider, (prev, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;

      next.value!.show(
        onUserEarnedReward: (ad, reward) {
          print('reward: $reward');
          ref
              .read(adPointsProvider.notifier)
              .update((state) => state + reward.amount.toInt());
        },
      );
    });

    if ($adRewardProvider.isLoading) {
      return Scaffold(body: Center(child: Text('Cargando anuncio')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ad Rewarded')),
      body: Center(child: Text('Puntos actuales: $adPoints')),
    );
  }
}

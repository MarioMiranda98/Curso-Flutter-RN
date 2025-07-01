import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/ads_provider/ad_mob_providers.dart';

class AdFullScreen extends ConsumerWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $intersitialAd = ref.watch(adIntersitialProvider);

    ref.listen(adIntersitialProvider, (prev, next) {
      if (!next.hasValue) {
        return;
      }

      if (next.value == null) return;

      next.value!.show();
    });

    if ($intersitialAd.isLoading) {
      return Scaffold(body: Center(child: Text('Cargando Ad')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ad Full Screen')),
      body: const Center(child: Text('Ya puedes regresar o ver esta pantalla')),
    );
  }
}

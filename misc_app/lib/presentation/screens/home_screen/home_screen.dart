import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:misc_app/presentation/providers/providers.dart';
import 'package:misc_app/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $adBannerProvider = ref.watch(adBannerProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text('Miscelaneos'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.push('/permissions');
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),

                  const MainMenu(),
                ],
              ),
            ),
          ),
          $adBannerProvider.when(
            data: (ad) => SizedBox(
              width: ad.size.width.toDouble(),
              height: ad.size.height.toDouble(),
              child: AdWidget(ad: ad),
            ),
            error: (error, stackTrace) => Text('$error'),
            loading: () => CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

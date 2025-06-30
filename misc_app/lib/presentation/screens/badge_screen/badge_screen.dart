import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/config/config.dart';
import 'package:misc_app/presentation/providers/badge_provider/badge_counter_provider.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('App Badge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              alignment: Alignment.lerp(
                Alignment.topRight,
                Alignment.bottomRight,
                0.2,
              ),
              label: Text('$badgeCounter'),
              child: Text('$badgeCounter', style: TextStyle(fontSize: 150.0)),
            ),
            FilledButton.tonal(
              onPressed: () {
                AppBadgePlugin.removeBadge();
                ref.invalidate(badgeCounterProvider);
              },
              child: const Text('Borrar Badge'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppBadgePlugin.updateBadgeCount(badgeCounter + 1);
          ref.read(badgeCounterProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

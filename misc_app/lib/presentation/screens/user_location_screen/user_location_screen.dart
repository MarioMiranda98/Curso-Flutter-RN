import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class UserLocationScreen extends ConsumerWidget {
  const UserLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    final $watchLocation = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ubicación')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación actual'),
            userLocationAsync.when(
              data: (data) => Text('$data'),
              error: (error, _) => Text('$error'),
              loading: () => CircularProgressIndicator(),
            ),
            const SizedBox(height: 30.0),
            const Text('Seguimiento de la ubicación'),
            $watchLocation.when(
              data: (data) => Text('$data'),
              error: (error, _) => Text('$error'),
              loading: () => CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

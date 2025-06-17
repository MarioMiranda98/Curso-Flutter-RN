import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $accelerometerGravityProvider = ref.watch(
      accelerometerGravityProvider,
    );
    final $accelerometerUserProvider = ref.watch(accelerometerUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Acelerómetro')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Gravity'),
          const SizedBox(height: 16.0),
          $accelerometerGravityProvider.when(
            data: (data) => Text(data.toString()),
            error: (e, stackTrace) => Text('$e'),
            loading: () => CircularProgressIndicator(),
          ),
          const SizedBox(height: 16.0),
          Text('User'),
          const SizedBox(height: 16.0),
          $accelerometerUserProvider.when(
            data: (data) => Text(data.toString()),
            error: (e, stackTrace) => Text('$e'),
            loading: () => CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

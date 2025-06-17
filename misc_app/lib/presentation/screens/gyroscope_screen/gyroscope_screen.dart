import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $gyroscopeProvider = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Giroscópio')),
      body: Center(
        child: $gyroscopeProvider.when(
          data: (data) =>
              Text(data.toString(), style: const TextStyle(fontSize: 30.0)),
          error: (e, stackTrace) => Text('$e'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

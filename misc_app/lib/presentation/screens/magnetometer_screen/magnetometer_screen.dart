import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $magnetomerProvider = ref.watch(magnetometerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Magnetometer')),
      body: Center(
        child: $magnetomerProvider.when(
          data: (data) => Text(data.toString()),
          error: (e, stackTrace) => Text('$e'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

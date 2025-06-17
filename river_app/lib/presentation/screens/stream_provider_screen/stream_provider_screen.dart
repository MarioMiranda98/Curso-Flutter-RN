import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/presentation/providers/provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $randomNames = ref.watch(randomNamesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Stream Provider')),
      body: $randomNames.when(
        data: (value) => Center(child: Text(value)),
        error: (error, statckTrace) => Text('Error'),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}

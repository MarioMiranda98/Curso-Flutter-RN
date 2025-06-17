import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/presentation/providers/provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('State Provider')),
      body: Center(
        child: Text(
          ref.watch(randomNameProvider),
          style: textTheme.titleMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.invalidate(randomNameProvider);
        },
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}

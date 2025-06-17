import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/permissions_provider/permissions_provider.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permiso Requerido')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read(permissionProvider.notifier).requestLocationAccess();
          },
          child: Text('Localización necesaria'),
        ),
      ),
    );
  }
}

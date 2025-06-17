import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permisos')),
      body: _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          onChanged: (_) {
            ref.read(permissionProvider.notifier).requestCameraAccess();
          },
          title: const Text('Cámara'),
          subtitle: Text('${permissions.camera}'),
        ),
        CheckboxListTile(
          value: permissions.photoLibrayGranted,
          onChanged: (_) {
            ref.read(permissionProvider.notifier).requestPhotoLibraryAccess();
          },
          title: const Text('Galería de fotos'),
          subtitle: Text('${permissions.photoLibray}'),
        ),
        CheckboxListTile(
          value: permissions.locationGranted,
          onChanged: (_) {
            ref.read(permissionProvider.notifier).requestLocationAccess();
          },
          title: const Text('Localización'),
          subtitle: Text('${permissions.location}'),
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted,
          onChanged: (_) {
            ref.read(permissionProvider.notifier).requestSensorsAccess();
          },
          title: const Text('Sensores'),
          subtitle: Text('${permissions.sensors}'),
        ),
      ],
    );
  }
}

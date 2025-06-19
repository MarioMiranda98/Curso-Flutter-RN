import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: currentPosition.when(
        data: (data) => _MapView(initLat: data.$1, initLong: data.$2),
        error: (error, stackTrace) => Text('$error'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}

class _MapView extends StatefulWidget {
  const _MapView({required this.initLat, required this.initLong});

  final double initLat;
  final double initLong;

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initLat, widget.initLong),
        zoom: 12.0,
      ),
      myLocationEnabled: true,
      // onMapCreated: (GoogleMapController controller) {
      //   _controller.complete(controller);
      // },
    );
  }
}

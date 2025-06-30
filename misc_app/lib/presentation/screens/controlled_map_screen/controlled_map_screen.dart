import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:misc_app/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchUserLocation = ref.watch(watchLocationProvider);

    return Scaffold(
      body: watchUserLocation.when(
        data: (values) => _MapAndControlls(lat: values.$1, long: values.$2),
        error: (error, stackTrace) => Text('$error'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}

class _MapAndControlls extends ConsumerWidget {
  const _MapAndControlls({required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        _MapView(lat: lat, long: long),
        Positioned(
          top: 40.0,
          left: 20.0,
          child: IconButton.filledTonal(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        Positioned(
          bottom: 40.0,
          left: 20.0,
          child: IconButton.filledTonal(
            onPressed: () => ref
                .read(mapControllerProvider.notifier)
                .goToLocation(lat, long),
            icon: const Icon(Icons.location_searching),
          ),
        ),
        // Positioned(
        //   bottom: 90.0,
        //   left: 20.0,
        //   child: IconButton.filledTonal(
        //     onPressed: () {},
        //     icon: const Icon(Icons.accessibility_new_outlined),
        //   ),
        // ),
        Positioned(
          bottom: 90.0,
          left: 20.0,
          child: IconButton.filledTonal(
            onPressed: () =>
                ref.read(mapControllerProvider.notifier).toggleFollowUser(),
            icon: Icon(
              ref.watch(mapControllerProvider).followingUser
                  ? Icons.directions_run_rounded
                  : Icons.accessibility_new_outlined,
            ),
          ),
        ),
        Positioned(
          bottom: 140.0,
          left: 20.0,
          child: IconButton.filledTonal(
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .addMarkerCurrentPosition('Por aqui paso el usuario');
            },
            icon: const Icon(Icons.pin_drop),
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  const _MapView({required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  ConsumerState<_MapView> createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: ref.watch(mapControllerProvider).markersSet,
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.lat, widget.long),
        zoom: 12.0,
      ),
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      onLongPress: (latlng) {
        ref
            .read(mapControllerProvider.notifier)
            .addMarker(latlng.latitude, latlng.longitude, 'Custom Marker');
      },
    );
  }
}

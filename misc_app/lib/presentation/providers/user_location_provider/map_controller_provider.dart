import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  const MapState({
    this.controller,
    this.isReady = false,
    this.followingUser = true,
    this.markers = const [],
  });

  final bool isReady;
  final bool followingUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  Set<Marker> get markersSet {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? followingUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followingUser: followingUser ?? this.followingUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnownLocation = event;
    });
  }

  StreamSubscription? userLocationSub;
  (double, double)? lastKnownLocation;

  Stream<(double, double)> trackUser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  void goToLocation(double latitude, double longitude) {
    final newPosition = CameraPosition(target: LatLng(latitude, longitude));

    state.controller?.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
      duration: const Duration(milliseconds: 500),
    );
  }

  void toggleFollowUser() {
    state = state.copyWith(followingUser: !state.followingUser);

    if (state.followingUser) {
      findUser();
      userLocationSub = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocationSub?.cancel();
    }
  }

  void findUser() async {
    if (lastKnownLocation != null) {
      goToLocation(lastKnownLocation!.$1, lastKnownLocation!.$2);
    }
  }

  void addMarkerCurrentPosition(String name) {
    if (lastKnownLocation == null) return;

    final (latitude, longitude) = lastKnownLocation!;
    addMarker(latitude, longitude, name);
  }

  void addMarker(double latitude, double longitude, String name) {
    final newMarker = Marker(
      markerId: MarkerId('${state.markers.length}'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: name, snippet: 'Esto es el snippet'),
    );

    state = state.copyWith(markers: [...state.markers, newMarker]);
  }
}

final mapControllerProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) {
      return MapNotifier();
    });

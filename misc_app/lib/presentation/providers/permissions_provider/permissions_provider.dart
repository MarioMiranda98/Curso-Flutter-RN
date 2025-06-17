import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
      return PermissionsNotifier();
    });

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState()) {
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibray: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  Future<void> requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibray: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}

class PermissionsState {
  const PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibray = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  final PermissionStatus camera;
  final PermissionStatus photoLibray;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  bool get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  bool get photoLibrayGranted {
    return photoLibray == PermissionStatus.granted;
  }

  bool get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  bool get locationGranted {
    return location == PermissionStatus.granted;
  }

  bool get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  bool get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibray,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionsState(
    camera: camera ?? this.camera,
    photoLibray: photoLibray ?? this.photoLibray,
    sensors: sensors ?? this.sensors,
    location: location ?? this.location,
    locationAlways: locationAlways ?? this.locationAlways,
    locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
  );
}

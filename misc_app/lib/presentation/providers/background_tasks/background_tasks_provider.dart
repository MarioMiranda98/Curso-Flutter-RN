import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'package:misc_app/config/config.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  checkCurrentStatus() async {
    state = await SharedPreferencesPlugin.getBool(processKeyName) ?? false;
  }

  toggleProcess() {
    if (state == true) {
      deactivateProcess();
    } else {
      activateProcess();
    }
  }

  activateProcess() async {
    // La primera vez es inmediato
    await Workmanager().registerPeriodicTask(
      processKeyName,
      processKeyName,
      frequency: const Duration(seconds: 10), // lo cambiará a 15 minutos
      constraints: Constraints(networkType: NetworkType.connected),
      tag: processKeyName,
    );

    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = true;
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }
}

final backgroundPokemonFetchProvider =
    StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
      return BackgroundFetchNotifier(
        processKeyName: fetchPeriodicBackgroundTaskKey,
      );
    });

// fetchPeriodicBackgroundTaskKey

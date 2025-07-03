import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/config/config.dart';
import 'package:misc_app/config/router/app_router.dart';
import 'package:misc_app/presentation/providers/app_state_provider/app_state_provider.dart';
import 'package:misc_app/presentation/providers/permissions_provider/permissions_provider.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdmobPlugin.initialize();
  QuickActionsPlugin.registerActions();

  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode:
        true, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  // Workmanager().registerOneOffTask(
  //   "com.mariomiranda.misc",
  //   "com.mariomiranda.misc",
  //   inputData: {'hola': 'mundo'},
  //   constraints: Constraints(
  //     networkType: NetworkType.connected,
  //     requiresBatteryNotLow: true,
  //     requiresCharging: true,
  //     requiresDeviceIdle: true,
  //     requiresStorageNotLow: true,
  //   ),
  // );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;

    if (state == AppLifecycleState.resumed) {
      ref.read(permissionProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}

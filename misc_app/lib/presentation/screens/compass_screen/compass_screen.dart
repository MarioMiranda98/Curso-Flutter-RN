import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/providers.dart';
import 'package:misc_app/presentation/screens/screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationGranted = ref.watch(permissionProvider).locationGranted;
    final $compassHeading = ref.watch(compassProvider);

    if (!locationGranted) {
      return LocationScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Brujula', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: $compassHeading.when(
          data: (data) => _Compass(heading: data ?? 0),
          error: (e, stackTrace) => Text('$e'),
          loading: () => CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}

class _Compass extends StatefulWidget {
  const _Compass({required this.heading});

  final double heading;

  @override
  State<_Compass> createState() => _CompassState();
}

class _CompassState extends State<_Compass> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/compass/quadrant-1.png'),
            // Transform.rotate(
            //   angle: (heading * (pi / 180) * -1),
            //   child: Image.asset('assets/images/compass/needle-1.png'),
            // ),
            AnimatedRotation(
              turns: getTurns(),
              curve: Curves.easeOut,
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/images/compass/needle-1.png'),
            ),
          ],
        ),
      ],
    );
  }
}

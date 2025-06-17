import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misc_app/presentation/providers/gryroscope_provider/gyroscope_provider.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $gyroscopeProvider = ref.watch(gyroscopeProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Giroscópio')),
      body: SizedBox.expand(
        child: $gyroscopeProvider.when(
          data: (data) => _BallSlate(x: data.x, y: data.y),
          error: (e, stackTrace) => Text('$e'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _BallSlate extends StatelessWidget {
  const _BallSlate({required this.x, required this.y});

  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    double currentY = (y * 150);
    double currentX = (x * 150);

    return Stack(
      alignment: Alignment.center,
      children: [
        Text('''x: $x, y: $y ''', style: const TextStyle(fontSize: 30.0)),
        AnimatedPositioned(
          left: (currentY - 25) + (screenWidth / 2),
          top: (currentX - 25) + (screenHeight / 2),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: _Ball(),
        ),
      ],
    );
  }
}

class _Ball extends StatelessWidget {
  const _Ball();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
    );
  }
}

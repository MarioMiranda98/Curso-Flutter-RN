import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:misc_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Miscelaneos'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.push('/permissions');
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),

            const MainMenu(),
          ],
        ),
      ),
    );
  }
}

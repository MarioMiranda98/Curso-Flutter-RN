import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('River App')),
      body: _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _CustomListTile(
          title: 'State Provider Screen',
          subtitle: 'Un estado simple',
          location: '/state-provider',
        ),
        _CustomListTile(
          title: 'Future Provider Screen',
          subtitle: 'Un simple future + family',
          location: '/future-provider',
        ),
        _CustomListTile(
          title: 'Stream Provider Screen',
          subtitle: 'Un simple stream',
          location: '/stream-provider',
        ),
        _CustomListTile(
          title: 'State notifier provider',
          subtitle: 'Un provider con estado personalizado',
          location: '/todos-screen',
        ),
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.title,
    required this.subtitle,
    required this.location,
  });

  final String title;
  final String subtitle;
  final String location;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(title, style: textTheme.titleMedium),
      subtitle: Text(title, style: textTheme.bodyLarge),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => context.push(location),
    );
  }
}

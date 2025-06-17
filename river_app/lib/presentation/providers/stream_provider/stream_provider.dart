import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/config/config.dart';

final randomNamesStreamProvider = StreamProvider.autoDispose<String>((
  ref,
) async* {
  await for (final name in RandomGenerator.randomNamesStream()) {
    yield name;
  }
});

// final randomNamesStreamProvider = StreamProvider<List<String>>((ref) async* {
  // await Future.delayed(const Duration(seconds: 2));

  // yield <String>[];
  // await Future.delayed(const Duration(seconds: 2));

  // yield ['Mario'];
  // await Future.delayed(const Duration(seconds: 2));

  // yield ['Mario', 'Lulis'];
  // await Future.delayed(const Duration(seconds: 2));

  // yield ['Mario', 'Lulis', 'Mario'];
  // await Future.delayed(const Duration(seconds: 2));

  // yield ['Mario', 'Lulis', 'Mario', 'Lulu'];
// });

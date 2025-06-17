import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_app/config/helpers/random_generator.dart';

final randomNameProvider = StateProvider.autoDispose<String>((ref) {
  return RandomGenerator.getRandomName();
});

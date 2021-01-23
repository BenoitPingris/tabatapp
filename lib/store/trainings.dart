import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/models/training.dart';

class TrainingsProvider extends StateNotifier<List<Training>> {
  TrainingsProvider() : super([]);

  void add(Training t) {
    state = [...state, t];
  }

  void remove(String id) {
    state = [
      for (var t in state)
        if (t.id != id) t
    ];
  }
}

final trainingsProvider = StateNotifierProvider<TrainingsProvider>((ref) {
  return TrainingsProvider();
});

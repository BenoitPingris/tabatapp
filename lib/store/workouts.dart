import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabatapp/models/workout.dart';

class WorkoutsProvider extends StateNotifier<List<Workout>> {
  WorkoutsProvider() : super([]);

  void add(Workout t) {
    state = [...state, t];
  }

  void remove(String id) {
    state = [
      for (var t in state)
        if (t.id != id) t
    ];
  }
}

final workoutsProvider = StateNotifierProvider<WorkoutsProvider>((ref) {
  return WorkoutsProvider();
});

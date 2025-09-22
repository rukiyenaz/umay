import 'package:bloc/bloc.dart';

import 'pregnancy_state.dart';

class PregnancyCubit extends Cubit<PregnancyState> {
  PregnancyCubit({required String name, required int currentWeek})
    : super(
        PregnancyState(
          name: name,
          currentWeek: currentWeek,
          totalWeeks: 40,
          fruit: _fruitData[currentWeek]?["fruit"] ?? "Unknown",
          fruitImage: _fruitData[currentWeek]?["image"] ?? "",
        ),
      );

  static final Map<int, Map<String, String>> _fruitData = {
    8: {"fruit": "Raspberry", "image": "🍇"},
    9: {"fruit": "Olive", "image": "🫒"},
    10: {"fruit": "Prune", "image": "🟣"},
    11: {"fruit": "Lime", "image": "🍈"},
    12: {"fruit": "Plum", "image": "🟣"},
    13: {"fruit": "Peach", "image": "🍑"},
    14: {"fruit": "Lemon", "image": "🍋"},
    15: {"fruit": "Apple", "image": "🍏"},
    16: {"fruit": "Avocado", "image": "🥑"},
    17: {"fruit": "Pear", "image": "🍐"},
    18: {"fruit": "Bell Pepper", "image": "🫑"},
    19: {"fruit": "Mango", "image": "🥭"},
    20: {"fruit": "Banana", "image": "🍌"},
    // İsteğe göre haftalar eklenebilir
  };

  void updateWeek(int newWeek) {
    emit(
      PregnancyState(
        name: state.name,
        currentWeek: newWeek,
        totalWeeks: state.totalWeeks,
        fruit: _fruitData[newWeek]?["fruit"] ?? "Unknown",
        fruitImage: _fruitData[newWeek]?["image"] ?? "",
      ),
    );
  }
}

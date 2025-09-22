class PregnancyState {
  final String name;
  final int currentWeek;
  final int totalWeeks;
  final String fruit;
  final String fruitImage;

  PregnancyState({
    required this.name,
    required this.currentWeek,
    required this.totalWeeks,
    required this.fruit,
    required this.fruitImage,
  });

  double get progress => currentWeek / totalWeeks;
}

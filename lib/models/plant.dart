class Plant {
  final String name;
  final int moisture;
  final String lastWatered;
  final int minMoisture;
  final int maxMoisture;

  Plant({
    required this.name,
    required this.moisture,
    required this.lastWatered,
    this.minMoisture = 40,
    this.maxMoisture = 70,
  });

  String get status {
    if (moisture < minMoisture) return 'Needs Water';
    if (moisture > maxMoisture) return 'Overwatered';
    return 'Healthy';
  }
}

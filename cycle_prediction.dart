class CyclePrediction {
  static const int cycleLength = 28;

  static DateTime nextPeriod(DateTime start) {
    return start.add(const Duration(days: cycleLength));
  }

  static DateTime ovulationDay(DateTime start) {
    return start.add(const Duration(days: cycleLength - 14));
  }
}
